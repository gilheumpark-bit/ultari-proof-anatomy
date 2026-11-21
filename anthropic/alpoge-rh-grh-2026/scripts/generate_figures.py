#!/usr/bin/env python3
import json
import math
import pathlib
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.font_manager as fm
import matplotlib.patches as mpatches

ROOT = pathlib.Path(__file__).resolve().parents[1]
DATA_DIR = ROOT / "data"
FIG_DIR = ROOT / "figures"

STRINGS = {
    "ko": {
        "sfx": "",
        "f1_buckets": [
            "아벨 다양체·인자 (기출 재증명 주력)",
            "신작 핵심 본체 (Formalism 5막)",
            "최상위 보형·갈루아 결합부",
            "보형 스펙트럼·기하 분해",
            "p-진 호지·높이·기초 이론",
            "베유 상한·상호법칙·기타",
        ],
        "f1_bar": "{v:.2f}백만 줄 ({pct:.1f}%)",
        "f1_x": "코드 분량 (백만 줄, 전체 17.37백만 줄)",
        "f1_t": "도판 1. 1,737만 줄 Lean 아카이브의 실제 구성 비율 (기출 기초공사 대 신작 본체)",
        "f2_l1": "가상 이탈 영점 존재 시 진동 폭 (X^0.75)",
        "f2_l2": "리만 가설 임계선 기준선 (sqrt(X) = X^0.5)",
        "f2_l3": "실제 소수 잔차 |Gz(X)| (X=10,000에서 1.75)",
        "f2_x": "조사 구간 X",
        "f2_y": "크기 (로그 눈금)",
        "f2_t": "도판 2. 실제 소수 적분 잔차 |Gz(X)| 대 가상 이탈 영점(0.75)의 폭주 비교",
        "f3_l1": "체비쇼프 이산화 오차 (X / m)",
        "f3_l2": "단순 리프트 누적 손실 (~ m^2 : m=X^(1/3)에서 2/3 장벽 충돌)",
        "f3_l3": "시소·헤케 평균 약분 후 제어 스케일 (~ m : m=sqrt(X)=100 도달)",
        "f3_a1": "단순 계산 정지점\n(m 약 21.5, 2/3 장벽)",
        "f3_a2": "시소 약분 후 균형점\n(m = sqrt(X) = 100, 1/2 기준선 도달)",
        "f3_x": "세타 리프트 반복 횟수 m (X = 10,000 기준)",
        "f3_y": "오차 및 손실 스케일 (로그 눈금)",
        "f3_t": "도판 3. 단순 리프트의 2/3 정지점 대 시소 약분 후 m = sqrt(X) 균형점 비교",
        "f4_bars": ["국소 랑글란즈\n(recTExists)", "갈루아-세타 정합\n(RowSrc)", "보형 창문·반디버\n(vwin_of_row)"],
        "f4_unit": "{v:.2f}M줄",
        "f4_x": "추이적 의존 콘 크기 (백만 줄)",
        "f4_ta": "A. 3대 척추 정점의 의존 분량",
        "f4_tb": "B. VWin(Ct=401) 내부 복소켤레 기우성(Parity) 분해",
        "f4_b1": "홀수(minus) 기우성 날개\n• 슈티켈베르거 합동 (Odd a)\n• 페레로-워싱턴 (mu = 0)\n• 가토 GL2 오일러 계 (CountI)\n• 베렌트 체 (ThmBcFree)",
        "f4_b2": "짝수(plus · 반디버) 날개\n• 슈티켈베르거 작용 = 0 (맹점)\n• 심플렉틱 GSp4 (CountII·III)\n• 유니터리 U(3) 히다 패칭 (CountV)\n• 아벨 다양체 8.14M줄 동원",
        "f4_b3": "합류 결론 : HVCore.of_four_alt → VWin (Ct = 401, eps < 1/52)\n샤파레비치-테이트 길이 합 ∑ (log l) · shaLen(E, e) ≤ exp(x^eps / 2)",
        "f4_join": "PointHV 결합",
        "f4_sup": "도판 4. 보형 창문 정리(VWin)의 1,609만 줄 의존 콘과 홀·짝 기우성(Parity) 양날개 구조",
    },
    "en": {
        "sfx": "_en",
        "f1_buckets": [
            "Abelian Varieties & Divisors (Literature Core)",
            "Novel Core Engine (Formalism, 5 Acts)",
            "Top Automorphic-Galois Assembly",
            "Automorphic Spectrum & Geometry",
            "p-adic Hodge, Heights & Foundations",
            "Weil Bound, Reciprocity & Others",
        ],
        "f1_bar": "{v:.2f}M lines ({pct:.1f}%)",
        "f1_x": "Code Volume (Million Lines, Total 17.37M Lines)",
        "f1_t": "Figure 1. Composition of the 17.37M-Line Lean Archive",
        "f2_l1": "Hypothetical Off-Line Zero Scale (X^0.75)",
        "f2_l2": "Riemann Hypothesis Critical Threshold (sqrt(X) = X^0.5)",
        "f2_l3": "Observed Prime Residual |Gz(X)| (1.75 at X = 10,000)",
        "f2_x": "Cutoff Scale X",
        "f2_y": "Magnitude (Log Scale)",
        "f2_t": "Figure 2. Smoothed Prime Residual |Gz(X)| vs Off-Line Zero Blowup (Re(rho) = 0.75)",
        "f3_l1": "Chebyshev Discretization Error (X / m)",
        "f3_l2": "Unreduced Lift Loss (~ m^2 : Stalls at 2/3 Barrier, m = X^(1/3))",
        "f3_l3": "Seesaw & Rank-Normalized Scale (~ m : Reaches m = sqrt(X) = 100)",
        "f3_a1": "Naive Stall Point\n(m ~ 21.5, 2/3 Barrier)",
        "f3_a2": "Normalized Balance Point\n(m = sqrt(X) = 100, Re(s) = 1/2)",
        "f3_x": "Iterated Theta-Lift Chain Length m (at X = 10,000)",
        "f3_y": "Error and Loss Scale (Log Scale)",
        "f3_t": "Figure 3. Naive 2/3 Lift Barrier vs Seesaw-Normalized m = sqrt(X) Balance",
        "f4_bars": ["Local Langlands\n(recTExists)", "Galois-Theta Bridge\n(RowSrc)", "Automorphic Window\n(vwin_of_row)"],
        "f4_unit": "{v:.2f}M",
        "f4_x": "Transitive Import Cone (Million Lines)",
        "f4_ta": "A. 3 Spine Import Cones",
        "f4_tb": "B. Parity Split in VWin (Ct = 401)",
        "f4_b1": "Odd (minus) Wing\n• Stickelberger (Odd a)\n• Ferrero-Washington (mu=0)\n• Kato GL2 System (CountI)\n• Behrend Sieve (ThmBcFree)",
        "f4_b2": "Even (plus / Vandiver) Wing\n• Stickelberger Action = 0\n• Symplectic GSp4 (CountII,III)\n• U(3) Hida Patching (CountV)\n• 8.14M Abelian-Variety Cone",
        "f4_b3": "Merged: HVCore.of_four_alt → VWin (Ct = 401, eps < 1/52)\nShafarevich-Tate Sum ∑ (log l) · shaLen(E, e) ≤ exp(x^eps / 2)",
        "f4_join": "PointHV Merge",
        "f4_sup": "Figure 4. The 16.09M-Line VWin Dependency Cone and Its Odd/Even Parity Wings",
    },
}


def configure_font(lang: str):
    avail = {f.name for f in fm.fontManager.ttflist}
    prefs = (
        ["NanumSquare Neo", "Noto Sans CJK KR", "NanumBarunGothic", "NanumGothic"]
        if lang == "ko"
        else ["DejaVu Sans", "Liberation Sans", "Noto Sans", "NanumSquare Neo"]
    )
    plt.rcParams["font.family"] = next((p for p in prefs if p in avail), "DejaVu Sans")
    plt.rcParams["axes.unicode_minus"] = False


def make_fig1_anatomy(t: dict):
    stats = json.loads((DATA_DIR / "anatomy_stats.json").read_text(encoding="utf-8"))
    b = stats["buckets"]
    other = (
        b["Development.WeilBound"]["lines"] + b["ReciprocityTheory"]["lines"]
        + b["CompanionTheory"]["lines"] + b["Development.ResolutionOfSingularities"]["lines"]
        + b["Development.EtaleCohomology"]["lines"] + b["PositivityTheory"]["lines"]
        + b["Development.DiscreteGroups"]["lines"] + b["Lemmata"]["lines"] + 70
    ) / 1e6
    raw_vals = [
        b["Development.AbelianVarietyTheory"]["lines"] / 1e6,
        b["Formalism"]["lines"] / 1e6,
        b["Development.AutomorphicArithmetic"]["lines"] / 1e6,
        b["Development.AutomorphicSpectrum"]["lines"] / 1e6,
        b["GroundTheory"]["lines"] / 1e6,
        other,
    ]
    raw_cols = ["#4A5568", "#B83227", "#1F5A73", "#64748B", "#788696", "#94A3B8"]
    labels = list(reversed(t["f1_buckets"]))
    vals = list(reversed(raw_vals))
    cols = list(reversed(raw_cols))

    fig, ax = plt.subplots(figsize=(8.8, 4.4), dpi=220)
    fig.patch.set_facecolor("#FAF9F6")
    ax.set_facecolor("#FAF9F6")
    bars = ax.barh(labels, vals, color=cols, height=0.58, edgecolor="#2D3748", linewidth=0.6)
    for bar, v in zip(bars, vals):
        pct = v * 1e6 / stats["total_lines"] * 100.0
        ax.text(v + 0.14, bar.get_y() + bar.get_height() / 2, t["f1_bar"].format(v=v, pct=pct),
                va="center", ha="left", fontsize=9.3, color="#1A202C", fontweight="bold")
    ax.set_xlim(0, 11.5)
    ax.set_xlabel(t["f1_x"], fontsize=10, color="#2D3748")
    fig.suptitle(t["f1_t"], fontsize=11.0, fontweight="bold", color="#1A202C", y=0.97)
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    ax.grid(axis="x", linestyle="--", alpha=0.35, color="#A0AEC0")
    fig.tight_layout(rect=[0, 0, 1, 0.93])
    fig.savefig(FIG_DIR / f"fig1_archive_breakdown{t['sfx']}.png", dpi=220)
    plt.close(fig)


def make_fig2_residual(t: dict):
    lab = json.loads((DATA_DIR / "prime_lab_results.json").read_text(encoding="utf-8"))
    rows = lab["von_mangoldt_table"]
    xs = [r["X"] for r in rows]
    gz = [abs(r["Gz_X_residual"]) for r in rows]
    sqrt_bound = [math.sqrt(x) for x in xs]
    fake_075 = [r["hypothetical_offline_0p75_scale"] for r in rows]

    fig, ax = plt.subplots(figsize=(8.2, 4.4), dpi=220)
    fig.patch.set_facecolor("#FAF9F6")
    ax.set_facecolor("#FAF9F6")
    ax.plot(xs, fake_075, marker="s", linewidth=2.2, linestyle="--", color="#B83227", label=t["f2_l1"])
    ax.plot(xs, sqrt_bound, marker="^", linewidth=1.9, linestyle="-.", color="#1F5A73", label=t["f2_l2"])
    ax.plot(xs, gz, marker="o", linewidth=2.5, color="#1E6B52", label=t["f2_l3"])
    ax.set_yscale("log")
    ax.set_ylim(0.5, 2500)
    ax.set_xlabel(t["f2_x"], fontsize=10, color="#2D3748")
    ax.set_ylabel(t["f2_y"], fontsize=10, color="#2D3748")
    ax.set_title(t["f2_t"], fontsize=11.0, fontweight="bold", pad=12, color="#1A202C")
    ax.legend(frameon=True, facecolor="#FFFFFF", edgecolor="#CBD5E1", fontsize=8.8,
              loc="center right", bbox_to_anchor=(0.98, 0.36))
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    ax.grid(True, which="both", linestyle=":", alpha=0.45, color="#94A3B8")
    fig.tight_layout()
    fig.savefig(FIG_DIR / f"fig2_residual_vs_fake_zero{t['sfx']}.png", dpi=220)
    plt.close(fig)


def make_fig3_barrier(t: dict):
    x_val = 10000.0
    ms = [float(k) for k in range(5, 165, 3)]
    fig, ax = plt.subplots(figsize=(8.2, 4.4), dpi=220)
    fig.patch.set_facecolor("#FAF9F6")
    ax.set_facecolor("#FAF9F6")
    ax.plot(ms, [x_val / m for m in ms], linewidth=2.3, color="#1F5A73", label=t["f3_l1"])
    ax.plot(ms, [m ** 2 for m in ms], linewidth=2.0, linestyle="--", color="#9C4221", label=t["f3_l2"])
    ax.plot(ms, [1.0 * m for m in ms], linewidth=2.3, color="#1E6B52", label=t["f3_l3"])
    ax.scatter([x_val ** (1.0 / 3.0)], [x_val ** (2.0 / 3.0)], color="#9C4221", zorder=5, s=55)
    ax.annotate(t["f3_a1"], xy=(21.54, 464.16), xytext=(8, 4200),
                arrowprops={"arrowstyle": "->", "color": "#9C4221", "lw": 1.2},
                fontsize=8.7, color="#7B341E", fontweight="bold")
    ax.scatter([100.0], [100.0], color="#B83227", zorder=6, s=65)
    ax.annotate(t["f3_a2"], xy=(100.0, 100.0), xytext=(72, 18),
                arrowprops={"arrowstyle": "->", "color": "#B83227", "lw": 1.4},
                fontsize=9.0, color="#B83227", fontweight="bold")
    ax.set_yscale("log")
    ax.set_ylim(8, 160000)
    ax.set_xlabel(t["f3_x"], fontsize=10, color="#2D3748")
    ax.set_ylabel(t["f3_y"], fontsize=10, color="#2D3748")
    ax.set_title(t["f3_t"], fontsize=10.8, fontweight="bold", pad=12, color="#1A202C")
    ax.legend(frameon=True, facecolor="#FFFFFF", edgecolor="#CBD5E1", fontsize=8.6, loc="upper left")
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    ax.grid(True, which="both", linestyle=":", alpha=0.45, color="#94A3B8")
    fig.tight_layout()
    fig.savefig(FIG_DIR / f"fig3_lift_cost_barrier{t['sfx']}.png", dpi=220)
    plt.close(fig)


def make_fig4_parity_vwin(t: dict):
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(9.4, 4.5), dpi=220, gridspec_kw={"width_ratios": [1.05, 1.28]})
    fig.patch.set_facecolor("#FAF9F6")
    ax1.set_facecolor("#FAF9F6")
    ax2.set_facecolor("#FAF9F6")
    vals = [4.21, 7.85, 16.09]
    cols = ["#64748B", "#1F5A73", "#B83227"]
    bars = ax1.barh(t["f4_bars"], vals, color=cols, height=0.52, edgecolor="#1E293B", linewidth=0.7)
    for bar, v in zip(bars, vals):
        ax1.text(v + 0.3, bar.get_y() + bar.get_height() / 2, t["f4_unit"].format(v=v),
                 va="center", ha="left", fontsize=9.0, fontweight="bold", color="#1A202C")
    ax1.set_xlim(0, 20.5)
    ax1.set_xlabel(t["f4_x"], fontsize=9.2, color="#2D3748")
    ax1.set_title(t["f4_ta"], fontsize=10.0, fontweight="bold", color="#0F172A", pad=10)
    ax1.spines["top"].set_visible(False)
    ax1.spines["right"].set_visible(False)
    ax1.grid(axis="x", linestyle="--", alpha=0.35, color="#94A3B8")

    ax2.axis("off")
    ax2.set_xlim(-0.2, 10.2)
    ax2.set_ylim(0, 10)
    ax2.set_title(t["f4_tb"], fontsize=9.8, fontweight="bold", color="#0F172A", pad=10)
    boxes = [
        (0.1, 5.85, 4.65, 3.35, "#EBF8FF", "#1F5A73", t["f4_b1"]),
        (5.25, 5.85, 4.65, 3.35, "#FFF5F5", "#B83227", t["f4_b2"]),
        (0.6, 0.85, 8.8, 2.85, "#EDF2F7", "#1E293B", t["f4_b3"]),
    ]
    for x, y, w, h, fc, ec, txt in boxes:
        rect = mpatches.FancyBboxPatch((x, y), w, h, boxstyle="round,pad=0.2", facecolor=fc, edgecolor=ec, linewidth=1.3)
        ax2.add_patch(rect)
        ax2.text(x + w / 2, y + h / 2, txt, ha="center", va="center", fontsize=7.7, color="#1A202C", linespacing=1.42)
    ax2.annotate("", xy=(3.6, 3.95), xytext=(2.5, 5.8), arrowprops={"arrowstyle": "->", "color": "#1F5A73", "lw": 1.6})
    ax2.annotate("", xy=(6.4, 3.95), xytext=(7.5, 5.8), arrowprops={"arrowstyle": "->", "color": "#B83227", "lw": 1.6})
    ax2.text(5.0, 4.85, t["f4_join"], ha="center", va="center", fontsize=8.3, fontweight="bold", color="#334155")
    fig.suptitle(t["f4_sup"], fontsize=10.9, fontweight="bold", color="#0F172A", y=0.98)
    fig.tight_layout(rect=[0, 0, 1, 0.93])
    fig.savefig(FIG_DIR / f"fig4_vwin_parity_and_counts{t['sfx']}.png", dpi=220)
    plt.close(fig)


def main():
    FIG_DIR.mkdir(parents=True, exist_ok=True)
    for lang in ("ko", "en"):
        configure_font(lang)
        t = STRINGS[lang]
        make_fig1_anatomy(t)
        make_fig2_residual(t)
        make_fig3_barrier(t)
        make_fig4_parity_vwin(t)
    print("FIGURES_OK: 8 high-DPI editorial charts generated (4 KO + 4 EN).")


if __name__ == "__main__":
    main()
