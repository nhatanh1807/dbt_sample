{{ config(
    materialized='table'
) }}

select distinct channel
from {{ ref('silver_orders') }}
where channel is not null