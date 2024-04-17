CREATE TABLE STORES (
Store varchar(10),
Quarter varchar(10),
Amount int);

INSERT INTO STORES (Store, Quarter, Amount)
VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);

select * from stores;

--Q : Find the missing quarter for each store

with cte as(
select *, RIGHT(Quarter,1) as Q
--row_number() over(partition by Store order by Quarter) as rn
from STORES)
select Store,'Q'+cast(10-sum(cast(Q as int)) as char(2)) as missing_q
from cte 
group by Store

/* Explanation:
Step 1: So to find the missing quarter ..we have used Right function 
        to trim the given Quarter's
Step 2: As we know total sum of quarters is 10
Step 3: We used group by function on Stores and subtracted 10 from 
        total sum of Trimmed quarters
Step 4: We concatenated with Q to satisfy the output
