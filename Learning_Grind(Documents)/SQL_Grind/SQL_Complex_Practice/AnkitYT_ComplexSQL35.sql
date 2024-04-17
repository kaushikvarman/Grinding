create table business_city (
business_date date,
city_id int
);

insert into business_city
values(cast('2020-01-02' as date),3),(cast('2020-07-01' as date),7),(cast('2021-01-01' as date),3),(cast('2021-02-03' as date),19)
,(cast('2022-12-01' as date),3),(cast('2022-12-15' as date),3),(cast('2022-02-28' as date),12);

--Q: Write a SQL to identify yearwise count of new cities 

select * from business_city
select * from business_city;

with cte as(
select year(business_date) as yr,city_id 
from business_city)
select c1.yr, count(case when c2.city_id is null then c1.city_id end) as count from cte c1 
left join cte c2 on c1.yr>c2.yr and c1.city_id = c2.city_id
group by c1.yr

/*Explanation:
Step1 : First here we extract year from business_date
Step2 : Now we will use self left join on c1.yr > c2.yr and c1.city_id = c2.city_id
Step3 : c1.yr > c2.yr and c1.city_id = c2.city_id gives us previous year's 
        operations in the each city
Step4 : So all the null values from the left join represents the new cities
        where udaan started their operations
Step5 : Now we will use c1.yr and count(case when c2.city_id is null then c1.city_id)
        Means it is giving count of all the operation in that year