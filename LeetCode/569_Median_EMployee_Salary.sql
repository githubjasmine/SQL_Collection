-- https://leetcode.com/problems/median-employee-salary/

-- The Employee table holds all employees.

+-----+------------+--------+
|Id   | Company    | Salary |
+-----+------------+--------+
|1    | A          | 2341   |
|2    | A          | 341    |
|3    | A          | 15     |
|4    | A          | 15314  |
|5    | A          | 451    |
|6    | A          | 513    |
|7    | B          | 15     |
|8    | B          | 13     |
|9    | B          | 1154   |
|10   | B          | 1345   |
|11   | B          | 1221   |
|12   | B          | 234    |
|13   | C          | 2345   |
|14   | C          | 2645   |
|15   | C          | 2645   |
|16   | C          | 2652   |
|17   | C          | 65     |
+-----+------------+--------+
-- Write a SQL query to find the median salary of each company.
-- Bonus points if you can solve it without using any built-in SQL functions.

-- Solution 1: intuitive
SELECT id, company, salary
FROM
(SELECT id, company, salary,
  CASE WHEN (ct%2=1 AND rn = (ct+1)/2)
  OR (ct%2=0 AND (rn = ct/2 OR rn = ct/2 + 1))
  THEN 'mid' ELSE NULL END median
FROM
(SELECT *,
  ROW_NUMBER() OVER(PARTITION BY company ORDER BY salary) rn,
  COUNT(*) OVER(PARTITION BY company) ct
  FROM employee) a) b
WHERE median IS NOT NULL
ORDER BY 2, 3

-- Solution 2: faster
SELECT T1.Id, T1.Company, T1.Salary
FROM (SELECT Id, Company, Salary,
  DENSE_RANK() OVER (PARTITION BY Company ORDER BY Salary, Id) AS Sort,
  COUNT(*) OVER (PARTITION BY Company) / 2.0 AS Counts
  FROM Employee ) T1
WHERE Sort BETWEEN Counts AND Counts + 1
  -- the way of finding median sort is really interesting
  
