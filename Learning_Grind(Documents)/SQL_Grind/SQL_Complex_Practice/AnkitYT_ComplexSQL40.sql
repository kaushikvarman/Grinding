create table students
(
student_id int,
student_name varchar(20)
);
insert into students values
(1,'Daniel'),(2,'Jade'),(3,'Stella'),(4,'Jonathan'),(5,'Will');

create table exams
(
exam_id int,
student_id int,
score int);

insert into exams values
(10,1,70),(10,2,80),(10,3,90),(20,1,80),(30,1,70),(30,3,80),(30,4,90),(40,1,60)
,(40,2,70),(40,4,80);

select * from students
select * from exams;

with cte as(
select e.*,s.student_name from exams e
left join students s on e.student_id = s.student_id),
cte2 as(
select *,rank() over(partition by exam_id order by score) as rnk from cte)
--select * from cte
select student_id
from cte2 
where rnk = 2
group by student_id ;

with all_scores as(
select exam_id,min(score) as min_score,max(score) as max_score 
from exams
group by exam_id)
select e.student_id

from exams e 
inner join all_scores on e.exam_id = all_scores.exam_id
group by student_id
having max(case when score = min_score or score = max_score then 1 else 0 end) = 0






