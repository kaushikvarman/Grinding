create table exams (student_id int, subject varchar(20), marks int);

insert into exams values (1,'Chemistry',91),(1,'Physics',91)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80)
,(4,'Chemistry',71),(4,'Physics',54);

--Q: Find students with same marks on physics and chemistry
select * from exams

select student_id from exams
where subject in ('Chemistry','Physics')
group by student_id
having count(subject) = 2 and count(distinct marks) = 1

/* Explanation:
Step 1: First have a look at given input
Step 2: Next We will filter the student_id's who have given both
        physics and chemistry Exams
Step 3: Next we use Group by and having clause to find Students
        having count(subject) = 2 and Count(distinct marks) = 1