-- https://leetcode.com/problems/average-salary-departments-vs-company

SELECT DISTINCT pay_month, department_id,
-- window fundtion would not aggregate,
-- need to use distinct to give result on each dept, month
CASE WHEN dept_avg > com_avg THEN 'higher'
WHEN dept_avg < com_avg THEN "lower"
ELSE 'same' END AS comparison
FROM
    (SELECT pay_month, department_id,
    AVG(amount) OVER(PARTITION BY pay_month, department_id) dept_avg,
    AVG(amount) OVER(PARTITION BY pay_month) com_avg
    FROM
        (SELECT SUBSTR(pay_date,1,7) pay_month, department_id, amount
        FROM salary s
        JOIN employee e
        ON s.employee_id = e.employee_id) a) b


-- The following solution doesn't work
  -- different dept might have different number of employees
  -- should not take avg on the dept_avg to get company wide average salary

  -- select pay_month, department_id,
  -- case when dept_avg = amount then 'same'
  -- when amount < dept_avg then 'lower'
  -- else 'higher' end as comparison
  -- from
  --     (select *, avg(amount) over(partition by pay_month) dept_avg
  --     from
  --         (select substr(pay_date,1,7) pay_month, department_id, avg(amount) amount
  --         from salary s
  --         join employee e
  --         on s.employee_id = e.employee_id
  --         group by 1,2) a) b
  -- order by 1 desc, 2
