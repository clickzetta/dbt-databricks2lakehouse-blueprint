#!/usr/bin/env python3
"""End-to-end validation for dbt-databricks → dbt-clickzetta migration."""

import subprocess, json, os, sys

PROFILE = os.getenv("CLICKZETTA_PROFILE", "aws_singapore_prod")

def sql(q):
    r = subprocess.run(
        ["cz-cli", "sql", q, "--profile", PROFILE, "--sync"],
        capture_output=True, text=True, cwd="/tmp", timeout=30
    )
    return json.loads(r.stdout) if r.stdout.strip() else {}

def n(table):
    r = sql(f"SELECT COUNT(*) FROM {table}")
    return r.get("rows", [[-1]])[0][0]

# ── EXPECTED (verified on AWS Singapore, dbt-clickzetta 1.7.10) ──
EXPECTED = {
    "dbt run:  30/30": True,
    "dbt test: 36/36": True,
}

# Seed counts
SEED_EXPECTED = {
    "dbt_blueprint_dev.user_events":              196,
    "dbt_blueprint_dev.merchant_events":           30,
    "dbt_blueprint_dev.industry_codes":            30,
    "dbt_blueprint_dev.account_events":            80,
    "dbt_blueprint_dev.card_events":               60,
    "dbt_blueprint_dev.raw_p2p_captured_events":  150,
    "dbt_blueprint_dev.raw_p2p_failed_events":     50,
    "dbt_blueprint_dev.raw_p2b_captured_events":   80,
    "dbt_blueprint_dev.raw_p2b_failed_events":     30,
}

# Model counts
MODEL_EXPECTED = {
    "dbt_blueprint_dev_staging.stg_user_events":              196,
    "dbt_blueprint_dev_staging.stg_p2p_captured":             150,
    "dbt_blueprint_dev_staging.stg_p2p_failed":                50,
    "dbt_blueprint_dev_staging.stg_p2b_captured":              80,
    "dbt_blueprint_dev_staging.stg_p2b_failed":                30,
    "dbt_blueprint_dev_staging.stg_merchants":                 30,
    "dbt_blueprint_dev_staging.stg_industry_codes":            30,
    "dbt_blueprint_dev_staging.stg_account_events":            80,
    "dbt_blueprint_dev_staging.stg_card_events":               60,
    "dbt_blueprint_dev_intermediate.int_users":               196,
    "dbt_blueprint_dev_intermediate.int_transactions":        310,
    "dbt_blueprint_dev_intermediate.int_merchants":            30,
    "dbt_blueprint_dev_intermediate.int_accounts":             80,
    "dbt_blueprint_dev_intermediate.int_cards":                60,
    "dbt_blueprint_dev_marts.fact_transaction":               310,
    "dbt_blueprint_dev_marts.dim_user_scd2__public":          (">=", 50),
    "dbt_blueprint_dev_marts.dim_user_current__public":       (">=", 50),
    "dbt_blueprint_dev_marts.dim_merchant_scd2":               30,
    "dbt_blueprint_dev_marts.dim_merchant_current":            (">=", 20),
}

passed = failed = 0

print("=== Seeds ===")
for table, exp in SEED_EXPECTED.items():
    act = n(table)
    ok = act == exp
    status = "\u2705" if ok else f"\u274C EXP={exp}"
    if ok: passed += 1
    else: failed += 1
    print(f"  {status}  {table}: {act:,}")

print("\n=== Models ===")
for table, exp in MODEL_EXPECTED.items():
    act = n(table)
    if isinstance(exp, tuple):
        op, val = exp
        ok = act >= val if op == ">=" else act == val
    else:
        ok = act == exp
    status = "\u2705" if ok else f"\u274C EXP={exp}"
    if ok: passed += 1
    else: failed += 1
    print(f"  {status}  {table.split('.')[-1]}: {act:,}")

print(f"\n{passed}/{passed+failed} passed", "\u2705" if failed==0 else f"\u274C {failed} FAILED")
sys.exit(0 if failed == 0 else 1)
