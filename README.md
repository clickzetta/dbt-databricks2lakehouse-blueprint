# dbt-blueprint

This repo is a comprehensive blueprint of how to use dbt to run data pipelines using Databricks compute. It showcases modular project structure, data contracts, various tests, incremental models with selectors, and Terraform-provisioned Databricks Workflows. No real financial data is used, only dummy data.

A copy-and-run **dbt + Databricks** blueprint for building **trustworthy, production-shaped data**:

- Modular layers (sources → staging → marts → semantic)
- Contracts & high-leverage tests
- Incremental models with selectors 
- Ready-to-demo dummy data (seeds)
- Optional Databricks Workflows via Terraform (IaC)

> All data is fake and safe to use publicly. Do **not** commit secrets.

---

## 1. Requirements

- Python **3.11+**
- [uv](https://docs.astral.sh/uv/) (or use `venv` + `pip`)
- A **Databricks** workspace (trial is fine)
- A **Personal Access Token (PAT)** from Databricks
- A **SQL Warehouse** *or* a **cluster** (you’ll need its **HTTP Path**)

---

## 2. Setup

### 2.1 Clone & Install

```bash
git clone https://github.com/<you>/dbt-blueprint.git
cd dbt-blueprint
uv sync
```

Create `~/.dbt/profiles.yml` (macOS/Linux) or `%USERPROFILE%\.dbt\profiles.yml` (Windows). Use token auth and reference environment variables to avoid hardcoding secrets.

```yaml
vmp_blueprint:
  target: dev
  outputs:
    dev:
      type: databricks
      host: "{{ env_var('DATABRICKS_HOST') }}"
      http_path: "{{ env_var('DATABRICKS_HTTP_PATH') }}"
      token: "{{ env_var('DATABRICKS_TOKEN') }}"
      catalog: "{{ env_var('DBT_CATALOG', 'hive_metastore') }}"
      schema: "{{ env_var('DBT_SCHEMA', 'dbt_blueprint_dev') }}"
      threads: 4
```

#### macOS/Linux

```bash
export DATABRICKS_HOST="https://<your-workspace-host>"
export DATABRICKS_HTTP_PATH="/sql/1.0/warehouses/<WAREHOUSE_OR_CLUSTER_HTTP_PATH>"
export DATABRICKS_TOKEN="dapi<your-token>"
export DBT_SCHEMA="dbt_blueprint_dev"
```

#### Windows (Powershell)

```powershell
$env:DATABRICKS_HOST="https://<your-workspace-host>"
$env:DATABRICKS_HTTP_PATH="/sql/1.0/warehouses/<WAREHOUSE_OR_CLUSTER_HTTP_PATH>"
$env:DATABRICKS_TOKEN="dapi<your-token>"
$env:DBT_SCHEMA="dbt_blueprint_dev"
```

---

## 3. Run dbt (Local)

From the repo root:

1. Install packages and load dummy data:
   ```bash
   uv run dbt deps
   uv run dbt seed
   ```

2. Validate connection and config:
   ```bash
   uv run dbt debug
   ```

3. Build models (fast, selective):
   ```bash
   uv run dbt run --select state:modified+
   ```

4. Run tests (contracts & quality):
   ```bash
   uv run dbt test
   ```

> **Tip:** If you change code, `state:modified+` only rebuilds what changed and its dependents.

---

## 4. Project Structure

```plaintext
dbt-blueprint/
├─ models/
│  ├─ sources/            # Source declarations + freshness
│  ├─ staging/            # Cleaned, contracted staging tables
│  ├─ intermediate/       # Intermediate layer for transformations
│  ├─ marts/              # Dims/facts (incremental by default)
│  └─ semantic/           # Exposures / metrics (optional)
├─ seeds/                 # Dummy CSVs (users, merchants, payments)
├─ macros/                # Custom tests/guards, helpers
├─ selectors.yml          # Run scoping (tags, state:modified+)
├─ dbt_project.yml
├─ terraform/             # Optional: Databricks Workflows via IaC
└─ README.md

---

## 5. Docs (Optional, Local Only)

Generate and serve documentation locally:

```bash
uv run dbt deps
uv run dbt docs generate
uv run dbt docs serve
```

This starts a local docs site (served from `target/`).