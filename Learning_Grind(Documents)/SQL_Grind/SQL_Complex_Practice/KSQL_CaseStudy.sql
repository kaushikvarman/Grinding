select * from credit_transactions;


--1- write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends 
with cte as(
select city,sum(amount) as t
from credit_transactions
group by city),
cye2 as (select sum(cast(amount as bigint)) as total_spent from credit_transactions)
select top 5 cte.*,round(t*1.0/total_spent*100,2) as percentage_contri from cte
inner join cye2 on 1=1
order by t desc

with cte1 as (
select city,sum(amount) as total_spend
from credit_transactions 
group by city)
,total_spent as (select sum(cast(amount as bigint)) as total_amount from credit_transactions)
select top 5 cte1.*, round(total_spend*1.0/total_amount * 100,2) as percentage_contribution from 
cte1 inner join total_spent on 1=1
order by total_spend desc

--2- write a query to print highest spend month and amount spent in that month for each card type
select * from credit_transactions

select datepart(year,transaction_date) as ye, DATEPART(month,transaction_date) as mo,card_type,sum(amount) as total_sales
from credit_transactions
group by datepart(year,transaction_date), DATEPART(month,transaction_date),card_type
order by mo;
--order by total_sales desc

with cte1 as
(select DATEPART(year,transaction_date) as ye, card_type,DATEPART(month,transaction_date) as mo, sum(amount) as total_sales
from credit_transactions
group by DATEPART(year,transaction_date),card_type,DATEPART(month,transaction_date)
order by mo,card_type,total_sales desc
),
cte2 as(select Datepart(month,transaction_date) as mo1,card_type,sum(amount) as total_amount from credit_transactions 
        group by Datepart(month,transaction_date),card_type)

select c.mo,c.total_sales,c2.card_type,c2.total_amount from cte1 c inner join cte2 c2 on c.mo = c2.mo1;


--3- write a query to print the transaction details(all columns from the table) for each card type when
--it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)

select * from credit_transactions;


with cte as (
select *,sum(amount) over(partition by card_type order by transaction_date,transaction_id) as total_spend
from credit_transactions
--order by card_type,total_spend desc
), cte2 as(
select *, rank() over(partition by card_type order by total_spend) as rn from cte where total_spend > 1000000
)
select * from cte2 
where rn = 1;




--4- write a query to find city which had lowest percentage spend for gold card type
select * from credit_transactions;

select city,card_type,sum(amount) as ts
from credit_transactions
where card_type = 'gold'
group by  city,card_type
order by ts

with cte as (
select city,card_type,sum(amount) as amount
,sum(case when card_type='Gold' then amount end) as gold_amount
from credit_transactions
group by city,card_type
order by city
select 
city,sum(gold_amount)*1.0/sum(amount) as gold_ratio
from cte
group by city
having count(gold_amount) > 0 and sum(gold_amount)>0
order by gold_ratio;


--5- write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)
select * from credit_transactions;

with cte1 as(
select city,exp_type,sum(amount) as ts,rank() over(partition by city order by sum(amount)) as rnk 
from credit_transactions
group by city,exp_type),
cte2 as(
select city,exp_type,sum(amount) as ts,rank() over(partition by city order by sum(amount) desc) as rnk 
from credit_transactions
group by city,exp_type)
select c1.city,c1.exp_type as leastExp,c2.exp_type as highExp--,ROW_NUMBER() over(partition by city) as rn
from cte1 c1 
inner join cte2 c2 on c1.rnk = c2.rnk and c1.city = c2.city 
where c2.rnk = 1 and c1.rnk =1;

with cte as (
select city,exp_type, sum(amount) as total_amount from credit_transactions
group by city,exp_type)
select
city , max(case when rn_asc=1 then exp_type end) as lowest_exp_type
, min(case when rn_desc=1 then exp_type end) as highest_exp_type
from
(select *
,rank() over(partition by city order by total_amount desc) rn_desc
,rank() over(partition by city order by total_amount asc) rn_asc
from cte) A
group by city;




select city,exp_type,sum(amount) le 
from credit_transactions
group by city,exp_type 
order by city,le

