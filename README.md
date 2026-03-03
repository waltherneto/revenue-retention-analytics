# Revenue & Retention Analytics Platform

Snowflake · SQL · dbt · Python · Dimensional Modeling · Incremental Processing · Data Reliability

---

# Project Overview

This project builds a production-style analytics warehouse to measure:

- Revenue performance  
- Returns impact  
- Customer behavior  
- Geographic distribution  
- Operational vs accounting revenue  

It simulates a real-world Analytics Engineering workflow:

Ingestion → RAW → STG → DIM → FACT → MART → Reliability Controls  

Dataset: Online Retail UK (2010–2011)

---

# Warehouse Architecture

Database: ANALYTICS_DB

Schemas:

- RAW → Source-aligned ingestion layer  
- ANALYTICS → Staging & dimensional modeling layer  

Layered Architecture:

RAW  
- Immutable  
- Audit-safe  
- No business rules  

STG (stg_online_retail)  
- Type casting  
- Derived metrics  
- Adjustment flags  
- Operational classification  

DIMENSIONS  
- dim_customer  
- dim_product  

FACT TABLE (Incremental MERGE)  
- fct_invoice_lines (transaction grain, surrogate key, idempotent)

AGGREGATED MART  
- fct_revenue_monthly (monthly finance mart)

OBSERVABILITY LAYER  
- obs_daily_volume_and_revenue  
- obs_monthly_revenue_reconciliation  

---

# Step 5 — Production-Grade Incremental Modeling

The transactional fact table was upgraded to a Snowflake MERGE-based incremental model using:

- Deterministic surrogate key (MD5 hash)
- Unique key enforcement
- Idempotent execution validation
- Cost-aware incremental strategy

This ensures scalability and production readiness.

(Full documentation available in docs/Step-05)

---

# Step 6 — Advanced Testing & Data Quality

The warehouse was upgraded with production-grade automated testing using dbt.

Enhancements include:

- Surrogate key uniqueness enforcement
- Referential integrity between fact and dimension tables
- Business-rule consistency tests
- Deterministic duplicate disambiguation strategy
- Full-refresh rebuild validation after key change

A real-world issue was detected:
duplicate surrogate key collisions due to lack of native line identifiers.

This was resolved using grain-aware row_number disambiguation inside the fact model.

(Full documentation available in docs/Step-06)

---

# Step 7 — Data Freshness, Observability & Reconciliation

The warehouse was elevated from modeled to monitored by introducing reliability controls.

Enhancements include:

- Source SLA simulation using dbt source freshness
- Daily drift detection (row count & revenue change monitoring)
- Automated financial reconciliation between fact and mart layers
- Observability-focused monitoring models

This introduces production-style reliability engineering practices into the analytics layer.

(Full documentation available in docs/Step-07)

---

# Financial Metrics (Mart Layer)

Validated from fct_revenue_monthly:

- Gross Revenue: 10,539,534.83  
- Returns Value: 511,913.68  
- Net Revenue: 10,027,621.15  
- Operational Net Revenue: 9,748,131.07  

All metrics are computed through reproducible dbt models.

---

# Governance & Engineering Principles

- Preserve source integrity in RAW  
- Separate operational and accounting effects  
- Model transformations explicitly  
- Enforce grain clarity  
- Build idempotent pipelines  
- Design for scalability and cost efficiency  
- Monitor freshness & reliability metrics  
- Implement reconciliation-based control checks  

---

# Technical Stack

- Snowflake  
- SQL  
- Python  
- dbt (DAG orchestration & modeling)  
- Git versioning  

---

# Roadmap

Completed:

- Snowflake warehouse setup  
- RAW ingestion  
- Data profiling & validation  
- Staging governance logic  
- Dimensional modeling (star schema)  
- Finance mart aggregation  
- Incremental MERGE hardening (production-grade)
- Advanced testing & data-quality enforcement  
- Freshness monitoring & observability layer  

Next:

- CI/CD automation (dbt + GitHub Actions)  
- Environment separation (dev/prod targets)  
- Partition-based performance optimization  
- Cost-aware warehouse tuning  
- BI exposure layer  

---

# Why This Project Matters

This project demonstrates:

- Layered warehouse architecture  
- Dimensional modeling (Kimball-style)  
- Snowflake incremental MERGE strategy  
- Idempotent data engineering pipelines  
- Automated data-quality enforcement  
- SLA configuration & observability design  
- Financial reconciliation controls  

It reflects real-world Data Engineering maturity — beyond transformation logic.
