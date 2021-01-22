-- https://leetcode.com/problems/find-customer-referee/

-- be careful about the nulls

Given a table customer holding customers information and the referee.

+------+------+-----------+
| id   | name | referee_id|
+------+------+-----------+
|    1 | Will |      NULL |
|    2 | Jane |      NULL |
|    3 | Alex |         2 |
|    4 | Bill |      NULL |
|    5 | Zack |         1 |
|    6 | Mark |         2 |
+------+------+-----------+
Return the list of customers NOT referred by the person with id '2'.

SELECT name
FROM customer
WHERE referee_id <> 2 OR referee_id IS NULL 
