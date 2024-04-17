select * from orders

select * from employee

--1-write a query to print 3rd highest salaried employee details for each department (give preferece to younger employee in case of a tie). 
--In case a department has less than 3 employees then print the details of highest salaried employee in that department.

with CTE as
(select *,
dense_rank() over(partition by dept_id order by salary desc,emp_age) as rnk
from employee) 
,CTE2 as
(select dept_id,count(1) as dep_count
from CTE 
group by dept_id)

select a.*
from CTE a 
inner join CTE2 b on a.dept_id = b.dept_id
where rnk = 3 or (dep_count<3 and rnk=1)


--2- write a query to find top 3 and bottom 3 products by sales in each region.

--try1
with sales_table as
(select region,product_id,sum(sales) as total_sales
from orders
group by region,product_id),
CTE1 as
(select *,
DENSE_RANK() over(partition by region,product_id order by total_sales asc) as rnk
from sales_table),
CTE2 as
(select *,
DENSE_RANK() over(partition by region,product_id order by total_sales desc) as rnk2
from sales_table)
select *
from CTE1

--try2 (succeeded ..but takes more time and space)
with sales_table as
(select region,product_id,sum(sales) as total_sales
from orders
group by region,product_id),
CTE1 as
(select *,
DENSE_RANK() over(partition by region order by total_sales desc) as rnk
from sales_table),
CTE2 as
(select *,
DENSE_RANK() over(partition by region order by total_sales asc) as rnk
from sales_table)
select * 
from CTE1 
where rnk <= 3
union
select *
from CTE2 
where rnk <= 3
order by region,rnk

--original soln

with region_sales as(
select region,product_id,sum(sales) as sales
from orders 
group by region,product_id)
,CTE1 as
(select *, rank() over(partition by region order by sales desc) as d
,rank() over(partition by region order by sales asc) as a
from region_sales) 
select region,product_id,sales, (case when d <= 3 then 'Top' else 'Bottom' end) as top_bottom
from CTE1 
where d<=3 or a<=3

--3- Among all the sub categories..which sub category had highest month over month growth by sales in Jan 2020.

select * from orders

select * from orders 
where DATEPART(year,Order_Date) = '2020'
order by Order_Date

with CTE1 as
(select sub_category,month(order_date) as month1,sum(sales) as total_sales
from orders 
where DATEPART(year,Order_date) = '2020'
group by Sub_Category,month(order_date))
select * ,rank() over(partition by sub_category order by total_sales desc) as ran
from CTE1


with sbc_sales as (
select sub_category,format(order_date,'yyyyMM') as year_month, sum(sales) as sales
from orders
group by sub_category,format(order_date,'yyyyMM')
)
, prev_month_sales as (select *,lag(sales) over(partition by sub_category order by year_month) as prev_sales
from sbc_sales)
select  top 1 * , (sales-prev_sales)/prev_sales as mom_growth
from prev_month_sales
where year_month='202001'
order by mom_growth desc




select month(order_date) as month
from orders
where DATEPART(year,Order_date) = '2020'






