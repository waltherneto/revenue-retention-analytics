# Step 11 — Data Warehouse Governance (Contracts, Docs & Exposures)

Snowflake · dbt · Data Contracts · Documentation · Exposures

---

## 🎯 Objective

Finalize the portfolio with production-grade governance patterns:

- Enforced data contracts on core fact models
- Strong documentation (models + columns + types)
- Explicit ownership metadata (meta)
- Exposures that connect warehouse outputs to business consumers
- dbt Docs evidence (lineage + contracts + tests)

This step focuses on trust, clarity, and production readiness—not new transformations.

---

# 11.A — Data Contracts on Core Facts

The fct_invoice_lines model was upgraded with:

- contract.enforced: true
- explicit data_type for critical columns
- tests that behave as a contract (not_null / unique / accepted_values)

### Evidence: Contract Enforcement in YAML

![Contract enforced YAML](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-11_contract-enforced-yml.jpg)

Figure 1 — Model contract enabled via contract.enforced: true with governed metadata and typed columns.

### Evidence: Contract + Types + Tests in dbt Docs (fct_invoice_lines)

![fct_invoice_lines docs columns](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-11_fct-invoice-lines-columns-tests.jpg)

Figure 2 — dbt Docs showing governed column types and contract-aligned tests for fct_invoice_lines.

---

# 11.B — Ownership & Governance Metadata

Governance metadata was standardized in YAML using config.meta:

- owner
- data_domain
- criticality
- pii
- grain
- slo

Interview talking point:

> I treat core marts as governed products. I document ownership, grain, and criticality, and enforce contracts on core facts to prevent schema drift.

---

# 11.C — Exposures (Consumers of the Warehouse)

Exposures were introduced to connect transformed datasets to business-facing consumers.

Example exposure:

- revenue_monthly_kpi_dashboard → depends on fct_revenue_monthly
- reliability_controls_monitoring → depends on observability models

### Evidence: Exposures List in dbt Docs

![Lineage graph](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-11_exposures-list.jpg)

Figure 3 — Exposures List in dbt Docs and exposure page documenting ownership, description, and dependencies for the simulated finance dashboard.

---

# 11.D — Lineage Evidence (Governed Data Product)

Lineage is used as a governance artifact to validate:

- clear dependency chain
- controlled transformations
- impact assessment for changes

### Evidence: Lineage Graph (Finance Mart)

![Finance mart lineage](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-11_lineage_graph.jpg)

Figure 4 — Lineage graph for fct_revenue_monthly, showing upstream sources and transformation chain.

---

# ✅ Commands Executed

- dbt run --select fct_invoice_lines --target dev
- dbt test --select fct_invoice_lines --target dev
- dbt docs generate --target dev
- dbt docs serve --target dev

---

# 🧠 Engineering Capabilities Demonstrated

- Contract enforcement to prevent schema drift
- Governed documentation (types + descriptions)
- Ownership metadata (accountability)
- Exposures linking data to consumers
- Lineage as a governance artifact
- Production-ready data product mindset

---

# 📌 Positioning

With Step 11, the portfolio demonstrates not only transformation skills, but also:

- governance maturity
- documentation discipline
- deployment awareness
- reliability engineering

This is a strong signal for entry-to-mid remote Data Engineer roles.
