# Revenue & Retention Analytics Platform

Snowflake · SQL · dbt · Python · Dimensional Modeling

---

# Project Overview

This project builds a production-style analytics warehouse to measure:

- Revenue performance  
- Returns impact  
- Customer behavior  
- Geographic distribution  
- Operational vs accounting revenue  

It simulates a real-world Analytics Engineering workflow:

Ingestion → RAW → STG → Dimensional Models → Finance Mart → BI Layer  

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

FACT TABLE  
- fct_invoice_lines (transaction grain)

AGGREGATED MART  
- fct_revenue_monthly (monthly finance mart)

---

# Dimensional Model (dbt Lineage)

The project follows a layered transformation structure:

raw.ONLINE_RETAIL  
→ stg_online_retail  
→ dim_customer / dim_product / fct_invoice_lines  
→ fct_revenue_monthly  

(Lineage screenshot available in docs/day-04)

---

# Financial Metrics (Mart Layer)

Validated from fct_revenue_monthly:

- Gross Revenue: 10,539,534.83  
- Returns Value: 511,913.68  
- Net Revenue: 10,027,621.15  
- Operational Net Revenue: 9,748,131.07  

All metrics are computed through reproducible dbt models.

---

# Governance Principles

- Preserve source integrity in RAW  
- Separate operational and accounting effects  
- Model transformations explicitly  
- Enforce grain clarity  
- Build reproducible DAGs  

---

# Technical Stack

- Snowflake  
- SQL  
- Python  
- dbt (Dimensional modeling & DAG management)  

---

# Roadmap

Completed:

- Snowflake warehouse setup  
- Clean RAW ingestion  
- Data profiling & revenue validation  
- Staging governance logic  
- Dimensional modeling (star schema)  
- Finance mart aggregation  
- dbt lineage documentation  

Next:

- Incremental modeling (production-grade)  
- Advanced testing & constraints  
- Performance optimization  
- BI exposure layer  

---

# Why This Project Matters

This project demonstrates:

- Layered warehouse architecture  
- Dimensional modeling (Kimball-style)  
- Revenue metric engineering  
- dbt dependency management  
- Governance-aware transformations  
- Production-style analytical thinking  

It reflects an Analytics Engineering mindset — not just SQL querying.
