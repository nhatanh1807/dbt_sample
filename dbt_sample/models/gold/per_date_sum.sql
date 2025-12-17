{{ config(materialized='table') }}

select 
    order_date, 
    {{ sum_column('order_amount') }}
from {{ ref('silver_orders') }}
group by order_date