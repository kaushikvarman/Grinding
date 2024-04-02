create table stadium (
id int,
visit_date date,
no_of_people int
);

insert into stadium
values (1,'2017-07-01',10)
,(2,'2017-07-02',109)
,(3,'2017-07-03',150)
,(4,'2017-07-04',99)
,(5,'2017-07-05',145)
,(6,'2017-07-06',1455)
,(7,'2017-07-07',199)
,(8,'2017-07-08',188);

--Q: Write a query to display the records which have 3 or more consecutive
--   rows with the amount of people more than 1
select * from stadium;

with cte as(
select *, row_number() over(order by id) as rn,
id-ROW_NUMBER() over(order by id) as rn_d
from stadium
where no_of_people >= 100)
select id,visit_date,no_of_people from cte
where rn_d = 
(select rn_d
from cte 
group by rn_d 
having count(2) >= 3)


/* Explanation:
Step1 : Here we will make use of id column
Step2 : We will use row_number() over id and generate row numbers
        where no_of people >= 100
Step3 : After that we will subtract id and row_number( if there is a
        common difference then they are consecutive) and frame it in CTE
Step4 : Now we will select rows where count(1)[count of consecutive days]
        >= 3..see the code and get intuition
