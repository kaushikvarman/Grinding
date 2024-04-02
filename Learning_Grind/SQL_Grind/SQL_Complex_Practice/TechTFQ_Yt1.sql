create table brands1
(
    Year    int,
    Brand   varchar(20),
    Amount  int
);
insert into brands1 values (2018, 'Apple', 45000);
insert into brands1 values (2019, 'Apple', 35000);
insert into brands1 values (2020, 'Apple', 75000);
insert into brands1 values (2018, 'Samsung',	15000);
insert into brands1 values (2019, 'Samsung',	20000);
insert into brands1 values (2020, 'Samsung',	25000);
insert into brands1 values (2018, 'Nokia', 21000);
insert into brands1 values (2019, 'Nokia', 17000);
insert into brands1 values (2020, 'Nokia', 14000);

--Q : Write a query to fetch the record of brand whose amount is increasing every year
select * from brands1;

with cte as(
select *,lag(amount,1,-amount) over(partition by brand order by Year,Brand) as lag1 from brands1)
select brand
from cte
group by brand 
having count(brand) = sum(case when Amount-lag1 >= 0 then 1 else 0 end)

/* Explanation:
Step1 : Here first I have used lag to know the previous year salary for the particular department
        and framed it in a CTE
Step2 : Next I have used group by on brand and used if count(brand) = count of positive(amount-lag1)
        then it is the answer
