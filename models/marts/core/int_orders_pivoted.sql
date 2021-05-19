        {%- set PAYMENT_METHODS = ['bank_transfer','coupon','credit_card','gift_card'] -%}
WITH PAYMENTS as (
        SELECT * FROM {{ ref('stg_payments') }} 
),
PIVOTED as (

    SELECT 
        ORDER_ID,
        {%- for PAYMENT_METHOD in PAYMENT_METHODS -%}
        sum(CASE WHEN PAYMENT_METHOD = '{{ PAYMENT_METHOD }}' THEN AMOUNT ELSE 0 END) as {{ PAYMENT_METHOD }}_amount
        {%- if not loop.last -%},{%-endif%}
        {% endfor %}
    FROM
        PAYMENTS 
    WHERE 
        STATUS = 'success' 
    GROUP BY 1

)
SELECT * FROM PIVOTED