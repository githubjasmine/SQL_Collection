-- https://leetcode.com/problems/students-and-examinations/

SELECT a.*, IFNULL(attended_exams,0) attended_exams
FROM (SELECT student_id, student_name, subject_name
      FROM students, subjects)
  -- first cross join the students & subjects table
  -- so that each student & each subject would exist in the final result
LEFT JOIN (SELECT student_id, subject_name, COUNT(*) attended_exams
          FROM examinations
          GROUP BY 1,2) b
ON a.student_id = b.student_id AND a.subject_name = b.subject_name
ORDER BY student_id, subject_name

-- this time luckily, the subjects in the subjects table is of the right ORDER
-- if not, first give subjects right order by rank|row_number|...
-- then cross join with students
