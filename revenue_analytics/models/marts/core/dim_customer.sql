select
  customer_id,
  max(country) as country
from {{ ref('stg_online_retail') }}
where customer_id is not null
group by 1