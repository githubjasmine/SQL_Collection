-- https://leetcode.com/problems/unpopular-books/

SELECT b.book_id, name
FROM books b
LEFT JOIN
    (SELECT book_id, SUM(quantity) ttl
    FROM orders
    WHERE DATEDIFF('2019-06-23', dispatch_date) <= 365
    GROUP BY 1) a
ON b.book_id = a.book_id
WHERE DATEDIFF('2019-06-23', available_from) >= 30
AND (ttl < 10 OR ttl IS NULL)


-- the wrong solution:
-- failed to consider books that are not sold in the past year
-- select book_id, name
-- from books
-- where book_id in (select book_id
--                  from orders
--                  where datediff('2019-06-23', dispatch_date) <= 365
--                  group by 1
--                  having sum(quantity) < 10)
-- and datediff('2019-06-23', available_from) >= 30
