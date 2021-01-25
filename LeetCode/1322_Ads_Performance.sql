-- https://leetcode.com/problems/ads-performance/

SELECT ad_id,
  IFNULL(ROUND(COUNT(IF(action='clicked',1,NULL))
  /COUNT(IF(action <> 'ignored',1,NULL))*100,2),0) ctr
FROM ads
GROUP BY 1
ORDER BY 2 DESC, 1

-- for queries with devides, always consider the null values from a 0 devider
