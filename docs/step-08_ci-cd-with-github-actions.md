# Step 8 — CI/CD with GitHub Actions (dbt CI)

Goal: introduce a production-style CI pipeline that validates every change to the dbt project before merge/deploy.

This step adds a GitHub Actions workflow that:

- Installs Python + dbt dependencies
- Creates a temporary `profiles.yml` using GitHub Secrets (no credentials committed)
- Runs compile/build steps (`dbt debug`, `dbt compile`, `dbt run`, `dbt test`)
- Provides fast feedback on data model failures (SQL errors, schema drift, broken tests)

---

# What Was Implemented

## 8.1 — GitHub Actions workflow

A new workflow file was added at:

- `.github/workflows/dbt-ci.yml`

Pipeline stages executed in CI:

- Checkout repository
- Setup Python
- Install dependencies (from `requirements.txt`)
- Create `profiles.yml` at runtime (from Secrets)
- `dbt deps`
- `dbt debug`
- `dbt compile`
- `dbt run`
- `dbt test`

Screenshot:

![CI run - success](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-8_ci-run-success.jpg)

Figure 1 — GitHub Actions workflow run completed successfully (dbt compile/run/test).

---

## 8.2 — GitHub Secrets for Snowflake connection

CI requires Snowflake credentials, but they must never be stored in the repository.

Required secrets (example names):

- `SNOWFLAKE_ACCOUNT` (e.g., `snowflake-account-number`)
- `SNOWFLAKE_USER` (e.g., `snowflake-user`)
- `SNOWFLAKE_PASSWORD`
- `SNOWFLAKE_ROLE` (e.g., `ACCOUNTADMIN`)
- `SNOWFLAKE_WAREHOUSE` (e.g., `COMPUTE_WH`)
- `SNOWFLAKE_DATABASE` (e.g., `ANALYTICS_DB`)
- `SNOWFLAKE_SCHEMA` (e.g., `ANALYTICS`)

Screenshot:

![GitHub Secrets](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-8_github-secrets.jpg)

Figure 2 — Repository secrets used to build `profiles.yml` dynamically in CI.

---

## 8.3 — Dependency management

A `requirements.txt` file was introduced to pin runtime dependencies used by CI, including:

- `dbt-core`
- `dbt-snowflake`

---

# Validation

To validate the CI end-to-end:

- Commit + push to `main` (or open a PR) and monitor the **Actions** tab.
- Confirm `dbt debug`, `dbt run`, and `dbt test` complete successfully.
- Inspect logs to ensure models and tests executed as expected.

Screenshot:

![Actions logs](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-8_actions-logs.jpg)

Figure 3 — Workflow steps and logs available for troubleshooting and auditability.

---

# Engineering Capabilities Demonstrated

- CI automation for analytics engineering
- Secure secret handling and ephemeral profiles
- Reproducible builds with dependency pinning
- Fast feedback loop on SQL + tests
- Production readiness mindset (quality gates)

---

# Notes

This CI workflow is intentionally minimal and focused on correctness. A next step is to add:

- PR-only execution (or `main` + PR)
- `dbt build` with selectors for impacted models
- artifacts upload (manifest/run_results) for debugging
- environment separation (dev/prod) and controlled deploys
