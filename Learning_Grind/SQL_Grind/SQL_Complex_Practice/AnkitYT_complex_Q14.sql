create table users2
(
user_id integer,
name varchar(20),
join_date date
);
insert into users2
values (1, 'Jon', CAST('2-14-20' AS date)), 
(2, 'Jane', CAST('2-14-20' AS date)), 
(3, 'Jill', CAST('2-15-20' AS date)), 
(4, 'Josh', CAST('2-15-20' AS date)), 
(5, 'Jean', CAST('2-16-20' AS date)), 
(6, 'Justin', CAST('2-17-20' AS date)),
(7, 'Jeremy', CAST('2-18-20' AS date));

create table events2
(
user_id integer,
type varchar(10),
access_date date
);

insert into events2 values
(1, 'Pay', CAST('3-1-20' AS date)), 
(2, 'Music', CAST('3-2-20' AS date)), 
(2, 'P', CAST('3-12-20' AS date)),
(3, 'Music', CAST('3-15-20' AS date)), 
(4, 'Music', CAST('3-15-20' AS date)), 
(1, 'P', CAST('3-16-20' AS date)), 
(3, 'P', CAST('3-22-20' AS date));

select * from users2 
select * from events2 

/* Q: 
Given the following two tables, return the fraction of users, rounded to two decimal places,
who accessed Amazon music and upgraded to prime membership within the first 30 days of signing up. 
*/

select count(distinct u.user_id) as total_users, count(distinct case when datediff(day,u.join_date,e.access_date) <=30 then u.user_id end) as Valued_customer
,1.0* count(distinct case when datediff(day,u.join_date,e.access_date) <=30 then u.user_id end)/count(distinct u.user_id) as ratio from users2 u
left join events2 e on u.user_id = e.user_id and e.type = 'P'
where u.user_id in (select user_id from events2 where type = 'Music')

/* Explanation:
Step 1: first we will try to find users who purchases amazon music using where and subquery
Step 2: Next with this result we will use left join and find users 
        who upgraded to prime 
Step 3: Now we will use datediff to calculate how many days customer took
        to upgrage to prime 
Step 4: We get total users by Count(distinct users) and Valued_customer by using count and 
        case when and to get ratio ..we divide them

