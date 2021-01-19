-- https://leetcode.com/problems/team-scores-in-football-tournament/

-- Fast solution with sum(if()):

SELECT t.team_id, team_name, IFNULL(num_points, 0) num_points
FROM teams t
LEFT JOIN
    (SELECT team_id, SUM(IF(points > 0, 3, IF(points < 0, 0, 1))) num_points
    FROM
        (SELECT host_team team_id, (host_goals - guest_goals) points
        FROM matches
        UNION ALL
        SELECT guest_team team_id, (guest_goals - host_goals) points
        FROM matches) a
    GROUP BY 1) b
ON t.team_id = b.team_id
ORDER BY 3 DESC, 1

-- Alternative solution with CASE WHEN, slower, but straight forward:
SELECT t.team_id, team_name, IFNULL(num_points,0) num_points
FROM teams t
LEFT JOIN
    (SELECT team_id, SUM(points) num_points
    FROM
        (SELECT host_team team_id,
        CASE WHEN host_goals > guest_goals THEN 3
        WHEN host_goals = guest_goals THEN 1
        ELSE 0 END AS points
        FROM matches
        UNION ALL
        SELECT guest_team team_id,
        CASE WHEN host_goals < guest_goals THEN 3
        WHEN host_goals = guest_goals THEN 1
        ELSE 0 END AS points
        FROM matches) a
    GROUP BY 1) b
ON t.team_id = b.team_id
ORDER BY 3 DESC, 1
