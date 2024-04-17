select * from drivers


select d1.id,count(1) as total_rides, count(d2.id) as profit_rides 
from drivers d1
left join drivers d2 on d1.id = d2.id and d2.end_loc = d1.start_loc and d2.end_time = d1.start_time
group by d1.id


select count(1) as profit_rides
from drivers d1
inner join drivers d2 on d2.end_loc = d1.start_loc and d2.end_time = d1.start_time

select * from orders

select left(order_id,2) as count1,count(distinct order_id)
from orders
group by left(order_id,2)


select 'category' as hierarchy_type,category as hierarchy_name
,sum(case when region='west' then sales end) as Total_sales_in_west
,sum(case when region='east' then sales end) as Total_sales_in_east
from orders 
group by category
union all
select 'sub-category',sub_category
,sum(case when region='west' then sales end) as Total_sales_in_west
,sum(case when region='east' then sales end) as Total_sales_in_east
from orders 
group by Sub_Category
union all
select 'ship-mode',ship_mode 
,sum(case when region='west' then sales end) as Total_sales_in_west
,sum(case when region='east' then sales end) as Total_sales_in_east
from orders
group by Ship_Mode

