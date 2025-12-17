{% macro sum_column(table, column) %}
    sum({{ column }}) as total_{{ column }}
{% endmacro %}