#!/usr/bin/env python3
"""
Independent symbolic verification solver for Problems 1-5 based on Lean 4 reference files in ./oai_ref/.
"""

import json
import math
import sympy as sp


def frac_irreducible_str(val):
    r = sp.Rational(val)
    return f"{r.p}/{r.q}"


def solve_qrh_problem_1():
    """
    Problem 1: Floor Source Margin Vanishing Threshold
    Reference: oai_ref/CentralExponent.lean (upstream: lean/OAI/NumberTheory/DirichletL/Detector/CentralExponent.lean),
               oai_ref/CubeFloorSaving.lean (upstream: lean/OAI/NumberTheory/DirichletL/PrimeRows/CubeFloorSaving.lean)
    """
    a, d, R, q, eta = sp.symbols("a d R q eta", rational=True)

    # Exact definition from DirichletL/Detector/CentralExponent.lean:
    source_exponent = (
        sp.Rational(17, 48) * (sp.Rational(1, 2) - sp.Rational(17, 50))
        + a
        + sp.Rational(17, 50)
        - 1
        - a * sp.Rational(23, 48)
        - d * sp.Rational(17, 50)
        + d * R
        + d * (a - sp.Rational(1, 2))
        + sp.Rational(1, 6) * (sp.Rational(17, 50) - sp.Rational(1, 2) + q)
    )

    delta = sp.Symbol("delta", rational=True)
    relative_exponent = (
        -sp.Rational(1, 48)
        + sp.Rational(2, 3) * delta
        + q / 6
        - sp.Rational(13, 16) * (1 - R)
        + (d - sp.Rational(13, 16)) * (R + delta / 2 - sp.Rational(17, 50))
    )

    # Verify original_exponent_identity: sourceExponent a d R q = 3/16 + relativeExponent (2*a - 1) d R q
    assert sp.simplify(
        source_exponent - (sp.Rational(3, 16) + relative_exponent.subs(delta, 2 * a - 1))
    ) == 0

    # Floor parameterization: a = 1/2 + eta, d = 13/16, R = 1, q = eta
    linear_expr = sp.simplify(
        source_exponent.subs(
            {
                a: sp.Rational(1, 2) + eta,
                d: sp.Rational(13, 16),
                R: 1,
                q: eta,
            }
        )
        - sp.Rational(3, 16)
    )
    assert linear_expr == sp.Rational(3, 2) * eta - sp.Rational(1, 48)

    eta_max = sp.solve(sp.Eq(linear_expr, 0), eta)[0]
    a_max = sp.Rational(1, 2) + eta_max
    assert eta_max == sp.Rational(1, 72)
    assert a_max == sp.Rational(37, 72)

    return {
        "linear_expression": str(linear_expr),
        "slope": frac_irreducible_str(sp.Rational(3, 2)),
        "intercept": frac_irreducible_str(-sp.Rational(1, 48)),
        "eta_max": frac_irreducible_str(eta_max),
        "a_max": frac_irreducible_str(a_max),
    }


def _endpoint_balanced_exponent(delta, y):
    """Build exact symbolic expressions from oai_ref/Endpoint.lean and verify endpoint_identity."""
    denominator = (37 + 34 * y) / sp.Integer(18)
    prime_weight = (7 + 18 * y + 8 * y**2) / sp.Integer(9)
    balance_denominator = (sp.Rational(5, 6) - delta) * denominator + delta * prime_weight
    certificate_weight = 51 + 41 * y
    balanced_cutoff = 1 + delta * prime_weight / (2 * balance_denominator)
    balanced_row_count = 1 - sp.Rational(5, 6) + (sp.Rational(5, 6) - delta) * balanced_cutoff
    balanced_exponent = (
        -sp.Rational(1, 48)
        + sp.Rational(2, 3) * delta
        + delta * (sp.Rational(1, 2) - y) / 6
        - sp.Rational(13, 16) * (1 - balanced_row_count)
    )
    lhs_id = 10368 * certificate_weight * balance_denominator * (-balanced_exponent)
    rhs_id = (3 + 5 * y) * ((4 * certificate_weight * delta - 79) ** 2 + 49) + 4 * y * (
        4 * certificate_weight * delta * ((1 + 3 * y) * (15 + 32 * y) * delta + 9 - 13 * y)
        + 265
        + 3485 * y
    )
    assert sp.simplify(lhs_id - rhs_id) == 0
    return balanced_exponent, certificate_weight


def solve_qrh_problem_2():
    """
    Problem 2: Exact Closed-Form Algebraic Saddle Point
    Reference: oai_ref/Endpoint.lean (upstream: lean/OAI/NumberTheory/DirichletL/Endpoint.lean)
    """
    delta, y = sp.symbols("delta y", real=True)
    balanced_exponent, certificate_weight = _endpoint_balanced_exponent(delta, y)

    # At boundary y = 0:
    be_y0 = sp.simplify(balanced_exponent.subs(y, 0))
    dbe_y0 = sp.diff(be_y0, delta)
    d2be_y0 = sp.diff(be_y0, delta, 2)

    roots = sp.solve(sp.Eq(dbe_y0, 0), delta)
    valid_roots = [
        sp.simplify(r)
        for r in roots
        if 0 <= float(r.evalf()) <= float(sp.Rational(5, 6))
    ]
    assert len(valid_roots) == 1
    delta_true = valid_roots[0]
    a_true = sp.simplify((1 + delta_true) / 2)

    # Canonical radical form p/q - r*sqrt(D)/s for a_true:
    # a_true = 323/276 - 35*sqrt(16354)/9384
    p, q, r = 323, 276, 35
    D, s = 16354, 9384
    assert math.gcd(p, q) == 1
    assert math.gcd(r, s) == 1
    assert all(D % (k * k) != 0 for k in range(2, int(math.isqrt(D)) + 1))
    assert sp.simplify(a_true - (sp.Rational(p, q) - sp.Rational(r, s) * sp.sqrt(D))) == 0

    # Also canonical radical form for delta_true = 185/138 - 35*sqrt(16354)/4692
    p_d, q_d, r_d = 185, 138, 35
    D_d, s_d = 16354, 4692
    assert sp.simplify(
        delta_true - (sp.Rational(p_d, q_d) - sp.Rational(r_d, s_d) * sp.sqrt(D_d))
    ) == 0

    a_true_float_10 = round(float(a_true.evalf(30)), 10)
    a_true_float_str = f"{float(a_true.evalf(30)):.10f}"
    delta_true_float_10 = round(float(delta_true.evalf(30)), 10)

    # Squared term at y = 0 in endpoint_identity is (4 * certificateWeight(0) * delta - 79)^2 = (204*delta - 79)^2
    sq_term_y0 = 4 * certificate_weight.subs(y, 0) * delta - 79
    delta_sos = sp.solve(sp.Eq(sq_term_y0, 0), delta)[0]
    assert delta_sos == sp.Rational(79, 204)
    a_sos = (1 + delta_sos) / 2
    assert a_sos == sp.Rational(283, 408)

    be_at_sos = sp.simplify(be_y0.subs(delta, delta_sos))
    d2be_at_sos = sp.simplify(d2be_y0.subs(delta, delta_sos))
    dbe_at_sos = sp.simplify(dbe_y0.subs(delta, delta_sos))
    assert be_at_sos == sp.Rational(-7, 30672)
    assert d2be_at_sos == sp.Rational(-236315300, 608806611)

    return {
        "balancedExponent_y0": str(be_y0),
        "delta_true": str(delta_true),
        "delta_true_radical": [p_d, q_d, r_d, D_d, s_d],
        "delta_true_float": delta_true_float_10,
        "a_true": str(a_true),
        "a_true_radical": [p, q, r, D, s],
        "a_true_float": a_true_float_10,
        "a_true_float_str": a_true_float_str,
        "delta_SOS": frac_irreducible_str(delta_sos),
        "a_SOS": frac_irreducible_str(a_sos),
        "balancedExponent_delta_SOS": frac_irreducible_str(be_at_sos),
        "d_balancedExponent_delta_SOS": frac_irreducible_str(dbe_at_sos),
        "d2_balancedExponent_delta_SOS": frac_irreducible_str(d2be_at_sos),
    }


def solve_qrh_problem_3(delta_sos_str):
    """
    Problem 3: Componentwise Gram Scale Exponents
    Reference: oai_ref/LowSourceScales.lean (upstream: lean/OAI/NumberTheory/DirichletL/Detector/LowSourceScales.lean),
               oai_ref/GramScaleLoss.lean (upstream: lean/OAI/NumberTheory/DirichletL/Detector/GramScaleLoss.lean),
               oai_ref/GramBound.lean (upstream: lean/OAI/NumberTheory/DirichletL/Detector/GramBound.lean),
               oai_ref/LowGramScale.lean (upstream: lean/OAI/NumberTheory/DirichletL/Detector/LowGramScale.lean),
               oai_ref/Endpoint.lean (upstream: lean/OAI/NumberTheory/DirichletL/Endpoint.lean)
    """
    delta = sp.Symbol("delta", rational=True)
    delta_sos = sp.Rational(delta_sos_str)

    # Z-exponents from Detector/LowSourceScales.lean:
    # X ~ Z^(17/48), Y ~ Z^(23/48), Q = q*X*Y => Q/Y ~ X ~ Z^(17/48), P = Y^2/Q ~ Y/X ~ Z^(6/48) = Z^(1/8)
    exp_X = sp.Rational(17, 48)
    exp_Y = sp.Rational(23, 48)
    exp_Q_over_Y = exp_X
    exp_P = exp_Y - exp_X  # 1/8
    assert exp_P == sp.Rational(1, 8)

    # Coarse bundled Gram energy exponent in Detector/LowGramScale.lean (source_gram_power & source_gram_sqrt_power):
    # (Q / Y) * P^(1/6) * Y^delta ~ Z^(3/8 + (23/48)*delta), sqrt exponent = 3/16 + (23/96)*delta = (18 + 23*delta)/96
    coarse_gram_exp = exp_Q_over_Y + sp.Rational(1, 6) * exp_P + exp_Y * delta
    coarse_sqrt_exp = coarse_gram_exp / 2
    assert coarse_gram_exp == sp.Rational(3, 8) + sp.Rational(23, 48) * delta
    assert coarse_sqrt_exp == sp.Rational(3, 16) + sp.Rational(23, 96) * delta

    # Unrelaxed non-exceptional Gram energy exponent at pure scale L = 1 in Detector/GramBound.lean:
    # (Q / Y) * P * (Y / (M * P))^(-1 + delta), where Y / P ~ X ~ Z^(17/48)
    # sqrt exponent = 1/16 + (17/96)*delta = (6 + 17*delta)/96
    componentwise_nonexc_gram_exp = exp_Q_over_Y + exp_P + (exp_Y - exp_P) * (-1 + delta)
    componentwise_nonexc_sqrt_exp = componentwise_nonexc_gram_exp / 2
    assert componentwise_nonexc_gram_exp == sp.Rational(1, 8) + sp.Rational(17, 48) * delta
    assert componentwise_nonexc_sqrt_exp == sp.Rational(1, 16) + sp.Rational(17, 96) * delta

    # Componentwise non-exceptional Gram energy exponent including the L <= B * Z^(1/6) divisor bound
    # from Detector/LowSourceScales.lean:81,95-98 (adds 1/6 to energy exponent, 1/12 = 8/96 to sqrt exponent):
    # sqrt exponent = 7/48 + (17/96)*delta = (14 + 17*delta)/96
    exp_L_bound = sp.Rational(1, 6)
    componentwise_nonexc_with_l_gram_exp = componentwise_nonexc_gram_exp + exp_L_bound
    componentwise_nonexc_with_l_sqrt_exp = componentwise_nonexc_with_l_gram_exp / 2
    assert componentwise_nonexc_with_l_gram_exp == sp.Rational(7, 24) + sp.Rational(17, 48) * delta
    assert componentwise_nonexc_with_l_sqrt_exp == sp.Rational(7, 48) + sp.Rational(17, 96) * delta

    # Intermediate relaxed non-exceptional Gram energy exponent after Detector/GramScaleLoss.lean:
    # (Q / Y) * (P^2 / Y) * Y^delta ~ Z^(1/8 + (23/48)*delta)
    relaxed_nonexc_gram_exp = exp_Q_over_Y + (2 * exp_P - exp_Y) + exp_Y * delta
    relaxed_nonexc_sqrt_exp = relaxed_nonexc_gram_exp / 2
    assert relaxed_nonexc_gram_exp == sp.Rational(1, 8) + sp.Rational(23, 48) * delta
    assert relaxed_nonexc_sqrt_exp == sp.Rational(1, 16) + sp.Rational(23, 96) * delta

    # Componentwise exceptional Gram energy exponent in Detector/GramBound.lean:
    # (Q / Y) * P^(1/6) ~ Z^(3/8)
    componentwise_exc_gram_exp = exp_Q_over_Y + sp.Rational(1, 6) * exp_P
    componentwise_exc_sqrt_exp = componentwise_exc_gram_exp / 2
    assert componentwise_exc_gram_exp == sp.Rational(3, 8)
    assert componentwise_exc_sqrt_exp == sp.Rational(3, 16)

    # Square-root Z-exponent savings relative to coarse_sqrt_exp:
    saving_nonexc_expr = sp.simplify(coarse_sqrt_exp - componentwise_nonexc_sqrt_exp)
    saving_nonexc_with_l_expr = sp.simplify(coarse_sqrt_exp - componentwise_nonexc_with_l_sqrt_exp)
    saving_exc_expr = sp.simplify(coarse_sqrt_exp - componentwise_exc_sqrt_exp)
    assert saving_nonexc_expr == sp.Rational(1, 8) + sp.Rational(1, 16) * delta
    assert saving_nonexc_with_l_expr == sp.Rational(1, 24) + sp.Rational(1, 16) * delta
    assert saving_exc_expr == sp.Rational(23, 96) * delta

    # Evaluate at delta = delta_SOS = 79/204:
    saving_nonexc = saving_nonexc_expr.subs(delta, delta_sos)
    saving_nonexc_with_l_bound = saving_nonexc_with_l_expr.subs(delta, delta_sos)
    saving_exc = saving_exc_expr.subs(delta, delta_sos)
    assert saving_nonexc == sp.Rational(487, 3264)
    assert saving_nonexc_with_l_bound == sp.Rational(215, 3264)
    assert saving_exc == sp.Rational(1817, 19584)

    # Uniform baseline endpoint margin from DirichletL/Endpoint.lean (balanced_endpoint_margin):
    margin_baseline = sp.Rational(49, 440640)
    assert saving_nonexc - sp.Rational(1, 12) == saving_nonexc_with_l_bound

    return {
        "coarse_sqrt_exponent": str(coarse_sqrt_exp),
        "coarse_sqrt_exponent_common_denom": "(18 + 23*delta)/96",
        "componentwise_nonexceptional_sqrt_exponent": str(componentwise_nonexc_sqrt_exp),
        "componentwise_nonexceptional_sqrt_exponent_common_denom": "(6 + 17*delta)/96",
        "componentwise_nonexceptional_with_L_bound_sqrt_exponent": str(componentwise_nonexc_with_l_sqrt_exp),
        "componentwise_nonexceptional_with_L_bound_sqrt_exponent_common_denom": "(14 + 17*delta)/96",
        "relaxed_nonexceptional_sqrt_exponent": str(relaxed_nonexc_sqrt_exp),
        "componentwise_exceptional_sqrt_exponent": str(componentwise_exc_sqrt_exp),
        "saving_nonexceptional_expr": str(saving_nonexc_expr),
        "saving_nonexceptional_with_L_bound_expr": str(saving_nonexc_with_l_expr),
        "saving_exceptional_expr": str(saving_exc_expr),
        "saving_nonexceptional": frac_irreducible_str(saving_nonexc),
        "saving_nonexceptional_with_L_bound": frac_irreducible_str(saving_nonexc_with_l_bound),
        "saving_exceptional": frac_irreducible_str(saving_exc),
        "margin_baseline": frac_irreducible_str(margin_baseline),
    }


def solve_qrh_problem_4():
    """
    Problem 4: Exact m >= 2 Vanishing and Continuation Threshold
    Reference: oai_ref/HighRowsTail.lean (upstream: lean/OAI/NumberTheory/DirichletL/Detector/HighRowsTail.lean),
               oai_ref/HighRowsScalar.lean (upstream: lean/OAI/NumberTheory/DirichletL/Detector/HighRowsScalar.lean),
               oai_ref/ScalarTable.lean (upstream: lean/OAI/NumberTheory/DirichletL/Detector/ScalarTable.lean),
               oai_ref/HighRowsCentralTerms.lean (upstream: lean/OAI/NumberTheory/DirichletL/Detector/HighRowsCentralTerms.lean)
    """
    # The 8 non-principal (e, l, k) branches in DirichletL/Detector/HighRowsCentralTerms.lean:
    # (e, l) in {(0, 2), (1, 0), (0, 1), (1, 1)} and k in {0, 1}, where t = e + 3*l, n = t - 1.
    branches = [
        {"name": "02_0", "e": 0, "l": 2, "k": 0, "s": sp.Rational(6, 1)},
        {"name": "02_1", "e": 0, "l": 2, "k": 1, "s": sp.Rational(6, 1)},
        {"name": "10_0", "e": 1, "l": 0, "k": 0, "s": sp.Rational(1, 2)},
        {"name": "10_1", "e": 1, "l": 0, "k": 1, "s": sp.Rational(3, 2)},
        {"name": "01_0", "e": 0, "l": 1, "k": 0, "s": sp.Rational(5, 2)},
        {"name": "01_1", "e": 0, "l": 1, "k": 1, "s": sp.Rational(3, 1)},
        {"name": "11_0", "e": 1, "l": 1, "k": 0, "s": sp.Rational(7, 2)},
        {"name": "11_1", "e": 1, "l": 1, "k": 1, "s": sp.Rational(4, 1)},
    ]

    vanishing_branches = []
    surviving_branches = []

    for b in branches:
        t = b["e"] + 3 * b["l"]
        n = t - 1
        k = b["k"]
        # From DirichletL/Detector/ScalarTable.lean (gaussValuationTable_above) and DirichletL/Detector/HighRowsScalar.lean:
        # For m >= 2 and 0 <= j < 6, j + 6*m >= 12 > n + 1.
        # At k = 0: gaussValuationTable (n + 1) (j + 6*m) is non-zero iff (n + 1) % 6 == 0.
        # At k = 1: gaussValuationTable n (j + 6*m - 1) is non-zero iff n % 6 == 0.
        if k == 0:
            survives = ((n + 1) % 6 == 0)
        else:
            survives = (n % 6 == 0)

        if survives:
            surviving_branches.append(b["name"])
        else:
            vanishing_branches.append(b["name"])

    assert len(vanishing_branches) == 6
    assert len(surviving_branches) == 2
    assert surviving_branches == ["02_0", "10_1"]

    # For surviving branches at m >= 2:
    # 1. Branch (e=1, l=0, k=1) with s = 3/2:
    #    Inequality: 3/2 - x - w - 6*m*z <= 1/2 - x  (or 1 - x - w - 6*m*z <= -x)
    #    Using x + w = 1: 1/2 - 6*m*z <= 1/2 - x  <=>  6*m*z >= x.
    #    For all m >= 2 and x in [1/2, 1] (w = 1 - x >= 0), worst case is m = 2, x = 1:
    #    12*z >= 1  =>  z >= 1/12.
    # 2. Branch (e=0, l=2, k=0) with s = 6 (and l=2 shift -2):
    #    Inequality: 6 - 2 - 6*x - 6*m*z <= 1/2 - x  <=>  6*m*z >= 7/2 - 5*x.
    #    For all m >= 2 and x in [1/2, 1], worst case is m = 2, x = 1/2:
    #    12*z >= 7/2 - 5/2 = 1  =>  z >= 1/12.
    z_re_min_10_1 = sp.Rational(1, 12)
    z_re_min_02_0 = sp.Rational(1, 12)
    z_re_min = max(z_re_min_10_1, z_re_min_02_0)
    assert z_re_min == sp.Rational(1, 12)

    return {
        "total_nonprincipal_branches": len(branches),
        "num_vanishing_branches": len(vanishing_branches),
        "num_surviving_branches": len(surviving_branches),
        "vanishing_branches": vanishing_branches,
        "surviving_branches": surviving_branches,
        "z_re_min": frac_irreducible_str(z_re_min),
    }


def solve_qrh_problem_5():
    """
    Problem 5: Principal Remainder Contour Shift Budget
    Reference: oai_ref/PrincipalRemainderBounds.lean (upstream: lean/OAI/NumberTheory/DirichletL/Detector/PrincipalRemainderBounds.lean),
               oai_ref/ParametersHighData.lean (upstream: lean/OAI/NumberTheory/DirichletL/ParametersHighData.lean)
    """
    a, beta, e, xi, upsilon = sp.symbols("a beta e xi upsilon", rational=True)

    # From DirichletL/Detector/PrincipalRemainderBounds.lean (source_scale_identity):
    scale_exp = (
        a
        - sp.Rational(11, 16)
        + sp.Rational(13, 16) * (xi - sp.Rational(1, 6))
        + sp.Rational(23, 48) * (upsilon - 1)
    )

    # w-contour shift: xi = 1/6 + e, upsilon = 19/20, a = beta + e
    w_exp = sp.simplify(
        scale_exp.subs(
            {
                a: beta + e,
                xi: sp.Rational(1, 6) + e,
                upsilon: sp.Rational(19, 20),
            }
        )
    )
    assert w_exp == beta - sp.Rational(11, 16) + sp.Rational(29, 16) * e - sp.Rational(23, 960)

    # z-contour shift: xi = 33/200, upsilon = 1, a = beta + e
    z_exp = sp.simplify(
        scale_exp.subs(
            {
                a: beta + e,
                xi: sp.Rational(33, 200),
                upsilon: 1,
            }
        )
    )
    assert z_exp == beta + e - sp.Rational(11, 16) - sp.Rational(13, 9600)

    # At e <= 1/1000 (source_w_strict_exponent, source_z_strict_exponent, source_remainders_strict_saving):
    e_max = sp.Rational(1, 1000)
    w_saving = sp.simplify((beta - sp.Rational(11, 16)) - w_exp.subs(e, e_max))
    z_saving = sp.simplify((beta - sp.Rational(11, 16)) - z_exp.subs(e, e_max))
    assert w_saving == sp.Rational(1063, 48000)
    assert z_saving == sp.Rational(17, 48000)

    b_principal = min(w_saving, z_saving)
    assert b_principal == sp.Rational(17, 48000)

    # Compare to principal_budget in DirichletL/ParametersHighData.lean:
    # principal_budget : sigma + t / 8 <= 17 / 48000
    principal_budget_rhs = sp.Rational(17, 48000)
    matches = bool(b_principal == principal_budget_rhs)

    return {
        "w_shift_saving_at_e_max": frac_irreducible_str(w_saving),
        "z_shift_saving_at_e_max": frac_irreducible_str(z_saving),
        "B_principal": frac_irreducible_str(b_principal),
        "matches_principal_budget": matches,
    }


def main():
    p1 = solve_qrh_problem_1()
    p2 = solve_qrh_problem_2()
    p3 = solve_qrh_problem_3(p2["delta_SOS"])
    p4 = solve_qrh_problem_4()
    p5 = solve_qrh_problem_5()

    result = {
        "problem_1": p1,
        "problem_2": p2,
        "problem_3": p3,
        "problem_4": p4,
        "problem_5": p5,
        # Top-level flat keys for direct lookup compatibility:
        "linear_expression": p1["linear_expression"],
        "eta_max": p1["eta_max"],
        "a_max": p1["a_max"],
        "delta_true": p2["delta_true"],
        "delta_true_radical": p2["delta_true_radical"],
        "a_true": p2["a_true"],
        "a_true_radical": p2["a_true_radical"],
        "a_true_float": p2["a_true_float"],
        "delta_SOS": p2["delta_SOS"],
        "a_SOS": p2["a_SOS"],
        "balancedExponent_delta_SOS": p2["balancedExponent_delta_SOS"],
        "d2_balancedExponent_delta_SOS": p2["d2_balancedExponent_delta_SOS"],
        "coarse_sqrt_exponent": p3["coarse_sqrt_exponent"],
        "componentwise_nonexceptional_sqrt_exponent": p3["componentwise_nonexceptional_sqrt_exponent"],
        "componentwise_nonexceptional_with_L_bound_sqrt_exponent": p3[
            "componentwise_nonexceptional_with_L_bound_sqrt_exponent"
        ],
        "saving_nonexceptional": p3["saving_nonexceptional"],
        "saving_nonexceptional_with_L_bound": p3["saving_nonexceptional_with_L_bound"],
        "saving_exceptional": p3["saving_exceptional"],
        "margin_baseline": p3["margin_baseline"],
        "num_vanishing_branches": p4["num_vanishing_branches"],
        "num_surviving_branches": p4["num_surviving_branches"],
        "vanishing_branches": p4["vanishing_branches"],
        "surviving_branches": p4["surviving_branches"],
        "z_re_min": p4["z_re_min"],
        "B_principal": p5["B_principal"],
        "matches_principal_budget": p5["matches_principal_budget"],
    }

    with open("symbolic_verification_result.json", "w", encoding="utf-8") as f:
        json.dump(result, f, indent=2)

    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
