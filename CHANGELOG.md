# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog and this project follows Semantic Versioning.

---

## v0.8.0 — CI/CD with GitHub Actions

### Added
- GitHub Actions workflow to run dbt in CI (`.github/workflows/dbt-ci.yml`)
- Dependency pinning for CI via `requirements.txt`
- Documentation for CI setup, Secrets, and validation (Step 8)

### Notes
- CI generates `profiles.yml` at runtime from GitHub Secrets (no credentials committed)

---

## v0.7.0 — Data freshness, observability & reconciliation

### Added
- Source freshness configuration and checks (`dbt source freshness`)
- Observability models for daily/ monthly monitoring
- Monthly revenue reconciliation controls

---

## v0.6.0 — Advanced testing & data quality

### Added
- Extended dbt tests across marts (unique, not_null, relationships)
- Custom assertions using dbt_utils (expression_is_true)
- Documentation focused on mid-level DE interview talking points

---

## v0.5.0 — Production-grade incremental modeling

### Added
- Incremental strategy for `fct_invoice_lines` (production pattern)
- Partition-friendly model structure and validations

---

## v0.4.0 — Dimensional modeling

### Added
- Staging layer (`stg_online_retail`)
- Dimensional marts (`dim_customer`, `dim_product`)
- Fact tables (`fct_invoice_lines`, `fct_revenue_monthly`)
- dbt docs lineage validation

---

## v0.3.0 — Staging validation

### Added
- Staging-level validation queries and consistency checks

---

## v0.2.0 — Data profiling & revenue validation

### Added
- Profiling queries for customer coverage, invoices, and revenue validation

---

## v0.1.0 — Initial setup

### Added
- Snowflake account setup and database/schema creation
- RAW ingestion of Online Retail dataset
