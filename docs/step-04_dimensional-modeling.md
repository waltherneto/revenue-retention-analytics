# Step 4 — Dimensional Modeling & Revenue Mart

## Objective

Design and implement a production-style dimensional model using dbt, transforming staging data into analytical-ready marts following a layered warehouse architecture.

---

# Architecture Overview

The project now follows a structured warehouse layering pattern:

```
raw.ONLINE_RETAIL
        ↓
stg_online_retail
        ↓
   ┌───────────────┬───────────────┐
   ↓               ↓               ↓
dim_customer   dim_product   fct_invoice_lines
                                    ↓
                           fct_revenue_monthly
```

---

## Lineage Graph

![Lineage Graph](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-04-lineage.jpg)

*Figure 1 — Full dbt lineage graph showing raw ingestion, staging transformations, dimensional modeling, and aggregated finance mart.*

---

## 📦 Models Created

### 1. dim_customer

**Purpose:**  
Provide a clean, deduplicated customer dimension.

- Unique customer ID
- Country attribution
- Star-schema ready

---

### 2. dim_product

**Purpose:**  
Product-level analytical dimension.

- Unique stock_code
- Normalized descriptions
- Analytical enrichment-ready

---

### 3️⃣ fct_invoice_lines

**Purpose:**  
Transaction-level fact table.

**Grain:** One row per invoice line

Measures:

- quantity
- unit_price
- line_amount
- return flag
- adjustment flag

---

### 4️⃣ fct_revenue_monthly

**Purpose:**  
Monthly aggregated revenue mart.

Measures:

- gross_revenue
- returns_value
- net_revenue
- operational_net_revenue

---

## 📈 Revenue Validation Query

![Revenue Validation](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-04-revenue-validation.jpg)

*Figure 2 — Validation query executed in Snowflake confirming aggregated financial metrics.*

---

## 🧠 Business Logic Implemented

```
gross_revenue = sum(line_amount where quantity > 0)
returns_value = sum(abs(line_amount where quantity < 0))
net_revenue = gross_revenue - returns_value
operational_net_revenue = net_revenue excluding adjustments
```

---

## 🧪 Commands Executed

```
dbt run
dbt test
dbt docs generate
dbt docs serve
```

---

## ⚙ Engineering Decisions

- Clear separation between staging and marts
- Explicit grain definition
- Business logic isolated in fact models
- Kimball-aligned dimensional modeling
- Explicit model dependencies using ref() and source()

---

## 🚀 Production Readiness Status

- Full DAG operational
- Revenue metrics validated
- Documentation generated
- Lineage graph verified

Next step: Production-grade incremental modeling (Step 5).
