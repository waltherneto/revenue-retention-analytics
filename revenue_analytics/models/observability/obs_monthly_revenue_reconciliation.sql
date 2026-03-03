{{ config(materialized='table') }}

with lines as (
    select
        date_trunc('month', invoice_date) as invoice_month,
        sum(sale_value) as gross_revenue_lines,
        sum(return_value) as returns_value_lines,
        sum(sale_value) - sum(return_value) as net_revenue_lines,
        sum(sale_value) - sum(return_value) + sum(adjustment_value) as operational_net_revenue_lines
    from {{ ref('fct_invoice_lines') }}
    group by 1
),
mart as (
    select
        invoice_month,
        gross_revenue as gross_revenue_mart,
        returns_value as returns_value_mart,
        net_revenue as net_revenue_mart,
        operational_net_revenue as operational_net_revenue_mart
    from {{ ref('fct_revenue_monthly') }}
)
select
    l.invoice_month,

    l.net_revenue_lines,
    m.net_revenue_mart,
    (l.net_revenue_lines - m.net_revenue_mart) as diff_net_revenue,

    l.operational_net_revenue_lines,
    m.operational_net_revenue_mart,
    (l.operational_net_revenue_lines - m.operational_net_revenue_mart) as diff_operational_net_revenue
from lines l
join mart m using (invoice_month)
order by 1