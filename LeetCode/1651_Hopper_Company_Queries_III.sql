-- https://leetcode.com/problems/hopper-company-queries-iii/

-- tricks:
-- 1. not every month has requests
-- 2. not every request would be accepted
-- 3. result table starts with Jan and end with Oct: window with following but not preceding

-- Solution:
WITH recursive m AS (SELECT 1 month
                     UNION
                     SELECT month+1
                     FROM m
                     WHERE month < 12)
SELECT *
FROM
    (SELECT month,
     ROUND(SUM(dis) OVER(ORDER BY month ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)/3, 2) average_ride_distance,
     ROUND(SUM(dur) OVER(ORDER BY month ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)/3, 2) average_ride_duration
     FROM
        (SELECT m.month, IFNULL(dis,0) dis, IFNULL(dur,0) dur
         FROM m
         LEFT JOIN
            (SELECT MONTH(requested_at) month,
             SUM(ride_distance) dis,
             SUM(ride_duration) dur
             FROM rides r
             JOIN acceptedrides a
             ON r.ride_id = a.ride_id
             WHERE YEAR(requested_at) = 2020
             GROUP BY 1) a
         ON m.month = a.month) b) c
WHERE month <= 10
