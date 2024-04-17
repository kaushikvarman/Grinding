create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success')


select * from tasks;

with cte as(
select *, ROW_NUMBER() over(partition by state order by date_value) as rn,
dateadd(day,-1*row_number() over(partition by state order by date_value),date_value) as base_date
from tasks)
select state,min(date_value) as start_date,max(date_value) as end_date
from cte 
group by base_date,state
order by start_date

/* Explanation:
Step 1: First we have used row number and partitioned by state to get numbers
Step 2: Next we have used dateadd function and used rn to get the same date
we have subtracted the date with its corresponding rn.
Step 3: Used group by with aggregate functions to get the result