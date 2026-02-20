# Step 1 — Ingestion Notes

## Problem
CSV ingestion showed limited actionable error feedback and inconsistent parsing.

## Approach
- Step back and rebuild Snowflake base objects (DB + schemas).
- Use Python to normalize:
  - encoding to UTF-8
  - datetime parsing for InvoiceDate
  - remove full-row duplicates
  - preserve returns (Quantity < 0) via flags

## Result
Loaded 534,129 rows into ANALYTICS_DB.RAW.ONLINE_RETAIL with validated date range and sales/returns breakdown.
