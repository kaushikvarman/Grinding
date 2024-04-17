--String Functions

--len
select order_id,customer_name,len(customer_name) as len_name
from orders

--left & right

select order_id,customer_name
,len(customer_name) as len_name
,left(customer_name,4) as left4
,right(customer_name,4) as right4
from orders

--subString

select order_id,customer_name
,len(customer_name) as len_name
,left(customer_name,4) as left4
,right(customer_name,4) as right4
,SUBSTRING(customer_name,3,4) as subtring_c
from orders

--charIndex

select order_id,customer_name
,len(customer_name) as len_name
,left(customer_name,4) as left4
,right(customer_name,4) as right4
,CHARINDEX(' ',customer_name) as space_pos
,CHARINDEX('n',Customer_Name,1) as first_pos
,CHARINDEX('n',Customer_Name,CHARINDEX('n',Customer_Name,1)+1) as second_pos
,CHARINDEX('n',Customer_Name,11) as n_pos
from orders

--concat

select order_id,customer_name
,len(customer_name) as len_name
,left(customer_name,4) as left4
,right(customer_name,4) as right4
,CHARINDEX(' ',customer_name) as space_pos
,CHARINDEX('n',Customer_Name,1) as first_pos
,CHARINDEX('n',Customer_Name,CHARINDEX('n',Customer_Name,1)+1) as second_pos
,CHARINDEX('n',Customer_Name,11) as n_pos
,CONCAT(order_id,' ',Customer_Name) as concats
from orders

--to find first name of a customer
select order_id,customer_name,
left(customer_name,CHARINDEX(' ',customer_name)) as first_name,
SUBSTRING(customer_name,0,CharIndex(' ',customer_name)) as first_n
from orders

--replace
select order_id,customer_name,
REPLACE(order_id,'CA','AD') as replaced_AB
from orders

--translate
select order_id,customer_name,
Translate(order_id,'UA','AD') as translate_AB
from orders

--null handling
select order_id,city,isnull(city,'NULL-CITY') as new_city
from orders
order by city

--coalesce
select order_id,city,isnull(city,'NULL-CITY') as new_city,
state, coalesce(city,state,region,'NULL-CITY') as coal_city
from orders
order by city

--cast
select top 5 order_id,sales,cast(sales as int) as sales_int
,round(sales,1) as sales_round 
from orders 

--setQueries
--creating sample tables for performing setQueries
create table orders_west(
order_id int,
region varchar(20),
sales int)

insert into orders_west values(11,'east',100)
insert into orders_west values(12,'east',100)
insert into orders_west values(11,'west',100)

create table orders_east(
order_id int,
region varchar(20),
sales int)

insert into orders_east values(11,'east',100)
insert into orders_east values(14,'east',100)
insert into orders_east values(15,'west',100)

Delete from orders_west where order_id > 12

select * from orders_east
select * from orders_west

alter table orders_east add customer_name varchar(20)

alter table orders_east
drop column customer_name

--unionALL
select * from orders_west
union all
select * from orders_east

--union
select * from orders_west
union 
select * from orders_east

--intersect
select * from orders_west
intersect
select * from orders_east

--except
select * from orders_east
except
select * from orders_west

--to get unique rows(the rows which are common in two table..will not appear)
(select * from orders_east
except
select * from orders_west)
union all
(select * from orders_west
except
select * from orders_east)












