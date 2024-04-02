select * from employee
order by dept_id,salary desc


--row_number()

select *,
ROW_NUMBER() over(order by salary desc) as rn 
from employee

--selecting top 2 salaries on each department
with CTE_par as
(select *,
ROW_NUMBER() over(partition by dept_id order by salary desc,emp_name asc) as rn
from employee)
select *
from CTE_par
where rn<=2


--rank 
select *,
ROW_NUMBER() over(order by salary desc) as rn,
rank() over(order by salary desc) as rnk
from employee


select *,
rank() over(partition by dept_id order by salary desc) as rank
from employee 

--row_number with 2 partition cols
select *,
row_number() over(partition by dept_id,salary order by salary) as rn
from employee

select *,
rank() over(partition by dept_id,salary order by salary) as rnk
from employee

--dense rank
select *, 
DENSE_RANK() over(partition by dept_id order by salary) as drnk
from employee


--printing top 5 selling products from each category by sales

select * from orders

with Cat_sales as
(select category,product_id,sum(sales) as category_sales
from orders 
group by category,product_id ),
cat_sales_2 as (select *,
dense_rank() over(partition by category order by category_sales desc) as ca_sa
from cat_sales) 
select category,product_id,category_sales 
from cat_sales_2 
where ca_sa<=5

--lead 
select *,
lead(salary,1) over(order by salary desc) as lead_emp 
from employee

--partition & lead 

select *,
lead(salary,1) over(partition by dept_id order by salary) as lead_emp
from employee

--lag
 


