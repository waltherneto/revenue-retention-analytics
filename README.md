
# Revenue Retention Analytics
Production-style Data Engineering project demonstrating modern **Analytics Engineering** and **Data Platform** practices using Snowflake, dbt, and CI/CD automation.

This repository simulates a real-world data platform used to support **revenue retention analytics**, focusing on reliability, observability, governance, and production deployment patterns expected in modern data teams.

---

# Business Context

Subscription-based companies must continuously monitor **revenue retention, customer behavior, and financial performance**.

However, analytics environments often suffer from:

- inconsistent transformations
- unreliable datasets
- lack of testing and observability
- manual deployment processes
- missing governance and documentation

This project demonstrates how a modern **Analytics Engineering workflow** can solve these challenges.

---

# Solution Overview

This project implements a layered analytics architecture with automated transformations, data quality validation, observability controls, and CI/CD automation.

Key capabilities include:

- Modern warehouse modeling in **Snowflake**
- Modular transformations using **dbt**
- Incremental processing for scalable pipelines
- Automated **data quality testing**
- Data freshness and observability monitoring
- **CI/CD automation** for deployment
- Environment separation for DEV and PROD
- Governance via contracts, documentation, and exposures

---

# Architecture

The project follows a layered warehouse architecture inspired by modern data platforms.

![Warehouse Architecture](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/warehouse_architecture.jpg)

Figure 1 — Warehouse architecture's illustration.

Architecture goals:

- isolate transformation layers
- guarantee reproducibility
- enable scalable analytics development
- ensure data reliability

---

# Data Platform Capabilities

## Warehouse Modeling

Implements a layered Snowflake architecture:

- **RAW** — raw ingested datasets
- **STAGING** — cleaned and standardized models
- **MARTS** — dimensional analytical models

This structure improves:

- maintainability
- data lineage
- query performance

---

## Analytics Engineering with dbt

Transformations are implemented using **dbt**, enabling:

- modular SQL models
- dependency management
- documentation generation
- version-controlled transformations

Key modeling patterns implemented:

- staging models
- dimensional marts
- incremental processing

---

## Incremental Processing

Large datasets are processed using **incremental MERGE strategies**, allowing:

- efficient pipeline execution
- reduced compute cost
- scalable data updates

---

## Data Quality Testing

Data reliability is enforced using advanced dbt tests.

Implemented checks include:

- schema validation
- uniqueness constraints
- null validation
- referential integrity
- reconciliation logic

---

## Data Freshness & Observability

Freshness checks simulate **SLA monitoring for upstream data sources**.

Capabilities demonstrated:

- source freshness validation
- anomaly detection signals
- observability patterns for analytics pipelines

---

## Governance & Documentation

Governance features include:

- dbt **model contracts**
- documented exposures
- structured ownership
- automated documentation

These practices help ensure:

- consistent data definitions
- discoverable datasets
- maintainable analytics environments

---

## CI/CD Automation

Data pipelines are deployed through **GitHub Actions CI/CD workflows**.

Deployment strategy:

```
Pull Request
    ↓
Run dbt tests in DEV
    ↓
Merge to main
    ↓
Deploy models to PROD
```

This workflow ensures:

- automated validation
- reproducible deployments
- controlled production releases

---

## Environment Separation

Two Snowflake environments simulate real production workflows.

```
ANALYTICS_DEV
ANALYTICS_PROD
```

Benefits:

- safe development testing
- isolated production workloads
- controlled promotion of changes

---

# Technology Stack

| Layer | Technology |
|------|-------------|
| Data Warehouse | Snowflake |
| Transformation | dbt Core |
| Testing | dbt tests |
| Orchestration | GitHub Actions |
| Programming | Python |
| Version Control | Git / GitHub |

---

# Project Workflow

Development follows a modern analytics engineering lifecycle:

1. Data ingestion into Snowflake RAW
2. Data profiling and validation
3. Staging model development
4. Dimensional model creation
5. Incremental pipeline implementation
6. Data quality testing
7. Freshness monitoring
8. CI/CD automation
9. Environment promotion
10. Performance optimization
11. Governance implementation

---

# Key Learning Outcomes

This project demonstrates practical capabilities expected from **entry-to-mid level Data Engineers and Analytics Engineers**, including:

- warehouse architecture design
- modular SQL transformations
- data pipeline reliability patterns
- testing and observability
- CI/CD automation
- analytics governance

---

# Repository Structure

```
revenue-retention-analytics
│
├── models
│   ├── staging
│   ├── marts
│
├── tests
│
├── macros
│
├── analyses
│
├── .github/workflows
│
└── dbt_project.yml
```

---

# Future Improvements

Potential extensions for this project include:

- pipeline orchestration with Airflow
- streaming ingestion
- automated anomaly detection
- cost monitoring and warehouse optimization

---

# Author

Walther Fornaciari Neto

Data Engineer focused on modern analytics platforms, data reliability, and scalable data pipelines.
