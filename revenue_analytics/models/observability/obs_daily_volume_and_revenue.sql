{{ config(materialized='table') }}

with daily as (
    select
        to_date(invoice_date) as d,
        count(*) as row_count,
        sum(sale_value) as gross_revenue,
        sum(return_value) as returns_value,
        sum(sale_value) - sum(return_value) as net_revenue
    from {{ ref('fct_invoice_lines') }}
    group by 1
),
with_lag as (
    select
        *,
        lag(row_count) over (order by d) as prev_row_count,
        lag(net_revenue) over (order by d) as prev_net_revenue
    from daily
)
select
    d,
    row_count,
    prev_row_count,
    case
      when prev_row_count is null or prev_row_count = 0 then null
      else (row_count - prev_row_count) / prev_row_count::float
    end as row_count_pct_change,
    net_revenue,
    prev_net_revenue,
    case
      when prev_net_revenue is null or prev_net_revenue = 0 then null
      else (net_revenue - prev_net_revenue) / prev_net_revenue::float
    end as net_revenue_pct_change
from with_lag
order by d