#!/usr/bin/env python3
import json
import math
import pathlib

ROOT = pathlib.Path(__file__).resolve().parents[1]
OUT = ROOT / "data/prime_lab_results.json"
EULER_GAMMA = 0.5772156649015328606


def von_mangoldt_table(limit: int):
    is_prime = [True] * (limit + 1)
    is_prime[0] = is_prime[1] = False
    lam = [0.0] * (limit + 1)
    for p in range(2, limit + 1):
        if not is_prime[p]:
            continue
        for mult in range(p * 2, limit + 1, p):
            is_prime[mult] = False
        lp = math.log(p)
        pk = p
        while pk <= limit:
            lam[pk] = lp
            pk *= p
    return lam


def sz_of(x: float, lam) -> float:
    nx = int(math.floor(x))
    return sum(lam[n] * (x / n - 1.0) for n in range(1, nx + 1) if lam[n] != 0.0)


def gz_of(x: float, lam) -> float:
    return sz_of(x, lam) - x * math.log(x) + (1.0 + EULER_GAMMA) * x


def cheb_node(m: int, j: int) -> float:
    return math.sin((2 * (j + 1) - 1) * math.pi / (4.0 * m)) ** 2


def spread_weighted_avg(m: int, x: float, lam) -> float:
    tot = 0.0
    for j in range(m):
        xs_j = x / (1.0 + (j + 1.0) / m)
        tot += (1.0 / m) * (x / xs_j) * gz_of(xs_j, lam)
    return tot


def digits_in_base(val: int, base: int):
    out = []
    tmp = val
    while tmp > 0:
        out.append(tmp % base)
        tmp //= base
    return out


def behrend_sphere_ap_free(n_max: int, base: int = 5):
    buckets = {}
    half = (base + 1) // 2
    for x in range(n_max):
        ds = digits_in_base(x, base)
        if all(d < half for d in ds):
            r2 = sum(d * d for d in ds)
            buckets.setdefault(r2, []).append(x)
    best_r2, best_set = max(buckets.items(), key=lambda kv: len(kv[1]))
    s = set(best_set)
    ap_violations = sum(
        1 for i, a in enumerate(best_set) for b in best_set[i + 1:] if (2 * b - a) in s
    )
    return {
        "n_max": n_max,
        "shell_r2": best_r2,
        "size": len(best_set),
        "ap_violations": ap_violations,
        "sample": best_set[:16],
    }


def main():
    lam = von_mangoldt_table(10000)
    rows = []
    for x in [100, 400, 1600, 3600, 10000]:
        m = int(round(math.sqrt(x)))
        gz = gz_of(x, lam)
        rows.append({
            "X": x,
            "m_sqrt_X": m,
            "cheb_first_node": round(cheb_node(m, 0), 6),
            "cheb_last_node": round(cheb_node(m, m - 1), 6),
            "Sz_X": round(sz_of(x, lam), 4),
            "main_term_XlogX_minus_1plusGamma_X": round(x * math.log(x) - (1.0 + EULER_GAMMA) * x, 4),
            "Gz_X_residual": round(gz, 4),
            "spread_weighted_avg_m": round(spread_weighted_avg(m, x, lam), 4),
            "abs_Gz_over_sqrtX": round(abs(gz) / math.sqrt(x), 5),
            "discretization_step_X_over_m": round(x / m, 2),
            "hypothetical_offline_0p75_scale": round(x ** 0.75, 2),
        })

    out_doc = {"von_mangoldt_table": rows, "behrend_demo": behrend_sphere_ap_free(500, base=5)}
    OUT.write_text(json.dumps(out_doc, indent=2, ensure_ascii=False), encoding="utf-8")
    print("PRIME_LAB_OK:", len(rows), "rows")


if __name__ == "__main__":
    main()
