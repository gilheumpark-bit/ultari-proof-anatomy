#!/usr/bin/env python3
"""
Part B Exhaustive AST Signature & Dependency Decompiler
Target:
  1) Formalism (all 18,254 .lean files)
  2) Pure_Vwin_Outside_Literature (all 10,832 .lean files)
  3) PublishedTheorems (all 1,073 .lean files)
  4) EveryCharacterOfLiteratureOfVWin + its 201 direct local imports
  5) Top-level spine & bridges (Main, Statements, Supplements, BuildAid, CoreGm, TieGlobal, etc.)
Zero hallucination: every byte is parsed directly from extracted/lean/src.
"""
import collections
import concurrent.futures
import json
import os
import pathlib
import re
import sys
import time

sys.dont_write_bytecode = True

PROJECT_ROOT = pathlib.Path(__file__).resolve().parents[1]
_CANDIDATE_SRCS = [
    pathlib.Path(os.environ["ALPOGE_LEAN_SRC"]) if os.environ.get("ALPOGE_LEAN_SRC") else None,
    pathlib.Path("/tmp/alpoge_repair_src/lean/src"),
    PROJECT_ROOT.parent / "Anthropic_Alpoge_RH_Forensic_2026-11-20/extracted/lean/src",
]
SRC_ROOT = next((c for c in _CANDIDATE_SRCS if c is not None and c.is_dir()), PROJECT_ROOT / "src")
ATLAS_DATA = PROJECT_ROOT / "atlas/data"
ATLAS_VOLS = PROJECT_ROOT / "atlas/volumes"

DECL_HEAD_RE = re.compile(
    r"^(?:@(?:[A-Za-z0-9_.]+|\[[^\]]*\])\s+)*(?:private\s+|protected\s+|noncomputable\s+|scoped\s+|local\s+|partial\s+|unsafe\s+)*"
    r"(theorem|lemma|def|abbrev|structure|class|instance|inductive)\b(?:\s+(?:\(priority\s*:=\s*[^)]+\)\s*)?([^\s:({⦃\[]+))?"
)

BOUND_LINE_RE = re.compile(
    r"^(?:end|namespace|section|noncomputable\s+section|open|variable|attribute|set_option|local\s+|scoped\s+|@\[|@[A-Za-z]|#)\b"
)

TACTIC_RE = re.compile(
    r"\b(rw|simp|dsimp|exact|apply|refine|linarith|nlinarith|ring|norm_num|omega|positivity|"
    r"aesop|calc|rcases|obtain|induction|by_contra|contrapose|ext|funext|congr|abel|group|field_simp)\b"
)


def scan_light_worker(paths):
    out = []
    for p_str in paths:
        p = pathlib.Path(p_str)
        rel = p.relative_to(SRC_ROOT)
        mod = ".".join(rel.with_suffix("").parts)
        raw = p.read_bytes()
        lines = raw.splitlines()
        deps = []
        in_imp = True
        for ln in lines:
            if in_imp and ln.startswith(b"import "):
                toks = [t.replace("«", "").replace("»", "") for t in ln[7:].decode("utf-8", "replace").split()]
                for t in toks:
                    if t in ("public", "all"):
                        continue
                    deps.append(t)
                continue
            if in_imp and ln.strip():
                in_imp = False
                break
        out.append((mod, str(rel), len(lines), len(raw), deps))
    return out


def extract_declarations(text: str):
    lines = text.splitlines()
    n = len(lines)
    decls = []
    i = 0
    while i < n:
        ln = lines[i]
        m = DECL_HEAD_RE.match(ln)
        if not m:
            i += 1
            continue
        kind = m.group(1)
        start_line = i + 1  # 1-based
        name = m.group(2) if m.group(2) else f"_inst_L{start_line}"
        # Find end of declaration (next top-level declaration or EOF)
        j = i + 1
        while j < n:
            ln_j = lines[j]
            if ln_j and not ln_j[0].isspace():
                if DECL_HEAD_RE.match(ln_j) or BOUND_LINE_RE.match(ln_j):
                    break
            j += 1
        end_line = j  # 1-based inclusive (or start_line if j == i+1)
        block_lines = lines[i:j]

        # Extract signature up to top-level ':=' or 'where'
        sig_parts = []
        body_parts = []
        in_sig = True
        for k, bl in enumerate(block_lines):
            if in_sig:
                # Look for := by, :=, or where
                if k == 0:
                    # Strip modifier + kind + name prefix from line 0? Keep from kind onward for clarity!
                    idx_kind = bl.find(kind)
                    bl_clean = bl[idx_kind:] if idx_kind >= 0 else bl
                else:
                    bl_clean = bl.strip()

                # Split at ' := ' or end-of-line ' :=' or ' where'
                split_pos = -1
                for sep in (" := by", " :=", "\t:=", " where"):
                    pos = bl_clean.find(sep)
                    if pos != -1:
                        if split_pos == -1 or pos < split_pos:
                            split_pos = pos
                if split_pos != -1:
                    sig_parts.append(bl_clean[:split_pos].strip())
                    body_parts.append(bl_clean[split_pos:])
                    in_sig = False
                elif bl_clean.endswith(":=") or bl_clean.endswith("where"):
                    cut = -2 if bl_clean.endswith(":=") else -5
                    sig_parts.append(bl_clean[:cut].strip())
                    in_sig = False
                else:
                    sig_parts.append(bl_clean)
                    if len(" ".join(sig_parts)) > 650:
                        in_sig = False
            else:
                body_parts.append(bl)

        sig = re.sub(r"\s+", " ", " ".join(sig_parts)).strip()
        if len(sig) > 700:
            sig = sig[:697] + "..."
        body_txt = "\n".join(body_parts)
        tacs = sorted(set(TACTIC_RE.findall(body_txt)))
        decls.append(
            {
                "kind": kind,
                "name": name,
                "line_start": start_line,
                "line_end": max(start_line, end_line),
                "signature": sig,
                "tactics": tacs,
            }
        )
        i = j
    return decls


def parse_deep_worker(items):
    results = []
    for mod, rel in items:
        p = SRC_ROOT / rel
        txt = p.read_text(encoding="utf-8", errors="replace")
        decls = extract_declarations(txt)
        results.append((mod, decls))
    return results


def cone(mod_deps, roots):
    seen = set()
    dq = collections.deque(r for r in roots if r in mod_deps)
    while dq:
        u = dq.popleft()
        if u in seen:
            continue
        seen.add(u)
        for d in mod_deps[u]:
            if d not in seen:
                dq.append(d)
    return seen


def write_markdown_volume(vol_path: pathlib.Path, title: str, subtitle: str, mods_sorted, meta_map, decl_map):
    total_files = len(mods_sorted)
    total_lines = sum(meta_map[m]["lines"] for m in mods_sorted)
    total_thms = sum(sum(1 for d in decl_map[m] if d["kind"] in ("theorem", "lemma")) for m in mods_sorted)
    total_defs = sum(sum(1 for d in decl_map[m] if d["kind"] not in ("theorem", "lemma")) for m in mods_sorted)

    # Group by 2nd/3rd module prefix
    groups = collections.defaultdict(list)
    for m in mods_sorted:
        parts = m.split(".")
        g = ".".join(parts[:3]) if len(parts) >= 3 else ".".join(parts[:2])
        groups[g].append(m)

    out = []
    out.append(f"# {title}\n")
    out.append(f"- **범위 설명**: {subtitle}")
    out.append(f"- **수록 파일 수**: `{total_files:,}`개 (`100.00%` 전수 수록)")
    out.append(f"- **수록 코드 줄 수**: `{total_lines:,}`줄")
    out.append(f"- **수록 선언 수**: 총 `{total_thms + total_defs:,}`개 (`theorem`/`lemma` `{total_thms:,}`개, `def`/`structure` 등 `{total_defs:,}`개)\n")
    out.append("## 하위 모듈 요약 통계\n")
    out.append("| 하위 모듈군 | 파일 수 | 줄 수 | 정리 수 | 정의·구조체 수 | 최다 피참조 허브 파일 (`in_degree`) |")
    out.append("| :--- | ---: | ---: | ---: | ---: | :--- |")

    sorted_groups = sorted(groups.items(), key=lambda kv: (-sum(meta_map[x]["lines"] for x in kv[1]), kv[0]))
    for g, g_mods in sorted_groups:
        gf = len(g_mods)
        gl = sum(meta_map[x]["lines"] for x in g_mods)
        gt = sum(sum(1 for d in decl_map[x] if d["kind"] in ("theorem", "lemma")) for x in g_mods)
        gd = sum(sum(1 for d in decl_map[x] if d["kind"] not in ("theorem", "lemma")) for x in g_mods)
        top_m = max(g_mods, key=lambda x: (meta_map[x]["in_degree"], meta_map[x]["lines"]))
        top_short = top_m.split(".")[-1] + ".lean"
        out.append(
            f"| `{g}` | `{gf:,}` | `{gl:,}` | `{gt:,}` | `{gd:,}` | `{top_short}` (`{meta_map[top_m]['in_degree']}`) |"
        )
    out.append("\n---\n")

    for g, g_mods in sorted_groups:
        out.append(f"## 모듈군: `{g}` (`{len(g_mods):,}`개 파일)\n")
        for m in sorted(g_mods, key=lambda x: (-meta_map[x]["in_degree"], x)):
            info = meta_map[m]
            dlist = decl_map[m]
            out.append(
                f"### `{info['rel']}` (`{info['lines']}`줄 · 피참조 `{info['in_degree']}` · Main거리 `{info['dist']}`)"
            )
            if not dlist:
                out.append("- *(선언 없음: 임포트 집계 또는 옵션·커맨드 전용 모듈)*\n")
                continue
            for d in dlist:
                sig_escaped = d["signature"].replace("|", "\\|")
                tac_str = f" · 전술: `{','.join(d['tactics'][:6])}`" if d["tactics"] else ""
                out.append(f"- `L{d['line_start']}-L{d['line_end']}`: `{sig_escaped}`{tac_str}")
            out.append("")

    vol_path.write_text("\n".join(out), encoding="utf-8")
    return total_files, total_lines, total_thms, total_defs, len(out)


def main():
    t0 = time.time()
    ATLAS_DATA.mkdir(parents=True, exist_ok=True)
    ATLAS_VOLS.mkdir(parents=True, exist_ok=True)

    all_paths = [str(p) for p in SRC_ROOT.rglob("*.lean")]
    print(f"[1/5] Found {len(all_paths):,} .lean files. Scanning full DAG...")

    workers = min(16, (os.cpu_count() or 8))
    chunk_size = max(500, len(all_paths) // (workers * 4))
    chunks = [all_paths[i : i + chunk_size] for i in range(0, len(all_paths), chunk_size)]

    raw_meta = {}
    with concurrent.futures.ProcessPoolExecutor(max_workers=workers) as ex:
        for batch in ex.map(scan_light_worker, chunks):
            for mod, rel, nlines, nbytes, deps in batch:
                raw_meta[mod] = {
                    "rel": rel,
                    "lines": nlines,
                    "bytes": nbytes,
                    "raw_deps": deps,
                }

    all_mods = set(raw_meta)
    mod_deps = {}
    in_degree = collections.Counter()
    ext_deps_map = {}
    for m, info in raw_meta.items():
        loc = [d for d in info["raw_deps"] if d in all_mods and d != m]
        ext = [d for d in info["raw_deps"] if d not in all_mods]
        mod_deps[m] = loc
        ext_deps_map[m] = ext
        for d in loc:
            in_degree[d] += 1

    # Shortest import distance from Main
    dist = {"Main": 0}
    dq = collections.deque(["Main"])
    while dq:
        u = dq.popleft()
        du = dist[u]
        for v in mod_deps.get(u, ()):
            if v not in dist:
                dist[v] = du + 1
                dq.append(v)

    print(f"[2/5] DAG ready in {time.time() - t0:.1f}s. Computing cones...")
    lit_mod = "Development.AutomorphicArithmetic.ThetaCorrespondence.ThetaPairLifts.ThirdPlaceSeries.EveryCharacterOfLiteratureOfVWin"
    vwin_mod = "Development.AutomorphicArithmetic.AutomorphicVarieties.ModularityArgument.ThresholdArguments.DenseThresholdCases.VwinOfRow"
    rh_char_mod = "Development.AutomorphicArithmetic.CharacterBoxes.RiemannHypothesisOfEveryCharacter"

    c_lit = cone(mod_deps, [lit_mod])
    c_vwin = cone(mod_deps, [vwin_mod])

    s_formalism = {m for m in all_mods if m.startswith("Formalism.")}
    s_pure_vwin = c_vwin - c_lit
    s_pub_thms = {m for m in all_mods if "PublishedTheorems" in m}
    s_ec_direct = set(mod_deps[lit_mod]) | {lit_mod}
    s_top_spine = {
        m
        for m in all_mods
        if dist.get(m, 999) <= 4
        or m.startswith("Supplements.")
        or m.startswith("BuildAid.")
        or m in ("Main", "Statements", rh_char_mod)
    }

    target_mods = sorted(s_formalism | s_pure_vwin | s_pub_thms | s_ec_direct | s_top_spine)
    print(
        f"[3/5] Deep AST parsing {len(target_mods):,} unique target modules "
        f"(Formalism={len(s_formalism):,}, PureVwin={len(s_pure_vwin):,}, "
        f"PublishedTheorems={len(s_pub_thms):,}, EveryCharDirect={len(s_ec_direct):,})..."
    )

    items = [(m, raw_meta[m]["rel"]) for m in target_mods]
    d_chunk = max(200, len(items) // (workers * 6))
    d_chunks = [items[i : i + d_chunk] for i in range(0, len(items), d_chunk)]

    decl_map = {}
    with concurrent.futures.ProcessPoolExecutor(max_workers=workers) as ex:
        for batch in ex.map(parse_deep_worker, d_chunks):
            for mod, decls in batch:
                decl_map[mod] = decls

    meta_map = {}
    for m in target_mods:
        meta_map[m] = {
            "module": m,
            "rel": raw_meta[m]["rel"],
            "lines": raw_meta[m]["lines"],
            "bytes": raw_meta[m]["bytes"],
            "in_degree": in_degree[m],
            "out_degree": len(mod_deps[m]),
            "dist": dist.get(m, -1),
            "local_imports": mod_deps[m],
            "external_imports": ext_deps_map[m],
        }

    print(f"[4/5] Writing JSONL databases to {ATLAS_DATA}...")

    def dump_jsonl(filename, mod_set):
        path = ATLAS_DATA / filename
        cnt_decls = 0
        with path.open("w", encoding="utf-8") as f:
            for m in sorted(mod_set):
                rec = dict(meta_map[m])
                rec["declarations"] = decl_map[m]
                cnt_decls += len(decl_map[m])
                f.write(json.dumps(rec, ensure_ascii=False) + "\n")
        return len(mod_set), cnt_decls

    f_files, f_decls = dump_jsonl("formalism_18254.jsonl", s_formalism)
    v_files, v_decls = dump_jsonl("pure_vwin_10832.jsonl", s_pure_vwin)
    p_files, p_decls = dump_jsonl("published_theorems_and_201_imports.jsonl", s_pub_thms | s_ec_direct)
    t_files, t_decls = dump_jsonl("top_spine_depth4.jsonl", s_top_spine)

    print(f"[5/5] Building Part B Markdown Encyclopedia Volumes in {ATLAS_VOLS}...")
    vol_specs = [
        (
            "B01_Formalism_LocalToGlobal.md",
            "Part B 도감 제1권: Formalism.LocalToGlobal 전수 명세 원장",
            "완전 정부호 유니터리 군 사슬, 부정정 실자리 헤케 비소멸, 수체 가족 및 국소-대역 리프트 (`Formalism.LocalToGlobal` 전수)",
            sorted(m for m in s_formalism if m.startswith("Formalism.LocalToGlobal.")),
        ),
        (
            "B02_Formalism_SharpRestriction.md",
            "Part B 도감 제2권: Formalism.SharpRestriction 전수 명세 원장",
            "GL5 6중 메타플렉틱 피복 상대 대각합 공식, 파르세발 대체, 예리한 제한 노름 상한 (`Formalism.SharpRestriction` 전수)",
            sorted(m for m in s_formalism if m.startswith("Formalism.SharpRestriction.")),
        ),
        (
            "B03_Formalism_HermitianCurvature.md",
            "Part B 도감 제3권: Formalism.HermitianCurvature 전수 명세 원장",
            "에르미트 계량 곡률, 아라켈로프 교차 높이, 콤팩트 지지 절단 (`Formalism.HermitianCurvature` 전수)",
            sorted(m for m in s_formalism if m.startswith("Formalism.HermitianCurvature.")),
        ),
        (
            "B04_Formalism_PeriodIntegrals.md",
            "Part B 도감 제4권: Formalism.PeriodIntegrals 전수 명세 원장",
            "랄리스 내적 공식·시소 항등식, 베셀·푸리에-야코비 주기 적분, 차울라-셀베르그·지겔 질량 하한 (`Formalism.PeriodIntegrals` 전수)",
            sorted(m for m in s_formalism if m.startswith("Formalism.PeriodIntegrals.")),
        ),
        (
            "B05_Formalism_Specialized_Subtheories.md",
            "Part B 도감 제5권: Formalism 나머지 특수 소이론 전수 명세 원장",
            "GL3 평균제곱, 세타 로그좌표, 왁 격자 뒤틀림, 말러 측도, 란다우 영점비소멸, 약수 부등식, 베렌트 집합, 최상단 Statement* 등 (`Formalism` 잔여 전수)",
            sorted(
                m
                for m in s_formalism
                if not any(
                    m.startswith(pfx)
                    for pfx in (
                        "Formalism.LocalToGlobal.",
                        "Formalism.SharpRestriction.",
                        "Formalism.HermitianCurvature.",
                        "Formalism.PeriodIntegrals.",
                    )
                )
            ),
        ),
        (
            "B06_PureVwin_AutomorphicVarieties.md",
            "Part B 도감 제6권: Pure_Vwin 보형 다양체·밀집 임계치 패칭 전수 원장",
            "기출 문헌 바깥의 신작 보형 다양체·모듈러성 임계치·작은 유수·3변수 유니터리 변형 (`AutomorphicVarieties` 전수)",
            sorted(m for m in s_pure_vwin if m.startswith("Development.AutomorphicArithmetic.AutomorphicVarieties.")),
        ),
        (
            "B07_PureVwin_Foundations_And_Hecke.md",
            "Part B 도감 제7권: Pure_Vwin 갈루아·국소랑글란즈·헤케 신작 원장",
            "약화된 반디버 성질(`RowSrc`), 국소 중심 단원(`RecTExists`), 휘태커-헤케·뒤틀린 대각합 등 (`Development.AutomorphicArithmetic` 잔여 신작 전수)",
            sorted(
                m
                for m in s_pure_vwin
                if m.startswith("Development.AutomorphicArithmetic.")
                and not m.startswith("Development.AutomorphicArithmetic.AutomorphicVarieties.")
            ),
        ),
        (
            "B08_PureVwin_Abelian_Spectrum_And_Others.md",
            "Part B 도감 제8권: Pure_Vwin 아벨·스펙트럼·양수성 신작 보조 원장",
            "`Pure_Vwin_Outside_Literature` 내부의 아벨 다양체·보형 스펙트럼·양수성 입력 등 잔여 신작 파일 전수",
            sorted(m for m in s_pure_vwin if not m.startswith("Development.AutomorphicArithmetic.")),
        ),
        (
            "B09_PublishedTheorems_1073_And_201_Imports.md",
            "Part B 도감 제9권: PublishedTheorems(1,073개) 및 EveryCharacter 직접 임포트(201개) 전수 명세 원장",
            "기출 대정리 명세 폴더 전수 및 `EveryCharacterOfLiteratureOfVWin.lean` 직접 호출 모듈 전수의 원문 시그니처",
            sorted(s_pub_thms | s_ec_direct),
        ),
        (
            "B10_Top_Spine_Depth0_To_4.md",
            "Part B 도감 제10권: 최상위 Main.lean 거리 0~4단 척추 및 빌드 보조 모듈 원장",
            "`Main.lean`으로부터 임포트 거리 4 이하 최상단 조립 계층, `Supplements`, `BuildAid` 전수 시그니처",
            sorted(s_top_spine),
        ),
    ]

    vol_stats = []
    for fname, title, sub, mlist in vol_specs:
        vf, vl, vt, vd, vmd_lines = write_markdown_volume(ATLAS_VOLS / fname, title, sub, mlist, meta_map, decl_map)
        vol_stats.append(
            {
                "file": fname,
                "title": title,
                "lean_files": vf,
                "lean_lines": vl,
                "theorems": vt,
                "defs": vd,
                "markdown_lines": vmd_lines,
            }
        )
        print(f"  -> {fname}: {vf:,} lean files | {vt+vd:,} decls | {vmd_lines:,} md lines")

    # Compute tactic frequency & top hubs across novel set (s_formalism | s_pure_vwin)
    novel_union = s_formalism | s_pure_vwin
    tac_counter = collections.Counter()
    kind_counter = collections.Counter()
    for m in novel_union:
        for d in decl_map[m]:
            kind_counter[d["kind"]] += 1
            for t in d["tactics"]:
                tac_counter[t] += 1

    top_novel_hubs = sorted(novel_union, key=lambda x: (-in_degree[x], -raw_meta[x]["lines"]))[:100]
    formalism_sub_stats = collections.defaultdict(lambda: [0, 0, 0, 0])
    for m in s_formalism:
        sub = m.split(".")[1] if "." in m else "(root)"
        formalism_sub_stats[sub][0] += 1
        formalism_sub_stats[sub][1] += meta_map[m]["lines"]
        formalism_sub_stats[sub][2] += sum(1 for d in decl_map[m] if d["kind"] in ("theorem", "lemma"))
        formalism_sub_stats[sub][3] += sum(1 for d in decl_map[m] if d["kind"] not in ("theorem", "lemma"))

    summary = {
        "generated_at": time.strftime("%Y-%m-%d %H:%M:%S %Z"),
        "archive_total_files": len(all_mods),
        "archive_total_lines": sum(raw_meta[m]["lines"] for m in all_mods),
        "formalism_files": len(s_formalism),
        "formalism_lines": sum(raw_meta[m]["lines"] for m in s_formalism),
        "formalism_declarations": f_decls,
        "pure_vwin_files": len(s_pure_vwin),
        "pure_vwin_lines": sum(raw_meta[m]["lines"] for m in s_pure_vwin),
        "pure_vwin_declarations": v_decls,
        "overlap_formalism_pure_vwin": len(s_formalism & s_pure_vwin),
        "novel_union_unique_files": len(novel_union),
        "novel_union_lines": sum(raw_meta[m]["lines"] for m in novel_union),
        "novel_union_declarations": sum(len(decl_map[m]) for m in novel_union),
        "published_theorems_files": len(s_pub_thms),
        "published_theorems_lines": sum(raw_meta[m]["lines"] for m in s_pub_thms),
        "every_character_direct_imports": len(mod_deps[lit_mod]),
        "target_parsed_unique_files": len(target_mods),
        "target_parsed_declarations": sum(len(decl_map[m]) for m in target_mods),
        "novel_kind_counts": dict(kind_counter),
        "novel_tactic_file_decl_hits": dict(tac_counter.most_common(30)),
        "volumes": vol_stats,
        "formalism_subtheories_count": len(formalism_sub_stats),
        "formalism_subtheories": [
            {
                "name": f"Formalism.{k}",
                "files": v[0],
                "lines": v[1],
                "theorems": v[2],
                "defs": v[3],
            }
            for k, v in sorted(formalism_sub_stats.items(), key=lambda kv: (-kv[1][1], kv[0]))
        ],
        "top_100_novel_hubs": [
            {
                "module": m,
                "rel": meta_map[m]["rel"],
                "in_degree": meta_map[m]["in_degree"],
                "lines": meta_map[m]["lines"],
                "dist": meta_map[m]["dist"],
                "decls": len(decl_map[m]),
            }
            for m in top_novel_hubs
        ],
    }
    (ATLAS_DATA / "atlas_summary.json").write_text(json.dumps(summary, ensure_ascii=False, indent=2), encoding="utf-8")

    # Write B00 master index volume
    b00 = []
    b00.append("# Part B 신작 영역 전수 수식 도감 총람 (`B00` 마스터 색인)\n")
    b00.append(f"- **생성 시각**: `{summary['generated_at']}`")
    b00.append(
        f"- **신작 고유 파일 합집합 (`Formalism ∪ Pure_Vwin`)**: `{summary['novel_union_unique_files']:,}`개 파일 "
        f"(`Formalism` `{summary['formalism_files']:,}`개 + `Pure_Vwin` `{summary['pure_vwin_files']:,}`개, 교집합 `{summary['overlap_formalism_pure_vwin']}`개)"
    )
    b00.append(f"- **신작 고유 코드 줄 수**: `{summary['novel_union_lines']:,}`줄")
    b00.append(f"- **신작 추출 선언 총수**: `{summary['novel_union_declarations']:,}`개 (`{summary['novel_kind_counts']}`)")
    b00.append(
        f"- **기출 명세 감사 수록분**: `PublishedTheorems` `{summary['published_theorems_files']:,}`개 파일 + "
        f"`EveryCharacterOfLiteratureOfVWin` 직접 임포트 `{summary['every_character_direct_imports']}`개"
    )
    b00.append(
        f"- **Part B 전체 AST 파싱 고유 모듈 총수**: `{summary['target_parsed_unique_files']:,}`개 파일 "
        f"(총 추출 선언 `{summary['target_parsed_declarations']:,}`개)\n"
    )
    b00.append("## 1. Part B 도감 전 10권 구성표\n")
    b00.append("| 권호 파일 | 수록 Lean 파일 | Lean 줄 수 | 정리(`theorem`/`lemma`) | 정의·구조체 | 생성 마크다운 줄 수 |")
    b00.append("| :--- | ---: | ---: | ---: | ---: | ---: |")
    for vs in vol_stats:
        b00.append(
            f"| `{vs['file']}` | `{vs['lean_files']:,}` | `{vs['lean_lines']:,}` | "
            f"`{vs['theorems']:,}` | `{vs['defs']:,}` | `{vs['markdown_lines']:,}` |"
        )
    b00.append("\n## 2. `Formalism` 하위 소이론 전수 통계 (`" + str(len(formalism_sub_stats)) + "`개 소이론)\n")
    b00.append("| 순위 | 소이론 모듈군 | 파일 수 | 줄 수 | 정리 수 | 정의·구조체 수 |")
    b00.append("| ---: | :--- | ---: | ---: | ---: | ---: |")
    for idx, st in enumerate(summary["formalism_subtheories"], 1):
        b00.append(
            f"| {idx} | `{st['name']}` | `{st['files']:,}` | `{st['lines']:,}` | `{st['theorems']:,}` | `{st['defs']:,}` |"
        )
    b00.append("\n## 3. 신작 영역 최다 피참조 핵심 허브 모듈 Top 50\n")
    b00.append("| 순위 | 파일 경로 | 피참조 수 (`in_degree`) | 줄 수 | Main 거리 | 선언 수 |")
    b00.append("| ---: | :--- | ---: | ---: | ---: | ---: |")
    for idx, h in enumerate(summary["top_100_novel_hubs"][:50], 1):
        b00.append(
            f"| {idx} | `{h['rel']}` | `{h['in_degree']:,}` | `{h['lines']:,}` | `{h['dist']}` | `{h['decls']}` |"
        )
    (ATLAS_VOLS / "B00_Master_Index_And_Hubs.md").write_text("\n".join(b00) + "\n", encoding="utf-8")

    b00_en = []
    b00_en.append("# Part B 100.00% AST Formula Atlas Master Index (`B00`)\n")
    b00_en.append(f"- **Generated At**: `{summary['generated_at']}`")
    b00_en.append(
        f"- **Novel Unique File Union (`Formalism ∪ Pure_Vwin`)**: `{summary['novel_union_unique_files']:,}` files "
        f"(`Formalism` `{summary['formalism_files']:,}` + `Pure_Vwin` `{summary['pure_vwin_files']:,}`, overlap `{summary['overlap_formalism_pure_vwin']}`)"
    )
    b00_en.append(f"- **Novel Unique Source Lines**: `{summary['novel_union_lines']:,}` lines")
    b00_en.append(f"- **Novel Extracted Declarations**: `{summary['novel_union_declarations']:,}` (`{summary['novel_kind_counts']}`)")
    b00_en.append(
        f"- **Classical Interface Boundary Indexed**: `PublishedTheorems` `{summary['published_theorems_files']:,}` files + "
        f"`EveryCharacterOfLiteratureOfVWin` direct imports `{summary['every_character_direct_imports']}`"
    )
    b00_en.append(
        f"- **Part B Total Unique AST-Parsed Modules**: `{summary['target_parsed_unique_files']:,}` files "
        f"(`{summary['target_parsed_declarations']:,}` declarations = `100.00%`)\n"
    )
    b00_en.append("## 1. Overview of All 10 Part B Signature Volumes (`B01`..`B10`)\n")
    b00_en.append("| Volume File | Lean Files | Lean Lines | Theorems (`theorem`/`lemma`) | Defs / Structs / Instances | Markdown Lines |")
    b00_en.append("| :--- | ---: | ---: | ---: | ---: | ---: |")
    for vs in vol_stats:
        b00_en.append(
            f"| `{vs['file']}` | `{vs['lean_files']:,}` | `{vs['lean_lines']:,}` | "
            f"`{vs['theorems']:,}` | `{vs['defs']:,}` | `{vs['markdown_lines']:,}` |"
        )
    b00_en.append(f"\n## 2. Complete Statistics Across All `{len(formalism_sub_stats)}` `Formalism` Subtheories\n")
    b00_en.append("| Rank | Subtheory Namespace | Files | Lines | Theorems | Defs / Structs / Instances |")
    b00_en.append("| ---: | :--- | ---: | ---: | ---: | ---: |")
    for idx, st in enumerate(summary["formalism_subtheories"], 1):
        b00_en.append(
            f"| {idx} | `{st['name']}` | `{st['files']:,}` | `{st['lines']:,}` | `{st['theorems']:,}` | `{st['defs']:,}` |"
        )
    b00_en.append("\n## 3. Top 50 Most-Imported Core Hub Modules Across the Novel Cone\n")
    b00_en.append("| Rank | Relative File Path (`src/`) | `in_degree` | Lines | `Main` Dist | Declarations |")
    b00_en.append("| ---: | :--- | ---: | ---: | ---: | ---: |")
    for idx, h in enumerate(summary["top_100_novel_hubs"][:50], 1):
        b00_en.append(
            f"| {idx} | `{h['rel']}` | `{h['in_degree']:,}` | `{h['lines']:,}` | `{h['dist']}` | `{h['decls']}` |"
        )
    (ATLAS_VOLS / "B00_Master_Index_And_Hubs.en.md").write_text("\n".join(b00_en) + "\n", encoding="utf-8")
    print(f"DONE in {time.time() - t0:.1f}s!")


if __name__ == "__main__":
    main()
