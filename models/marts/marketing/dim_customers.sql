with customers as (

     select * from {{ ref('stg_jaffle_shop__customers') }}

),

orders as ( 

    select * from {{ ref('stg_jaffle_shop__orders') }}

),

payments as (

     select * from {{ ref('stg_stripe__payments') }}
    where status = 'success'
),

customer_orders as (

    select
        o.customer_id,

        min(o.order_date) as first_order_date,
        max(o.order_date) as most_recent_order_date,
        count(o.order_id) as number_of_orders
        , sum(coalesce(p.amount,0)) as lifetime_value

    from orders as o 
    left join payments as p using (order_id)

    group by 1

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        customer_orders.lifetime_value,
        coalesce (customer_orders.number_of_orders, 0) 
        as number_of_orders

    from customers

    left join customer_orders using (customer_id)

)

select * from final