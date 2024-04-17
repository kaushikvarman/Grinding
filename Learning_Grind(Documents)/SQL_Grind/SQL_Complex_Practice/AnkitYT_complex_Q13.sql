create table orders1
(
order_id int,
customer_id int,
product_id int,
);


insert into orders1 VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

create table products (
id int,
name varchar(10)
);
insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');

--recommendation system based on-product pairs most commonly purchased together
 

select pr1.name+' '+pr2.name as p2,count(1) as purchase_freq from orders1 o1 
inner join orders1 o2 on o1.order_id = o2.order_id
inner join products pr1 on pr1.id = o1.product_id
inner join products pr2 on pr2.id = o2.product_id
where o1.product_id < o2.product_id
group by pr1.name,pr2.name

/* Explanation:
Step 1: First we are using self inner join and elimination duplicates like (1,1)
(2,2),(3,3)(2,1)(3,1) etc..using where
Step 2: Now we have to just apply group by on p1,p2 and count the product pair
Step 3: Next we have joined with products table to get the names of the products
Step 4: Than later concatenated the products names
*/