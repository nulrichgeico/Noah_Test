{% macro limit_data_in_dev(COLUMN_NAME) %}
{% if target.name == 'dev' %}
WHERE {{COLUMN_NAME}} >= dateadd('day', -3, current_timestamp)
{% endif %}
{% endmacro %}