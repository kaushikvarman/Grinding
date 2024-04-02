--select * from orders



--1- write a query to find premium customers from orders data. Premium customers are those who have done more orders than average no of orders per customer.

select customer_id,count(order_id) from orders
group by customer_id
having count(order_id) >
(select avg(c) from
(select customer_id,count(distinct Order_id) as c
from orders 
group by customer_id) as total_order_customer)

with no_of_orders_each_customer as (
select customer_id,count(distinct order_id) as no_of_orders
from orders 
group by customer_id)
--select * from 
--no_of_orders_each_customer where no_of_orders > 
(select avg(no_of_orders) from no_of_orders_each_customer)

--2- write a query to find employees whose salary is more than average salary of employees in their department

with avgd as
(select dept_id,avg(salary) as avgs
from employee
group by dept_id)
select emp_name,salary from
employee e 
inner join avgd d
on e.dept_id = d.dept_id 
where salary > avgs

select e.* from employee e
inner join (select dept_id,avg(salary) as avg_sal from employee group by dept_id)  d
on e.dept_id=d.dept_id
where salary>avg_sal

--3- write a query to find employees whose age is more than average age of all the employees.

select * from employee

select emp_name,emp_age
from employee
where emp_age >(select avg(emp_age) as avgs
from employee)

--4- write a query to print emp name, salary and dep id of highest salaried employee in each department 
with avg_sal as(
select dept_id,max(salary) as max_sal
from employee 
group by dept_id)
select e.emp_name,a.max_sal,a.dept_id
from avg_sal a
left join employee e on a.max_sal = e.salary

select e.* from employee e
inner join (select dept_id,max(salary) as max_sal from employee group by dept_id)  d
on e.dept_id=d.dept_id
where salary=max_sal


--5- write a query to print emp name, salary and dep id of highest salaried overall

select emp_name,salary,dept_id from employee 
where salary = (select max(salary) from employee)

--6- write a query to print product id and total sales of highest selling products (by no of units sold) in each category
select * from orders

with sell as
(select distinct product_id,max(quantity) as max_sale
from orders
group by product_id)
select o.category,s.product_id
from orders o
inner join sell s on o.Product_ID = s.product_id 


select * from employee

select top 2 dept_id,max(salary)
from employee
group by dept_id