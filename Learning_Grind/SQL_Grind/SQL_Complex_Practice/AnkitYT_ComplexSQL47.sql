create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');

--Q : write a query to print total rides and profit rides of each driver
--    profit ride is when end location of current ride is same as start loc of next ride
select * from drivers;

with cte as(
select *,lag(end_loc,1) over(partition by id order by end_loc) as prev_end_loc
from drivers)
--select * from cte 
select id,count(start_loc) as total_rides,sum(case when start_loc = prev_end_loc then 1 else 0 end) as profit_rides
from cte
group by id 


/* Explanation:
Step1 : From the given data we have retrieved prev_end_loc using lag(end_loc,1) and framed
        it in a CTE
Step2 : Now from the cte we select count(start_loc) to get count of total rides
Step3 : When start_loc = prev_end_loc then it is profit ride
Step4 : Next we count the total rides and sum(start_loc = prev_end_loc) to get profit_rides
        grouped by id