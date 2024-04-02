create table company_users 
(
company_id int,
user_id int,
language varchar(20)
);

insert into company_users values (1,1,'English')
,(1,1,'German')
,(1,2,'English')
,(1,3,'German')
,(1,3,'English')
,(1,4,'English')
,(2,5,'English')
,(2,5,'German')
,(2,5,'Spanish')
,(2,6,'German')
,(2,6,'Spanish')
,(2,7,'English');

select * from company_users;

--Q: Find companies who have atleast 2 users who speaks

with cte as(
select company_id,user_id,count(language) as l from company_users
where language in('English','German')
group by company_id,user_id
having count(language) = 2)
select company_id
from cte
group by company_id 
having count(user_id) >= 2

/* Explanation:

Step 1: First we filter the table with people speaking only English and German
Step 2: Now we use group by on company and user to find count of people 
        Speaking two languages and framed it in CTE
Step 3: Next we will find company where count of users >=2 

