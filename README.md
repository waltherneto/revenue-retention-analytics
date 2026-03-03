# Revenue Retention Analytics (Snowflake + dbt)

A production-oriented Data Engineering portfolio project demonstrating modern analytics engineering practices using Snowflake and dbt.

---

## Current Architecture Level

This project now includes:

- RAW ingestion layer
- Staging layer
- Dimensional modeling (star schema)
- Incremental processing strategy
- Advanced testing & data quality
- Data freshness & observability
- CI/CD automation with GitHub Actions
- Environment separation (DEV / PROD)

---

## Project Steps

1. Step 1 — Snowflake setup & ingestion
2. Step 2 — Data profiling & validation
3. Step 3 — Staging validation
4. Step 4 — Dimensional modeling
5. Step 5 — Incremental modeling
6. Step 6 — Advanced testing & data quality
7. Step 7 — Freshness & observability
8. Step 8 — CI/CD automation
9. Step 9 — Environment separation (DEV / PROD)

---

## Environments

Snowflake Databases:

- ANALYTICS_DEV
- ANALYTICS_PROD

CI Behavior:

- Pull Request → DEV target
- Push to main → PROD target

---

## Stack

- Snowflake
- dbt Core + dbt-snowflake
- GitHub Actions
- Python (light preprocessing)

---

This repository now reflects a deployment-aware Data Engineering workflow suitable for entry-to-mid-level remote Data Engineer roles.
