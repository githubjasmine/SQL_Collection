-- https://leetcode.com/problems/students-report-by-geography/

-- Solution 1: CTE & ROW_NUMBER() & LEFT JOIN

```
should use ROW_NUMBER() instead of rank()
since there'd be duplicated names in each continent
```
WITH am AS
  (SELECT name America, ROW_NUMBER() OVER(ORDER BY name) rm
  FROM student
  WHERE continent = "America"),
a AS
  (SELECT name Asia, ROW_NUMBER() OVER(ORDER BY name) rm
  FROM student
  WHERE continent = 'Asia'),
e AS
  (SELECT name Europe, ROW_NUMBER() OVER(ORDER BY name) rm
  FROM student
  WHERE continent = 'Europe')

SELECT America, Asia, Europe
FROM am
LEFT JOIN a
ON am.rm = a.rm
LEFT JOIN e
ON am.rm = e.rm

-- can't simply go with a case when: NULL would appear at the top of each column
