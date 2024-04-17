create table billings 
(
emp_name varchar(10),
bill_date date,
bill_rate int
);

insert into billings values
('Sachin','01-JAN-1990',25)
,('Sehwag' ,'01-JAN-1989', 15)
,('Dhoni' ,'01-JAN-1989', 20)
,('Sachin' ,'05-Feb-1991', 30)
;

create table HoursWorked 
(
emp_name varchar(20),
work_date date,
bill_hrs int
);
insert into HoursWorked values
('Sachin', '01-JUL-1990' ,3)
,('Sachin', '01-AUG-1990', 5)
,('Sehwag','01-JUL-1990', 2)
,('Sachin','01-JUL-1991', 4)

select * from billings
select * from HoursWorked

select * from billings b
right join HoursWorked h on b.emp_name = h.emp_name and b.bill_date < h.work_date

--Question : Calculate total charges as per billing rate

with cte as(
select *, lead(dateadd(day,-1,bill_date),1,'9999-12-31') over(partition by emp_name order by bill_date) as b 
from billings)
select hw.emp_name,sum(c.bill_rate* hw.bill_hrs) as pay from cte c
inner join HoursWorked hw on hw.emp_name = c.emp_name
and hw.work_date between c.bill_date and c.b 
group by hw.emp_name

/* Explanation:
Step 1: We have used lead function to compare the dates while joining with HW table
        and used '9999-12-31' to avoid issues with null value
Step 2: And used dateadd(day,-1,bill_date) to exclude the date where an emp_name has
        got salary increment
Step 3: Then used inner join and joined tables on emp_name and workdate ...next used
        group by and sum function to get the answer
