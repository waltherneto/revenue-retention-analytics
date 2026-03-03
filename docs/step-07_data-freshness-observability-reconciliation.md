# Step 7 — Data Freshness, Observability & Reconciliation

Snowflake · dbt · Data Reliability Engineering

---

## 🎯 Objective

Elevate the warehouse from “modeled” to monitored and production-aware by implementing:

- Source Freshness (SLA simulation)
- Daily Observability (volume & revenue drift detection)
- Financial Reconciliation Controls

This step demonstrates reliability engineering beyond transformation logic.

---

# 7.A — Source Freshness (SLA Simulation)

Freshness was configured at the RAW layer using dbt source freshness.

Configuration Highlights:

- loaded_at_field: INVOICE_DATE  
- Simulated SLA thresholds (historical dataset context)

In production scenarios, thresholds would reflect ingestion cadence (e.g., 12h warn, 24h error).

Execution:

dbt source freshness

Screenshot:

![Source Freshness Output](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-07-freshness.jpg)

Figure 1 — Successful freshness validation showing SLA configuration applied.

---

# 7.B — Daily Observability (Drift Detection)

Created monitoring model:

models/observability/obs_daily_volume_and_revenue.sql

Metrics tracked:

- Daily row count  
- Daily net revenue  
- Percentage change vs previous day  

Purpose:

- Detect ingestion drops  
- Detect revenue anomalies  
- Surface sudden behavior shifts  

Execution:

dbt run --select obs_daily_volume_and_revenue

Example Query:

select *
from ANALYTICS_DB.ANALYTICS.OBS_DAILY_VOLUME_AND_REVENUE
order by abs(net_revenue_pct_change) desc
limit 10

Screenshot:

![Daily Observability Table](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-07-daily-observability.jpg)

Figure 2 — Daily revenue and volume drift detection model output.

---

# 7.C — Financial Reconciliation Control

Created reconciliation control model:

models/observability/obs_monthly_revenue_reconciliation.sql

Purpose:

- Compare transactional aggregation vs finance mart
- Detect discrepancies automatically
- Ensure accounting consistency

Execution:

dbt run --select obs_monthly_revenue_reconciliation

Validation query:

select *
from ANALYTICS_DB.ANALYTICS.OBS_MONTHLY_REVENUE_RECONCILIATION
where diff_net_revenue <> 0
   or diff_operational_net_revenue <> 0

Result: 0 rows (no discrepancies)

Screenshot:

![Monthly Reconciliation](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-07-reconciliation.jpg)

Figure 3 — Monthly reconciliation control showing zero financial discrepancies.

---

# Engineering Capabilities Demonstrated

- SLA awareness
- Automated freshness monitoring
- Data drift detection
- Financial control framework
- Reliability-first warehouse design
- Observability at analytics layer

---

# Positioning

At this stage, the warehouse includes:

- Incremental processing
- Deterministic surrogate keys
- Automated testing contracts
- Source freshness SLAs
- Observability monitoring
- Reconciliation controls

This reflects production-ready Data Engineering thinking.
