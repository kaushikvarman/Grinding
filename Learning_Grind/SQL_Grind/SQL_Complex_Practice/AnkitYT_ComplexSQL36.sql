create table movie(
seat varchar(50),occupancy int
);
insert into movie values('a1',1),('a2',1),('a3',0),('a4',0),('a5',0),('a6',0),('a7',1),('a8',1),('a9',0),('a10',0),
('b1',0),('b2',0),('b3',0),('b4',1),('b5',1),('b6',1),('b7',1),('b8',0),('b9',0),('b10',0),
('c1',0),('c2',1),('c3',0),('c4',1),('c5',1),('c6',0),('c7',1),('c8',0),('c9',0),('c10',1);

--Q : Write a SQL query to find four consecutive empty seats in the theatre
select * from movie;

with cte as(
select seat,left(seat,1)as seat1,cast(SUBSTRING(seat,2,3) as int) as num,occupancy from movie),
cte2 as(
select *,max(occupancy) over(partition by seat1 order by num rows between current row and 3 following)
as is_4_empty,
count(occupancy) over(partition by seat1 order by num rows between current row and 3 following)
as cnt from cte ),
cte3 as(
select * from cte2 
where is_4_empty = 0 and cnt = 4)
select cte2.seat,cte2.occupancy from cte2
inner join cte3 on cte2.seat1 = cte3.seat1 and cte2.num between cte3.num and cte3.num+3

/* Explanation:

Step1 : First we will separate row and seat number using left and substring function
        also we will convert seat number to int and framed it in cte1
Step2 : Next we will use running aggregation function.. here we used max(occupancy) 
        in the window of four rows
Step3 : Also we will find count of rows which helps us indicating how many rows are
        there consecutively and framed it in a cte2
Step4 : Now we will retrieve rows where is_4_empty = 0 and cnt = 4 ...which gives us
        the starting seat number where there are 4 consecutive empty seats and framed 
		it in cte3
Step5 : Now we will use inner join on cte3 and cte2 on cte2.seat1 = cte3.seat1 and
        cte2.num is in between cte3.num and cte3.num+3
		See the code and get intuition
