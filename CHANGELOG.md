# Changelog

## v0.9.0 — Environment Separation

### Added
- DEV and PROD Snowflake databases
- Multi-target dbt configuration (dev/prod)
- CI-aware target selection (PR → DEV, main → PROD)
- Environment-specific GitHub Secrets

### Notes
- This upgrade transitions the project to production-aware deployment standards.

---

## v0.8.0 — CI/CD Automation

- GitHub Actions workflow for dbt validation
- Secure profiles.yml generation
- Automated dbt debug/run/test

---

## v0.7.0 — Freshness & Observability

- Source freshness configuration
- Observability models
- Revenue reconciliation checks

---

## v0.6.0 — Advanced Testing

- Extended dbt test coverage
- Custom assertion logic

---

## v0.5.0 — Incremental Modeling

- Production-style incremental fact model

---

## v0.4.0 — Dimensional Modeling

- Staging layer
- Fact & dimension models

---

## v0.3.0 — Staging Validation

- Data standardization and validation

---

## v0.2.0 — Data Profiling

- Revenue validation and customer coverage analysis

---

## v0.1.0 — Initial Setup

- Snowflake account setup
- RAW ingestion
