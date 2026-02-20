# Changelog

All notable changes to this project are documented here.

------------------------------------------------------------------------

## [v0.6.0] - Advanced Testing & Data Quality Hardening

### Added

- Implemented advanced dbt data tests at mart layer
- Enforced surrogate key uniqueness validation on fct_invoice_lines
- Added referential integrity tests (fact → dimensions)
- Introduced business-rule expression tests (quantity, price, revenue logic)
- Detected and resolved surrogate key collisions using deterministic row_number disambiguation
- Validated full-refresh rebuild after surrogate key change

### Engineering Improvements

- Elevated warehouse from "modeled" to "contract-tested"
- Hardened fact-layer uniqueness under incremental MERGE strategy
- Increased reliability through automated data-quality enforcement
- Improved production-readiness posture

------------------------------------------------------------------------

## [v0.5.0] - Incremental MERGE & Production Hardening

### Added

- Converted fct_invoice_lines to incremental MERGE model
- Implemented deterministic surrogate key (MD5)
- Enforced unique_key strategy in dbt
- Validated idempotent re-execution behavior
- Documented performance trade-offs and scaling considerations

### Architecture

- Transitioned from full rebuild to incremental ingestion
- Improved scalability and cost efficiency
- Hardened transactional fact layer for production scenarios

------------------------------------------------------------------------

## [v0.4.0] - Dimensional Modeling & Finance Mart

### Added

- Implemented star schema (dim_customer, dim_product)
- Created transaction-level fact table (fct_invoice_lines)
- Created monthly aggregated finance mart (fct_revenue_monthly)
- Configured dbt DAG with explicit dependencies
- Generated dbt lineage documentation
- Validated financial reconciliation at mart layer

------------------------------------------------------------------------

## [v0.3.0] - Staging Layer & Governance Implementation

### Added

- Created STG_ONLINE_RETAIL view
- Introduced IS_ADJUSTMENT flag
- Introduced IS_VALID_TRANSACTION guardrail logic
- Defined operational revenue calculation
- Implemented anomaly guardrails for extreme values
- Validated reconciliation between raw and operational revenue

------------------------------------------------------------------------

## [v0.2.0] - Data Profiling & Revenue Validation

### Added

- Customer coverage analysis
- Revenue sanity validation (Gross, Returns, Net)
- Accounting adjustment impact measurement
- Geographic revenue distribution
- Monthly revenue trend validation
- Governance strategy definition

------------------------------------------------------------------------

## [v0.1.0] - Warehouse Setup & Raw Ingestion

### Added

- Snowflake warehouse configuration
- Database and schema creation
- Clean CSV ingestion pipeline
- Initial data validation checks
