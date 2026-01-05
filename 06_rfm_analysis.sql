WITH year19 as (
    SELECT 
        client_id,
        date_of_delivery,
        order_number,
        product_code,
        delivery_amount
    FROM cleaned2019
    WHERE order_number is not null
), year20 as (
    SELECT
        client_id,
        date_of_delivery,
        order_number,
        product_code,
        delivery_amount
    FROM cleaned2020
    WHERE order_number is not null
), recency AS (
    SELECT
        client_id,
        MAX(date_of_delivery) AS latest_delivery
    FROM (
        SELECT client_id, date_of_delivery FROM year19
        UNION ALL
        SELECT client_id, date_of_delivery FROM year20
    ) t
    GROUP BY client_id
), frequency AS (
    SELECT
        client_id,
        COUNT(DISTINCT order_number) AS total_orders
    FROM (
        SELECT client_id, order_number FROM year19
        UNION ALL
        SELECT client_id, order_number FROM year20
    ) t
    GROUP BY client_id
), monetary AS (
    SELECT
        client_id,
        SUM(delivery_amount) AS total_revenue
    FROM (
        SELECT client_id, delivery_amount FROM year19
        UNION ALL
        SELECT client_id, delivery_amount FROM year20
    ) t
    GROUP BY client_id
)
SELECT
    r.client_id,
    r.latest_delivery,        -- Recency
    f.total_orders,           -- Frequency
    m.total_revenue           -- Monetary
FROM recency r
LEFT JOIN frequency f
    ON r.client_id = f.client_id
LEFT JOIN monetary m
    ON r.client_id = m.client_id
ORDER BY r.latest_delivery DESC;
