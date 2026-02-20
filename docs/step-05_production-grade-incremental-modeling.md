
# Step 5 — Production-Grade Incremental Modeling (Snowflake + dbt)

## Objective

Harden the warehouse by converting the transactional fact table into a 
production-grade incremental model using Snowflake MERGE strategy.

This step transitions the project from a learning implementation 
to a scalable, enterprise-ready architecture.

---

# Technical Upgrade

Model upgraded:
`fct_invoice_lines`

Configuration applied:

```sql
{{ config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = 'invoice_line_sk',
    on_schema_change = 'sync_all_columns'
) }}
```

---

# Surrogate Key Strategy

Because the dataset does not provide a native line-level identifier, 
a deterministic surrogate key was implemented:

```sql
md5(concat_ws('|',
  coalesce(invoice_no, ''),
  coalesce(stock_code, ''),
  coalesce(to_varchar(invoice_date), ''),
  coalesce(to_varchar(quantity), ''),
  coalesce(to_varchar(unit_price), ''),
  coalesce(to_varchar(customer_id), ''),
  coalesce(country, '')
)) as invoice_line_sk
```

## Why this matters (Interview Talking Point)

- Ensures deterministic idempotency  
- Enables reliable MERGE operations  
- Avoids duplicate ingestion  
- Aligns with enterprise dimensional modeling standards  

In production systems, surrogate keys are critical when natural keys are unstable or incomplete.

---

# Incremental Execution — First Run

![First Incremental Run](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-05-first-run.jpg)

*Figure 1 — Initial incremental execution creating the transactional fact table using Snowflake MERGE strategy.*

---

# Incremental Execution — Idempotency Validation

![Second Incremental Run](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-05-second-run.jpg)

*Figure 2 — Second execution returning SUCCESS 0, confirming idempotent behavior and absence of duplicate inserts.*

---

# Row Count Validation

Validation query executed in Snowflake:

```sql
select count(*) 
from ANALYTICS_DB.ANALYTICS.FCT_INVOICE_LINES;
```

![Row Count Validation](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-05-rowcount-validation.jpg)

*Figure 3 — Row count validation confirming stable record count after repeated executions.*

---

# Performance Considerations

While the `NOT IN` strategy is simple and reliable, 
it can become inefficient at large scale due to full table scans.

## Production Optimization Options

1. Partition-based incremental using `invoice_date`
2. Change detection using hash-diff columns
3. Snowflake clustering strategy
4. Micro-partition pruning optimization

## Interview Talking Point

If scaling to hundreds of millions of rows, 
I would replace the `NOT IN` logic with a date-based window or staged merge pattern 
to reduce scan cost and improve performance.

This demonstrates awareness of warehouse cost control and scaling constraints.

---

# Engineering Concepts Demonstrated

- Deterministic surrogate key generation
- Snowflake MERGE incremental strategy
- Idempotent data pipelines
- DAG-aware modeling in dbt
- Production scalability considerations
- Warehouse performance trade-offs

---

# Positioning

This step elevates the project from:

“Analytics Engineering learning exercise”

to

“Production-grade Data Engineering architecture simulation.”
