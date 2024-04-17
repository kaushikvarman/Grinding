CREATE TABLE [dbo].[int_orders](
 [order_number] [int] NOT NULL,
 [order_date] [date] NOT NULL,
 [cust_id] [int] NOT NULL,
 [salesperson_id] [int] NOT NULL,
 [amount] [float] NOT NULL
) ON [PRIMARY];

INSERT INTO [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (30, CAST('1995-07-14' AS Date), 9, 1, 460);

INSERT into [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (10, CAST('1996-08-02' AS Date), 4, 2, 540);

INSERT INTO [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (40, CAST('1998-01-29' AS Date), 7, 2, 2400);

INSERT INTO [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (50, CAST('1998-02-03' AS Date), 6, 7, 600);

INSERT into [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (60, CAST('1998-03-02' AS Date), 6, 7, 720);

INSERT into [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (70, CAST('1998-05-06' AS Date), 9, 7, 150);

INSERT into [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (20, CAST('1999-01-30' AS Date), 4, 8, 1800);

select * from int_orders
select * from int_orders

--FInd the largest order by value for each salesperson and display order details
--Do not use CTE,Subqueries,Window FUnc,temp tables


select i.order_number,i.order_date,i.cust_id,i.salesperson_id,i.amount from int_orders i
left join int_orders i2 on i.salesperson_id = i2.salesperson_id
group by i.order_number,i.order_date,i.cust_id,i.salesperson_id,i.amount
having i.amount >= max(i2.amount)

/* Explanation:
Step1 : Here we have used left self join 
Step2 : Then used left table coloumns and performed group by 
Step3 : Used having filter to filter the amount from 2 tables
