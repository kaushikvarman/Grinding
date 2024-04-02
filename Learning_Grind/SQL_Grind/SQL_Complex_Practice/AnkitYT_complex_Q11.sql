create table spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);



insert into spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);

/*Question : https://www.youtube.com/watch?v=4MLVfsQEGl0&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=11&ab_channel=AnkitBansal */
select * from spending;
--to get users who purchased only on one platform on a given date
--and to get platform we used max(platform)..as we only have one row
with cte as(
select spend_date,user_id,max(platform) as platform,sum(amount) as amount from spending 
group by spend_date, user_id
having count(distinct(platform))= 1
union all --using union all to combine the user's who ordered from single 
          --single device and users who ordered on both devices
select spend_date,user_id,'both' as platform,sum(amount) as amount from spending 
group by spend_date, user_id
having count(distinct(platform))= 2
union all --used duplicate record for getting output
select distinct spend_date,null as user_id,'both' as platform, 0 as amount
from spending)
select spend_date, platform,sum(amount) as total_amount,count(distinct user_id) as total_users
from cte 
group by spend_date,platform
order by spend_date,platform desc