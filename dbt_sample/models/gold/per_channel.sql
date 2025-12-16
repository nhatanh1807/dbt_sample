{{ config(materialized='view') }}

-- đảm bảo dim_channel được build trước
-- depends_on: {{ ref('dim_channel') }}

{% if execute %}
    {% set query %}
        select channel
        from {{ ref('dim_channel') }}
        order by channel
    {% endset %}

    {% set results = run_query(query) %}
    {% set channels = results.columns[0].values() %}
{% else %}
    {% set channels = [] %}
{% endif %}

select
    {% for c in channels %}
        round(
            sum(
                case
                    when o.channel = '{{ c }}'
                    then o.order_amount
                    else 0
                end
            ),
            2
        ) as {{ c | lower | replace(' ', '_') }}_amount
        {% if not loop.last %},{% endif %}
    {% endfor %}
from {{ ref('silver_orders') }} o