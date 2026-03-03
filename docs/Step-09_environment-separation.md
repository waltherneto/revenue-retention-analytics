# Step 9 — Environment Separation (DEV / PROD)

Snowflake · dbt · GitHub Actions · Deployment Awareness

---

## 🎯 Objective

Introduce production-style **environment separation** to reduce deployment risk and simulate real-world workflows.

This step implements:

- Separate Snowflake databases for DEV and PROD
- dbt targets for each environment
- CI-aware target selection (PR → DEV, main → PROD)
- Environment-specific secrets (no credentials committed)

---

# 9.A — Snowflake Databases (DEV / PROD)

Two databases were created to isolate environments:

- `ANALYTICS_DEV`
- `ANALYTICS_PROD`

Both can share the same warehouse (`COMPUTE_WH`) while keeping datasets isolated at the database level.

Screenshot:

![Snowflake databases DEV/PROD](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-09_snowflake-databases.jpg)

Figure 1 — Snowflake showing separate DEV and PROD databases (`ANALYTICS_DEV` and `ANALYTICS_PROD`).

---

# 9.B — Local dbt Targets (profiles.yml)

Local dbt configuration was updated to include multiple targets:

- `dev` → `ANALYTICS_DEV`
- `prod` → `ANALYTICS_PROD`

Validation commands:

- `dbt run --target dev`
- `dbt test --target dev`
- `dbt run --target prod`
- `dbt test --target prod`

Screenshot:

![dbt debug profiles dir](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-09_dbt-debug-profiles.jpg)

Figure 2 — dbt debug confirming the local profiles directory and valid configuration.

Screenshot:

![dbt run dev](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-09_dbt-run-dev.jpg)
![dbt run prod](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-09_dbt-run-prod.jpg)

Figures 3 and 4 — Successful dbt runs in both environments (`--target dev` and `--target prod`).

---

# 9.C — CI-Aware Deployment Strategy (PR → DEV, main → PROD)

The GitHub Actions workflow was upgraded to support environment separation.

Key changes:

- Generate a temporary `profiles.yml` during CI execution
- Select `DBT_TARGET` dynamically:
  - Pull Request → `dev`
  - Push to `main` → `prod`
- Execute `dbt debug`, `dbt compile`, `dbt run`, and `dbt test` using the chosen target

Screenshot:

![GitHub Actions run - success](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-09_actions-run-success.jpg)

Figure 5 — GitHub Actions run completed successfully with environment-aware target execution.

---

# 9.D — Environment-Specific Secrets

To keep environments isolated in CI, two additional GitHub Secrets were introduced:

- `SNOWFLAKE_DATABASE_DEV` = `ANALYTICS_DEV`
- `SNOWFLAKE_DATABASE_PROD` = `ANALYTICS_PROD`

Screenshot:

![GitHub secrets for DEV/PROD](https://raw.githubusercontent.com/waltherneto/revenue-retention-analytics/main/docs/screenshots/step-09_github-secrets-dev-prod.jpg)

Figure 6 — Environment-specific secrets enabling CI builds against DEV and PROD safely.

---

# 🧠 Engineering Capabilities Demonstrated

- Production-grade environment isolation
- Deployment-aware dbt configuration
- CI-driven promotion workflow (PR validation vs production runs)
- Secure secret management (no credentials committed)
- Reduced risk and improved reproducibility

---

# 📌 Positioning

Environment separation is a core expectation for entry-to-mid Data Engineers because it demonstrates:

- operational maturity
- disciplined deployment practices
- awareness of production data safety

With Step 9, the project moves from “single-environment analytics engineering” to a **deployment-aware data warehouse workflow**.
