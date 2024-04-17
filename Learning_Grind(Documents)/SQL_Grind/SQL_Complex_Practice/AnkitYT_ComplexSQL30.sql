create table players_location
(
name varchar(20),
city varchar(20)
);

insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');

select * from players_location;

with cte as(
select *,row_number() over(partition by city order by name) as rn
from players_location)
select min(case when city = 'Bangalore' then name end) as Bangalore,
min(case when city = 'Mumbai' then name end) as Mumbai,
min(case when city = 'Delhi' then name end) as Delhi
from cte 
group by rn

/*Explanation:
Step1 : First we have used row_number over by city order by name
Step2 : Now using rn as key we will perform group by operation
Step3 : Then we use case when and aggreagate functions to get the 
        output as required