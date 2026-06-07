# dbt-databricks → dbt-clickzetta Migration

[![Original](https://img.shields.io/badge/Original-Alex--Teodosiu/dbt--blueprint-⭐72-blue)](https://github.com/Alex-Teodosiu/dbt-blueprint)

Migrate a **dbt-databricks** project (staging → intermediate → marts → semantic, 30 models, 36 tests) to **dbt-clickzetta** with a **single-line adapter change** in `profiles.yml`.

## Quick Start

```bash
cp .env.example .env   # Fill in credentials
python3 setup.py       # deps + seed + run
python3 e2e.py         # 28/28 assertions ✅
```

Or run dbt directly:

```bash
cd 03_lakehouse
export DBT_PROFILES_DIR=$(pwd)
dbt deps && dbt seed && dbt run && dbt test
# seed:  9/9  PASS
# run:  30/30 PASS
# test: 36/36 PASS
```

## Project Structure

```
├── 01_source/            ← Original dbt-databricks project (preserved)
│   └── dbt_blueprint/    #   profiles.yml with type: databricks
├── 02_migration/         ← Migration notes & change log
├── 03_lakehouse/         ← Migrated dbt-clickzetta project
│   ├── models/           #   staging → intermediate → marts → semantic
│   ├── macros/           #   calculate_age, generate_schema_name (updated)
│   ├── seeds/            #   9 CSV files with financial domain test data
│   ├── profiles.yml      #   type: clickzetta ← THE key change
│   └── dbt_project.yml
├── .env.example
├── setup.py              ← One-click: deps + seed + run
└── e2e.py                ← Automated assertions
```

## The One Change That Matters

```yaml
# Before (dbt-databricks) — 01_source/dbt_blueprint/profiles.yml
connection_databricks:
  outputs:
    dev_local:
      type: databricks
      catalog: dbt_blueprint
      host: dbc-a505ff10-0af5.cloud.databricks.com
      http_path: /sql/1.0/warehouses/4fa4ca06332da87f
      token: "{{ env_var('BLUEPRINT_DATABRICKS_TOKEN') }}"

# After (dbt-clickzetta) — 03_lakehouse/profiles.yml
dbt_blueprint:
  outputs:
    dev:
      type: clickzetta
      instance: "{{ env_var('CZ_INSTANCE') }}"
      workspace: "{{ env_var('CZ_WORKSPACE') }}"
      service: "{{ env_var('CZ_SERVICE') }}"
      username: "{{ env_var('CZ_USERNAME') }}"
      password: "{{ env_var('CZ_PASSWORD') }}"
```

**Everything else — models, macros, tests, data contracts, unit tests — runs unchanged.**

## Additional Changes (syntax compatibility)

| File | Change | Impact |
|------|--------|--------|
| `macros/calculate_age.sql` | `DATEDIFF(year,s,e)+DATEADD` → `YEAR(e)-YEAR(s)-CASE` | Lakehouse compat |
| `macros/generate_schema_name.sql` | target name `databricks_cluster` → `clickzetta_prod` | Env name |
| `staging/*.sql` (9 files) | `col :: type` → `CAST(col AS type)` | Databricks cast syntax |
| `intermediate/int_users.sql` | `getdate()` → `current_date()` | Function name |
| `semantic/enriched_transactions.sql` | Removed duplicate `payment_source_id` | Bug in original |

`SELECT * EXCEPT (col)` — **no change needed**, supported by both Databricks and Lakehouse.

## Verified

Tested on **AWS Singapore** (instance `de1cbb4a`, dbt-clickzetta 1.7.10):

| Step | Result |
|------|--------|
| `dbt seed` | 9/9 PASS |
| `dbt run` | 30/30 PASS |
| `dbt test` | 36/36 PASS |

## Related

- [Databricks → 云器 Lakehouse 迁移评估系列](https://github.com/clickzetta/Databricks-vs-Lakehouse)
- Original: [Alex-Teodosiu/dbt-blueprint](https://github.com/Alex-Teodosiu/dbt-blueprint) ⭐72
