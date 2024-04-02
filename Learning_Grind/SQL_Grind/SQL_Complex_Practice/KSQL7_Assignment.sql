--Assignment - 7



--1  write a query to produce below output from icc_world_cup table.
--team_name, no_of_matches_played , no_of_wins , no_of_losses

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup

(select team_1 as team_name,count(Team_1) + count(Team_2) as no_of_matches_played
from icc_world_cup
group by Team_1)
union all
(select winner,count(winner) as a
from icc_world_cup
group by winner)

select team_1,count(winner) as n
from icc_world_cup
group by Team_1



with all_teams as 
(select team_1 as team, case when team_1=winner then 1 else 0 end as win_flag from icc_world_cup
union all
select team_2 as team, case when team_2=winner then 1 else 0 end as win_flag from icc_world_cup)
select team,count(1) as total_matches_played , sum(win_flag) as matches_won,count(1)-sum(win_flag) as matches_lost
from all_teams
group by team


--2-write a query to print first name and last name of a customer using orders table(everything after first space can be considered as last name)
--customer_name, first_name,last_name

select customer_name,Substring(customer_name,1,CharIndex(' ',customer_name)) as F_name,SubString(customer_name,
CharIndex(' ',customer_name),len(customer_name)-CharIndex(' ',customer_name)+1) as S_name
from orders


--3- write a query to print below output using drivers table. Profit rides are the no of rides where end location of a ride is same as start location of immediate next ride for a driver

--drivers_table
create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));

insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');

select * from drivers

select id,count(1) as total_rides,sum(case when en
from drivers
group by id

select id, count(1) as total_rides
,sum(case when end_loc=next_start_location then 1 else 0 end ) as profit_rides
from (
select *
, lead(start_loc,1) over(partition by id order by start_time asc) as next_start_location
from drivers) A
group by id;

--4-write a query to print customer name and no of occurence of character 'n' in the customer name.
--customer_name , count_of_occurence_of_n

select customer_name,len(customer_name)-len(replace(LOWER(Customer_name),'n','')) as count_of_n
from Orders



--6-the first 2 characters of order_id represents the country of order placed . write a query to print total no of orders placed in each country
select top 100 order_id from Orders

select SUBSTRING(order_id,1,2) as Country,count(distinct order_id) from orders 
group by SUBSTRING(order_id,1,2)

select left(order_id,2) as country, count(distinct order_id) as total_orders
from orders 
group by left(order_id,2)
select * from orders


--%%%%%%%%%%%%%%%%%%%%%%
select * from drivers
select * from drivers

select *
from drivers d1
inner join drivers d2 on d1.id = d2.id and d1.end_loc = d2.start_loc and d1.end_time = d2.start_time
--group by d1.id 

create table sample(
id int,
name1 varchar(20),
phoneNUM varchar(20),
)

insert into sample values(1,'kaushik','23212321')
insert into sample values(2,'kaushik','23212321')
insert into sample values(3,'kaushik','23212321')

select * from sample s1
inner join sample s2 on s1.id = s2.id

select * from sample
select * from sample