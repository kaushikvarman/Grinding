create table call_details  (
call_type varchar(10),
call_number varchar(12),
call_duration int
);

insert into call_details
values ('OUT','181868',13),('OUT','2159010',8)
,('OUT','2159010',178),('SMS','4153810',1),('OUT','2159010',152),('OUT','9140152',18),('SMS','4162672',1)
,('SMS','9168204',1),('OUT','9168204',576),('INC','2159010',5),('INC','2159010',4),('SMS','2159010',1)
,('SMS','4535614',1),('OUT','181868',20),('INC','181868',54),('INC','218748',20),('INC','2159010',9)
,('INC','197432',66),('SMS','2159010',1),('SMS','4535614',1);

select * from call_details;

/* Q: Write a Sql query to determine phone numbers that satisfy below conditions
1- the numbers have both incoming and outgoing cals
2- sum of duration of outgoing calls is greater than incoming calls
*/
with cte as(
select call_number,
sum(case when call_type='OUT' then call_duration end) as out_duration,
sum(case when call_type='INC' then call_duration end) as in_duration
from call_details
group by call_number)
select call_number 
from cte
where out_duration is not null and in_duration is not null and out_duration>in_duration
/* Explanation:
Step1 : Here first we will select call_number and its call types using case when
Step2 : Now we will use group by on call_numbers and calculate total duration of
        outgoing and incoming calls of a call_number
Step3 : In the last we will select the call_number using a where filter */



