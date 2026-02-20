-- [DBT-S6-010]
{{ config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = 'invoice_line_sk',
    on_schema_change = 'sync_all_columns'
) }}

with src as (
    select *
    from {{ ref('stg_online_retail') }}
),

numbered as (
    select
        *,
        row_number() over (
          partition by
            invoice_no, stock_code, invoice_date, quantity, unit_price, customer_id, country
          order by invoice_no
        ) as line_dup_n
    from src
),

base as (
    select
        md5(
          concat_ws('|',
            coalesce(invoice_no, ''),
            coalesce(stock_code, ''),
            coalesce(to_varchar(invoice_date), ''),
            coalesce(to_varchar(quantity), ''),
            coalesce(to_varchar(unit_price), ''),
            coalesce(to_varchar(customer_id), ''),
            coalesce(country, ''),
            coalesce(to_varchar(line_dup_n), '')
          )
        ) as invoice_line_sk,

        invoice_no,
        invoice_date,
        customer_id,
        stock_code,
        country,
        quantity,
        unit_price,
        line_amount,
        is_sale,
        is_return,
        is_adjustment,
        case when is_sale = 1 and is_adjustment = 0 then line_amount else 0 end as sale_value,
        case when is_return = 1 and is_adjustment = 0 then abs(line_amount) else 0 end as return_value,
        case when is_adjustment = 1 then line_amount else 0 end as adjustment_value

    from numbered
)

select *
from base

{% if is_incremental() %}
where invoice_line_sk not in (select invoice_line_sk from {{ this }})
{% endif %}