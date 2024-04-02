create table tbl_orders (
order_id integer,
order_date date
);
insert into tbl_orders
values (1,'2022-10-21'),(2,'2022-10-22'),
(3,'2022-10-25'),(4,'2022-10-25');

select * from tbl_orders

select * into tbl_orders_copy from tbl_orders --Creating a snapshot of the table


insert into tbl_orders
values (5,'2023-10-21'),(6,'2023-10-22');  --inserting two new records

delete from tbl_orders where order_id =1   --deleting a record from the original table


select * from tbl_orders_copy
select * from tbl_orders

select coalesce(t1.order_id,t2.order_id) as order_id,
case when t2.order_id is Null then 'I'
     when t1.order_id is Null then 'D'
end as flag
from tbl_orders t1
full outer join tbl_orders_copy t2 on t1.order_id = t2.order_id
where t1.order_id is Null or t2.order_id is Null

/* Explanation:
Step1 : Initially Given a table with sample data of orders with 4 rows
Step2 : Created a snapshot of the table to store a copy of table version
Step3 : Inserted two new rows in the original table and deleted one row from
        the original table
Step4 : Task is to find the delta's of these two tables
Step5 : Used full outer join to get the details from the both the tables
Step6 : Now if a t2.order_id null then it indicates that we have inserted rows
Step7 : And if t1.order_id null then it indicates that we've deleted a row
Step8 : Just see the code and get intuition


