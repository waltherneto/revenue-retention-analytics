# Step 10 — Performance & Cost Optimization

Snowflake · dbt · Query Profiling · State-Based Execution

---

## Objective

This step focuses on **query performance optimization and warehouse cost control**.  
Two areas are addressed:

1. Snowflake physical optimization (clustering & query profiling)
2. dbt execution optimization (state-based builds)

These practices simulate real-world **Data Engineering performance tuning workflows**.

---

# 10.A — Establish a Performance Baseline

Before optimizing queries, we measure baseline performance.

### Baseline Query

```sql
SELECT
  DATE_TRUNC('month', invoice_date) AS invoice_month,
  SUM(IFF(is_sale=1, line_amount, 0)) AS gross_revenue,
  SUM(IFF(is_return=1, ABS(line_amount), 0)) AS returns_value,
  SUM(IFF(is_sale=1, line_amount, 0)) - SUM(IFF(is_return=1, ABS(line_amount), 0)) AS net_revenue
FROM ANALYTICS_PROD.ANALYTICS.FCT_INVOICE_LINES
GROUP BY 1
ORDER BY 1;
```

Metrics collected from Snowflake Query Profile:

- execution time
- bytes scanned
- partitions scanned

Screenshot placeholder:

![Query Profile Baseline](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-10_query-profile-baseline.jpg)

Figure 1 — Snowflake Query Profile showing execution stages before optimization.

---

# 10.B — Snowflake Table Optimization (Clustering)

Because most analytical queries filter or aggregate by time, we apply clustering on the fact table.

### Apply clustering key

```sql
ALTER TABLE ANALYTICS_PROD.ANALYTICS.FCT_INVOICE_LINES
CLUSTER BY (TO_DATE(invoice_date));
```

This improves **micro-partition pruning** when filtering or aggregating by date.

### Verification

After applying clustering:

1. Re-run the baseline query.
2. Compare Query Profile metrics.
3. Confirm cluster configuration in table details.

Screenshot placeholders:

![Table Cluster Key](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-10_cluster-key.jpg)

![Query Profiler after Optimization](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-10_query-profile-after.jpg)

Figure 2 — Snowflake table configuration showing cluster key applied.

Figure 3 — Query Profile comparison after clustering optimization.

---

# 10.C — dbt Execution Optimization (State-Based Builds)

Large dbt projects should avoid rebuilding the entire DAG when only a few models change.

State comparison allows dbt to run only modified models.

---

## 10.C.1 — Compile project

```bash
dbt compile
```

Generates the state artifacts:

target/manifest.json  
target/run_results.json

---

## 10.C.2 — Run full baseline build

```bash
dbt build --target dev
```

This establishes the current project state.

---

## 10.C.3 — Modify a model

Example:

models/marts/finance/fct_invoice_lines.sql

Add a temporary comment to simulate a code change.

---

## 10.C.4 — Run only modified models

```bash
dbt build   --select state:modified+   --defer   --state ./target   --target dev
```

Explanation:

| Parameter | Purpose |
|---|---|
| state:modified+ | runs modified models and downstream dependencies |
| --state | compares current code with previous manifest |
| --defer | references existing objects |
| --target dev | executes in development environment |

---

## 10.C.5 — Validate reduced execution

The terminal output should show something like:

Found 1 model to run

instead of the full DAG execution.

Screenshot placeholder:

![dbt State-Based Execution](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-10_state-based-run.jpg)

Figure 4 — dbt state-based execution running only modified models.

---

# Engineering Capabilities Demonstrated

This step demonstrates:

- Query performance analysis using Snowflake Query Profile
- Micro-partition pruning optimization via clustering
- Cost-aware warehouse query design
- State-based dbt execution for faster CI/CD pipelines
- Reduced compute cost during development workflows
