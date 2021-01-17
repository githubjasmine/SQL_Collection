-- https://leetcode.com/problems/reported-posts-ii/

SELECT ROUND(AVG(rate)*100,2) average_daily_percent
FROM
    (SELECT COUNT(remove_date)/COUNT(action_date) rate
    FROM
        (SELECT DISTINCT a.post_id, action_date, remove_date
        FROM actions a
        LEFT JOIN removals r
        ON a.post_id = r.post_id
        WHERE action = 'report' AND extra = 'spam') a
    GROUP BY action_date) b

-- there's duplicates in the actions table,
-- but DISTINCT on the joint table of actions & removals:
-- one post can be reported as spam for several times,
-- but only need to be removed for once.

-- why not distinct on the actions table:
-- we need the action_date info,
-- while a post can be reported spam on different date,
-- distinct in this layer wouldn't be able to filter this
