create table users1 (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));

 create table orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );


 insert into users1 values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

 insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

 insert into orders values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
 ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);

 /* write an SQL query to find for each seller, whether the brand of the second item(by date) they sold
 is their favorite brand.
 if a sellet sold less than two items, report the answer for that seller as no. o/p
seller id  2nd_item_fav_brand
 1              yes/no
 2              yes/no
 */


 with cte as(
 select *,rank() over(partition by seller_id order by order_date) as rn
 from orders)
 select u.user_id,case when i.item_brand = u.favorite_brand then 'yes'
 else 'no' end as second_fav
 from users1 u
 left join cte c on c.seller_id = u.user_id and rn=2
 left join items i on c.item_id = i.item_id
 order by u.user_id
 
 /* Explanation:
Step 1: First we have used rank() to find 2nd most fav brand
Step 2: Next we left join Users table with CTE to get all the users 
where rn = 2
Step 3: Next we used left join with items table and used case when
to match the item_brand and favorite_brand 
Step 4: Finally selected the columns required for the output.