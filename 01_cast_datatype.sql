--1. change datatype and create new table

CREATE TABLE cleaned2019 as
SELECT
    order_number :: INT,
    client_id :: INT,
    product_code :: INT,
    date_of_delivery :: DATE,
    CAST(REPLACE(delivery_amount, ',', '') AS FLOAT) as delivery_amount
FROM business2019;

CREATE TABLE cleaned2020 as 
SELECT
    order_number :: INT,
    client_id :: INT,
    product_code :: INT,
    date_of_delivery :: DATE,
    CAST(REPLACE(delivery_amount, ',', '') AS FLOAT) as delivery_amount
FROM business2020;
