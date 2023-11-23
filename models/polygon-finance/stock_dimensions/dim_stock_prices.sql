SELECT
    GENERATE_UUID() AS price_key,
    stock_key,
    open_price,
    close_price,
    lowest_price,
    highest_price,
    adjusted
FROM {{ ref("stg_stock") }}
