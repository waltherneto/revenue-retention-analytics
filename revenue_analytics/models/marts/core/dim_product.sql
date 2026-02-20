select
  stock_code,
  max(description) as product_description
from {{ ref('stg_online_retail') }}
where stock_code is not null
group by 1