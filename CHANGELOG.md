# Changelog

All notable changes to this project are documented here.

------------------------------------------------------------------------

## [v0.4.0] - Dimensional Modeling & Finance Mart

### Added

- Implemented star schema (dim_customer, dim_product)
- Created transaction-level fact table (fct_invoice_lines)
- Created monthly aggregated finance mart (fct_revenue_monthly)
- Configured dbt DAG with explicit dependencies
- Generated dbt lineage documentation
- Validated financial reconciliation at mart layer

### Architecture

- Introduced dimensional modeling layer
- Formalized grain definition
- Separated transactional and aggregated marts
- Established production-ready transformation pipeline

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
