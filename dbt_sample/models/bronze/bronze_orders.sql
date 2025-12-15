{{ config(materialized='table') }}

select
    *,
    current_timestamp() as ingestion_ts
from {{ source('raw', 'orders_raw') }}