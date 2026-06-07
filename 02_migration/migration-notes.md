# Migration Notes: dbt-databricks → dbt-clickzetta

## Changes Summary (minimal diff)

| File | Change | Type |
|------|--------|------|
| `profiles.yml` | `type: databricks` → `type: clickzetta`; `catalog/host/http_path` → `instance/workspace/service/vcluster` | **Core — 1 line per target** |
| `dbt_project.yml` | `profile: connection_databricks` → `profile: dbt_blueprint` | 1 line |
| `macros/calculate_age.sql` | `DATEDIFF(year,s,e)+DATEADD(...)` → `YEAR(e)-YEAR(s)-CASE...` | Lakehouse compat |
| `macros/generate_schema_name.sql` | `target.name in ["prod","databricks_cluster"]` → `["prod","clickzetta_prod"]` | Target name |
| `staging/*/*.sql` (9 files) | `col :: type` → `CAST(col AS type)` | Databricks-specific cast syntax |
| `intermediate/int_users.sql` | `getdate()` → `current_date()` | Function name |
| `semantic/enriched_transactions.sql` | Removed duplicate `payment_source_id` in CTE | Bug in original |

**Not changed**: `SELECT * EXCEPT (col)` — supported by both Databricks and Lakehouse.

## What Stayed the Same

All dbt model logic is unchanged:
- staging → intermediate → marts → semantic pipeline structure
- CTE patterns, window functions, LEAD/LAG, SCD Type 2 logic
- `dbt_utils.generate_surrogate_key()` macro
- `dbt_date` package usage
- Data contracts, unit tests, data tests
- All SQL business logic (JOINs, filters, aggregations)

## Seeds (added for standalone execution)

The original project required a live Databricks workspace with ingestion tables.
Seeds provide equivalent dummy data for local dev/testing:

| Seed | Rows | Replaces |
|------|------|---------|
| `user_events.csv` | 196 | `raw.user_events` |
| `merchant_events.csv` | 30 | `raw.merchants_dk_no` |
| `industry_codes.csv` | 30 | `raw.industry_codes` |
| `account_events.csv` | 80 | `raw.raw_account_events` |
| `card_events.csv` | 60 | `raw.raw_card_events` |
| `raw_p2p_captured_events.csv` | 150 | `raw.raw_p2p_captured_events` |
| `raw_p2p_failed_events.csv` | 50 | `raw.raw_p2p_failed_events` |
| `raw_p2b_captured_events.csv` | 80 | `raw.raw_p2b_captured_events` |
| `raw_p2b_failed_events.csv` | 30 | `raw.raw_p2b_failed_events` |

## Verified (AWS Singapore, de1cbb4a)

```
dbt seed:  9/9  PASS
dbt run:  30/30 PASS
dbt test: 36/36 PASS
```
