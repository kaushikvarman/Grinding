select * from orders


--difference between having and where--
select Sub_category,sum(sales) as total_sales
from orders
group by Sub_Category
having max(order_date) > '2020-01-01'
order by total_sales desc

select Sub_category,sum(sales) as total_sales
from orders
group by Sub_Category
--having max(order_date) > '2020-01-01'
order by total_sales desc

select Sub_category,sum(sales) as total_sales
from orders
group by Sub_Category
having max(order_date) > '2020-01-01'
order by total_sales desc

select Sub_category,sum(sales) as total_sales
from orders
where Order_Date > '2020-01-01'
group by Sub_Category
--having max(order_date) > '2020-01-01'
order by total_sales desc

--practice--
--setting city null to 2 order id--
update Orders
set City = null 
where Order_ID in('CA-2020-161389','US-2021-156909')

select * from Orders 
where Order_ID in('CA-2020-161389','US-2021-156909')

--to find null values-- 
select * from Orders
where city is null

select * from Orders
where city is not null

--aggregations--
select count(0) as cnt
from Orders

select count(*) as cnt
,sum(sales) as total_sales
from Orders

select count(*) as cnt,
sum(sales) as total_sales,
max(sales) as maximum_sale,
min(profit) as min_profit,
avg(profit) as avg_profit
from Orders

select top 1 * from orders order by sales desc

--group by-- 
select region, count(*) as cnt,
sum(sales) as total_sales,
max(sales) as max_sale,
min(profit) as min_profit,
avg(profit) as avg_profit
from Orders
group by region 

--will not run--
select sales from orders group by region

select region from orders group by region

select region,category,sum(sales) as total_sales
from orders
group by region,category
order by region

select region,sum(sales) as total_sales
from orders
group by region;

select region,sum(sales) as total_sales
from orders
where profit>50
group by region
order by total_sales desc

select sub_category, sum(sales) as total_sales 
from orders
group by Sub_Category
having sum(sales) > 100000
order by total_sales desc

select sub_category, sum(sales) as total_sales
from orders
where profit > 50
group by Sub_Category
having sum(sales) > 100000
order by total_sales desc

select sub_category,sum(sales) as total_sales
from orders
group by Sub_Category
having Sub_Category = 'Phones'
order by total_sales desc;

select sub_category,sum(sales) as total_sales
from orders
where Sub_Category = 'Phones'
group by Sub_Category
order by total_sales desc;

select sub_category,sum(sales) as total_sales
from orders
group by Sub_Category
having max(order_date) > '2020-01-01'
order by total_sales desc;

select sub_category,sum(sales) as total_sales
from orders
group by Sub_Category
--having max(order_date) > '2020-01-01'
order by total_sales desc;

select sub_category, min(order_date) as min_orderDate,max(order_date) as max_orderDate,sum(sales) as total_sales
from orders
group by Sub_Category
having max(Order_Date) > '2021-01-01'
order by total_sales desc

select sub_category, min(order_date) as min_orderDate,max(order_date) as max_orderDate,sum(sales) as total_sales
from orders
group by Sub_Category
having max(Order_Date) > '2020-01-01'
order by total_sales desc

--Assignment 4--
--1 write a update statement to update city as null for order ids :  CA-2020-161389 , US-2021-156909
update Orders
set city = null
where order_id in('CA-2020-161389','US-2021-156909')

select * from Orders
where city is null

--2- write a query to find orders where city is null (2 rows)
select * from Orders
where city is null

--3- write a query to get total profit, first order date and latest order date for each category
select category, sum(profit) as total_profit, min(order_date) as first_order_date, max(order_date) as latest_order
from orders
group by Category

--4- write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category
select sub_category, avg(profit) as avg_profit, max(profit) as max_profit
from Orders
group by Sub_Category
having avg(profit) >max(profit)/2

select sub_category
from orders
group by sub_category
having avg(profit) > max(profit)/2

--5- create the exams table with below script;
create table exams (student_id int, subject varchar(20), marks int); 

insert into exams values (1,'Chemistry',91),(1,'Physics',91),(1,'Maths',92)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80),(3,'Maths',80)
,(4,'Chemistry',71),(4,'Physics',54)
,(5,'Chemistry',79);

select * from exams

select student_id,marks from exams
where subject in('Chemistry','Physics')
group by student_id, marks
having count(1) = 2

select student_id , marks
from exams 
where subject in ('Physics','Chemistry')
group by student_id , marks

select student_id
from exams 

update exams 
set marks = 87
where student_id = '1' and subject = 'Physics'

--6-write a query to find total number of products in each category.
select category, count(distinct product_id) as productCount
from Orders
group by Category 

--7- write a query to find top 5 sub categories in west region by total quantity sold

select top 5 region,Sub_Category,sum(quantity) as total_quantity
from Orders 
group by region,Sub_Category 
having region = 'west'
order by total_quantity desc


--8- write a query to find total sales for each region and ship mode combination for orders in year 2020

select region,ship_mode,sum(sales) as total_sales
from orders 
where Order_Date between '2020-01-01' and '2020-12-31'
group by region,ship_mode
order by Region



