-- https://leetcode.com/problems/patients-with-a-condition/

SELECT *
FROM patients
WHERE conditions LIKE "% DIAB1%" OR conditions LIKE "DIAB1%"

-- both conditions are necessary:
-- ACNE DIAB100
-- DIAB100
