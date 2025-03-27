with

source as (

    select * from {{ source('jaffle_shop', 'orders') }}

),

renamed as (

    select

        ----------  ids
        id as order_id,
        '7f790ed7-0fc4-4de2-a1b0-cce72e657fc4' as location_id,
        user_id as customer_id,

        ---------- numerics
        -- (order_total / 100.0) as order_total,
        -- (tax_paid / 100.0) as tax_paid,
        100.0 as order_total,
        18.0 as tax_paid,

        ---------- timestamps
        -- {{ dbt.date_trunc('day','ordered_at') }} as ordered_at
        {{ dbt.date_trunc('day','order_date') }} as ordered_at

    from source

)

select * from renamed