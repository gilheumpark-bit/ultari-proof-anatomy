#!/usr/bin/env python3
"""
Generate 8 publication-grade high-DPI scientific figures (4 Korean + 4 English)
for the Part A Monograph from measured AST data in atlas/data/atlas_summary.json.
"""
import json
import pathlib
import sys

sys.dont_write_bytecode = True

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.font_manager as fm

ROOT = pathlib.Path(__file__).resolve().parents[1]
SUMMARY_PATH = ROOT / "atlas/data/atlas_summary.json"
FIG_DIR = ROOT / "figures"


def configure_font(lang: str):
    if lang == "ko":
        candidates = [
            "Noto Sans CJK KR",
            "Noto Sans KR",
            "NanumGothic",
            "Malgun Gothic",
            "UnDotum",
            "DejaVu Sans",
        ]
    else:
        candidates = [
            "DejaVu Sans",
            "Liberation Sans",
            "Noto Sans",
        ]
    avail = {f.name for f in fm.fontManager.ttflist}
    for c in candidates:
        if c in avail:
            plt.rcParams["font.family"] = c
            break
    plt.rcParams["axes.unicode_minus"] = False


def render_suite(summary: dict, lang: str):
    configure_font(lang)
    sfx = "" if lang == "ko" else "_en"

    # 1. Fig 01: Whole Archive vs Part A-B Decompilation Stratification
    fig, ax = plt.subplots(figsize=(10.6, 5.2), dpi=220)
    if lang == "ko":
        labels = [
            "전체 아카이브\n(175,187개 파일)",
            "기출 문헌 재증명 하부\n(약 145,100개 파일)",
            "신작 코어 Formalism\n(18,254개 파일 · B01~B05)",
            "신작 반디버·보형 VWin\n(10,832개 파일 · B06~B08)",
            "PublishedTheorems + 201임포트\n(1,258개 파일 · A02·B09)",
        ]
    else:
        labels = [
            "Entire Archive\n(175,187 files)",
            "Classical Re-Proof Lower Cone\n(~145,100 files)",
            "Novel Core: Formalism\n(18,254 files · B01-B05)",
            "Novel Vandiver Bypass: Pure_Vwin\n(10,832 files · B06-B08)",
            "PublishedTheorems + 201 Imports\n(1,258 files · A02 · B09)",
        ]
    lines_m = [17.374, 13.150, 3.201, 1.029, 0.119]
    colors = ["#1e293b", "#64748b", "#0f766e", "#0284c7", "#b45309"]
    bars = ax.barh(labels[::-1], lines_m[::-1], color=colors[::-1], height=0.56, edgecolor="#0f172a", linewidth=0.8)
    for bar, val in zip(bars, lines_m[::-1]):
        unit = "줄" if lang == "ko" else "lines"
        ax.text(
            bar.get_width() + 0.22,
            bar.get_y() + bar.get_height() / 2,
            f"{val:.3f}M {unit} ({val / 17.374215 * 100:.2f}%)",
            va="center",
            fontsize=9.5,
            fontweight="bold",
            color="#0f172a",
        )
    ax.set_xlim(0, 21.8)
    if lang == "ko":
        ax.set_xlabel("Lean 4 소스 코드 분량 (백만 줄, 실측)", fontsize=10.5, fontweight="bold")
        ax.set_title("알푀게 리만 가설 아카이브 계층 분해 및 Part A-B 해독 범위 (단위: 백만 줄)", fontsize=12, fontweight="bold", pad=12)
    else:
        ax.set_xlabel("Lean 4 Source Code Volume (Million Lines, Measured)", fontsize=10.5, fontweight="bold")
        ax.set_title("Alpöge-Claude RH Archive Stratification & Part A-B Decompilation Scope", fontsize=12, fontweight="bold", pad=12)
    ax.grid(axis="x", linestyle="--", alpha=0.35)
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    fig.tight_layout()
    fig.savefig(FIG_DIR / f"fig_ab_01_archive_stratification{sfx}.png", bbox_inches="tight", pad_inches=0.12)
    plt.close(fig)

    # 2. Fig 02: Formalism Top 16 Subtheories by Line Count
    fig, ax = plt.subplots(figsize=(10.6, 6.4), dpi=220)
    top_sub = summary["formalism_subtheories"][:16]
    names = [s["name"].replace("Formalism.", "") for s in top_sub][::-1]
    vals = [s["lines"] / 1000.0 for s in top_sub][::-1]
    thms = [s["theorems"] for s in top_sub][::-1]
    bar_colors = ["#0f766e" if v > 100 else "#0369a1" for v in vals]
    bars = ax.barh(names, vals, color=bar_colors, height=0.62, edgecolor="#0f172a", linewidth=0.6)
    for bar, v, t in zip(bars, vals, thms):
        lbl = f"{v:,.1f}K 줄 (정리 {t:,}개)" if lang == "ko" else f"{v:,.1f}K lines ({t:,} thms)"
        ax.text(
            bar.get_width() + 14,
            bar.get_y() + bar.get_height() / 2,
            lbl,
            va="center",
            fontsize=8.6,
            color="#0f172a",
        )
    ax.set_xlim(0, 1210)
    if lang == "ko":
        ax.set_xlabel("코드 분량 (천 줄, 실측)", fontsize=10.5, fontweight="bold")
        ax.set_title("신작 코어 Formalism 상위 16대 소이론 분량 및 정리 분포 (전체 116개 소이론 중)", fontsize=11.8, fontweight="bold", pad=12)
    else:
        ax.set_xlabel("Source Volume (Thousand Lines, Measured)", fontsize=10.5, fontweight="bold")
        ax.set_title("Top 16 Novel Formalism Subtheories by Code Volume & Theorems (of 116 Total)", fontsize=11.6, fontweight="bold", pad=12)
    ax.grid(axis="x", linestyle="--", alpha=0.35)
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    fig.tight_layout()
    fig.savefig(FIG_DIR / f"fig_ab_02_formalism_subtheories{sfx}.png", bbox_inches="tight", pad_inches=0.12)
    plt.close(fig)

    # 3. Fig 03: Top 18 Novel Hub Modules by In-Degree
    fig, ax = plt.subplots(figsize=(10.9, 6.4), dpi=220)
    hubs = summary["top_100_novel_hubs"][:18][::-1]
    h_names = [
        h["rel"].split("/")[0][:4] + "/../" + "/".join(h["rel"].split("/")[-2:]).replace(".lean", "")
        for h in hubs
    ]
    h_deg = [h["in_degree"] for h in hubs]
    h_dist = [h["dist"] for h in hubs]
    bars = ax.barh(h_names, h_deg, color="#4338ca", height=0.62, edgecolor="#1e1b4b", linewidth=0.6)
    for bar, dg, ds in zip(bars, h_deg, h_dist):
        lbl = f"피참조 {dg:,}회 (Main 거리 {ds})" if lang == "ko" else f"in_degree={dg:,} (dist={ds})"
        ax.text(
            bar.get_width() + 12,
            bar.get_y() + bar.get_height() / 2,
            lbl,
            va="center",
            fontsize=8.5,
            color="#0f172a",
        )
    ax.set_xlim(0, 1300)
    if lang == "ko":
        ax.set_xlabel("아카이브 내부 직접 임포트 피참조 횟수 (in_degree)", fontsize=10.5, fontweight="bold")
        ax.set_title("신작 영역(Formalism ∪ Pure_Vwin) 최다 피참조 핵심 허브 모듈 Top 18", fontsize=11.4, fontweight="bold", pad=12)
    else:
        ax.set_xlabel("Direct Internal Import Count (in_degree)", fontsize=10.5, fontweight="bold")
        ax.set_title("Top 18 Most-Imported Hubs in Novel Cone (Formalism ∪ Pure_Vwin)", fontsize=10.8, fontweight="bold", pad=12)
    ax.grid(axis="x", linestyle="--", alpha=0.35)
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    fig.tight_layout()
    fig.savefig(FIG_DIR / f"fig_ab_03_top_hubs_indegree{sfx}.png", bbox_inches="tight", pad_inches=0.12)
    plt.close(fig)

    # 4. Fig 04: Tactic Profile Across All Novel Declarations
    n_novel = summary["novel_union_declarations"]
    aesop_cnt = summary["novel_tactic_file_decl_hits"].get("aesop", 0)
    fig, ax = plt.subplots(figsize=(10.6, 5.8), dpi=220)
    tacs = list(summary["novel_tactic_file_decl_hits"].items())[:16][::-1]
    t_names = [k for k, _ in tacs]
    t_vals = [v / 1000.0 for _, v in tacs]
    bars = ax.barh(t_names, t_vals, color="#0d9488", height=0.62, edgecolor="#134e4a", linewidth=0.6)
    for bar, (_, raw_v) in zip(bars, tacs):
        lbl = f"{raw_v:,}개 선언 ({raw_v / n_novel * 100:.1f}%)" if lang == "ko" else f"{raw_v:,} decls ({raw_v / n_novel * 100:.1f}%)"
        ax.text(
            bar.get_width() + 1.8,
            bar.get_y() + bar.get_height() / 2,
            lbl,
            va="center",
            fontsize=8.6,
            color="#0f172a",
        )
    ax.set_xlim(0, 166)
    if lang == "ko":
        ax.set_xlabel(f"사용 선언 수 (천 개, 신작 선언 모수 {n_novel:,}개)", fontsize=10.5, fontweight="bold")
        ax.set_title(f"신작 영역 {n_novel:,}개 선언의 증명 전술(Tactic) 분포 (aesop 단 {aesop_cnt}건 = {aesop_cnt / n_novel * 100:.3f}%)", fontsize=11.6, fontweight="bold", pad=12)
    else:
        ax.set_xlabel(f"Declarations Using Tactic (Thousands, Total Novel Decls = {n_novel:,})", fontsize=10.5, fontweight="bold")
        ax.set_title(f"Tactic Usage Across {n_novel:,} Novel Declarations (aesop = {aesop_cnt} hits, {aesop_cnt / n_novel * 100:.3f}%)", fontsize=11.4, fontweight="bold", pad=12)
    ax.grid(axis="x", linestyle="--", alpha=0.35)
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    fig.tight_layout()
    fig.savefig(FIG_DIR / f"fig_ab_04_tactic_anatomy{sfx}.png", bbox_inches="tight", pad_inches=0.12)
    plt.close(fig)


def main():
    FIG_DIR.mkdir(parents=True, exist_ok=True)
    summary = json.loads(SUMMARY_PATH.read_text(encoding="utf-8"))
    render_suite(summary, "ko")
    render_suite(summary, "en")
    print("Generated 8 figures (4 KO + 4 EN) in", FIG_DIR)


if __name__ == "__main__":
    main()
