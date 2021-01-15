-- https://leetcode.com/problems/active-users/

SELECT DISTINCT b.id, name
FROM
    (SELECT id, login_date,
      RANK() OVER(PARTITION BY id ORDER BY login_date) rk
      FROM (SELECT DISTINCT * FROM logins) a) b
JOIN accounts ac
ON b.id = ac.id
GROUP BY id, DATE_ADD(login_date, INTERVAL -rk day)
HAVING COUNT(*) >= 5
ORDER BY 1

-- remember to consider:
-- 1. distinct id & login_date: there'd be duplicated entries in the logins tb
-- 2. distinct id in the outlayer: same id might have several consecutive days of logins
-- 3. order by id in the final output
