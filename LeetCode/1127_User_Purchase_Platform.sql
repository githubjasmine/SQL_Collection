-- https://leetcode.com/problems/user-purchase-platform/

-- This solution is faster then 98% of the other submissions:


SELECT r.spend_date, r.platform, IFNULL(total_amount,0) total_amount, IFNULL(total_users,0) total_users
FROM
    (SELECT spend_date, platform, rk
    FROM (SELECT DISTINCT spend_date FROM spending) d,
        (SELECT 'desktop' platform, 1 rk
        UNION
        SELECT 'mobile', 2
        UNION
        SELECT 'both', 3) p) r
LEFT JOIN
    (SELECT spend_date, platform, SUM(amount) total_amount, COUNT(distinct user_id) total_users
    FROM
        (SELECT user_id, spend_date,
        CASE WHEN ct=2 THEN 'both' ELSE platform END AS platform,
        amount
        FROM
            (SELECT *, COUNT(*) OVER(PARTITION BY user_id, spend_date) ct
            FROM spending) a) b
    GROUP BY 1,2) c
ON r.spend_date = c.spend_date AND r.platform = c.platform
ORDER BY r.spend_date, rk
