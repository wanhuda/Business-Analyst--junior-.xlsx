# Introduction
This project was conducted to analyse the business trend of a store throughout two years of its operation (2019-2020). This project contains two dataset of each respective year.

# Executive Summary
This report address business trend of a store 

# Objectives

1. To investigate the client purchasing power/pattern
2. To see top selling product to improve marketing for those product
3. To see growth of seller's revenue after the addition  of product  to the store
4. To see customer retention value to the store

# Data Overview

- **Data source** : [Kaggle](https://www.kaggle.com/datasets/sticktogethertm/business-analysis-junior)
- **Data size** : This dataset contains of two tables for each the year 0f 2019 and 2020 respectively. For each table, it collects the Order Number, Client ID, Product Code, Date of Delivery and Delivery Amount
- **Limitations and challenge** : Data collected for only two years, thus make it not enough to study the trend throughout the years of store operation. A huge part of data were missing from the columns, making it possibly bias (?)

# Data Cleaning
For this dataset, there were several cleaning steps that was done.

- **Missing data** : Since for the most part of missing data, only one column data is available, all rows with missing data were deleted.
- **Redundancies** : All redundant data were eliminated
- **Datatype** : Upon checking the data, datatype conversion were done for further analysis and calculation

# Analysis
## Total Earning in 2020 in Comparison with 2019
To identify the total earning in 2020, I create a table that shows earning for each product for both year. Then, I sum the total earning.

```sql
WITH year19 as (
    SELECT 
        product_code,
        SUM(delivery_amount) as total_amount
    FROM cleaned2019
    WHERE order_number is not null
    GROUP BY product_code
), year20 as (
    SELECT
        product_code,
        SUM(delivery_amount) as total_amount
    FROM cleaned2020
    WHERE order_number is not null
    GROUP BY product_code
)
SELECT
    b.product_code,
    b.total_amount as earning_2020,
    a.total_amount as earning_2019,
    ABS(b.total_amount - a.total_amount) as difference,
    sum(ABS(b.total_amount - a.total_amount)) over()
FROM year20 b 
LEFT JOIN year19 a
    on a.product_code = b.product_code
WHERE a.product_code is not NULL
```


