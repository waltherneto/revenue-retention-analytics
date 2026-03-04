# Changelog

## v0.11.0 — Governance (Contracts, Docs & Exposures)

Added:

- Enforced dbt contracts on core fact model(s)
- Column type documentation for governed schemas
- Ownership metadata via config.meta (owner, domain, criticality, grain)
- Exposures documenting downstream consumers (dashboards/monitoring)
- dbt Docs evidence (tests, columns, lineage, exposures)

---

## v0.10.0 — Performance & Cost Optimization

- Query profiling workflow
- Clustering strategy (time-based pruning)
- dbt state-based execution (state:modified+)

---

## v0.9.0 — Environment Separation

- DEV / PROD Snowflake databases
- CI-aware target selection

---

## v0.8.0 — CI/CD Automation

- GitHub Actions pipeline for dbt validation

---

## v0.7.0 — Data Freshness & Observability

- Source freshness monitoring
- Observability models
- Reconciliation controls

---

## v0.6.0 — Advanced Testing

- dbt tests across marts
- Surrogate key collision fix documented

---

## v0.5.0 — Incremental Models

- Incremental MERGE hardening

---

## v0.4.0 — Dimensional Modeling

- Dimensional marts and finance mart

---

## v0.3.0 — Staging Layer

- Staging validation and governance flags

---

## v0.2.0 — Profiling

- Customer coverage and revenue validation

---

## v0.1.0 — Initial Setup

- Snowflake setup and ingestion
