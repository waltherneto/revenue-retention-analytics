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

Ingestion → RAW → STG → Marts (dbt) → BI Layer

The dataset used is the Online Retail UK e-commerce transactions dataset
(2010--2011).

------------------------------------------------------------------------

# Key Findings

## Dataset Scale

-   534,129 rows loaded
-   Date range: 2010-12-01 → 2011-12-09
-   23,796 distinct invoices
-   4,371 identified customers

## Customer Coverage

-   24.82% of transactions are anonymous
-   Retention metrics exclude anonymous customers
-   Revenue metrics may include all transactions

## Revenue Validation

-   Gross Revenue: 10,642,110.80
-   Returns Value: 893,979.73
-   Net Revenue: 9,748,131.07

## Accounting Adjustment Impact

-   4,154 adjustment rows (\~0.78%)
-   Adjustment value: -192,557.05

## Operational Revenue (Staging Logic Applied)

-   Gross Revenue (Operational): 10,205,339.10
-   Returns Value (Operational): 264,650.98
-   Net Revenue (Operational): 9,940,688.12

Operational revenue excludes accounting adjustments and extreme
anomalies through governance guardrails.

------------------------------------------------------------------------

# Architecture

Database: ANALYTICS_DB

Schemas:

-   RAW → Source-aligned ingestion layer
-   ANALYTICS → Staging & modeling layer

Layer Responsibilities:

RAW\
- Immutable - Audit-safe - No business rules applied

STG (View: STG_ONLINE_RETAIL)\
- Adds LINE_AMOUNT, SALE_VALUE, RETURN_VALUE - Introduces IS_ADJUSTMENT
flag - Introduces IS_VALID_TRANSACTION guardrails - Separates
operational vs accounting revenue

MARTS (Upcoming via dbt)\
- Revenue fact tables - Customer retention metrics - Monthly and country
aggregates

------------------------------------------------------------------------

# Governance Principles

-   Preserve source integrity in RAW
-   Flag anomalies instead of deleting
-   Separate operational and accounting effects
-   Use guardrails for extreme values
-   Design transformations dbt-ready

------------------------------------------------------------------------

# Roadmap

Completed: - Snowflake warehouse setup - RAW ingestion pipeline - Data
profiling & revenue validation - Adjustment impact analysis - Staging
layer implementation - Operational revenue formalization

Next: - Bootstrap dbt project - Implement staging models in dbt - Create
revenue & retention marts - Add automated data tests - Build executive
dashboard

------------------------------------------------------------------------

# Technical Stack

-   Snowflake
-   SQL
-   Python
-   dbt (next phase)
-   Power BI (next phase)

------------------------------------------------------------------------

# Why This Project Matters

This project demonstrates:

-   End-to-end analytics engineering thinking
-   Financial metric validation
-   Governance-aware modeling
-   Operational vs accounting separation
-   Reproducible layered architecture

It reflects production-style analytical system design --- not just SQL
querying.
