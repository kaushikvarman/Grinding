--select * from orders

--3-Among all the sub categories..which sub category had highest month over month growth by sales in Jan 2020.

 
with sbc_sales as (
select sub_category,format(order_date,'yyyyMM') as year_month, sum(sales) as sales
from orders
group by sub_category,format(order_date,'yyyyMM')
)
, prev_month_sales as (select *,lag(sales) over(partition by sub_category order by year_month) as prev_sales
from sbc_sales)
select  * , (sales-prev_sales)/prev_sales as mom_growth
from prev_month_sales
where year_month='202001'
order by mom_growth desc

--4-write a query to print top 3 products in each category by year over year sales growth in year 2020.

select * from orders 

with cp_sales as(
select category,product_id,format(order_date,'yyyy') as years,sum(sales) as total_sales
from orders 
group by category,Product_ID,FORMAT(order_date,'yyyy')
),prev_years as(
select * ,lag(total_sales,1) over(partition by category order by years) as year_growth
from cp_sales),
rnk1 as
(select *,rank() over(partition by category order by (total_sales-year_growth)/year_growth desc ) as rnk
from prev_years
where years = '2020')
select *
from rnk1
where rnk <= 3

--5
create table call_start_logs
(
phone_number varchar(10),
start_time datetime
);

insert into call_start_logs values
('PN1','2022-01-01 10:20:00'),('PN1','2022-01-01 16:25:00'),('PN2','2022-01-01 12:30:00')
,('PN3','2022-01-02 10:00:00'),('PN3','2022-01-02 12:30:00'),('PN3','2022-01-03 09:20:00')

create table call_end_logs
(
phone_number varchar(10),
end_time datetime
);
insert into call_end_logs values
('PN1','2022-01-01 10:45:00'),('PN1','2022-01-01 17:05:00'),('PN2','2022-01-01 12:55:00')
,('PN3','2022-01-02 10:20:00'),('PN3','2022-01-02 12:50:00'),('PN3','2022-01-03 09:40:00')
;

select * from call_start_logs
select * from call_end_logs

select s.phone_number,s.rn,s.start_time,e.end_time, datediff(minute,start_time,end_time) as duration
from 
(select *,row_number() over(partition by phone_number order by start_time) as rn  from call_start_logs) s
inner join (select *,row_number() over(partition by phone_number order by end_time) as rn  from call_end_logs) e
on s.phone_number = e.phone_number and s.rn=e.rn;