--joins on same table

select * from employee

select * from employee

select e1.emp_id,e1.emp_name,e2.emp_name as manager
from employee e1
inner join employee e2 on e1.manager_id = e2.emp_id

--employees whose salary is > then their managers
select e1.emp_id,e1.emp_name,e1.salary,e2.emp_name as manager,e2.salary
from employee e1
inner join employee e2 on e1.manager_id = e2.emp_id
where e1.salary > e2.salary 

--employees whose salary and age is > then their managers
select e1.emp_id,e1.emp_name,e1.salary,e2.emp_name as manager,e2.salary
from employee e1
inner join employee e2 on e1.manager_id = e2.emp_id
where e1.salary > e2.salary and e1.emp_age > e2.emp_age

--employees whose age is more than their managers
select e1.emp_id,e1.emp_name,e1.emp_age,e2.emp_name as manager,e2.emp_age
from employee e1
inner join employee e2 on e1.manager_id = e2.emp_id
where e1.emp_age > e2.emp_age

--functions(string and date)

--to get employees names from each dept_id

select dept_id,STRING_AGG(emp_name,'||') within group (order by salary) as list_of_employees
from employee
group by dept_id

select dept_id,STRING_AGG(emp_name,'||') within group (order by emp_name) as list_of_employees
from employee
group by dept_id

--date function

select order_id,order_date,datepart(year,order_date) as year_of_order_date
from orders
--where DATEPART(year,order_date) = 2020

select order_id,order_date,datepart(year,order_date) as year_of_order_date,
DATEPART(month,Order_Date) as month_of_order
from orders


--adding days
select order_id,order_date, DATEADD(day,5,order_date) as order_date5,
DATEADD(week,5,order_date) as order_week5
from orders

--datediff

select order_id,order_date,ship_date,datediff(day,order_date,Ship_Date) as date_diff_days,
datediff(week,Order_Date,Ship_Date) as date_diff_weeks
from orders

--case when

select order_id,profit,
case
when profit < 100 then 'low Profit'
when profit < 250 then 'medium profit'
when profit < 400 then 'high profit'
else 'huge profit'
end as profit_category
from orders 
