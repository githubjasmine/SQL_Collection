-- https://leetcode.com/problems/total-sales-amount-by-year/

-- Table: Product
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | product_name  | varchar |
-- +---------------+---------+
-- product_id is the primary key for this table.
-- product_name is the name of the product.

-- Table: Sales
-- +---------------------+---------+
-- | Column Name         | Type    |
-- +---------------------+---------+
-- | product_id          | int     |
-- | period_start        | date    |
-- | period_end          | date    |
-- | average_daily_sales | int     |
-- +---------------------+---------+
-- product_id is the primary key for this table.
-- period_start and period_end indicates the start and end date for sales period, both dates are inclusive.
-- The average_daily_sales column holds the average daily sales amount of the items for the period.

-- Write an SQL query to report the Total sales amount of each item for each year, with corresponding product name, product_id, product_name and report_year.
-- Dates of the sales years are between 2018 to 2020. Return the result table ordered by product_id and report_year.

-- Solution:
SELECT a.product_id, product_name, report_year, days*average_daily_sales total_amount
FROM
    (SELECT product_id, '2018' report_year,
     DATEDIFF(LEAST(period_end, '2018-12-31'), period_start)+1 days,
     average_daily_sales
     FROM sales
     WHERE year(period_start) = 2018
     -- Use LEAST() function to compare the end_date
     -- +1 in calculating days
    UNION ALL

    SELECT product_id, '2020' report_year,
     DATEDIFF(period_end, GREATEST(period_start, '2020-01-01'))+1 days,
     average_daily_sales
     FROM sales
     WHERE year(period_end) = 2020
     -- GREATEST()
    UNION ALL

    SELECT product_id, '2019' report_year,
     DATEDIFF(LEAST(period_end, '2019-12-31'),
              GREATEST(period_start, '2019-01-01'))+1 days,
     average_daily_sales
     FROM sales
     WHERE year(period_start) >= 2018 OR year(period_end) <= 2020) a
     -- >= & <= to include the period that goes directly from 2018 to 2020
JOIN product p
ON a.product_id = p.product_id
WHERE days > 0
-- if starts in 2020 or ends in 2018, the datediff would be negative
-- thus need to set restriction of days>0 in the outer layer
ORDER BY 1, 3
