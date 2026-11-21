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


def configure_korean_font():
    preferred = ["NanumSquare Neo", "Noto Sans CJK KR", "NanumBarunGothic", "NanumGothic"]
    avail = {f.name for f in fm.fontManager.ttflist}
    chosen = next((p for p in preferred if p in avail), "DejaVu Sans")
    plt.rcParams["font.family"] = chosen
    plt.rcParams["axes.unicode_minus"] = False


def make_fig1_anatomy():
    stats = json.loads((DATA_DIR / "anatomy_stats.json").read_text(encoding="utf-8"))
    b = stats["buckets"]
    items = [
        ("아벨 다양체·인자 (기출 재증명 주력)", b["Development.AbelianVarietyTheory"]["lines"] / 1e6, "#4A5568"),
        ("신작 핵심 본체 (Formalism 5막)", b["Formalism"]["lines"] / 1e6, "#B83227"),
        ("최상위 보형·갈루아 결합부", b["Development.AutomorphicArithmetic"]["lines"] / 1e6, "#1F5A73"),
        ("보형 스펙트럼·기하 분해", b["Development.AutomorphicSpectrum"]["lines"] / 1e6, "#64748B"),
        ("p-진 호지·높이·기초 이론", b["GroundTheory"]["lines"] / 1e6, "#788696"),
        ("베유 상한·상호법칙·기타", (
            b["Development.WeilBound"]["lines"] + b["ReciprocityTheory"]["lines"]
            + b["CompanionTheory"]["lines"] + b["Development.ResolutionOfSingularities"]["lines"]
            + b["Development.EtaleCohomology"]["lines"] + b["PositivityTheory"]["lines"]
            + b["Development.DiscreteGroups"]["lines"] + b["Lemmata"]["lines"] + 70
        ) / 1e6, "#94A3B8"),
    ]
    labels = [x[0] for x in reversed(items)]
    vals = [x[1] for x in reversed(items)]
    cols = [x[2] for x in reversed(items)]

    fig, ax = plt.subplots(figsize=(8.6, 4.4), dpi=220)
    fig.patch.set_facecolor("#FAF9F6")
    ax.set_facecolor("#FAF9F6")
    bars = ax.barh(labels, vals, color=cols, height=0.58, edgecolor="#2D3748", linewidth=0.6)
    for bar, v in zip(bars, vals):
        pct = v * 1e6 / stats["total_lines"] * 100.0
        ax.text(v + 0.14, bar.get_y() + bar.get_height() / 2, f"{v:.2f}백만 줄 ({pct:.1f}%)",
                va="center", ha="left", fontsize=9.5, color="#1A202C", fontweight="bold")
    ax.set_xlim(0, 10.3)
    ax.set_xlabel("코드 분량 (백만 줄, 전체 17.37백만 줄)", fontsize=10, color="#2D3748")
    ax.set_title("도판 1. 1,737만 줄 Lean 아카이브의 실제 구성 비율 (기출 기초공사 대 신작 본체)",
                 fontsize=11.5, fontweight="bold", pad=12, color="#1A202C")
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    ax.grid(axis="x", linestyle="--", alpha=0.35, color="#A0AEC0")
    fig.tight_layout()
    fig.savefig(FIG_DIR / "fig1_archive_breakdown.png", dpi=220)
    plt.close(fig)


def make_fig2_residual():
    lab = json.loads((DATA_DIR / "prime_lab_results.json").read_text(encoding="utf-8"))
    rows = lab["von_mangoldt_table"]
    xs = [r["X"] for r in rows]
    gz = [abs(r["Gz_X_residual"]) for r in rows]
    sqrt_bound = [math.sqrt(x) for x in xs]
    fake_075 = [r["hypothetical_offline_0p75_scale"] for r in rows]

    fig, ax = plt.subplots(figsize=(8.2, 4.4), dpi=220)
    fig.patch.set_facecolor("#FAF9F6")
    ax.set_facecolor("#FAF9F6")
    ax.plot(xs, fake_075, marker="s", linewidth=2.2, linestyle="--", color="#B83227",
            label="가상 이탈 영점 존재 시 진동 폭 (X^0.75)")
    ax.plot(xs, sqrt_bound, marker="^", linewidth=1.9, linestyle="-.", color="#1F5A73",
            label="리만 가설 임계선 기준선 (sqrt(X) = X^0.5)")
    ax.plot(xs, gz, marker="o", linewidth=2.5, color="#1E6B52",
            label="실제 소수 잔차 |Gz(X)| (X=10,000에서 1.75)")

    ax.set_yscale("log")
    ax.set_ylim(0.5, 2500)
    ax.set_xlabel("조사 구간 X", fontsize=10, color="#2D3748")
    ax.set_ylabel("크기 (로그 눈금)", fontsize=10, color="#2D3748")
    ax.set_title("도판 2. 실제 소수 적분 잔차 |Gz(X)| 대 가상 이탈 영점(0.75)의 폭주 비교",
                 fontsize=11.5, fontweight="bold", pad=12, color="#1A202C")
    ax.legend(frameon=True, facecolor="#FFFFFF", edgecolor="#CBD5E1", fontsize=9.0,
              loc="center right", bbox_to_anchor=(0.98, 0.36))
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    ax.grid(True, which="both", linestyle=":", alpha=0.45, color="#94A3B8")
    fig.tight_layout()
    fig.savefig(FIG_DIR / "fig2_residual_vs_fake_zero.png", dpi=220)
    plt.close(fig)


def make_fig3_barrier():
    X = 10000.0
    ms = [float(k) for k in range(5, 165, 3)]
    disc_err = [X / m for m in ms]
    naive_cost = [(m ** 2) / 1.0 for m in ms]
    seesaw_cost = [1.0 * m for m in ms]

    fig, ax = plt.subplots(figsize=(8.2, 4.4), dpi=220)
    fig.patch.set_facecolor("#FAF9F6")
    ax.set_facecolor("#FAF9F6")
    ax.plot(ms, disc_err, linewidth=2.3, color="#1F5A73", label="체비쇼프 이산화 오차 (X / m)")
    ax.plot(ms, naive_cost, linewidth=2.0, linestyle="--", color="#9C4221",
            label="단순 리프트 누적 손실 (~ m^2 : m=X^(1/3)에서 2/3 장벽 충돌)")
    ax.plot(ms, seesaw_cost, linewidth=2.3, color="#1E6B52",
            label="시소·헤케 평균 약분 후 제어 스케일 (~ m : m=sqrt(X)=100 도달)")

    ax.scatter([X ** (1.0 / 3.0)], [X ** (2.0 / 3.0)], color="#9C4221", zorder=5, s=55)
    ax.annotate("단순 계산 정지점\n(m 약 21.5, 2/3 장벽)",
                xy=(21.54, 464.16), xytext=(8, 4200),
                arrowprops={"arrowstyle": "->", "color": "#9C4221", "lw": 1.2},
                fontsize=8.8, color="#7B341E", fontweight="bold")

    ax.scatter([100.0], [100.0], color="#B83227", zorder=6, s=65)
    ax.annotate("시소 약분 후 균형점\n(m = sqrt(X) = 100, 1/2 기준선 도달)",
                xy=(100.0, 100.0), xytext=(74, 18),
                arrowprops={"arrowstyle": "->", "color": "#B83227", "lw": 1.4},
                fontsize=9.2, color="#B83227", fontweight="bold")

    ax.set_yscale("log")
    ax.set_ylim(8, 160000)
    ax.set_xlabel("세타 리프트 반복 횟수 m (X = 10,000 기준)", fontsize=10, color="#2D3748")
    ax.set_ylabel("오차 및 손실 스케일 (로그 눈금)", fontsize=10, color="#2D3748")
    ax.set_title("도판 3. 단순 리프트의 2/3 정지점 대 시소 약분 후 m = sqrt(X) 균형점 비교",
                 fontsize=11.0, fontweight="bold", pad=12, color="#1A202C")
    ax.legend(frameon=True, facecolor="#FFFFFF", edgecolor="#CBD5E1", fontsize=8.8, loc="upper left")
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    ax.grid(True, which="both", linestyle=":", alpha=0.45, color="#94A3B8")
    fig.tight_layout()
    fig.savefig(FIG_DIR / "fig3_lift_cost_barrier.png", dpi=220)
    plt.close(fig)


def make_fig4_parity_vwin():
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(9.2, 4.5), dpi=220, gridspec_kw={"width_ratios": [1.05, 1.25]})
    fig.patch.set_facecolor("#FAF9F6")
    ax1.set_facecolor("#FAF9F6")
    ax2.set_facecolor("#FAF9F6")

    labels = [
        "국소 랑글란즈\n(recTExists)",
        "갈루아-세타 정합\n(RowSrc)",
        "보형 창문·반디버\n(vwin_of_row)",
    ]
    vals = [4.21, 7.85, 16.09]
    cols = ["#64748B", "#1F5A73", "#B83227"]
    bars = ax1.barh(labels, vals, color=cols, height=0.52, edgecolor="#1E293B", linewidth=0.7)
    for bar, v in zip(bars, vals):
        ax1.text(v + 0.3, bar.get_y() + bar.get_height() / 2, f"{v:.2f}M줄",
                 va="center", ha="left", fontsize=9.0, fontweight="bold", color="#1A202C")
    ax1.set_xlim(0, 20.2)
    ax1.set_xlabel("추이적 의존 콘 크기 (백만 줄)", fontsize=9.2, color="#2D3748")
    ax1.set_title("A. 3대 척추 정점의 의존 분량", fontsize=10.2, fontweight="bold", color="#0F172A", pad=10)
    ax1.spines["top"].set_visible(False)
    ax1.spines["right"].set_visible(False)
    ax1.grid(axis="x", linestyle="--", alpha=0.35, color="#94A3B8")

    ax2.axis("off")
    ax2.set_xlim(0, 10)
    ax2.set_ylim(0, 10)
    ax2.set_title("B. VWin(Ct=401) 내부 복소켤레 기우성(Parity) 분해", fontsize=10.2, fontweight="bold", color="#0F172A", pad=10)

    boxes = [
        (0.2, 5.9, 4.5, 3.3, "#EBF8FF", "#1F5A73", "홀수(minus) 기우성 날개\n• 슈티켈베르거 합동 (Odd a)\n• 페레로-워싱턴 (mu = 0)\n• 가토 GL2 오일러 계 (CountI)\n• 베렌트 체 (ThmBcFree)"),
        (5.3, 5.9, 4.5, 3.3, "#FFF5F5", "#B83227", "짝수(plus · 반디버) 날개\n• 슈티켈베르거 작용 = 0 (맹점)\n• 심플렉틱 GSp4 (CountII·III)\n• 유니터리 U(3) 히다 패칭 (CountV)\n• 아벨 다양체 8.14M줄 동원"),
        (0.9, 0.9, 8.2, 2.8, "#EDF2F7", "#1E293B", "합류 결론 : HVCore.of_four_alt → VWin (Ct = 401, eps < 1/52)\n샤파레비치-테이트 길이 합 ∑ (log l) · shaLen(E, e) ≤ exp(x^eps / 2)"),
    ]
    for x, y, w, h, fc, ec, txt in boxes:
        rect = mpatches.FancyBboxPatch((x, y), w, h, boxstyle="round,pad=0.2", facecolor=fc, edgecolor=ec, linewidth=1.3)
        ax2.add_patch(rect)
        ax2.text(x + w / 2, y + h / 2, txt, ha="center", va="center", fontsize=8.1, color="#1A202C", linespacing=1.45)

    ax2.annotate("", xy=(3.6, 3.95), xytext=(2.5, 5.8), arrowprops={"arrowstyle": "->", "color": "#1F5A73", "lw": 1.6})
    ax2.annotate("", xy=(6.4, 3.95), xytext=(7.5, 5.8), arrowprops={"arrowstyle": "->", "color": "#B83227", "lw": 1.6})
    ax2.text(5.0, 4.85, "PointHV 결합", ha="center", va="center", fontsize=8.3, fontweight="bold", color="#334155")

    fig.suptitle("도판 4. 보형 창문 정리(VWin)의 1,609만 줄 의존 콘과 홀·짝 기우성(Parity) 양날개 구조",
                 fontsize=11.2, fontweight="bold", color="#0F172A", y=0.98)
    fig.tight_layout(rect=[0, 0, 1, 0.93])
    fig.savefig(FIG_DIR / "fig4_vwin_parity_and_counts.png", dpi=220)
    plt.close(fig)


def main():
    FIG_DIR.mkdir(parents=True, exist_ok=True)
    configure_korean_font()
    make_fig1_anatomy()
    make_fig2_residual()
    make_fig3_barrier()
    make_fig4_parity_vwin()
    print("FIGURES_OK: 4 high-DPI editorial charts generated.")


if __name__ == "__main__":
    main()
