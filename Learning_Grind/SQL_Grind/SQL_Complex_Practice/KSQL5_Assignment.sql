--assignment 5--
--1- write a query to get region wise count of return orders
select o.region, count(distinct r.order_id) as return_count
from orders o
inner join returns$ r on o.Order_ID = r.Order_Id
group by o.region

select * from returns$

--2- write a query to get category wise sales of orders that were not returned
select o.category ,sum(o.sales) as total_sales
from orders o
left join returns$ r on o.Order_ID = r.Order_Id
where r.Return_Reason is null
group by o.category

--creating employee,dept table
create table employee(
    emp_id int,
    emp_name varchar(20),
    dept_id int,
    salary int,
    manager_id int,
    emp_age int
);


insert into employee values(1,'Ankit',100,10000,4,39);
insert into employee values(2,'Mohit',100,15000,5,48);
insert into employee values(3,'Vikas',100,10000,4,37);
insert into employee values(4,'Rohit',100,5000,2,16);
insert into employee values(5,'Mudit',200,12000,6,55);
insert into employee values(6,'Agam',200,12000,2,14);
insert into employee values(7,'Sanjay',200,9000,2,13);
insert into employee values(8,'Ashish',200,5000,2,12);
insert into employee values(9,'Mukesh',300,6000,6,51);
insert into employee values(10,'Rakesh',500,7000,6,50);
select * from employee;

create table dept(
    dep_id int,
    dep_name varchar(20)
);
insert into dept values(100,'Analytics');
insert into dept values(200,'IT');
insert into dept values(300,'HR');
insert into dept values(400,'Text Analytics');
select * from dept;


--3- write a query to print dep name and average salary of employees in that dep
select * from employee
select * from dept

select d.dep_name, avg(e.salary) as avg_sal
from dept d
left join employee e on e.dept_id = d.dep_id
group by d.dep_name
having avg(e.salary) is not null

--perfect sol--
select d.dep_name,avg(e.salary) as avg_sal
from employee e
inner join dept d on e.dept_id=d.dep_id
group by d.dep_name


--4- write a query to print dep names where none of the emplyees have same salary.

select * from employee
select * from dept

select d.dep_name, e.salary
from dept d
left join employee e on d.dep_id = e.dept_id

select d.dep_name, e.salary
from dept d
inner join employee e on d.dep_id = e.dept_id
group by d.dep_name,e.salary
having count(e.emp_id) = count(distinct e.salary)

select d.dep_name
from employee e
inner join dept d on e.dept_id=d.dep_id
group by d.dep_name
having count(e.emp_id)=count(distinct e.salary)



--5- write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)
select top 10 * from orders
select distinct Return_Reason from returns$

select o.sub_category
--count(o.sub_category) as scount 
from orders o
inner join returns$ r on o.Order_ID = r.Order_Id
group by o.Sub_Category
having count(distinct return_reason) = 3

--6- write a query to find cities where not even a single order was returned.

--just a left join--
select top 100 o.city,r.Return_Reason
from orders o
left join returns$ r on o.Order_ID = r.Order_Id
group by o.city,r.Return_Reason
order by o.city

--original soln--
select city
from orders o
left join returns$ r on o.order_id=r.order_id
group by city
having count(r.order_id)=0
order by o.city
 
--my answer--
select distinct o.city, r.return_reason
from orders o 
left join returns$ r on o.Order_ID = r.Order_Id
where r.Order_Id is null
order by o.city

--7- write a query to find top 3 subcategories by sales of returned orders in east region

--my soln--
select top 3 o.Sub_Category, o.region, sum(o.sales) as total_sales
from orders o
inner join returns$ r on o.Order_ID = r.Order_Id
where r.Return_Reason is not null and Region = 'east'
group by o.Sub_Category, o.region
order by sum(sales) desc

--original soln--
select top 3 sub_category,sum(o.sales) as return_sales
from orders o
inner join returns$ r on o.order_id=r.order_id
where o.region='East'
group by sub_category
order by return_sales  desc

--8- write a query to print dep name for which there is no employee

--my soln
select d.dep_name
from dept d
left join employee e on d.dep_id = e.dept_id
where e.emp_id is null

--original soln-- 
select d.dep_id,d.dep_name
from dept d 
left join employee e on e.dept_id=d.dep_id
group by d.dep_id,d.dep_name
having count(e.emp_id)=0;

--9- write a query to print employees name for dep id is not avaiable in dept table
select * from employee
select * from dept

select e.emp_name 
from employee e
left join dept d on e.dept_id = d.dep_id
where d.dep_id is null

select e.*
from employee e 
left join dept d  on e.dept_id=d.dep_id
where d.dep_id is null;







