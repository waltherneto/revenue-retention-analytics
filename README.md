# Revenue & Retention Analytics Platform (Snowflake + dbt + Power BI)

## Objective
Build a reliable analytics foundation to track **revenue**, **returns**, and **customer retention** from an e-commerce transactions dataset.
This project simulates an end-to-end Analytics Engineering workflow:
**ingestion → raw layer → data modeling (dbt) → business-ready metrics → dashboards (Power BI).**

## Stack
- **Snowflake** (data warehouse)
- **SQL** (profiling, validation, analytics)
- **dbt** (data modeling, testing, documentation) *(next steps)*
- **Power BI** (dashboards) *(next steps)*
- **Python** (controlled data cleaning + reproducible ingestion)

## Dataset
**Online Retail** (UK-based e-commerce transactions), containing invoice lines with:
- Invoice number, product code/description
- Quantity, unit price
- Invoice datetime
- Customer ID (can be null)
- Country

## Repository Structure
- `/docs`: progress notes, key decisions, screenshots
- `/scripts`: python utilities (data cleaning/conversion)
- `/sql`: profiling and validation queries
- `/dbt`: dbt project (added later)
- `/powerbi`: Power BI files/screenshots (added later)

---

# Day 1 — Warehouse Setup & Ingestion (Completed)

## What was done
- Created Snowflake account (trial)
- Created database: `ANALYTICS_DB`
- Created schemas: `RAW` and `ANALYTICS`
- Loaded cleaned dataset into: `ANALYTICS_DB.RAW.ONLINE_RETAIL`
- Validated row counts, date range, and sales/returns flags

## Why cleaning was needed
The original CSV ingestion via UI/CSV parsing was inconsistent and provided limited actionable error feedback.
To make ingestion deterministic and reproducible, a Python-based cleaning step was adopted to:
- Standardize datetime parsing (`InvoiceDate`)
- Normalize encoding (export clean UTF-8)
- Remove exact duplicates to avoid double counting
- Preserve business-critical signals (sales vs returns)

## RAW layer philosophy (important)
The `RAW` schema is treated as the **closest representation of the source** with minimal enforcement of business rules.
Example: `CustomerID` may be null (anonymous purchases). This is **acceptable in RAW**.
Business rules (e.g., excluding null customers from retention metrics) will be applied in dbt models.

---

# Data Quality Summary (Day 1)

## Load validation
- Rows loaded: **534,129**
- Date range: **2010-12-01 08:26:00 → 2011-12-09 12:50:00**
- Sales rows (`IS_SALE=1`): **524,878**
- Return rows (`IS_RETURN=1`): **9,251**

## Cleaning outcomes (Python)
- Invalid InvoiceDate rows dropped: **0**
- Exact duplicates removed: **5,263**
- Output exported rows: **534,129**

## Notes about CustomerID
- `CustomerID` may be null for anonymous transactions.
- Revenue metrics may include all transactions.
- Retention/cohort metrics will use **identified customers only** (`CustomerID not null`) in the modeling layer.

---

# Metrics (Planned)
These will be implemented in the analytics layer (dbt):

- **Gross Revenue** = sum(quantity * unit_price) where `IS_SALE=1`
- **Returns Value** = sum(abs(quantity) * unit_price) where `IS_RETURN=1`
- **Net Revenue** = Gross Revenue - Returns Value
- **Orders** = count distinct invoice_no (valid)
- **AOV** = Net Revenue / Orders
- **Active Customers (Monthly)** = customers with ≥1 order in month
- **Cohort Retention** = retained customers / cohort size (monthly)

---

# Architecture (Planned)
**Snowflake**
- `ANALYTICS_DB.RAW`: source-aligned table(s)
- `ANALYTICS_DB.ANALYTICS`: dbt models (staging, intermediate, marts)

**dbt layers (next)**
- `stg_`: typed + standardized fields
- `int_`: reusable business logic
- `fct_` / `dim_`: star schema for reporting
- cohort + customer-month facts for retention analysis

---

# How to run (Day 1)
1. Clean source CSV with Python (`/scripts/convert_csv_clean.py`) to generate `online_retail_clean.csv`
2. Upload the clean CSV to Snowflake stage (UI) and `COPY INTO` the RAW table
3. Run validation queries (row counts, date range, sales/returns)

> Next steps will add dbt models + tests + Power BI dashboards.

---

# Roadmap
- [ ] Day 2: data profiling + first revenue sanity checks (SQL)
- [ ] Day 3–14: dbt project (staging → marts, tests, docs)
- [ ] Day 15–20: Power BI dashboards (Executive + Analytical)
- [ ] Day 21–30: polishing portfolio + interview script + applications
