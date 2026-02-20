# Revenue & Retention Analytics Platform

Snowflake · SQL · dbt · Python · Dimensional Modeling · Incremental Processing

---

# Project Overview

This project builds a production-style analytics warehouse to measure:

- Revenue performance  
- Returns impact  
- Customer behavior  
- Geographic distribution  
- Operational vs accounting revenue  

It simulates a real-world Analytics Engineering workflow:

Ingestion → RAW → STG → Dimensional Models → Incremental Fact Layer → Finance Mart  

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

---

# Technical Stack

- Snowflake  
- SQL  
- Python  
- dbt (DAG orchestration & modeling)  

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

Next:

- Advanced testing & constraints  
- Partition-based performance optimization  
- Incremental finance mart  
- BI exposure layer  

---

# Why This Project Matters

This project demonstrates:

- Layered warehouse architecture  
- Dimensional modeling (Kimball-style)  
- Snowflake incremental MERGE strategy  
- Idempotent data engineering pipelines  
- Performance-aware warehouse design  
- Production-level analytics engineering  

It reflects real-world Data Engineering thinking — not just SQL querying.
