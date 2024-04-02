--select * from employee

--to find avg(salary) for each dept with aggregates and WAF 

select * 
,avg(salary) over(partition by dept_id) as avg_dep_salary
from employee;

--without using aggregate on window functions
with CTE as(
select dept_id,avg(salary) as avg_salary
from employee
group by dept_id)
select e.*,c.avg_salary
from CTE c 
inner join employee e on c.dept_id = e.dept_id

--max with WAF
select *
,max(salary) over(partition by dept_id) as max_salary
from employee

--max with WAF and order by(gives running salary)
select *
,max(salary) over(partition by dept_id order by salary) as running_sal
from employee

--count with WAF
select *
,count(salary) over(partition by dept_id) as count_of_salary
from employee

--count with WAF and order by ..gives running count of salaries
select *
,count(salary) over(partition by dept_id order by salary) as count_of_salary
from employee

--sum with WAF ..gives sum of all salaries per dept
select * 
,sum(salary) over(partition by dept_id) as sum_sal 
from employee 

--sum with waf and order by...gives running salary based on order by
select * 
,sum(salary) over(partition by dept_id order by emp_id) as sum_sal_running 
from employee 

--max with partition,parti with order,with order without parti
select *
,max(salary) over(partition by dept_id) as max_dep_sal
,max(salary) over(partition by dept_id order by emp_id) as dep_emp_running_sal
,max(salary) over(order by emp_id asc) as running_emp_sal
from employee;

--sum(salary) with order by 
--Here it adds two consecutive duplicates as 
select *,
sum(salary) over(order by salary) as running_salary
from employee

--to avoid duplicates error..we use two col in orderby
select *
,sum(salary) over(order by salary,emp_id DESC) as running_sal
from employee 

--avg(salary) 
select *
,avg(salary) over(partition by dept_id order by emp_id) as avg_running_salary
from employee

--running count
select 
count(salary) as running_count 
from employee

--salary of 2 preceding and current row
select *
,sum(salary) over(order by emp_id desc rows between 2 preceding and current row) as rolling_3_sal
from employee 

--salary of 1 precedind,current_row and 1 following

select *
,sum(salary) over(order by emp_id rows between 1 preceding and 1 following) as roll_3_sal
from employee

--salary of 5 following and 10 following
select *
,sum(salary) over(order by emp_id rows between 5 following and 10 following) as roll_10_sal
from employee

--unbounded preceding and current_row
select *
,sum(salary) over(order by emp_id rows between unbounded preceding and current row) as unb_prev_sal
from employee

--same as
select *,
sum(salary) over(order by emp_id) as sum_sal
from employee

select *,
sum(salary) over(partition by dept_id order by emp_id desc rows between unbounded preceding and current row) as unb_parti
from employee;

with CTE as(
select datepart(year,order_date) as year_order,DATEPART(month,order_date) as month_order,
sum(sales) as total_sales
from orders 
group by datepart(year,order_date),DATEPART(month,order_date))
select year_order,month_order,total_sales,
sum(total_sales) over(order by year_order,month_order rows between 2 preceding and current row) as rolling_3
from CTE












