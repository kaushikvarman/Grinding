create table covid(city varchar(50),days date,cases int);

insert into covid values('DELHI','2022-01-01',100);
insert into covid values('DELHI','2022-01-02',200);
insert into covid values('DELHI','2022-01-03',300);

insert into covid values('MUMBAI','2022-01-01',100);
insert into covid values('MUMBAI','2022-01-02',100);
insert into covid values('MUMBAI','2022-01-03',300);

insert into covid values('CHENNAI','2022-01-01',100);
insert into covid values('CHENNAI','2022-01-02',200);
insert into covid values('CHENNAI','2022-01-03',150);

insert into covid values('BANGALORE','2022-01-01',100);
insert into covid values('BANGALORE','2022-01-02',300);
insert into covid values('BANGALORE','2022-01-03',200);
insert into covid values('BANGALORE','2022-01-04',400);

--Q: Find Cities where the covid cases are increasing continously
select * from covid;

with cte as(
select *,rank() over(partition by city order by days) as rd,
rank() over(partition by city order by cases) as cd
from covid)
select city--count(case when rd = cd then 1 end) as c,count(city)
from cte 
group by city
having count(case when rd = cd then 1 end) = count(city)

/* Explanation:
Step 1: Task is to find cities where covid cases are increasing daily
Step 2: Used rank() on days and cases..and framed in CTE
Step 3: Now we will find cities where ranks of days and cases are equal to 
        count(city)


select *,rank() over(partition by city order by days,cases) as cd
from covid

select *,rank() over(partition by city order by cases) as cd from covid