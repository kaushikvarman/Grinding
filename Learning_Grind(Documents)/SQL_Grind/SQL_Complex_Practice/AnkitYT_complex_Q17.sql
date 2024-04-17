create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');

select * from UserActivity

select *,rank() over(partition by username order by startDate) as rn from UserActivity;

with cte as(
select *,lead(activity,1,activity) over(partition by username order by startDate) as l ,row_number() over(partition by username order by startDate) as rn
from UserActivity)
select username,l as activity,startDate,endDate from cte 
where rn = 1

--Question : Get the 2nd most recent activity of a user. If a user has only one activity then that is his recent activity

with cte as(
select *, count(1) over(partition by username) as c, ROW_NUMBER() over(partition by username order by startDate) as n
from UserActivity)
select username,activity,startDate,endDate 
from cte 
where c = 1 or n = 2

/* Explanation:
Step1 : I have used count function to calculate the number of activities done by each user
        and also used Row_number to identify 2nd activity
Step2 : In case if a user is having only one activity ..then we will filter that based on count
        and users who have more than one activity..we can get them by using n(row_number) = 2