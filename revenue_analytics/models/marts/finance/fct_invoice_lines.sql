{{ config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = 'invoice_line_sk',
    on_schema_change = 'sync_all_columns'
) }}

with base as (

    select
        -- Surrogate key (deterministic)
        md5(
          concat_ws('|',
            coalesce(invoice_no, ''),
            coalesce(stock_code, ''),
            coalesce(to_varchar(invoice_date), ''),
            coalesce(to_varchar(quantity), ''),
            coalesce(to_varchar(unit_price), ''),
            coalesce(to_varchar(customer_id), ''),
            coalesce(country, '')
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

    from {{ ref('stg_online_retail') }}

)

select *
from base

{% if is_incremental() %}

-- Only process records that are new or changed compared to what's already in the target table.
where invoice_line_sk not in (select invoice_line_sk from {{ this }})

{% endif %}