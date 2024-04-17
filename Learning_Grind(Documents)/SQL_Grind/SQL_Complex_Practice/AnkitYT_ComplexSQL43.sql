create table emp1(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);

insert into emp1
values
(1, 'Ankit', 100,10000, 4, 39)
insert into emp1
values (2, 'Mohit', 100, 15000, 5, 48);
insert into emp1
values (3, 'Vikas', 100, 12000,4,37);
insert into emp1
values (4, 'Rohit', 100, 14000, 2, 16);
insert into emp1
values (5, 'Mudit', 200, 20000, 6,55);
insert into emp1
values (6, 'Agam', 200, 12000,2, 14);
insert into emp1
values (7, 'Sanjay', 200, 9000, 2,13);
insert into emp1
values (8, 'Ashish', 200,5000,2,12);
insert into emp1
values (9, 'Mukesh',300,6000,6,51);
insert into emp1
values (10, 'Rakesh',500,7000,6,50);


--Q: Write an SQL query to list emp_name along with their manager and senior manager
--   name and senior manager is manager's manager

select * from emp1;



select e1.emp_id,e1.emp_name,e2.emp_name as manager,e3.emp_name as sr_manager from emp1 e1
inner join emp1 e2 on e1.manager_id = e2.emp_id
inner join emp1 e3 on e2.manager_id = e3.emp_id

/* Explanation:
Step1 : First to solve anything using self join, run the table twice and find
        which columns to match
Step2 : Next use a inner join to match the required columns
Step3 : See the code and get intuition