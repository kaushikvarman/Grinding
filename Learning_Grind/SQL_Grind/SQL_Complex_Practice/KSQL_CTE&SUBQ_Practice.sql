select * from orders



select order_id
from Orders
group by order_id 
having sum(sales)> (select avg(total_sales) as Av from
(select order_id,sum(sales) as total_sales
from Orders
group by Order_ID) as Avg_orders_sales)

--
select * from employee
select * from dept

update employee 
set dept_id = 700
where emp_id = 8

--
select dep_id from dept


select * from employee 
where dept_id not in (select dep_id from dept)

select dept_id,emp_age from employee
where dept_id not in (select dep_id from dept)

--
select dept_id from employee 
except 
select dep_id from dept


--subqueries with join 

select A.*,B.*
from
(select order_id,sum(sales) as order_sales 
from orders 
group by order_id) A
inner join
(select avg(orders_aggregated.order_sales) as avg_order_value from
(select order_id,sum(sales) as order_sales 
from orders
group by order_id) as orders_aggregated) B
on 1=1
where order_sales>avg_order_value

select * from employee e
inner join 
(select dept_id,avg(salary) as Avg_sal
from employee
group by dept_id) as A
on e.dept_id = A.dept_id

select * from icc_world_cup

select team_name,count(1) as matches_played,sum(win_flag) as matches_won,count(1)-sum(win_flag)
as matches_lost
from
(select team_1 as team_name,(case when team_1 = winner then 1 else 0 end ) as win_flag
from icc_world_cup
union all
select team_2,(case when team_2 = winner then 1 else 0 end )
from icc_world_cup) A
group by team_name 

--CTE--

with A as
(select team_1 as team_name,(case when team_1 = winner then 1 else 0 end) as win_flag
from icc_world_cup
union all
select team_2,case when team_2 = winner then 1 else 0 end
from icc_world_cup)
select team_name,count(1) as matches_played,sum(win_flag) as wins,count(1)-sum(win_flag) as loses
from A 
group by team_name


with dep as
(select dept_id,avg(salary) as avg_dep_sal
from employee 
group by dept_id)
,total_sal as (select dept_id,sum(avg_dep_sal) as ts from dep group by dept_id)
,combined as (select * from
select e.*,d.*
from employee e 
inner join total_sal d 
on e.dept_id = d.dept_id


