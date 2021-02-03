-- https://leetcode.com/problems/hopper-company-queries-ii/


WITH RECURSIVE m AS (SELECT 1 month
                     UNION
                     SELECT month + 1
                     FROM m
                     WHERE month < 12)
SELECT month, IFNULL(ROUND(rct/((SUM(active_drivers)
              OVER(ORDER BY month))+(SELECT COUNT(*) FROM drivers
              WHERE YEAR(join_date) < 2020))*100,2),0) working_percentage
FROM
    (SELECT m.month, IFNULL(ct,0) active_drivers, IFNULL(rct,0) rct
     FROM m
     LEFT JOIN
        (SELECT MONTH(join_date) month, COUNT(*) ct
         FROM drivers
         WHERE YEAR(join_date) = 2020
         GROUP BY 1) a
     ON m.month = a.month
     LEFT JOIN
        (SELECT month, COUNT(distinct driver_id) rct
         FROM
            (SELECT MONTH(requested_at) month, driver_id
             FROM rides r
             JOIN acceptedrides a
             ON r.ride_id = a.ride_id
             WHERE YEAR(requested_at)=2020) a
         GROUP BY 1) c
     ON m.month = c.month
    ) b
