create table brands 
(
category varchar(20),
brand_name varchar(20)
);
insert into brands values
('chocolates','5-star')
,(null,'dairy milk')
,(null,'perk')
,(null,'eclair')
,('Biscuits','britannia')
,(null,'good day')
,(null,'boost');

--Q: Write a SQL query to populate category values to the last not null value
select * from brands;

with cte1 as(
select *,ROW_NUMBER() over(order by (select null)) as rn from brands),
cte2 as(
select *,lead(rn,1,999) over(order by rn) as next_rn from cte1
where category is not null)
select c2.category,c2.brand_name from cte1 c1
inner join cte2 c2 on c1.rn>=c2.rn and c1.rn<=c2.next_rn 

/* Explanation:
Step1 : First we have generated a row number for each row(We didnt have any
        over by column to give row number) so we used "order by (select null)"
		which generates row_number for each row in the table
Step2 : After generating rn, we retreive rows where category is not null
Step3 : Now we use lead(rn,1,999) to get the next_rn(which is biscuits) and use 
        this next_rn as range in inner join
Step4 : Next we join cte1 and cte2 where cte1.rn's range is between cte2.rn and
        cte2.next_rn(biscuits)