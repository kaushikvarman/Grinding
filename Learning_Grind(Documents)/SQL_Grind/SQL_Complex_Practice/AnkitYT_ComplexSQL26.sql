CREATE TABLE subscriber (
 sms_date date ,
 sender varchar(20) ,
 receiver varchar(20) ,
 sms_no int
);
-- insert some values
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Vibhor',10);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Pawan',30);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Pawan',5);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Vibhor',8);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Deepak',50);


select * from subscriber;

--Q : Find total number of messages exchanged between each person per day

with cte as(
select *, case when sender<receiver then sender else receiver end as p1,
case when sender>receiver then sender else receiver end as p2 from subscriber)
select sms_date,p1,p2,sum(sms_no) as s
from cte 
group by sms_date,p1,p2

/* Explanation:
Step1 : First we have used case when and implemented horizonal sort to the 
        get the output ..so that we use group by and aggregate functions
Step2 : Next we will frame this result as cte and as we now have 
        matching sender and receiver(p1 and p2) 
Step3 : Now we can just apply group by and use sum on sms_no to get the
        number of msgs exchanged between two persons






