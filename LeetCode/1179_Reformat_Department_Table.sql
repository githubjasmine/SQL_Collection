-- https://leetcode.com/problems/reformat-department-table/

-- Originally, my solution would be using left joins to create multiple cols:
select distinct d.id, Jan_Revenue, Feb_Revenue, Mar_Revenue, Apr_Revenue, May_Revenue, Jun_Revenue, Jul_Revenue, Aug_Revenue, Sep_Revenue, Oct_Revenue, Nov_Revenue, Dec_Revenue
from department d
left join (select id, revenue Jan_Revenue
          from department
          where month = 'Jan') m1
on d.id = m1.id
left join (select id, revenue Feb_Revenue
          from department
          where month = 'Feb') m2
on d.id = m2.id
left join (select id, revenue Mar_Revenue
          from department
          where month = 'Mar') m3
on d.id = m3.id
left join (select id, revenue Apr_Revenue
          from department
          where month = 'Apr') m4
on d.id = m4.id
left join (select id, revenue May_Revenue
          from department
          where month = 'May') m5
on d.id = m5.id
left join (select id, revenue Jun_Revenue
          from department
          where month = 'Jun') m6
on d.id = m6.id
left join (select id, revenue Jul_Revenue
          from department
          where month = 'Jul') m7
on d.id = m7.id
left join (select id, revenue Aug_Revenue
          from department
          where month = 'Aug') m8
on d.id = m8.id
left join (select id, revenue Sep_Revenue
          from department
          where month = 'Sep') m9
on d.id = m9.id
left join (select id, revenue Oct_Revenue
          from department
          where month = 'Oct') m10
on d.id = m10.id
left join (select id, revenue Nov_Revenue
          from department
          where month = 'Nov') m11
on d.id = m11.id
left join (select id, revenue Dec_Revenue
          from department
          where month = 'Dec') m12
on d.id = m12.id
order by 1

-- a more efficient way would be using case when to get multiple cols,
-- and group by to aggregate the ids
select id,
sum(case when month = 'Jan' then revenue end) as 'Jan_Revenue',
sum(case when month = 'Feb' then revenue end) as 'Feb_Revenue',
sum(case when month = 'Mar' then revenue end) as 'Mar_Revenue',
sum(case when month = 'Apr' then revenue end) as 'Apr_Revenue',
sum(case when month = 'May' then revenue end) as 'May_Revenue',
sum(case when month = 'Jun' then revenue end) as 'Jun_Revenue',
sum(case when month = 'Jul' then revenue end) as 'Jul_Revenue',
sum(case when month = 'Aug' then revenue end) as 'Aug_Revenue',
sum(case when month = 'Sep' then revenue end) as 'Sep_Revenue',
sum(case when month = 'Oct' then revenue end) as 'Oct_Revenue',
sum(case when month = 'Nov' then revenue end) as 'Nov_Revenue',
sum(case when month = 'Dec' then revenue end) as 'Dec_Revenue'
from department
group by id
