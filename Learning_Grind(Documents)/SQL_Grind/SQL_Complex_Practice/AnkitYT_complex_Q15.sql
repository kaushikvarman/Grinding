create table transactions(
order_id int,
cust_id int,
order_date date,
amount int
);

/* Context & Question
Customer retention refers to the ability of a company or product to retain its customers 
over some specified period. High customer retention means customers of the product or business 
tend to return to, continue to buy or in some other way not defect to another product or business,
or to non-use entirely. 
Company programs to retain customers: Zomato Pro , Cashbacks, Reward Programs etc.
Once these programs in place we need to build metrics to check if programs are working or not. 
That is where we will write SQL to drive customer retention count.
*/

--SQL program for retention
--If a same customer orders something in the consecutive month then that customer is retained
select * from transactions

select month(t1.order_date) as month_date, count(distinct t2.cust_id) as customer_retained from transactions t1 
left join transactions t2 on t1.cust_id = t2.cust_id and
Datediff(month,t2.order_date,t1.order_date)=1
group by month(t1.order_date)

/* Explanation:
Step 1: First we have used left join and joined with customer's 2nd month order
Step 2: Later used aggregate function t1's order data and found number of customers
        retained in a month
*/

--Calculting Customer Churn

select month(t2.order_date) as month_date, count(distinct t2.cust_id) as customer_retained from 
transactions t2
left join transactions t1 on t1.cust_id = t2.cust_id and
Datediff(month,t2.order_date,t1.order_date)=1
where t1.cust_id is null
group by month(t2.order_date)

/* Explanation:

Step 1: Here logic is same as previous and we have changed the left join tables
        To calculate the customer's lost
We can say on Month 1 we have lost one customer and in 2nd month we have lost 4 
        customers

