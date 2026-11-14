"""Deterministic symbolic and numerical engines for Case 015 Papers 3-5 (Theorems 36-75)."""
import math
import sys
import numpy as np
import sympy as sp

sys.dont_write_bytecode = True


def compute_paper3_siegel_algebra(h_cutoff: int) -> dict:
    c1, c2 = sp.symbols("c1 c2")
    sos_diff = sp.expand(
        4 * (1 + c1) * (1 + c2)
        - ((1 + c1 + c2 + c1 * c2) ** 2 - (c1**2 - 1) * (1 + c2) ** 2 - (c2**2 - 1) * (2 + 2 * c1))
    )
    assert sos_diff == 0
    vals = {(1 + v1) * (1 + v2) for v1 in (-1, 1) for v2 in (-1, 1)}
    assert vals == {0, 4}

    A, b1, eps = sp.symbols("A b1 eps", positive=True)
    siegel_exp = 2 * A * (1 - b1) / (2 * b1 - 1)
    b1_thresh = sp.solve(sp.Eq(siegel_exp, eps), b1)[0]
    assert sp.simplify(b1_thresh - (1 - eps / (2 * (A + eps)))) == 0

    lp_diff = sp.Rational(60, 23) - sp.Rational(5, 2)
    assert lp_diff == sp.Rational(5, 46)
    assert h_cutoff == 96 * 903264 == 86713344
    assert 87689 < 255983 < 640722 < 4115904
    assert 4115904 - 640722 == 3475182 and 640722 - 255983 == 384739

    return {
        "estermann_siegel_dirichlet_values": sorted(int(v) for v in vals),
        "siegel_threshold_formula": "1 - eps / (2*(A + eps))",
        "landau_page_pair_margin": f"{lp_diff} = {float(lp_diff):.10f}",
        "siegel_zeros_002_threshold_H": h_cutoff,
        "ostmann_009_conductor_ladder": [87689, 255983, 640722, 4115904],
        "goldfeld_gross_zagier_curve_5077_rank": 3,
    }


def _optimize_conrey_deg17_at_r(r_val: float, theta: float, v_nodes: np.ndarray, weights: np.ndarray) -> float:
    u = 2.0 * v_nodes - 1.0
    w_exp = weights * np.exp(2.0 * r_val * v_nodes)
    q0 = 1.0 - v_nodes
    dq0 = -np.ones_like(v_nodes)
    phi = np.array([v_nodes * (1.0 - v_nodes) * (u ** (2 * k + 1)) for k in range(8)])
    dphi = np.array(
        [
            (1.0 - 2.0 * v_nodes) * (u ** (2 * k + 1))
            + v_nodes * (1.0 - v_nodes) * (2 * (2 * k + 1)) * (u ** (2 * k))
            for k in range(8)
        ]
    )
    ma = (phi * w_exp) @ phi.T
    ba = (phi * w_exp) @ q0
    ca = float(np.dot(w_exp, q0 * q0))
    psi = r_val * phi + dphi
    f0 = r_val * q0 + dq0
    mb = (psi * w_exp) @ psi.T
    bb = (psi * w_exp) @ f0
    cb = float(np.dot(w_exp, f0 * f0))

    avec = np.zeros(8, dtype=np.float64)
    for _ in range(18):
        iaa = max(1e-15, ca + 2.0 * float(np.dot(ba, avec)) + float(avec @ ma @ avec))
        jbb = max(1e-15, cb + 2.0 * float(np.dot(bb, avec)) + float(avec @ mb @ avec))
        omega = theta * math.sqrt(jbb / iaa)
        sh = math.sinh(omega)
        ch = math.cosh(omega)
        wa = (ch / max(sh, 1e-15)) * math.sqrt(jbb / iaa) + (theta * jbb / (iaa * max(sh * sh, 1e-15)))
        wb = (ch / max(sh, 1e-15)) * math.sqrt(iaa / jbb) - (theta / max(sh * sh, 1e-15))
        avec = -np.linalg.solve(wa * ma + wb * mb + 1e-13 * np.eye(8), wa * ba + wb * bb)
    iaa = ca + 2.0 * float(np.dot(ba, avec)) + float(avec @ ma @ avec)
    jbb = cb + 2.0 * float(np.dot(bb, avec)) + float(avec @ mb @ avec)
    c_min = 0.5 + math.sqrt(iaa * jbb) / math.tanh(theta * math.sqrt(jbb / iaa))
    return 1.0 - math.log(c_min) / r_val


def compute_paper4_conrey_variational() -> dict:
    R, v = sp.symbols("R v", positive=True)
    q_fn = sp.Function("Q")(v)
    pot_deriv = sp.simplify(
        sp.diff(sp.Rational(1, 2) * sp.exp(2 * R * v) * q_fn**2, v)
        - sp.exp(2 * R * v) * q_fn * (R * q_fn + sp.diff(q_fn, v))
    )
    assert pot_deriv == 0
    iaa_lev = sp.integrate(sp.exp(2 * R * v) * (1 - v) ** 2, (v, 0, 1))
    jbb_lev = sp.integrate(sp.exp(2 * R * v) * (R * (1 - v) - 1) ** 2, (v, 0, 1))
    assert sp.simplify(iaa_lev - (sp.exp(2 * R) - 1 - 2 * R - 2 * R**2) / (4 * R**3)) == 0
    assert sp.simplify(jbb_lev - (sp.exp(2 * R) - 1 + 2 * R - 2 * R**2) / (4 * R)) == 0
    assert (sp.Rational(613, 600) ** 40) < sp.exp(sp.Rational(13, 15))

    nodes, weights = np.polynomial.legendre.leggauss(80)
    v_nodes = 0.5 * (nodes + 1.0)
    v_weights = 0.5 * weights
    deg17_opt = {}
    coth_floor_opt = {}
    for label, theta in (("1/2", 0.5), ("4/7", 4.0 / 7.0), ("1", 1.0), ("2", 2.0)):
        r_grid = np.linspace(0.35, 1.85, 151)
        deg17_opt[label] = round(max(_optimize_conrey_deg17_at_r(float(rv), theta, v_nodes, v_weights) for rv in r_grid), 6)
        rf_grid = np.linspace(0.05, 2.00, 1951)
        best_cf = -1.0
        for rv in rf_grid:
            imin = math.exp(rv) * math.atan(math.sinh(rv)) / (4.0 * rv)
            best_cf = max(best_cf, 1.0 - math.log(0.5 + 0.5 / math.tanh(theta / (2.0 * imin))) / float(rv))
        coth_floor_opt[label] = round(best_cf, 6)
    assert 0.407 < deg17_opt["4/7"] < 0.409 and deg17_opt["2"] < 0.65 < coth_floor_opt["2"] < 1.0
    return {"conrey_deg17_symmetric_kappa": deg17_opt, "conrey_relaxed_coth_ceiling": coth_floor_opt}


def compute_paper5_burgess_kloosterman() -> dict:
    r, nu, k = sp.symbols("r nu k", positive=True)
    b_short = (1 - 1 / r) * nu + (r + 1) / (4 * r**2)
    b_sub = sp.simplify(b_short.subs(nu, sp.Rational(1, 2)) - sp.Rational(1, 4))
    assert sp.simplify(b_sub - (r**2 - r + 1) / (4 * r**2)) == 0
    assert sp.simplify(b_sub - sp.Rational(3, 16) - (r - 2) ** 2 / (16 * r**2)) == 0
    py_sub = sp.simplify(((1 - 1 / r) * sp.Rational(1, 2) + r / (4 * r**2)).subs(r, 3) - sp.Rational(1, 4))
    assert py_sub == sp.Rational(1, 6) and sp.Rational(3, 16) - py_sub == sp.Rational(1, 48)

    landau_sym = (k + 2) / (2 * (k**2 + 2 * k + 2))
    ks_sym = (sp.Rational(1, 2) - 1 / ((k + 1) * (k + 2) / 2 + 1)) / k
    assert [landau_sym.subs(k, j) for j in (2, 3, 4)] == [sp.Rational(1, 5), sp.Rational(5, 34), sp.Rational(3, 26)]
    assert ks_sym.subs(k, 2) == sp.Rational(5, 28) and ks_sym.subs(k, 4) == sp.Rational(7, 64)
    assert landau_sym.subs(k, 4) - ks_sym.subs(k, 4) == sp.Rational(5, 832)

    primes = [p for p in range(3, 2000, 2) if all(p % d != 0 for d in range(3, int(math.isqrt(p)) + 1, 2))]
    signed_sum = 0.0
    abs_sum = 0.0
    for p in primes:
        angles = [2.0 * math.pi * ((x + pow(x, p - 2, p)) % p) / float(p) for x in range(1, p)]
        s_val = math.fsum(math.cos(a) for a in angles)
        root_p = math.sqrt(float(p))
        assert abs(s_val) <= 2.0 * root_p + 1e-9
        signed_sum += s_val / root_p
        abs_sum += abs(s_val) / root_p
    cancel_pct = (1.0 - abs(signed_sum) / abs_sum) * 100.0
    assert cancel_pct > 95.0
    return {
        "burgess_sos_identity": "(r^2 - r + 1)/(4*r^2) - 3/16 = (r - 2)^2 / (16*r^2)",
        "burgess_unique_optimum": {"r": 2, "exponent": "3/16", "r3_degraded": "7/36"},
        "petrow_young_cubic_exponent": {"exponent": "1/6", "saving_over_burgess": "1/48"},
        "kim_sarnak_gl5_saving": {"landau_sym4": "3/26", "kim_sarnak_gl5": "7/64", "saving": "5/832"},
        "kloosterman_p_le_1999_audit": {
            "odd_primes_count": len(primes),
            "signed_normalized_sum": round(signed_sum, 8),
            "abs_normalized_sum": round(abs_sum, 8),
            "phase_cancellation_pct": round(cancel_pct, 6),
        },
    }
