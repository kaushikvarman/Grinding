CREATE TABLE flights
(
cid VARCHAR(512),
fid VARCHAR(512),
origin VARCHAR(512),
Destination VARCHAR(512)
);

INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f1', 'Del', 'Hyd');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f2', 'Hyd', 'Blr');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f3', 'Mum', 'Agra');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f4', 'Agra', 'Kol');

select * from flights;

with cte as(
select *,row_number() over(partition by cid order by cid) as OriDes from flights);

with cte as(
select *, Lead(Destination,1) over(partition by cid order by cid) as destination1 from flights  )
select cid,origin,destination1 
from cte 
where destination1 is not null

CREATE TABLE sales 
(
 order_date date,
 customer VARCHAR(512),
 qty INT
);

INSERT INTO sales (order_date, customer, qty) VALUES ('2021-01-01', 'C1', '20');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-01-01', 'C2', '30');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-02-01', 'C1', '10');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-02-01', 'C3', '15');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-03-01', 'C5', '19');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-03-01', 'C4', '10');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-04-01', 'C3', '13');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-04-01', 'C5', '15');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-04-01', 'C6', '10');

select * from sales
select * from sales

select left(Datename(month,order_date),3)+right(year(order_date),2) as YM,count(customer) as count from sales
group by left(Datename(month,order_date),3)+right(year(order_date),2) 

select distinct(customer)
from sales 
group by customer

select *,rank() over(order by customer,order_date) from sales

SELECT DATENAME(MONTH, DATEADD(MONTH, 3, '2020-12-01')) AS 'Month Name'

with cte as(
select cid,origin,
lead(destination)over(partition by cid order by fid) as destination
from flights
)
select cid,origin,destination from cte 
where destination is not null

--select cid, case when OriDes = Min(OriDes) then origin end as origin,
--            case when OriDes = Max(OriDes) then destination end as destination from cte 
--group by cid
			