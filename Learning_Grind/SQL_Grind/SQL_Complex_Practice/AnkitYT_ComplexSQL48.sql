create table purchase_history
(userid int
,productid int
,purchasedate date
);
SET DATEFORMAT dmy;
insert into purchase_history values
(1,1,'23-01-2012')
,(1,2,'23-01-2012')
,(1,3,'25-01-2012')
,(2,1,'23-01-2012')
,(2,2,'23-01-2012')
,(2,2,'25-01-2012')
,(2,4,'25-01-2012')
,(3,4,'23-01-2012')
,(3,1,'23-01-2012')
,(4,1,'23-01-2012')
,(4,2,'25-01-2012')
;
--Q : Write a SQL query to find user's who purchased different products on different dates
select * from purchase_history

select *, row_number() over(partition by userid,purchasedate order by userid) as rn 
from purchase_history;

select *, row_number() over(partition by userid,purchasedate order by userid) as rn 
from purchase_history;

select *, lag(productid,1) over(partition by userid order by userid) as la
from purchase_history

select *, lag(productid,1) over(partition by userid,purchasedate order by userid) as la
from purchase_history;

with cte as(
select *, row_number() over(partition by userid,purchasedate order by userid) as rn 
from purchase_history)
select * from cte

select *,max(productid) over(partition by userid,purchasedate order by userid) as m
from purchase_history;

with cte as(
select *,max(productid) over(partition by userid,purchasedate order by userid) as m
from purchase_history)
select c1.*,c2.* from cte c1 
left join cte c2 on c1.userid = c2.userid and c2.productid > c1.productid and c1.purchasedate != c2.purchasedate

select p1.userid from purchase_history p1 
left join purchase_history p2 on p1.userid = p2.userid and p2.productid > p1.productid and p1.purchasedate != p2.purchasedate
where p2.userid is null and p2.productid is null
group by p1.userid
having count(p1.productid) = 1


select p1.*,p2.* from purchase_history p1 
left join purchase_history p2 on p1.userid = p2.userid and p2.productid > p1.productid and p1.purchasedate != p2.purchasedate

select userid,purchasedate,count(productid)
from purchase_history
group by userid,purchasedate

select * from purchase_history;

with cte as(
select *,max(productid) over(partition by userid,purchasedate order by userid) as m
from purchase_history)
select c1.*,c2.* from cte c1
inner join cte c2 on c1.purchasedate < c2.purchasedate and c1.userid = c2.userid

with cte as(
select *,max(productid) over(partition by userid,purchasedate order by userid) as m
from purchase_history)
select c1.*,c2.* from cte c1
left join cte c2 on c1.purchasedate < c2.purchasedate and c1.userid=c2.userid

select userid,purchasedate,count(distinct productid) 
from purchase_history
group by userid,purchasedate
order by userid


select * from purchase_history

select *




select * from purchase_history





select p1.userid from purchase_history p1
left join purchase_history p2 on p1.userid = p2.userid and p1.productid != p2.productid
and p1.purchasedate < p2.purchasedate
group by p1.userid
having count(p1.userid) -1 = count(p2.userid)

/* Explanation:
Step1 : First I have used self left join on p1.userid = p2.usedid and p1.productid != p2.productid
        and p1.purchasedate < p2.purchasedate
Step2 : The self left join lets us compare the product_id from two different purchasedates
Step3 : Now from here we'll select the userid and count(p1.productid)-1 = count(p2.productid) 
        if count(p1.productid)-1 = count(p2.productid)  satisfies then it tells us that userid
		has ordered different products on different dates
*/

/* but ankit solved this question in most efficient way
sol : select userid from purchasehistory
      group by userid
	  having count(purchasedate)>1 and count(productid) = count(distinct productid)
*/
