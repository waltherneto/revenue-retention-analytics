with source as (
    select * 
    from {{ source('raw', 'ONLINE_RETAIL') }}
),

renamed as (
    select
        INVOICE_NO::varchar           as invoice_no,
        STOCK_CODE::varchar           as stock_code,
        DESCRIPTION::varchar          as description,
        QUANTITY::number(38,0)        as quantity,
        INVOICE_DATE::timestamp_ntz   as invoice_date,
        UNIT_PRICE::number(38,2)      as unit_price,
        CUSTOMERID_INT::number(38,0)  as customer_id,
        COUNTRY::varchar              as country,

        /* derived fields */
        (quantity * unit_price)::number(38,2) as line_amount,

        /* operational classification */
        iff(quantity < 0, 1, 0) as is_return,
        iff(quantity > 0, 1, 0) as is_sale,

        /* accounting/system adjustments */
        iff(upper(stock_code) in ('AMAZONFEE', 'M') or upper(description) like '%ADJUST%', 1, 0) as is_adjustment

    from source
)

select *
from renamed