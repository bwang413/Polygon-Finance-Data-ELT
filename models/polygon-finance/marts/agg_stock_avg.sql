{{ config(
    materialized='incremental',
    unique_key='symbol'
) }}
SELECT
    ss.symbol,
    dsd.date,
    AVG(dsp.open_price) AS avg_open_price,
    AVG(dsp.close_price) AS avg_close_price,
    AVG(dsp.lowest_price) AS avg_lowest_price,
    AVG(dsp.highest_price) AS avg_highest_price,
    AVG(CAST(ss.number_of_transaction AS INTEGER)) AS avg_number_of_transaction
FROM {{ ref('stg_stock') }} ss
LEFT JOIN {{ ref('dim_stock_dates') }} dsd
ON ss.request_id = dsd.request_id
LEFT JOIN {{ ref("dim_stock_prices") }} dsp
ON ss.stock_id = dsp.stock_id
GROUP BY ss.symbol, dsd.date