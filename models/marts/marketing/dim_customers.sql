
-- with customers as (

--     select * 
--     from {{ ref('stg_jaffle_shop__customers') }} 

-- ),

-- orders as (

    select * 
    from {{ ref('stg_jaffle_shop__orders') }}

-- )

-- customer_orders as (
--     select 

-- )