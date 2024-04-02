
select * from trips
select * from Users
/* write an SQL query to find the cancellation rate of requests with unbanned users
each day between "2013-10-01" and "2013-10-03".
ROund cancellation rate to two decimal points.

the cancellation rate is computed by dividing the number of canceled( by client or driver)
requests with unbanned users by the total number of requests with unbanned users on that day
*/


select request_at, count(case when status in('cancelled_by_client','cancelled_by_driver') then 1 else null end) as cancelled_trips,
count(1) as total_rides,
1.0*count(case when status in('cancelled_by_client','cancelled_by_driver') then 1 else null end)/
count(1)*100 as cancellation_ratio
from trips t
inner join users u on t.client_id = u.users_id
inner join users u1 on t.driver_id = u1.users_id
where u.banned != 'Yes' and u1.banned='No'
group by request_at

/* Explanation : 
Step 1: First we have used joins to combine the trips table with users_id(clients) and trips table with users_id(drivers)
used two inner joins to combine them and filtered the banned clients and banned drivers
Step 2: Next used aggregate functions with case when and found cancelled_trips and total_rides
Step 3: Calculating cancellation ratio using the aggregate values. 


