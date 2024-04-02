

select top 5 * 
from orders 
order by order_date desc


select distinct top 5 Customer_name from orders
order by Customer_Name 

select Customer_name from orders

select * from orders

--filters-- 

select * from orders
where Ship_Mode = 'First Class'

select * from orders
where Customer_Name != 'Gene Hale'

select order_date,quantity,Customer_Name from orders
where quantity = 5
order by Order_Date

select * from orders
where Order_Date between '2020-12-08' and '2020-12-12'
order by order_date

--in--

select * from orders 
where ship_mode in('First Class','same day')
order by Ship_Mode

select * from orders
where quantity in(3,5)
order by Quantity

select *, profit/sales as ratio, profit+sales as total,GETDATE()as cdate
from orders

--string matching--
select order_id,order_date,customer_name 
from orders
where customer_name = 'Claire Gute'

--like--
select order_id,order_date,customer_name
from orders 
where Customer_Name like 'C%'

select order_id,customer_name 
from orders 
where Customer_name like 'A%A'

--upper function--
--if we enables case sensitive in MYSQL then this command will be helpful--
select order_id,customer_name ,upper(customer_name) as upper_name
from orders 
where upper(customer_name) like 'A%a';

--wildchar--
select order_id, customer_name 
from orders 
where Customer_Name like '_l%'

select order_id, customer_name 
from orders 
where Customer_Name like 'C[alb]%'
order by Customer_Name

--assignment--
--1Q--
select * from orders
where Customer_Name like '_a_d%'

--2Q-- 
select * from orders 
where Order_Date between '2020-12-01' and '2020-12-31'

--3Q--
select * from orders 
where ship_mode not in('Standard class','First Class') AND Ship_Date > '2020-11-30'

--4Q--
select Customer_Name from orders
where Customer_Name like '[^A]%' or Customer_Name like '%[^n]'
--where Customer_Name not like 'A%n'
order by Customer_Name

--5Q--
select * from orders
where profit < 0

--6Q--
select * from orders 
where profit=0 or Quantity<3

--7Q-- 
select * from orders
where Discount > 0 and region = 'South'

--8Q--
select top 5 * from orders
where Category = 'Furniture'
order by sales desc

--9Q--
select * from orders 
where Category in ('technology','furniture') and Order_Date between '2020-01-01' and '2020-12-31'
order by Order_Date

--10Q--
select * from orders 
where Order_Date between '2020-01-01' and '2020-12-31' and Ship_Date between '2021-01-01' and '2021-12-31'