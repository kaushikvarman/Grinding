select count(case when filter_room_types like '%entire home%' then 1 End) as 'entire home',
count(case when filter_room_types like '%private room%' then 1 End) as 'private room',
count(case when filter_room_types like '%shared room%' then 1 End) as 'shared room'
from 
airbnb_searches


select * from airbnb_searches

select distinct(filter_room_types) from airbnb_searches

with cte1 as(
select count(case when filter_room_types like '%entire home%' then 1 End) as 'cnt' from airbnb_searches
union all 
select count(case when filter_room_types like '%private room%' then 1 End) as 'private room' from airbnb_searches
union all
select count(case when filter_room_types like '%shared room%' then 1 End) as 'shared room' from airbnb_searches)


select 'a','b','c';