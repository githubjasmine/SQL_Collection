-- https://leetcode.com/problems/find-median-given-frequency-of-numbers/

-- credit to: https://leetcode.com/problems/find-median-given-frequency-of-numbers/discuss/102710/Easy-peasy

-- the thinking process is kinda tricky

SELECT AVG(n1.number) median
FROM numbers n1
WHERE ABS((SELECT SUM(frequency) FROM numbers n WHERE n.number >= n1.number)
          - (SELECT SUM(frequency) FROM numbers n WHERE n.number <= n1.number))
          <= frequency

-- explanation:
-- Let's take all numbers from left including current number and then do same for right.
-- (select sum(Frequency) from Numbers where Number<=n.Number) as left
-- (select sum(Frequency) from Numbers where Number<=n.Number) as right
-- Now if difference between Left and Right less or equal to Frequency of the current number that means this number is median.
-- Ok, what if we get two numbers satisfied this condition? Easy peasy - take AVG(). Ta-da!
--
-- suppose number x has frequency of n, and total frequency of other numbers that are on its left is l, on its right is r.
--
-- the equation above is (n+l) - (n+r) = l - r, x is median if l==r, of course.
--
-- When l != r, as long as n can cover the difference, x is the median.

-- similar question:
-- https://leetcode.com/problems/median-employee-salary/
