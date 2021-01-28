-- https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/

-- Solution:
SELECT id, COUNT(DISTINCT id2) num
FROM
    (SELECT requester_id id, accepter_id id2
    FROM request_accepted
    UNION
    SELECT accepter_id, requester_id
    FROM request_accepted) a
GROUP BY 1
ORDER BY num DESC
LIMIT 1

"""
it's possible that a pair of friends
may accept the friend request of each other.
use "UNION" istead of "UNION ALL" to deal with this
since "UNION" would automatically drop the duplicated rows
"""
