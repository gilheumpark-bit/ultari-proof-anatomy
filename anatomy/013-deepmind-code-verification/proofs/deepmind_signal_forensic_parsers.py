#!/usr/bin/env python3
"""
Live regex and text parsers over `proofs/oai_ref/` for Case 013:
Google DeepMind `code-verification` (`libsignal-cli`, commit `808b4b7ffef1`).

Extracts hook tables, linker segments, Rust CLI harness constants, uncommitted
AGPL-3.0-only ELF metadata, refinement-hygiene script allowlists, TCB trust
caveats, PQXDH deployment bounds, Arm64 differential-testing filters, Class Z
`udf #0` stubs, `DEVIATIONS.md` headers, and comparator manifests directly from
preserved upstream files without hardcoded snapshot self-assertions.
"""

from __future__ import annotations

from fractions import Fraction
import json
from pathlib import Path
import re


def strip_lean_comments(text: str) -> str:
    """Remove nested-free block comments and line comments from Lean 4 source."""
    return re.sub(r"--[^\n]*", "", re.sub(r"/-.*?-/", "", text, flags=re.S))


def parse_oai_ref_and_hook_cutplane(oai_ref_dir: Path) -> dict:
    """Live-parse binary hook tables, stock.ld, token patch, and 1 GiB peak budget."""
    all_files = sorted(p for p in oai_ref_dir.rglob("*") if p.is_file())
    lean_files = [p for p in all_files if p.suffix == ".lean"]
    non_lean_files = [p for p in all_files if p.suffix != ".lean"]
    lean_total_lines = sum(len(p.read_text(encoding="utf-8").splitlines()) for p in lean_files)

    cli_bin = strip_lean_comments(
        (oai_ref_dir / "LibsignalBinary/Specifications/SignalSession/CliBinaryPq.lean").read_text(encoding="utf-8")
    )
    cli_run = strip_lean_comments(
        (oai_ref_dir / "LibsignalBinary/Specifications/SignalSession/CliRun.lean").read_text(encoding="utf-8")
    )
    m_dehook = re.search(r"def\s+cliDehookedSymsPlaced\s*:\s*List\s+String\s*:=\s*\[(.*?)\]", cli_bin, re.S)
    m_pq = re.search(
        r"def\s+cliPqxdhHookTablePlaced\b.*?List\s*\(String\s*×\s*\(State\s*→\s*State\)\)\s*:=\s*\[(.*?)\]\s*noncomputable\s+def\s+cliHookTablePlaced",
        cli_bin,
        re.S,
    )
    m_extra = re.search(r"def\s+cliHookTablePlaced\b.*?\+\+\s*\[(.*?)\]\s*def\s+cliPanicSymbolsPlaced", cli_bin, re.S)
    m_panic = re.search(r"def\s+cliPanicSymbolsPlaced\s*:\s*List\s+String\s*:=\s*\[(.*?)\]", cli_bin, re.S)
    assert m_dehook and m_pq and m_extra and m_panic

    dehooked_syms = [t.strip() for t in m_dehook.group(1).split(",") if t.strip()]
    pq_hook_syms = re.findall(r'"(_RNv[^"]+)"', m_pq.group(1))
    extra_rows = [r.strip() for r in m_extra.group(1).splitlines() if r.strip().startswith("(")]
    panic_syms = re.findall(r'"([^"]+)"', m_panic.group(1))
    drop_zeroize_hooks = len(re.findall(r'"_RNvX[^"]*4drop"', cli_bin + "\n" + cli_run))

    total_hooks = len(pq_hook_syms) + len(extra_rows)
    bypassed = total_hooks + len(panic_syms)
    tracked = bypassed + len(dehooked_syms)
    ratio = Fraction(bypassed, tracked)

    lakefile_txt = (oai_ref_dir / "lakefile.lean").read_text(encoding="utf-8")
    hub_paths = (
        "Computational/Theorems/Main.lean",
        "Symbolic/Theorems/Refinement.lean",
        "Symbolic/Theorems/Security.lean",
        "LibsignalBinary/Specifications/SignalSession/CliElf.lean",
    )
    hub_lines = [len((oai_ref_dir / rel).read_text(encoding="utf-8").splitlines()) for rel in hub_paths]
    stock_ld = (oai_ref_dir / "third_party/libsignal/libsignal-session/cli-elf/stock.ld").read_text(encoding="utf-8")
    guards_txt = (oai_ref_dir / "LibsignalBinary/Specifications/LibsignalSpqrV1/Guards.lean").read_text(encoding="utf-8")
    fits_txt = (oai_ref_dir / "LibsignalBinary/Proofs/PeakBudget/CliFitsTraceArith.lean").read_text(encoding="utf-8")
    fds_txt = (oai_ref_dir / "LibsignalBinary/Proofs/SpecLemmas/SignalSession/ElfSlicesPqOomH2KM1.lean").read_text(encoding="utf-8")
    m_s4 = re.search(r"\b(1,?036,?375,?496)\b", fits_txt)
    assert m_s4 is not None
    peak_s4 = int(m_s4.group(1).replace(",", ""))
    phys_mem = 1 << 30

    return {
        "oai_ref_total_files": len(all_files),
        "oai_ref_lean_files": len(lean_files),
        "oai_ref_non_lean_files": len(non_lean_files),
        "oai_ref_lean_total_lines": lean_total_lines,
        "lakefile_root_lines": len(lakefile_txt.splitlines()),
        "lakefile_default_targets": len(re.findall(r"@\[default_target\]", lakefile_txt)),
        "cli_elf_hub_lines_sum": sum(hub_lines),
        "cli_elf_hub_line_tuple": hub_lines,
        "hook_table_placed_symbols": total_hooks,
        "pqxdh_spqr_hook_symbols": len(pq_hook_syms),
        "session_runtime_hook_symbols": len(extra_rows),
        "hooked_drop_zeroize_symbols": drop_zeroize_hooks,
        "panic_sigabrt_symbols": len(panic_syms),
        "dehooked_elf_symbols": len(dehooked_syms),
        "total_tracked_symbols": tracked,
        "bypassed_symbols": bypassed,
        "bypassed_symbol_fraction": f"{ratio.numerator}/{ratio.denominator}",
        "bypassed_symbol_percent": round(float(ratio) * 100, 4),
        "stock_ld_has_text_ab_split": ("text_a PT_LOAD FLAGS(5);" in stock_ld and "text_b PT_LOAD FLAGS(5);" in stock_ld),
        "raw_cpufeature_token_found": "[0xff#8, 3#8, 0#8, 0#8, 0#8]" in guards_txt,
        "fds_hi_frame_guard_found": "H2KGhostArms" in fds_txt,
        "phys_mem_avail_bytes": phys_mem,
        "peak_s4_footprint_bytes": peak_s4,
        "peak_heap_slack_bytes": phys_mem - peak_s4,
    }


def parse_rust_cli_harness_and_elf_pin(oai_ref_dir: Path) -> dict:
    """Live-parse Rust CLI harness sources, CliElf.lean SHA-256 pin, AGPL README, and Heap SYNC.txt."""
    cli_dir = oai_ref_dir / "third_party/libsignal/libsignal-session/cli"
    coins_rs = (cli_dir / "src/coins.rs").read_text(encoding="utf-8")
    cli_lib_rs = (cli_dir / "src/lib.rs").read_text(encoding="utf-8")
    stores_rs = (cli_dir / "src/stores.rs").read_text(encoding="utf-8")
    io_lib_rs = (cli_dir / "io/src/lib.rs").read_text(encoding="utf-8")
    ratchet_rs = (cli_dir / "ratchet/src/lib.rs").read_text(encoding="utf-8")
    handshake_rs = (cli_dir / "handshake/src/lib.rs").read_text(encoding="utf-8")
    libsig_readme = (oai_ref_dir / "third_party/libsignal/README.md").read_text(encoding="utf-8")
    cli_elf = (oai_ref_dir / "LibsignalBinary/Specifications/SignalSession/CliElf.lean").read_text(encoding="utf-8")
    heap_readme = (oai_ref_dir / "LibsignalBinary/Heap/README.md").read_text(encoding="utf-8")
    sync_txt = (oai_ref_dir / "LibsignalBinary/Heap/Fine/VendorFree/SYNC.txt").read_text(encoding="utf-8")

    m_stdin = re.search(r"STDIN_CAP:\s*usize\s*=\s*1\s*<<\s*(\d+)", io_lib_rs)
    m_file = re.search(r"FILE_CAP:\s*usize\s*=\s*1\s*<<\s*(\d+)", io_lib_rs)
    m_wchunk = re.search(r"WRITE_CHUNK_LEN:\s*usize\s*=\s*0x([0-9a-fA-F_]+)", io_lib_rs)
    m_ebadf = re.search(r"EBADF:\s*\w+\s*=\s*(\d+)", io_lib_rs)
    m_send = re.search(r"input\.len\(\)\s*>\s*([0-9_]+)", cli_lib_rs)
    m_keygen = re.search(r"\*n\s*<=\s*(\d+)", cli_lib_rs)
    m_bkey = re.search(r"signed id:u(\d+)\s*‖\s*base[\s/]*key\[(\d+)\]", stores_rs)
    m_elf_sha = re.search(r'sha256\s+"([0-9a-f]{64})"', cli_elf)
    assert m_stdin and m_file and m_wchunk and m_ebadf and m_send and m_keygen and m_bkey and m_elf_sha

    base_key_bytes = (int(m_bkey.group(1)) // 8) + int(m_bkey.group(2))
    sync_entries = [ln.strip() for ln in sync_txt.splitlines() if ln.strip() and not ln.strip().startswith("#")]
    crypto_rng_impls = sum("impl rand_core::CryptoRng for Coins" in txt for txt in (ratchet_rs, handshake_rs))

    return {
        "coins_zero_fill_tail": "dst[now.len()..].fill(0)" in coins_rs,
        "coins_crypto_rng_impl_crates": crypto_rng_impls,
        "io_stdin_cap_bytes": 1 << int(m_stdin.group(1)),
        "io_file_cap_bytes": 1 << int(m_file.group(1)),
        "io_write_chunk_len_bytes": int(m_wchunk.group(1).replace("_", ""), 16),
        "io_ebadf_errno": int(m_ebadf.group(1)),
        "cli_send_plaintext_cap_bytes": int(m_send.group(1).replace("_", "")),
        "cli_keygen_max_opks": int(m_keygen.group(1)),
        "stores_base_key_entry_bytes": base_key_bytes,
        "stores_opk_empty_file_delete": "put(name(id), Vec::new())" in stores_rs,
        "frozen_unix_epoch_clock": ("SystemTime::UNIX_EPOCH" in cli_lib_rs and "Timestamp::from_epoch_millis(0)" in cli_lib_rs),
        "single_poll_noop_waker": ("Waker::noop()" in handshake_rs and "Poll::Pending => None" in handshake_rs),
        "pinned_elf_gitignored_path": ".GeneratedLean/cli-elf/libsignal-cli.elf" in cli_elf,
        "pinned_elf_sha256": m_elf_sha.group(1),
        "agpl_license_declared": "AGPL-3.0-only" in libsig_readme,
        "generated_lean_gitignored": "compiled from AGPL-3.0-only source and is a derived work of libsignal" in libsig_readme,
        "panic_line_numbers_frozen": "the source line of every panic site is compiled into the verified machine code" in libsig_readme,
        "heap_imported_by_zero_headlines": bool(
            re.search(r"No headline theorem or statement specification in `Computational/` or `Symbolic/`\s+imports", heap_readme)
        ),
        "heap_sync_mirrored_files": len(sync_entries),
    }


def parse_hygiene_and_tcb_caveats(oai_ref_dir: Path) -> dict:
    """Live-parse refinement-hygiene scripts, READING_THE_THEOREMS.md, and Symbolic PAPER_DIFFERENCES.md."""
    hyg_sh = (oai_ref_dir / "Symbolic/scripts/check_refinement_hygiene.sh").read_text(encoding="utf-8")
    exempt_txt = (oai_ref_dir / "Symbolic/scripts/machine_free_exempt_specs.txt").read_text(encoding="utf-8")
    reading_md = (oai_ref_dir / "Computational/docs/READING_THE_THEOREMS.md").read_text(encoding="utf-8")
    pdiff_md = (oai_ref_dir / "docs/Symbolic/PAPER_DIFFERENCES.md").read_text(encoding="utf-8")

    def _bash_array(name: str) -> list[str]:
        m = re.search(rf"(?m)^{name}=\(\n(.*?)\n\)", hyg_sh, re.S)
        assert m is not None
        return [ln.strip() for ln in m.group(1).splitlines() if ln.strip() and not ln.strip().startswith("#")]

    cli_games = _bash_array("cli_cryptogames")
    cli_wit_own = [x for x in _bash_array("cli_wit") if not x.startswith('"${')]
    cli_trusted_own = [x for x in _bash_array("cli_trusted") if not x.startswith('"${')]
    cli_wit_len = len(cli_wit_own) + len(cli_games)
    cli_trusted_len = len(cli_trusted_own) + cli_wit_len
    file_patterns = _bash_array("files")
    kept_thms = _bash_array("kept_theorems")
    st_expect_sites = len(re.findall(r'\bst_expect\s+"', hyg_sh))
    comm_missing_lc = ('sort -u > "$scratch/st_trusted.txt"' in hyg_sh and 'comm -23 "$1" "$2"' in hyg_sh)

    m_ex_claim = re.search(r"Each of these\s+(\d+)\s+modules", exempt_txt)
    assert m_ex_claim is not None
    exempt_active = [ln.strip() for ln in exempt_txt.splitlines() if ln.strip() and not ln.strip().startswith("#")]

    reading_lines = reading_md.splitlines()
    t_start = next(i + 1 for i, ln in enumerate(reading_lines) if ln.startswith("## 5. Trust caveats"))
    t_end = next(i for i in range(t_start, len(reading_lines)) if reading_lines[i].startswith("## 6."))
    while t_end > t_start and (not reading_lines[t_end - 1].strip() or reading_lines[t_end - 1].strip() == "---"):
        t_end -= 1

    m_vc = re.search(r"### 5\.3 Important Scope Differences.*?\n(.*?)(?:\n---|\n## 6\.|\Z)", pdiff_md, re.S)
    assert m_vc is not None
    validcall_clauses = len(re.findall(r"(?m)^\|\s*\*\*\d+\.", m_vc.group(1)))

    return {
        "hygiene_cli_cryptogames": len(cli_games),
        "hygiene_cli_wit": cli_wit_len,
        "hygiene_cli_trusted": cli_trusted_len,
        "hygiene_cli_allowlist_total": len(cli_games) + cli_wit_len + cli_trusted_len,
        "hygiene_file_glob_entries": len(file_patterns),
        "hygiene_kept_theorems_declared": len(kept_thms),
        "hygiene_self_test_controls": st_expect_sites,
        "hygiene_comm_missing_lc_all_c": comm_missing_lc,
        "exempt_specs_claimed_mixed": int(m_ex_claim.group(1)),
        "exempt_specs_active_mixed": len(exempt_active),
        "exempt_specs_comment_drift": int(m_ex_claim.group(1)) - len(exempt_active),
        "reading_theorems_total_lines": len(reading_lines),
        "trust_caveats_start_line": t_start,
        "trust_caveats_end_line": t_end,
        "trust_caveats_line_span": t_end - t_start + 1,
        "trust_caveats_human_reviewed_ops": ("pqAtomicOps" in reading_md and "physical running-time" in reading_md),
        "spqr_classical_non_regression_only": "classical/hybrid non-regression guarantee" in pdiff_md,
        "tr_key_known_omits_mackey_and_iv": "`macKey` and `iv` are intentionally excluded" in pdiff_md,
        "validcall_restriction_clauses": validcall_clauses,
        "imperfect_memory_erasure_note": "imperfect memory erasure" in pdiff_md,
    }


def parse_arm64_tcb_testing_and_alink(oai_ref_dir: Path) -> dict:
    """Live-parse Arm64/Trusted TCB files, Arm64/TESTING.md fault skips, and alink_check.py Class Z stubs."""
    tcb_root = oai_ref_dir / "arm64-semantics/Arm64/Trusted"
    syscalls_raw = (tcb_root / "Syscalls.lean").read_text(encoding="utf-8")
    syscalls_txt = strip_lean_comments(syscalls_raw)
    m_std_tbl = re.search(r"def\s+standardTable\b.*?:=\s*([^\n]+)", syscalls_txt)
    m_sys_cnt = re.search(r"`(\d+)`\s+syscalls", syscalls_raw)
    assert m_std_tbl and m_sys_cnt
    syscall_families = [t.strip() for t in m_std_tbl.group(1).split("++") if t.strip()]

    mmap_txt = strip_lean_comments((tcb_root / "Syscalls/Mm/Mmap.lean").read_text(encoding="utf-8"))
    exit_txt = strip_lean_comments((tcb_root / "Syscalls/Kernel/Exit.lean").read_text(encoding="utf-8"))
    rw_raw = (tcb_root / "Syscalls/Fs/ReadWrite.lean").read_text(encoding="utf-8")
    sel_txt = strip_lean_comments((tcb_root / "Syscalls/Fs/Select.lean").read_text(encoding="utf-8"))
    ptypes_txt = strip_lean_comments((tcb_root / "Process/Types.lean").read_text(encoding="utf-8"))
    hoare_txt = strip_lean_comments((tcb_root / "Spec/Hoare.lean").read_text(encoding="utf-8"))
    eval_raw = (tcb_root / "ISA/Eval.lean").read_text(encoding="utf-8")
    m_rw_max = re.search(r"MAX_RW_COUNT.*?0x([0-9a-fA-F_]+)", rw_raw)
    assert m_rw_max is not None

    testing_md = (oai_ref_dir / "arm64-semantics/Arm64/TESTING.md").read_text(encoding="utf-8")
    alink_py = (oai_ref_dir / "scripts/stock-pin/alink_check.py").read_text(encoding="utf-8")
    m_st_unm = re.search(r"STATUS_UNMODELED\s*=\s*(\d+)", testing_md)
    m_st_flt = re.search(r"STATUS_FAULT_OTHER\s*=\s*(\d+)", testing_md)
    m_dweak = re.search(r"displaced_weak\s*==\s*\{(\d+)\s+outline\s+atomics\}", alink_py)
    assert m_st_unm and m_st_flt and m_dweak
    displaced_weak = int(m_dweak.group(1))

    return {
        "modeled_linux_syscalls": int(m_sys_cnt.group(1)),
        "syscall_dispatch_families": syscall_families,
        "arm64_trusted_eval_lines": len(eval_raw.splitlines()),
        "mmap_halts_on_oom": ".OutOfMemory" in mmap_txt,
        "exit_group_unmasked": ("Exited" in exit_txt and "&&&" not in exit_txt and "% 256" not in exit_txt),
        "max_rw_count_bytes": int(m_rw_max.group(1).replace("_", ""), 16),
        "ppoll_pollnval_trap": ("POLLNVAL" in sel_txt and "2#32" in sel_txt),
        "fixed_aslr_off_stack_and_mmap": ("0x00007fffffff0000#64" in ptypes_txt and "0x0000600000000000#64" in ptypes_txt),
        "at_random_zero_replicated": "List.replicate 16 0#8" in ptypes_txt,
        "hoare_normal_outcome_guard": ("SubroutineOutcome" in hoare_txt and ".OutOfMemory" in hoare_txt),
        "testing_status_unmodeled": int(m_st_unm.group(1)),
        "testing_status_fault_other": int(m_st_flt.group(1)),
        "testing_skip_sail_exemptions": sum(tok in testing_md for tok in ("`DC ZVA`", "`ADDV`")),
        "alink_class_z_udf0_four_bytes": (r'b"\x00\x00\x00\x00"' in alink_py and "st_size != 4" in alink_py),
        "alink_displaced_weak_atomics": displaced_weak,
    }


def parse_pqxdh_deviations_and_comparator(oai_ref_dir: Path) -> dict:
    """Live-parse PQXDH.md, GLOSSARY.md, DEVIATIONS.md, Cheval26/Synthetic disproofs, and comparator."""
    pqxdh_md = (oai_ref_dir / "Computational/docs/PQXDH.md").read_text(encoding="utf-8")
    glossary_md = (oai_ref_dir / "Computational/docs/GLOSSARY.md").read_text(encoding="utf-8")
    dev_md = (oai_ref_dir / "Computational/docs/DEVIATIONS.md").read_text(encoding="utf-8")
    paper_map = (oai_ref_dir / "docs/PAPER_MAP.md").read_text(encoding="utf-8")

    m_tot = re.search(r"(?m)^\|\s*total\s*\|\s*\d+\s*\|\s*\d+\s*\|\s*\d+\s*\|\s*\d+\s*\|\s*(\d+)\s*\|", dev_md)
    m_c3 = re.search(r"17\{?,\}?441\}\{16\{?,\}?384", pqxdh_md)
    m_q40 = re.search(r"q\\_total\}\s*=\s*2\^\{40\}", pqxdh_md)
    m_chains = re.search(r"at most\s+(\d+)\s+\(`MAX_RECEIVER_CHAINS`\)", glossary_md)
    m_jumps = re.search(r"`MAX_FORWARD_JUMPS`\s*\|\s*([0-9,]+)", glossary_md)
    m_mkeys = re.search(r"`MAX_MESSAGE_KEYS`\s*\|\s*([0-9,]+)", glossary_md)
    assert m_tot and m_c3 and m_q40 and m_chains and m_jumps and m_mkeys

    dev_headers = re.findall(r"(?m)^### (DEV-[A-Z0-9-]+)\b", dev_md)
    dev_lines = dev_md.splitlines()
    cheval_files = sorted((oai_ref_dir / "Symbolic/BugInjection/Disproofs").glob("Cheval26*Cli.lean"))
    carriers, unchecked = set(), 0
    for cf in cheval_files:
        raw = cf.read_text(encoding="utf-8")
        unchecked += int("not machine-checked as a counterexample" in raw)
        m_car = re.search(r"Disproofs\.Impl\.(Cheval26\w+)\.disproof", strip_lean_comments(raw))
        if m_car:
            carriers.add(m_car.group(1))

    synth_files = sorted((oai_ref_dir / "Symbolic/BugInjection/Synthetic/Disproofs").glob("*.lean"))
    synth_sorry = sum("sorry" in strip_lean_comments(sf.read_text(encoding="utf-8")) for sf in synth_files)
    fixtures_txt = strip_lean_comments((oai_ref_dir / "arm64-semantics/ProofLib/Testing/AxiomAudit/Fixtures.lean").read_text(encoding="utf-8"))
    comp_cfg = json.loads((oai_ref_dir / "comparator/computational.json").read_text(encoding="utf-8"))
    sym_cfg = json.loads((oai_ref_dir / "comparator/symbolic.json").read_text(encoding="utf-8"))
    run_sh = (oai_ref_dir / "comparator/run.sh").read_text(encoding="utf-8")
    all_entries = comp_cfg["theorem_names"] + sym_cfg["theorem_names"]
    short_names = [t.rsplit(".", 1)[-1] for t in all_entries]

    return {
        "deviations_table_claimed": int(m_tot.group(1)),
        "deviations_actual_headers": len(dev_headers),
        "deviations_missing_aead15": ("DEV-AEAD14" in dev_headers and "DEV-AEAD15" not in dev_headers),
        "dev_pq8_line": next(i + 1 for i, ln in enumerate(dev_lines) if ln.startswith("### DEV-PQ8")),
        "dev_pq9_line": next(i + 1 for i, ln in enumerate(dev_lines) if ln.startswith("### DEV-PQ9")),
        "dev_pq19_classical_only": ("### DEV-PQ19" in dev_md and "pqxdhHndlKeyIndExp" in dev_md),
        "pqxdh_q_total_budget": 1 << 40,
        "pqxdh_c3_numerator": 17441,
        "pqxdh_c3_denominator": 16384,
        "pqxdh_step_cost_budget_2pow96": "2^{96.00}" in pqxdh_md,
        "pqxdh_term5_vacuous_2pow010": "2^{+0.10}" in pqxdh_md,
        "glossary_max_receiver_chains": int(m_chains.group(1)),
        "glossary_max_forward_jumps": int(m_jumps.group(1).replace(",", "")),
        "glossary_max_message_keys": int(m_mkeys.group(1).replace(",", "")),
        "glossary_spqr_off_standalone": ("off in the verified image" in glossary_md and "spqrOffSessionParams" in dev_md),
        "cheval26_witness_files": len(cheval_files),
        "cheval26_distinct_carriers": len(carriers),
        "cheval26_aliased_unchecked_traces": unchecked,
        "paper_map_stale_t12d_claim": "Pending retarget (`T-12(d)`)" in paper_map,
        "synthetic_disproof_sorry_files": synth_sorry,
        "axiom_audit_fixture_sorrys": len(re.findall(r"\bsorry\b", fixtures_txt)),
        "computational_json_entries": len(comp_cfg["theorem_names"]),
        "symbolic_json_entries": len(sym_cfg["theorem_names"]),
        "total_json_entries": len(all_entries),
        "unique_headline_theorems": len(set(short_names)),
        "duplicate_symbolic_entries": sorted({s for s in short_names if short_names.count(s) > 1}),
        "enable_nanoda_computational": comp_cfg["enable_nanoda"],
        "enable_nanoda_symbolic": sym_cfg["enable_nanoda"],
        "prewarm_outside_landrun": ("prewarm_targets" in run_sh and "landrun" in run_sh),
    }
