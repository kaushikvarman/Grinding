create table SALE (merchant varchar(100), amount int, pay_mode varchar(100));

insert into SALE values('merchant_1',150,'cash');
insert into SALE values('merchant_1',500,'online');
insert into SALE values('merchant_2',450,'online');
insert into SALE values('merchant_1',100,'cash');
insert into SALE values('merchant_3',600,'cash');
insert into SALE values('merchant_5',200,'online');
insert into SALE values('merchant_2',100,'online');

--Q: Write a SQL query to find total amount received by each merchant
--   via CASH & Online mode
select * from SALE

select merchant,coalesce(sum(case when pay_mode = 'cash' then amount end),0) as cash_amount,
coalesce(sum(case when pay_mode = 'online' then amount end),0) as online_amount
from sale 
group by merchant

/* Explanation:
Step1 : There's no big logic here..see the code and understand