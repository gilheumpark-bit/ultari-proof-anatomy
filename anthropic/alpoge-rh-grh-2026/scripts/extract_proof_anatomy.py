#!/usr/bin/env python3
import collections
import json
import os
import pathlib
import re

ROOT = pathlib.Path(__file__).resolve().parents[1]
CANDIDATES = [
    ROOT.parent / "Anthropic_Alpoge_RH_Forensic_2026-11-20/extracted/lean/src",
    ROOT.parents[2] / "Anthropic_Alpoge_RH_Forensic_2026-11-20/extracted/lean/src",
]
DEFAULT_SRC = next((c for c in CANDIDATES if c.is_dir()), CANDIDATES[0])
SRC = pathlib.Path(os.environ.get("ALPOGE_LEAN_SRC", str(DEFAULT_SRC)))
OUT = ROOT / "data/anatomy_stats.json"
DECL_RE = re.compile(
    rb"^(?:private\s+|protected\s+|noncomputable\s+)*(theorem|lemma|def|abbrev|structure|class|instance|inductive)\b"
)


def parse_one_file(p: pathlib.Path):
    m = ".".join(p.relative_to(SRC).with_suffix("").parts)
    raw = p.read_bytes()
    lines = raw.splitlines()
    deps = set()
    in_imports = True
    thms = 0
    defs = 0
    for ln in lines:
        if in_imports and ln.startswith(b"import "):
            toks = [t.replace("«", "").replace("»", "") for t in ln[7:].decode("utf-8").split()]
            deps.update(t for t in toks if t not in ("public", "all"))
            continue
        if in_imports and ln.strip():
            in_imports = False
        mat = DECL_RE.match(ln)
        if not mat:
            continue
        if mat.group(1) in (b"theorem", b"lemma"):
            thms += 1
        else:
            defs += 1
    return m, deps, len(lines), len(raw), thms, defs


def parse_all():
    mod_deps = {}
    mod_lines = {}
    mod_bytes = {}
    thm_cnt = 0
    def_cnt = 0
    for p in SRC.rglob("*.lean"):
        m, deps, nlines, nbytes, thms, defs = parse_one_file(p)
        mod_deps[m] = deps
        mod_lines[m] = nlines
        mod_bytes[m] = nbytes
        thm_cnt += thms
        def_cnt += defs
    all_mods = set(mod_deps)
    for m in all_mods:
        mod_deps[m] = [d for d in mod_deps[m] if d in all_mods and d != m]
    return mod_deps, mod_lines, mod_bytes, thm_cnt, def_cnt


def cone(mod_deps, roots):
    seen = set()
    dq = collections.deque(r for r in roots if r in mod_deps)
    while dq:
        u = dq.popleft()
        if u in seen:
            continue
        seen.add(u)
        dq.extend(d for d in mod_deps[u] if d not in seen)
    return seen


def main():
    mod_deps, mod_lines, mod_bytes, thm_cnt, def_cnt = parse_all()
    buckets = collections.defaultdict(lambda: [0, 0, 0])
    for m, lns in mod_lines.items():
        parts = m.split(".")
        b = f"Development.{parts[1]}" if parts[0] == "Development" and len(parts) >= 2 else parts[0]
        buckets[b][0] += 1
        buckets[b][1] += lns
        buckets[b][2] += mod_bytes[m]

    lit_mod = "Development.AutomorphicArithmetic.ThetaCorrespondence.ThetaPairLifts.ThirdPlaceSeries.EveryCharacterOfLiteratureOfVWin"
    vwin_mod = "Development.AutomorphicArithmetic.AutomorphicVarieties.ModularityArgument.ThresholdArguments.DenseThresholdCases.VwinOfRow"
    row_mod = "Development.AutomorphicArithmetic.Foundations.GaloisRepresentations.IntegralStructures.RowSrc"
    rec_mod = "Development.AutomorphicArithmetic.Foundations.LocalLanglands.LocalCentralUnits.RecTExists"
    rh_mod = "Development.AutomorphicArithmetic.CharacterBoxes.RiemannHypothesisOfEveryCharacter"
    crit_mod = "Formalism.GammaFactorNonvanishing.CritLine"
    cor_mod = "Development.AutomorphicArithmetic.AutomorphicVarieties.SmallClassNumbers.CorGKOf"

    c_lit = cone(mod_deps, [lit_mod])
    c_vwin = cone(mod_deps, [vwin_mod])
    c_row = cone(mod_deps, [row_mod])
    c_rec = cone(mod_deps, [rec_mod])
    c_cor = cone(mod_deps, [cor_mod])
    c_rh_bridge = cone(mod_deps, [rh_mod, crit_mod, "Development.AutomorphicArithmetic.CharacterBoxes.ClaimStrip"])

    lit_path = SRC / (lit_mod.replace(".", "/") + ".lean")
    lit_thms = re.findall(r"theorem\s+UpperTheory\.LiteratureTheorems\.([A-Za-z0-9_']+)\s*\(", lit_path.read_text(encoding="utf-8"))

    res = {
        "total_files": len(mod_deps),
        "total_lines": sum(mod_lines.values()),
        "total_bytes": sum(mod_bytes.values()),
        "theorem_lemma_count": thm_cnt,
        "def_struct_count": def_cnt,
        "buckets": {
            k: {"files": v[0], "lines": v[1], "mb": round(v[2] / 1e6, 2)}
            for k, v in sorted(buckets.items(), key=lambda x: -x[1][1])
        },
        "cones": {
            "EveryCharacterOfLiteratureOfVWin": {"files": len(c_lit), "lines": sum(mod_lines[m] for m in c_lit)},
            "VwinOfRow": {"files": len(c_vwin), "lines": sum(mod_lines[m] for m in c_vwin)},
            "RowSrc_galoisLocalGlobal": {"files": len(c_row), "lines": sum(mod_lines[m] for m in c_row)},
            "RecTExists_LocalLanglands": {"files": len(c_rec), "lines": sum(mod_lines[m] for m in c_rec)},
            "CorGKOf_SmallClassNumbers": {"files": len(c_cor), "lines": sum(mod_lines[m] for m in c_cor)},
            "RH_CritLine_FunctionalEq_Bridge": {"files": len(c_rh_bridge), "lines": sum(mod_lines[m] for m in c_rh_bridge)},
            "Pure_Literature_Outside_Vwin": {"files": len(c_lit - c_vwin), "lines": sum(mod_lines[m] for m in (c_lit - c_vwin))},
            "Pure_Vwin_Outside_Literature": {"files": len(c_vwin - c_lit), "lines": sum(mod_lines[m] for m in (c_vwin - c_lit))},
        },
        "literature_wrapper_theorem_count": len(lit_thms),
        "literature_wrapper_theorems": lit_thms,
    }
    OUT.write_text(json.dumps(res, indent=2, ensure_ascii=False), encoding="utf-8")
    print(f"EXTRACTED_OK: files={res['total_files']} lines={res['total_lines']} lit_wrappers={len(lit_thms)}")


if __name__ == "__main__":
    main()
