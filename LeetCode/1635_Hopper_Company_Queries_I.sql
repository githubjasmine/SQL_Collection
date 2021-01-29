-- https://leetcode.com/problems/hopper-company-queries-i/

-- faster then 90%

WITH RECURSIVE m AS (SELECT 1 month
                     UNION
                     SELECT month+1
                     FROM m
                     WHERE month <= 11)

SELECT month, (SUM(new) OVER(ORDER BY month))
              +(SELECT COUNT(*) FROM drivers
                WHERE YEAR(join_date)<2020) active_drivers, accepted_rides
FROM
    (SELECT m.month, IFNULL(new,0) new, IFNULL(accepted_rides,0) accepted_rides
     FROM m
     LEFT JOIN
        (SELECT MONTH(join_date) month, COUNT(*) new
         FROM drivers
         WHERE YEAR(join_date)=2020
         GROUP BY 1) a
     ON m.month = a.month
     LEFT JOIN
        (SELECT MONTH(requested_at) month, COUNT(*) accepted_rides
         FROM rides
         WHERE ride_id IN (SELECT ride_id FROM acceptedrides)
         AND YEAR(requested_at)=2020
         GROUP BY 1) b
     ON m.month = b.month) b
