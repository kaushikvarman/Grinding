create table activity(
player_id int,
device_id int,
event_date date,
games_P int
)

insert into activity(player_id,device_id,event_date,games_P)
values (1,2,'2016-03-01',5),(1,2,'2016-05-02',6),(2,3,'2017-06-25',1),(3,1,'2016-03-02',0),(3,4,'2018-07-03',5);

select * from activity;

with cte as(
select *,lead(event_date,1) over(partition by player_id order by player_id) as p from activity)
select player_id,device_id from cte 
where event_date < p

with cte as(
select *,rank() over(partition by player_id order by event_date) as ran from activity)
select player_id,device_id 
from cte 
where ran = 1


select * from activity;

with cte as(
select player_id, min(event_date) as min1, max(event_date) as max2 from activity
group by player_id),
cte2 as(
select *,DATEDIFF(day,max2,min1)+63 as con from cte)
select sum(case when con = 1 then 1 else 0 end)*100/(select count(player_id) from cte2)from cte2 
	
select 100/3 






















select * from cinema

select *,lead(free,1,free) over( order by seat_id) as c from cinema

select *,count(free) over(partition by free order by seat_id) from cinema















select *, lag(free,1) over(order by seat_id) as lag1,lag(free,2) over
(order by seat_id) as lag2 from cinema

select *, lag(seat_id,1) over(order by seat_id) from cinema



select *, sum(free) over(order by seat_id) from cinema
