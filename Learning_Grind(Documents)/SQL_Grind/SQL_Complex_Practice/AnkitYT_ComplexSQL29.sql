create table event_status
(
event_time varchar(10),
status varchar(10)
);
insert into event_status 
values
('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),('10:08','on'),('10:09','off')
,('10:11','on'),('10:12','off');


select case when status = 'on' then event_time end as login1,case when status='off' then event_time end as logout
,status from event_status

select e1.*,e2.event_time from event_status e1
left join event_status e2 on e1.event_time = e2.event_time

select * from event_status;


with cte as(
select event_time,status+lag(status,1,status) over(order by event_time) as l from event_status)
,cte2 as(
select *,sum(case when l = 'onoff' then 1 else 0 end) over(order by event_time) as rn
from cte)
select min(event_time) as login,max(event_time) as logout,count(1)-1 as onCount
from cte2 
group by rn 

/* Explanation:
Step1 : Get previous status using lag 
Step2 : In order to create an id for the sequence of on/off, use case within SUM to create a group key. 
        This is basically continuously checking if the order is changing from previous value. 
Step3 : Use the group key(rn to get anything.







