# Revenue Retention Analytics (Snowflake + dbt)

Production-style Data Engineering portfolio project demonstrating modern analytics engineering workflows—now including contracts, observability, CI/CD, and environment separation.

---

## Architecture Overview

RAW → STAGING → MARTS → METRICS → RELIABILITY → GOVERNANCE

Capabilities implemented:

- Snowflake warehouse modeling
- dbt transformations and documentation
- Incremental MERGE processing
- Advanced data quality testing
- Source freshness SLA simulation
- Observability + reconciliation controls
- CI/CD automation with GitHub Actions
- Environment separation (DEV / PROD)
- Performance and cost optimization approach
- Governance: contracts + exposures + owned documentation

---

## Project Steps

1. Step 1 — Snowflake Setup
2. Step 2 — Data Profiling
3. Step 3 — Staging Models
4. Step 4 — Dimensional Modeling
5. Step 5 — Incremental Models
6. Step 6 — Advanced Data Testing
7. Step 7 — Freshness & Observability
8. Step 8 — CI/CD with GitHub Actions
9. Step 9 — Environment Separation
10. Step 10 — Performance & Cost Optimization
11. Step 11 — Governance (Contracts, Docs & Exposures)

---

## Environments

Snowflake databases:

- ANALYTICS_DEV
- ANALYTICS_PROD

CI/CD strategy:

- Pull Request → DEV validation
- Push to main → PROD execution

---

## Technology Stack

- Snowflake
- dbt Core + dbt-snowflake
- dbt_utils
- GitHub Actions
- Python

---

This repository demonstrates practical capabilities expected from entry-to-mid level remote Data Engineers, including reliability and governance patterns.
