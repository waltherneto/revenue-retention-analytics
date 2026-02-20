# Day 3 — Staging Layer & Governance Logic

## Objective

The goal of Day 3 was to introduce a structured staging layer on top of
RAW data and formalize governance rules for operational revenue metrics.

This marks the transition from raw ingestion to analytical engineering
design.

------------------------------------------------------------------------

# Architectural Evolution

By the end of Day 3, the architecture now includes:

RAW → Source-aligned data\
STG → Technical normalization and governance flags\
Operational Metrics → Built from validated transactions

The RAW layer remains untouched and audit-safe.\
All business logic is implemented in the STAGING layer.

------------------------------------------------------------------------

# Staging View Created

View: ANALYTICS_DB.ANALYTICS.STG_ONLINE_RETAIL

The staging view introduces:

-   LINE_AMOUNT (quantity × unit_price)
-   SALE_VALUE (positive sales only)
-   RETURN_VALUE (positive return values)
-   IS_ADJUSTMENT flag
-   IS_VALID_TRANSACTION flag

------------------------------------------------------------------------

# Adjustment Detection Logic

Transactions are flagged as adjustments if:

-   STOCK_CODE in ('AMAZONFEE', 'B', 'M')
-   DESCRIPTION contains keywords such as:
    -   adjust
    -   manual
    -   fee
    -   bad debt

Adjustment rows identified: 4,154 (\~0.78% of dataset)

These rows are preserved but excluded from operational metrics.

------------------------------------------------------------------------

# Valid Transaction Definition

A transaction is considered valid if:

-   It is not an accounting adjustment
-   UNIT_PRICE \> 0
-   ABS(QUANTITY) ≤ 10,000
-   UNIT_PRICE ≤ 10,000

This creates guardrails against extreme outliers without mutating RAW.

Resulting segmentation:

Total Rows: 534,129\
Valid Rows: 529,967\
Invalid Rows: 4,162

Only 8 rows were invalid beyond explicit adjustments, indicating strong
dataset consistency.

------------------------------------------------------------------------

# Operational Revenue Validation

Using only IS_VALID_TRANSACTION = 1:

Gross Revenue (Operational): 10,205,339.10\
Returns Value (Operational): 264,650.98\
Net Revenue (Operational): 9,940,688.12

Comparison with previous net revenue:

Net Revenue (Including Adjustments): 9,748,131.07\
Difference: \~192,557.05

This difference matches the accounting adjustment impact measured on Day
2.

------------------------------------------------------------------------

# Governance Decisions Established

1.  RAW layer remains immutable and audit-aligned.
2.  Adjustments are flagged, not deleted.
3.  Operational revenue excludes adjustment rows.
4.  Outliers are handled through guardrails, not destructive filtering.
5.  Revenue transparency is prioritized over aggressive cleaning.

------------------------------------------------------------------------

# Engineering Principles Reinforced

-   Separate ingestion from business logic.
-   Measure anomalies before filtering.
-   Distinguish operational performance from accounting entries.
-   Design layers that are dbt-ready.
-   Maintain reproducibility and traceability.

------------------------------------------------------------------------

# Next Step

Day 4 will introduce dbt to formalize:

-   stg models
-   reusable intermediate models
-   fact tables for revenue and retention
-   automated data tests

This transitions the project from SQL-based transformation to analytics
engineering workflow.
