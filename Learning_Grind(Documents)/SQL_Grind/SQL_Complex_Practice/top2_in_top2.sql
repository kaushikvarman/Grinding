create table orders(
  	category varchar(20),
	product varchar(20),
	user_id int , 
  	spend int,
  	transaction_date DATE
);

Insert into orders values
('appliance','refrigerator',165,246.00,'2021/12/26'),
('appliance','refrigerator',123,299.99,'2022/03/02'),
('appliance','washingmachine',123,219.80,'2022/03/02'),
('electronics','vacuum',178,152.00,'2022/04/05'),
('electronics','wirelessheadset',156,	249.90,'2022/07/08'),
('electronics','TV',145,189.00,'2022/07/15'),
('Television','TV',165,129.00,'2022/07/15'),
('Television','TV',163,129.00,'2022/07/15'),
('Television','TV',141,129.00,'2022/07/15'),
('toys','Ben10',145,189.00,'2022/07/15'),
('toys','Ben10',145,189.00,'2022/07/15'),
('toys','yoyo',165,129.00,'2022/07/15'),
('toys','yoyo',163,129.00,'2022/07/15'),
('toys','yoyo',141,129.00,'2022/07/15'),
('toys','yoyo',145,189.00,'2022/07/15'),
('electronics','vacuum',145,189.00,'2022/07/15');

--Q : Find top 2 products in the top 2 categories based on spend amount?
select * from orders;


with cte as(
select *,sum(spend) over(partition by category order by category) as run_sum from orders)
,cte2 as(
select *,dense_rank() over(order by run_sum desc) as rnk from cte)
,cte3 as(
select category,product,sum(spend) as product_sum from cte2
where rnk < 3
group by category,product),
cte4 as(
select *,rank() over(partition by category order by product_sum desc) as rn from cte3)
select category,product from cte4 
where rn < 3 
order by product_sum desc

/* Explanation:
Step1 : First used running sum to find the top categories with highest sum 
Step2 : Next used dense_rank to find the top 2 categories 
Step3 : Found sum category and product where rank < 3 ..which helps us finding
        top products in top 2 categories
Step4 : Used rank on the result from group by and filtered rn < 3 to get 
        top 2 products in top 2 categories

