select
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