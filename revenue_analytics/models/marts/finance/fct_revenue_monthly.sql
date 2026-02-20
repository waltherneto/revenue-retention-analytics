with base as (
  select
    date_trunc('month', invoice_date) as invoice_month,
    sale_value,
    return_value,
    adjustment_value
  from {{ ref('fct_invoice_lines') }}
)
select
  invoice_month,
  sum(sale_value) as gross_revenue,
  sum(return_value) as returns_value,
  sum(sale_value) - sum(return_value) as net_revenue,
  sum(sale_value) - sum(return_value) + sum(adjustment_value) as operational_net_revenue
from base
group by 1
order by 1