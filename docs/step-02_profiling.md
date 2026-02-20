# Step 2 — Data Profiling & Revenue Validation

## Objective

The goal of Step 2 was to:

-   Perform structured data profiling on the RAW layer\
-   Measure customer identification coverage\
-   Validate revenue metrics (gross, returns, net)\
-   Quantify the impact of accounting adjustments\
-   Identify potential outliers and non-operational transactions\
-   Define preliminary governance rules for the staging layer

This phase ensures that metrics are built on validated and
well-understood data.

------------------------------------------------------------------------

## Dataset Overview (RAW Layer)

**Table:** ANALYTICS_DB.RAW.ONLINE_RETAIL\
**Rows loaded:** 534,129\
**Date range:** 2010-12-01 → 2011-12-09

The RAW layer intentionally preserves the dataset close to source,
including:

-   Anonymous transactions (CustomerID can be null)\
-   Accounting adjustments\
-   Extreme quantity/price values

Business rules are not enforced in RAW.

------------------------------------------------------------------------

## 1. Customer Coverage Analysis

### Results

-   **Total Rows:** 534,129\
-   **Rows with NULL CustomerID:** 132,565\
-   **Anonymous Transactions:** 24.82%

### Interpretation

Almost 25% of transactions are anonymous purchases.

This is realistic in e-commerce environments where:

-   Guest checkout is allowed\
-   Customer accounts are optional\
-   Some legacy data lacks identifiers

### Governance Decision

-   Revenue metrics may include all transactions.\
-   Retention, cohort, and customer-level metrics will use only
    transactions with non-null CustomerID.\
-   This distinction will be applied in the modeling (dbt) layer.

------------------------------------------------------------------------

## 2. Orders and Customer Base

### Orders

-   **Distinct Invoices:** 23,796\
-   **Invoices with identified customer:** 22,186

This indicates that most invoices are linked to identified customers,
even though many individual rows are anonymous.

### Customers

-   **Distinct identified customers:** 4,371

This defines the active customer base for retention and cohort analysis.

------------------------------------------------------------------------

## 3. Revenue Sanity Check

### Financial Metrics

-   **Gross Revenue:** 10,642,110.80\
-   **Returns Value:** 893,979.73\
-   **Net Revenue:** 9,748,131.07

### Metric Definitions

-   Gross Revenue: sum of (quantity × unit_price) for sale rows\
-   Returns Value: sum of (absolute quantity × unit_price) for return
    rows\
-   Net Revenue: Gross Revenue minus Returns Value

Returns represent approximately **8.4%** of gross revenue, which is
plausible for retail environments.

------------------------------------------------------------------------

## 4. Accounting Adjustments Impact

During outlier analysis, extreme prices and quantities were identified.
Examples included:

-   Stock codes and descriptions related to fees, manual entries, bad
    debt, and adjustments\
-   Extremely large quantities (up to ±80,995)\
-   Extremely high unit prices (up to 38,970)

These rows are not typical product sales but accounting or system
adjustments.

### Adjustment Impact

-   **Adjustment Rows:** 4,154 (approximately 0.78% of the dataset)\
-   **Adjustment Value:** -192,557.05

### Operational Revenue (Excluding Adjustments)

-   **Operational Net Revenue:** 9,940,688.12

### Interpretation

Although adjustment rows represent a small portion of the dataset, they
have a meaningful financial impact.

Therefore:

-   The RAW layer preserves these records for auditability\
-   The staging layer will introduce an adjustment flag\
-   Operational dashboards and core revenue metrics will exclude
    adjustment rows\
-   Adjustments may be reported separately for transparency

This mirrors real-world financial data modeling practices.

------------------------------------------------------------------------

## 5. Monthly Revenue Trend

### Best Month

-   **November 2011:** 1,456,145.80

### Worst Month

-   **December 2011:** 432,701.06

December underperformance is expected due to partial month coverage
(data ends on December 9th). This confirms temporal consistency of the
dataset.

------------------------------------------------------------------------

## 6. Geographic Revenue Distribution

Top 3 countries by Net Revenue:

1.  **United Kingdom:** 8,189,252.30\
2.  **Netherlands:** 284,661.54\
3.  **EIRE:** 262,993.38

The UK dominates revenue, consistent with the dataset origin (UK-based
retailer).

------------------------------------------------------------------------

## 7. Outlier and Data Quality Observations

Observed extremes:

-   **Maximum unit price:** 38,970.00\
-   **Maximum quantity:** 80,995\
-   **Minimum quantity:** -80,995

These extremes correspond primarily to:

-   Accounting adjustments\
-   Fee-related entries\
-   Inventory corrections

No automatic hard filtering was applied in RAW. Instead, a governance
strategy was defined:

-   Flag adjustments\
-   Exclude adjustments from operational revenue\
-   Preserve adjustments for financial transparency and auditability

This approach prevents metric distortion while maintaining traceability.

------------------------------------------------------------------------

## Architectural Maturity Gained (Step 2)

This stage clarified several critical engineering principles:

-   RAW should remain source-aligned\
-   Cleaning and business rules belong in modeling layers\
-   Outliers must be measured before filtered\
-   Revenue should distinguish operational performance versus accounting
    effects\
-   Customer-level analytics must explicitly handle anonymous
    transactions

------------------------------------------------------------------------

## Next Step

Step 3 will formalize:

-   Adjustment logic in the staging layer\
-   A valid transaction definition aligned with business metrics\
-   Preparation for the dbt modeling layer (staging → marts)
