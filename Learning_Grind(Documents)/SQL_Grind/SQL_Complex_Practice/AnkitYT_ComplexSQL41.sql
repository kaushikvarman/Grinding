create table phonelog(
    Callerid int, 
    Recipientid int,
    Datecalled datetime
);

insert into phonelog(Callerid, Recipientid, Datecalled)
values(1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000');

--Q: Write an SQL query to find out callers whose first and last call was to same 
--   person on a given day

select * from phonelog;



with cte as(
select Callerid,Recipientid,concat(month(datecalled),'-',day(datecalled)) as dat,row_number() over(partition by callerid,concat(month(datecalled),'-',day(datecalled)) 
order by Callerid,Datecalled) as rn1 from phonelog )
--select * from cte
,cte2 as(
select callerid,dat,min(rn1) as min1,max(rn1) as max1
from cte
group by callerid,dat)
select c1.callerid,c1.recipientid from cte c1 
inner join cte2 c2 on c1.Callerid = c2.Callerid and c1.dat = c2.dat 
and (c1.rn1 = c2.min1 or c1.rn1 = c2.max1)
group by c1.Callerid,c1.Recipientid
having count(1) > 1;

/* Explanation:
Step1 : First I have retrieved date and month and gave a row_number 
        partitioned by caller_id and dat and framed it in one cte
Step2 : Now I have retrived min of rn and max of rn for each caller_id
        on a given date(min of rn gives us the first call and max of rn
		gives us the last call made by callerid) and framed in cte2 
Step3 : Now I have joined cte1 and cte2 on inner join cte2 c2 on 
        c1.Callerid = c2.Callerid and c1.dat = c2.dat 
        and (c1.rn1 = c2.min1 or c1.rn1 = c2.max1) 
Step4 : Next group by on caller_id and recipient_id, now if a caller_id
        made first and last call to same recipient..then their count would be
		two and we retrieve them.








