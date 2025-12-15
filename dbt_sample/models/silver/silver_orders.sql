{{ config(materialized='table') }}

select
    order_id,
    customer_id,
    order_date,
    order_amount,
    country, channel,
    ingestion_ts
from {{ ref('bronze_orders') }}
where order_id is not null