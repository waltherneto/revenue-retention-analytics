# Changelog

All notable changes to this project will be documented in this file.

The format is inspired by Keep a Changelog and follows semantic
versioning principles.

------------------------------------------------------------------------

## \[v0.2.0\] - Data Profiling & Revenue Validation

### Added

-   Comprehensive data profiling on RAW layer
-   Customer coverage analysis (anonymous vs identified customers)
-   Revenue validation (Gross, Returns, Net Revenue)
-   Accounting adjustment detection logic
-   Operational Net Revenue metric (excluding adjustments)
-   Geographic revenue distribution analysis
-   Monthly revenue trend validation
-   Governance strategy definition for staging layer

### Decisions

-   RAW layer remains source-aligned and unfiltered
-   Adjustments will be flagged, not removed
-   Retention metrics will exclude anonymous customers
-   Operational revenue will exclude accounting adjustments

------------------------------------------------------------------------

## \[v0.1.0\] - Initial Warehouse Setup & Raw Ingestion

### Added

-   Snowflake account setup
-   Database ANALYTICS_DB creation
-   RAW and ANALYTICS schemas
-   Python cleaning pipeline for Online Retail dataset
-   Clean CSV ingestion into RAW.ONLINE_RETAIL
-   Sales and return flags (IS_SALE, IS_RETURN)
-   Initial row count and date validation
-   Day 1 ingestion documentation

### Data Quality Actions

-   Standardized InvoiceDate parsing
-   Removed 5,263 exact duplicate rows
-   Preserved anonymous transactions
-   Preserved accounting adjustment rows for transparency

------------------------------------------------------------------------

## Upcoming (Planned)

-   dbt staging layer implementation
-   valid_transaction logic formalization
-   Revenue and retention marts
-   Data tests and documentation
-   Executive dashboard (Power BI)
-   Portfolio refinement and interview preparation
