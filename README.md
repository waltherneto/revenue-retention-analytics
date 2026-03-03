# Revenue Retention Analytics (Snowflake + dbt)

A portfolio-grade Data Engineering project that builds a clean, testable, and production-oriented analytics layer on top of the Online Retail dataset using Snowflake and dbt.

---

## Stack

- Snowflake (warehouse + storage)
- dbt Core + dbt-snowflake (transformations, testing, documentation)
- GitHub Actions (CI pipeline for dbt)
- Python (light data preparation during ingestion)

---

## Project Steps

Docs are written as “Steps” (not “Days”) to better reflect an incremental delivery pipeline.

1. Step 1 — Snowflake setup and ingestion (RAW)
2. Step 2 — Data profiling & revenue validation
3. Step 3 — Staging validation and operational revenue definition
4. Step 4 — Dimensional modeling (staging + marts)
5. Step 5 — Production-grade incremental modeling
6. Step 6 — Advanced testing & data quality
7. Step 7 — Data freshness, observability & reconciliation
8. Step 8 — CI/CD with GitHub Actions (dbt CI)

Key documentation files (in `/docs`):

- `docs/step-07_data-freshness-observability-reconciliation.md`
- `docs/step-8_ci-cd-with-github-actions.md`

---

## Deliverables (current)

- RAW ingestion of Online Retail into Snowflake
- Staging model with standardized types and operational flags
- Dimensional marts (`dim_customer`, `dim_product`)
- Fact tables (`fct_invoice_lines`, `fct_revenue_monthly`)
- Incremental strategy for production-like processing
- Data tests (not_null, unique, relationships, and custom assertions)
- Source freshness SLA checks
- Observability controls + revenue reconciliation
- CI workflow validating dbt project on GitHub Actions

---

## How to run locally

Typical command sequence inside the dbt project folder (`revenue_analytics/`):

- `dbt deps`
- `dbt debug`
- `dbt run`
- `dbt test`
- `dbt docs generate` and `dbt docs serve`

---

## CI

A GitHub Actions workflow runs dbt in CI with an ephemeral `profiles.yml` created from GitHub Secrets.

- Workflow: `.github/workflows/dbt-ci.yml`
- Docs: `docs/step-8_ci-cd-with-github-actions.md`
