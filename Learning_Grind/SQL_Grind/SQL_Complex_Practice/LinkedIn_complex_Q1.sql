
with cte as(
select *, rank() over(partition by cid order by fid) as rn from flights)
select * from cte 

select * from flights f
inner join flights f1 on f.cid = f1.cid 

select * from flights 

create table flights1(
cust_id int,
flight_id VARCHAR(20),
origin VARCHAR(20),
destination VARCHAR(20)
)

insert into flights1(cust_id,flight_id,origin,destination)
values(1, 'Flight2', 'Goa', 'Kochi'),
(1, 'Flight1', 'Delhi', 'Goa'),
(1, 'Flight3', 'Kochi', 'Hyderabad'),
(2, 'Flight1', 'Pune', 'Chennai'),
(2, 'Flight2', 'Chennai', 'Pune'),
(3, 'Flight1', 'Mumbai', 'Bangalore'),
(3, 'Flight2', 'Bangalore', 'Ayodhya'),
(4, 'Flight1', 'Ahmedabad', 'Indore'),
(4, 'Flight2', 'Indore', 'Kolkata'),
(4, 'Flight3', 'Ranchi', 'Delhi'),
(4, 'Flight4', 'Delhi', 'Mumbai');

--Q: Find customer's origin and destination from his iternary given in the table 
select * from flights1;

with cte as(
select *,rank() over(partition by cust_id order by flight_id) as rn from flights1)
,cte2 as(
select cust_id,min(rn) as min,max(rn) as max from cte 
group by cust_id)
,cte3 as(
select c1.cust_id,c1.origin,c1.destination ,lead(destination,1) over(partition by c1.cust_id order by flight_id) as dest
,rank() over(partition by c1.cust_id order by flight_id) as rnk
from cte2 c2
left join cte c1 on c2.cust_id = c1.cust_id and c2.min = c1.rn or c2.cust_id = c1.cust_id and c2.max = c1.rn)
select cust_id,origin, dest 
from cte3
where rnk = 1






