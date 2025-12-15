{{ config(materialized='table') }}

select 
    order_date, 
    country, channel,
    count(*) as orders, 
    round(sum(order_amount), 2) as total_revenue
from {{ ref('silver_orders') }}
group by order_date, country, channel