create table candidates (
emp_id int,
experience varchar(20),
salary int
);

insert into candidates values
(1,'Junior',10000),(2,'Junior',15000),(3,'Junior',40000),(4,'Senior',16000),(5,'Senior',20000),(6,'Senior',50000);

--Q: A company has the budget of $70000, company wants to hire seniors with lowest salaries first
--   And then juniors with remaining salaries, write an SQL query for this.
select * from candidates;

with cte as(
select *,sum(salary) over(partition by experience order by salary) as running_sum
from candidates),
cte2 as(
select * from cte 
where experience = 'Senior' and  running_sum < 70000)
select emp_id,experience,salary from  cte 
where experience = 'Junior' and running_sum < 70000-(select sum(salary) from cte2)
union all
select emp_id,experience,salary from cte2

/* Explanation:
Step1 : First we have computed running sum of salaries for both juniors and seniors
Step2 : Now company will select seniors where running_sum < 70000 and framed it in a
        CTE
Step3 : Now next we will select juniors where running_sum < remaining budget of seniors
        budget
Step4 : At last we will perform union-all with cte2 to get the required answer



