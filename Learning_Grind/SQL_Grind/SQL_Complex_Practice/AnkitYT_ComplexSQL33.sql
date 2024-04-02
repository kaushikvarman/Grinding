CREATE TABLE [emp](
 [emp_id] [int] NULL,
 [emp_name] [varchar](50) NULL,
 [salary] [int] NULL,
 [manager_id] [int] NULL,
 [emp_age] [int] NULL,
 [dep_id] [int] NULL,
 [dep_name] [varchar](20) NULL,
 [gender] [varchar](10) NULL
) ;
insert into emp values(1,'Ankit',14300,4,39,100,'Analytics','Female')
insert into emp values(2,'Mohit',14000,5,48,200,'IT','Male')
insert into emp values(3,'Vikas',12100,4,37,100,'Analytics','Female')
insert into emp values(4,'Rohit',7260,2,16,100,'Analytics','Female')
insert into emp values(5,'Mudit',15000,6,55,200,'IT','Male')
insert into emp values(6,'Agam',15600,2,14,200,'IT','Male')
insert into emp values(7,'Sanjay',12000,2,13,200,'IT','Male')
insert into emp values(8,'Ashish',7200,2,12,200,'IT','Male')
insert into emp values(9,'Mukesh',7000,6,51,300,'HR','Male')
insert into emp values(10,'Rakesh',8000,6,50,300,'HR','Male')
insert into emp values(11,'Akhil',4000,1,31,500,'Ops','Male')

--Q: Write an SQL query to find details of employees with 3rd highest salary in each department
--   in case there are less then 3 employees in a dept then return emp details with
--   lowest salry in that dep
select * from emp;


with cte as(
select *,rank() over(partition by dep_id order by salary desc) as ran,
count(1) over(partition by dep_id) as cnt
from emp)
select * from cte
where ran = 3 or (cnt<3 and cnt=ran)

/* Explanation:
Step1 : To get the 3rd highest salary from each department we just use rank() function and
        retrieve row where rank = 3
Step2 : To get the emp_details with lowest salary in that dept..we have used count() window
        function on each dept_id
Step3 : Now Wer ever the count = rank then that is the row of emp details with the lowest salary
        in that dep
Step4 : "where ran = 3 or (cnt<3 and cnt=ran)" now we use this filter and get the required 
        output
    