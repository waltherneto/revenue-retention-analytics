with by_month_from_lines as (
    select
        date_trunc('month', invoice_date) as invoice_month,
        sum(sale_value) as gross_revenue,
        sum(return_value) as returns_value,
        sum(sale_value) - sum(return_value) as net_revenue,
        sum(sale_value) - sum(return_value) + sum(adjustment_value) as operational_net_revenue
    from {{ ref('fct_invoice_lines') }}
    group by 1
),
by_month_mart as (
    select
        invoice_month,
        gross_revenue,
        returns_value,
        net_revenue,
        operational_net_revenue
    from {{ ref('fct_revenue_monthly') }}
)
select
    l.invoice_month,
    l.net_revenue as net_from_lines,
    m.net_revenue as net_from_mart,
    (l.net_revenue - m.net_revenue) as diff_net_revenue
from by_month_from_lines l
join by_month_mart m using (invoice_month)
order by 1