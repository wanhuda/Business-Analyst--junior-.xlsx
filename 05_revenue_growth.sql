--4) Analyze customer revenue growth in 2020.

WITH year19 as (
    SELECT 
        client_id,
        SUM(delivery_amount) as total_amount
    FROM cleaned2019
    WHERE order_number is not null
    GROUP BY client_id
), year20 as (
    SELECT
        client_id,
        SUM(delivery_amount) as total_amount
    FROM cleaned2020
    WHERE order_number is not null
    GROUP BY client_id
)
SELECT
    COALESCE(a.client_id, b.client_id) AS client_id,
    COALESCE(b.total_amount, 0) - COALESCE(a.total_amount, 0) AS revenue_growth
FROM year19 a
FULL OUTER JOIN year20 b
    ON a.client_id = b.client_id
ORDER BY revenue_growth DESC
