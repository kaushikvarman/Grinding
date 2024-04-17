/* Implementing pareto principle in SQL
pareto principle states that 80% of consequence come from 20% of causes 
examples :
1. 80% of the productivity come from 20% of the employees.
2. 80% of your sales come from 20% of your clients.
3. 80% of decisions in a meeting are made in 20% of the time.
4. 80% of your sales comes from 20% of your products or services.
*/

--Found top 20% selling products
with cte as(
select Product_ID,sum(sales) as product_sales,ROW_NUMBER() over(order by sum(sales) desc) rn  from orders
group by Product_ID)
select Product_ID, sum(product_sales) over(order by product_sales desc) as running_sum ,sum(product_sales) over () as total_sale from cte 
where rn <= (20.0*(select count(1) from cte)/100)

--Explanation(My approach)
/*
Step 1 : First we find the product and its total sale from the past 3 years
and also used row_number to identify top 20% of product_sales and took this result in CTE
Step 2 : Now we find product_id, running sum for our reference and total sum
from the top 20% selling products

*/

--Found products which contributes to overall 80% of products sales
with cte as(
select product_id,sum(sales) as product_sales 
from Orders
group by Product_ID),
cte2 as(
select product_id,product_sales, sum(product_sales) over(order by product_sales desc) as running_total_sum from cte)
select product_id,product_sales,running_total_sum from cte2 
where running_total_sum < (select 0.8 * sum(sales) from orders)


--to find 80% of total_sales
select 0.8*sum(sales) from orders

--Explanation:
/*
step 1 : Similar to the above problem found first we have found each product and its sales for last 3 years 
framed it in one CTE
step 2 : Next calculated running sum of product from cte and placed it in CTE2
step 3 : Now we will retrieve product_id and their running sum where running_sum 
is less than 80% of total sales

