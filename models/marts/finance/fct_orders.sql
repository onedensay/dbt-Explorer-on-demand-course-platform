with payments as (

     select * from {{ ref('stg_stripe__payments') }}
    where status = 'success'
),
orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }}

),
final as (

select 
      o.order_id
    , o.customer_id
    , o.order_date
    , sum(coalesce(p.amount,0)) as amount
from orders as o 
left join payments as p using (order_id)

group by 1,2,3
)

select * from final