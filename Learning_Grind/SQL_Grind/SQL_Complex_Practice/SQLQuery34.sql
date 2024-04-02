select * from employee

with A as
(select *,
ROW_NUMBER() over(partition by dept_id order by salary desc) as rnk
from employee)
select *
from A 
where rnk = 3
union
