--6- write a query to find percentage contribution of spends by females for each expense type
select * from credit_transactions


select exp_type,sum(case when gender = 'F' then amount end)*1.0/sum(amount) as ts
from credit_transactions
group by exp_type 
order by ts desc

--7- which card and expense type combination saw highest month over month growth in Jan-2014

with cte as(
select datepart(year,transaction_date) as ye,DATEPART(month,transaction_date) as mo,card_type,exp_type, sum(amount) as ts
from credit_transactions
group by datepart(year,transaction_date),DATEPART(month,transaction_date),card_type,exp_type),
--order by ye,mo,ts desc
cte2 as(
select *,lag(ts,1) over(partition by card_type,exp_type order by ye,mo, ts desc) as lag_sales
from cte )
select top 1 ye,mo,card_type,exp_type,ts,lag_sales,(ts-lag_sales) as mom_sales 
from cte2 
where ye = '2014' and mo = '1'
order by mom_sales desc 
--group by ye,mo,card_type,exp_type
--order by ye,mo


with cte as (
select card_type,exp_type,datepart(year,transaction_date) yt
,datepart(month,transaction_date) mt,sum(amount) as total_spend
from credit_transactions
group by card_type,exp_type,datepart(year,transaction_date),datepart(month,transaction_date)
)
select  top 1 *, (total_spend-prev_mont_spend) as mom_growth
from (
select *
,lag(total_spend,1) over(partition by card_type,exp_type order by yt,mt) as prev_mont_spend
from cte) A
where prev_mont_spend is not null and yt=2014 and mt=1
order by mom_growth desc;

--9- during weekends which city has highest total spend to total no of transcations ratio

with cte as(
select *,datepart(weekday,transaction_date) as td
from credit_transactions
where datepart(weekday,transaction_date) = 1 or datepart(weekday,transaction_date) = 7)
select city,sum(amount)/count(transaction_id) as ts
from cte
group by city
order by ts desc

select top 1 city,sum(amount)/count(1) as ratio
from credit_transactions
where DATEPART(weekday,transaction_date) in (1,7)
group by city 
order by ratio desc

--
