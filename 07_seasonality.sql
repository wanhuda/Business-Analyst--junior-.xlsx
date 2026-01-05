--6) Check the seller's income by month. Is there seasonality?
 
WITH year19 as (
    SELECT 
        client_id,
        date_of_delivery,
        order_number,
        product_code,
        delivery_amount
    FROM cleaned2019
    WHERE order_number is not null  and date_of_delivery is not null
), year20 as (
    SELECT
        client_id,
        date_of_delivery,
        order_number,
        product_code,
        delivery_amount
    FROM cleaned2020
    WHERE order_number is not null  and date_of_delivery is not null
), monthly_revenue as (
    SELECT
        extract(MONTH FROM date_of_delivery) as months,
        EXTRACT(YEAR FROM date_of_delivery) as years,
        SUM(delivery_amount) as delivery_amount
    FROM 
        (SELECT date_of_delivery, delivery_amount FROM year19
        UNION ALL 
        SELECT date_of_delivery, delivery_amount FROM year20
        )
    GROUP BY months, years
    ORDER BY years, months
)
SELECT
    months,
    AVG(delivery_amount) as avg_monthly
from monthly_revenue
group by months
ORDER BY avg_monthly DESC
 


--SELECT * from cleaned2019