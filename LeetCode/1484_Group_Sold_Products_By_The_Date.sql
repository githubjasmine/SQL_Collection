-- https://leetcode.com/problems/group-sold-products-by-the-date/

-- the key is to combining multiple rows into a comma deliminated cell
-- reference: https://www.tutorialspoint.com/combining-multiple-rows-into-a-comma-delimited-list-in-mysql

-- GROUP_CONCAT(cal ORDER BY col)

SELECT sell_date, COUNT(*) num_sold,
  GROUP_CONCAT(product ORDER BY product) products
FROM (SELECT DISTINCT * FROM activities) a
GROUP BY 1
