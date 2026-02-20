# Step 6 — Advanced Testing & Data Quality (dbt + Snowflake)

## Objective

Implement production-grade data quality checks to increase trust in the warehouse.
This step focuses on automated validation of:

- Key uniqueness (including surrogate keys in incremental models)
- Referential integrity between fact and dimension tables
- Business-rule consistency (sanity constraints)
- Reconciliation-style checks (where applicable)

---

# Test Suite Overview

This step introduces a dedicated marts test layer:

- File: `models/marts/marts_tests.yml`
- Scope: `dim_customer`, `dim_product`, `fct_invoice_lines`, `fct_revenue_monthly`

Key categories:

- **Uniqueness & Not Null**: primary keys + surrogate keys  
- **Relationships**: FK-like integrity between facts and dimensions  
- **Consistency Rules**: numeric constraints and classification coherence  
- **Warehouse Contracts (YAML)**: descriptions + test-as-contract approach  

---

# Key Finding: Surrogate Key Collisions

During initial implementation, the uniqueness test for `invoice_line_sk` failed:

- `unique_fct_invoice_lines_invoice_line_sk` → **2 duplicates**

This revealed a real-world issue:
the dataset has identical invoice-line attributes and does not include a native `line_id`.

## Resolution

A deterministic duplicate disambiguation strategy was added:

- Generate a `row_number()` within the invoice-line grain partition
- Include that `line_dup_n` in the surrogate key hash

This restored uniqueness while preserving a deterministic, reproducible key.

### Interview Talking Point

> When the source lacks a stable line-level identifier, a DE must create a deterministic surrogate key.
> I validated key uniqueness with dbt tests, detected collisions, and fixed them using a grain-aware
> row_number-based disambiguation strategy.

---

# Implementation Details

## 1) Deterministic line disambiguation

```sql
row_number() over (
  partition by
    invoice_no, stock_code, invoice_date, quantity, unit_price, customer_id, country
  order by invoice_no
) as line_dup_n
```

## 2) Updated surrogate key

```sql
md5(concat_ws('|', ..., to_varchar(line_dup_n)))
```

## 3) Backfill (required once)

Because the surrogate key changed, the fact model was rebuilt:

- `dbt run --select fct_invoice_lines --full-refresh`

---

# Results

After applying the fix, the fact-layer tests passed successfully:

- `PASS=9 WARN=0 ERROR=0` (fact-focused test subset)

---

# Recommended Screenshots

## Test Run Evidence

![dbt test success](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-06-dbt-test-success.jpg)

*Figure 1 — dbt test execution showing the suite passing successfully after surrogate key hardening.*

## Fix Applied (Code Diff or Model Snippet)

![surrogate key disambiguation](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-06-line-dup-fix.jpg)

*Figure 2 — Deterministic row_number-based disambiguation added to guarantee stable uniqueness.*

---

# Engineering Concepts Demonstrated

- Data-quality automation with dbt tests
- Fact/DIM referential integrity (relationships tests)
- Deterministic surrogate key design
- Detecting and fixing key collisions
- Safe backfill strategy for incremental models
- Production mindset: trust, contracts, repeatability

---

# Positioning

This step demonstrates production-grade thinking:

- Not only building models, but **ensuring they are reliable**
- Using tests to **surface real data issues**
- Applying deterministic fixes aligned with warehouse best practices
