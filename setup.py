#!/usr/bin/env python3
"""Setup: create Lakehouse schemas and run dbt pipeline."""
import os, subprocess, sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).parent
os.chdir(PROJECT_ROOT)

env = {**os.environ,
    "DBT_PROFILES_DIR": str(PROJECT_ROOT / "03_lakehouse"),
    "CZ_INSTANCE": os.getenv("CZ_INSTANCE", "de1cbb4a"),
    "CZ_WORKSPACE": os.getenv("CZ_WORKSPACE", "quick_start"),
    "CZ_SCHEMA": os.getenv("CZ_SCHEMA", "dbt_blueprint_dev"),
    "CZ_VCLUSTER": os.getenv("CZ_VCLUSTER", "DEFAULT"),
    "CZ_USERNAME": os.getenv("CZ_USERNAME", ""),
    "CZ_PASSWORD": os.getenv("CZ_PASSWORD", ""),
    "CZ_SERVICE": os.getenv("CZ_SERVICE", "https://ap-southeast-1-aws.api.singdata.com"),
}

def run(cmd, **kw):
    r = subprocess.run(cmd, shell=True, env=env, cwd=str(PROJECT_ROOT / "03_lakehouse"), **kw)
    if r.returncode != 0:
        print(f"FAILED: {cmd}")
        sys.exit(1)
    return r

print("1. Installing dbt packages...")
run("dbt deps --project-dir .", capture_output=False)

print("\n2. Loading seed data...")
run("dbt seed --project-dir . --no-partial-parse", capture_output=False)

print("\n3. Running models...")
run("dbt run --project-dir . --no-partial-parse", capture_output=False)

print("\nSetup complete! Run python3 e2e.py to verify.")
