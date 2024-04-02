--select * from orders

--1- write a sql to find top 3 products in each category by highest rolling 3 months total sales for Jan 2020.
with cte as(
select category,Product_ID,DATEPART(year,order_date) as ye,datepart(month,order_date) as mo,sum(sales) as total_sales
from orders 
group by category,Product_ID,DATEPART(year,order_date),datepart(month,order_date)
), cte2 as
(select *, sum(total_sales) over(partition by category,product_id order by ye,mo rows between 2 preceding and current row ) as roll3_sales
from cte)
,cte3 as(
select *,DENSE_RANK() over(partition by category order by roll3_sales desc) as drnk from cte2 where ye=2020 and mo=1)
select * from cte3
where drnk <= 3

--2- write a query to find products for which month over month sales has never declined
with cte as(
select product_id,datepart(year,order_date) as ye,DATEPART(month,order_date) as mo,sum(sales) as total_sales
from orders 
group by product_id,datepart(year,order_date),DATEPART(month,order_date))
select *,lag(total_sales,1,0) over(partition by product_id order by ye,mo) as la
from cte



