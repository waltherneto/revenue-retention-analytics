# Revenue & Retention Analytics Platform

Snowflake · SQL · dbt · Power BI · Python

------------------------------------------------------------------------

# Project Overview

This project builds a production-style analytics foundation for
measuring:

-   Revenue performance\
-   Returns impact\
-   Customer retention\
-   Geographic distribution\
-   Operational vs accounting revenue

The goal is to simulate a real Analytics Engineering workflow:

Ingestion → Raw Layer → Profiling → Governance Decisions → Modeling
(dbt) → Business Metrics → BI Layer

The dataset used is the Online Retail UK e-commerce transactions dataset
(2010--2011).

------------------------------------------------------------------------

# Key Findings (So Far)

## Dataset Scale

-   534,129 rows loaded into Snowflake RAW layer
-   Date range: 2010-12-01 → 2011-12-09
-   23,796 distinct invoices
-   4,371 identified customers

## Customer Coverage

-   24.82% of transactions are anonymous (CustomerID is null)
-   Retention metrics will use only identified customers
-   Revenue metrics may include all transactions

## Revenue Validation

-   Gross Revenue: 10,642,110.80
-   Returns Value: 893,979.73
-   Net Revenue: 9,748,131.07

Returns represent \~8.4% of gross revenue, consistent with retail
environments.

## Accounting Adjustments Impact

-   4,154 adjustment rows (\~0.78% of dataset)
-   Adjustment value: -192,557.05
-   Operational Net Revenue (excluding adjustments): 9,940,688.12

Conclusion: accounting entries materially affect financial metrics and
must be flagged rather than removed.

## Geographic Distribution

Top 3 countries by Net Revenue: 1. United Kingdom -- 8,189,252.30 2.
Netherlands -- 284,661.54 3. EIRE -- 262,993.38

------------------------------------------------------------------------

# Architecture

## Snowflake Warehouse

Database: ANALYTICS_DB

Schemas: - RAW → source-aligned tables - ANALYTICS → modeled layer (dbt)

RAW philosophy: - Preserve original data structure - Do not enforce
business rules - Keep adjustments and anonymous transactions

## Modeling Strategy (Next Phase)

Planned dbt layers:

-   stg\_ → typed and standardized fields
-   int\_ → reusable business logic
-   fct\_ → revenue, orders, customer-month facts
-   dim\_ → customer and date dimensions

Adjustments will be flagged using an IS_ADJUSTMENT rule in staging.

------------------------------------------------------------------------

# Data Quality & Governance Strategy

Principles established during profiling:

-   RAW must remain source-aligned
-   Outliers must be measured before filtered
-   Operational revenue must exclude accounting adjustments
-   Anonymous customers must be handled explicitly in retention logic
-   Financial transparency is prioritized over aggressive cleaning

------------------------------------------------------------------------

# Roadmap

Completed: - Warehouse setup (Snowflake) - RAW ingestion pipeline
(Python + COPY) - Data profiling and revenue validation - Adjustment
impact analysis - Governance strategy definition

Next Steps: - Implement staging logic in dbt - Define valid_transaction
rule - Build revenue & retention marts - Create executive dashboard
(Power BI) - Add data tests and documentation (dbt docs)

------------------------------------------------------------------------

# Technical Stack

-   Snowflake (Cloud Data Warehouse)
-   SQL (profiling and analytics)
-   Python (controlled ingestion and cleaning)
-   dbt (data transformation & testing -- upcoming)
-   Power BI (visualization -- upcoming)

------------------------------------------------------------------------

# Why This Project Matters

This project demonstrates:

-   End-to-end data pipeline thinking
-   Financial metric validation
-   Real-world anomaly handling
-   Governance-aware modeling decisions
-   Ability to distinguish operational vs accounting data
-   Engineering maturity beyond simple data cleaning

The focus is not just on writing SQL --- but on designing reliable
analytical systems.
