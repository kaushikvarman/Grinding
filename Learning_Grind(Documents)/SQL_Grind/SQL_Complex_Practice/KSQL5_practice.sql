select * from orders

select * from returns$

select * from returns$
order by Order_id

select o.order_id,o.order_date,r.return_reason
from orders o
inner join returns$ r on o.Order_ID = r.order_id

--inner joining orders and returns...then..selecting distinct order_id's from orders
select distinct o.order_id,o.order_date,r.return_reason
from orders o
inner join returns$ r on o.Order_ID = r.order_id

--joining orders and returns wer there order_id's are matched
select *
from orders o
inner join returns$ r on o.Order_ID = r.order_id

--gives all the columns from the orders table wer the order_id 
--are matched with returns table order_id
select o.*
from orders o
inner join returns$ r on o.Order_ID = r.Order_Id

--similar to the above sql query..here additionally it gives
--return_reason column
select o.*,r.return_reason
from orders o
inner join returns$ r on o.Order_ID = r.Order_Id

--left join--
select o.order_id,o.product_id,r.return_reason,r.order_id as return_order_id
from orders o
left join returns$ r on o.Order_ID = r.Order_Id

--performed left join on orders and returns then retrived
--rows where return reason is not null..its sames as inner join
select o.order_id,o.product_id,r.return_reason,r.order_id as return_order_id
from orders o
left join returns$ r on o.Order_ID = r.Order_Id
where Return_Reason is not null

--group by on return reason--
select r.return_reason,sum(sales) as total_sales
from orders o
left join returns$ r on o.Order_ID = r.Order_Id
group by r.Return_Reason

--excludes total sales for NULL--
select r.return_reason,sum(sales) as total_sales
from orders o
inner join returns$ r on o.Order_ID = r.Order_Id
group by r.Return_Reason

--cross join--
select count(*) 
from orders
inner join returns$ r on 1=1

select count(*) from orders
select count(*) from returns$

select o.order_id,o.product_id,r.return_reason,r.order_id as return_order_id
from orders o
left join returns$ r on o.Order_ID = r.Order_Id

select o.order_id,o.product_id,r.return_reason,r.order_id as return_order_id
from orders o
right join returns$ r on o.Order_ID = r.Order_Id

select o.order_id,o.product_id,r.return_reason,r.order_id as return_order_id
from returns$  r
left join orders o on o.Order_ID = r.Order_Id

--full join--
--full join = left join + right join--
select o.order_id,o.product_id,r.return_reason,r.order_id as return_order_id
from orders o
full join returns$ r on o.Order_ID = r.Order_Id

create table people
(
manager varchar(20),
region varchar(20),
)

insert into people
values('Kaushik','South'),
('SaiTeja','east'),
('vamshi','west'),
('Anish','North')

select * from people

--applying two inner joins
select o.Region, o.order_id,o.product_id,r.return_reason
--,p.manager
from orders o
inner join returns$ r on o.Order_ID = r.Order_Id
inner join people p on o.Region = p.region 


