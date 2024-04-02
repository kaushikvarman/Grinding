--Q Find new customers every day and repeating customers
-- link : https://www.youtube.com/watch?v=MpAMjtvarrc&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=2&ab_channel=AnkitBansal

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;

select * from customer_orders
select * from customer_orders

select order_date, distinct(customer_id)
from customer_orders
group by order_date

select count(1) from customer_orders where order_date = '2022-01-01'


--my sol
with cte as
(select customer_id,min(order_date) as first_order from customer_orders
group by customer_id)
select first_order,count(customer_id) as new_customer,(select count(1) from customer_orders where order_date = '2022-01-01') - count(customer_id) as repeat_cu
from cte
group by first_order