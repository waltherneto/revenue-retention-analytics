# [PY-ONLINE-RETAIL-CLEAN-002]
import json
import pandas as pd
from pathlib import Path

INPUT = Path("online_retail.csv")
OUT_CSV = Path("online_retail_v5.csv")
OUT_JSONL = Path("online_retail_v5.jsonl")

# 1) Ler o CSV com encoding tolerante
df = pd.read_csv(INPUT, encoding="latin1")

# 2) Converter InvoiceDate (seu ponto crítico)
df["InvoiceDate"] = pd.to_datetime(
    df["InvoiceDate"],
    format="%m/%d/%y %H:%M",  # exemplo: 12/1/10 8:26
    errors="coerce"
)

invalid_dates = int(df["InvoiceDate"].isna().sum())

# Remove linhas com data inválida (sem isso, vira ruído no warehouse)
df = df.dropna(subset=["InvoiceDate"]).copy()

# 3) Padronizar data em string ISO (Snowflake lê fácil)
df["InvoiceDate"] = df["InvoiceDate"].dt.strftime("%Y-%m-%d %H:%M:%S")

# 4) Selecionar colunas oficiais do projeto
cols = [
    "InvoiceNo",
    "StockCode",
    "Description",
    "Quantity",
    "InvoiceDate",
    "UnitPrice",
    "CustomerID",
    "Country",
]
df = df[cols].copy()

# 5) Tipos numéricos seguros
df["Quantity"] = pd.to_numeric(df["Quantity"], errors="coerce")
df["UnitPrice"] = pd.to_numeric(df["UnitPrice"], errors="coerce")

# Remove linhas sem Quantity/UnitPrice, e regras mínimas
df = df.dropna(subset=["Quantity", "UnitPrice"]).copy()
df = df[(df["Quantity"] != 0) & (df["UnitPrice"] > 0)].copy()

# 6) Normalização de strings (evita problemas de aspas/espacos)
df["InvoiceNo"] = df["InvoiceNo"].astype(str).str.strip()
df["StockCode"] = df["StockCode"].astype(str).str.strip()
df["Description"] = df["Description"].astype(str).str.replace(r"\s+", " ", regex=True).str.strip()
df["Country"] = df["Country"].astype(str).str.strip()

# 7) Flags úteis (mantém devoluções)
df["IS_RETURN"] = (df["Quantity"] < 0).astype(int)
df["IS_SALE"] = (df["Quantity"] > 0).astype(int)

# 8) CustomerID: não dropa geral (deixa para camada analítica),
# mas tenta normalizar quando possível.
# (CustomerID pode vir como float por causa de NaN)
df["CustomerID"] = df["CustomerID"].astype("string").str.strip()
df.loc[df["CustomerID"].isin(["<NA>", "nan", "None", ""]), "CustomerID"] = pd.NA

# cria CUSTOMERID_INT opcional para facilitar joins (sem matar linhas)
df["CUSTOMERID_INT"] = pd.to_numeric(df["CustomerID"], errors="coerce").astype("Int64")

# 9) Deduplicação
before_dedup = len(df)
df = df.drop_duplicates()
dedup_removed = before_dedup - len(df)

# 10) Renomear colunas alinhadas com Snowflake (mantendo suas convenções)
df = df.rename(columns={
    "InvoiceNo": "INVOICE_NO",
    "StockCode": "STOCK_CODE",
    "Description": "DESCRIPTION",
    "Quantity": "QUANTITY",
    "InvoiceDate": "INVOICE_DATE",
    "UnitPrice": "UNIT_PRICE",
    "CustomerID": "CUSTOMERID",        # string
    "Country": "COUNTRY",
})

# Reordenar (inclui flags e customerid_int)
ordered_cols = [
    "INVOICE_NO", "STOCK_CODE", "DESCRIPTION",
    "QUANTITY", "INVOICE_DATE", "UNIT_PRICE",
    "CUSTOMERID", "CUSTOMERID_INT",
    "COUNTRY", "IS_SALE", "IS_RETURN"
]
df = df[ordered_cols]

# 11) Exportar CSV limpo (padrão para carga)
df.to_csv(
    OUT_CSV,
    index=False,
    encoding="utf-8",
    sep=",",
    quotechar='"'
)

# 12) Exportar JSONL (um JSON por linha), plano B confiável
with open(OUT_JSONL, "w", encoding="utf-8") as f_out:
    for record in df.to_dict(orient="records"):
        json.dump(record, f_out, ensure_ascii=False)
        f_out.write("\n")

print("OK")
print("Invalid InvoiceDate rows dropped:", invalid_dates)
print("Duplicates removed:", dedup_removed)
print("Rows exported:", len(df))
print("Saved CSV:", OUT_CSV.resolve())
print("Saved JSONL:", OUT_JSONL.resolve())
