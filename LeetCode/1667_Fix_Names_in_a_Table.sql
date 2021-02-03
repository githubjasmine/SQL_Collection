-- https://leetcode.com/problems/fix-names-in-a-table/

SELECT user_id,  CONCAT(UPPER(LEFT(name,1)),
                        LOWER(SUBSTR(name,2,LENGTH(name)))) name
FROM users
ORDER BY 1

-- CONCAT("A","B") = "AB"
-- in SUBSTR(), if you want to sub till the end of the str,
-- there's no need to specify the end point
