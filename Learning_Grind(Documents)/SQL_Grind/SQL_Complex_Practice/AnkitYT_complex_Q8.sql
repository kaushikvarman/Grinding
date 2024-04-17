create table players
(player_id int,
group_id int)

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);



create table matches1
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int)

insert into matches1 values (1,15,45,3,0);
insert into matches1 values (2,30,25,1,2);
insert into matches1 values (3,30,15,2,0);
insert into matches1 values (4,40,20,5,2);
insert into matches1 values (5,35,50,1,1);

/* 
Q: Write an SQL query to find the winner in each group
-> The winner in each group is the player who scored the maximum total points
within the group. In the case of a tie, the lowest player_id wins.
*/

select * from matches1
select * from players;

/* 
Q: Write an SQL query to find the winner in each group
-> The winner in each group is the player who scored the maximum total points
within the group. In the case of a tie, the lowest player_id wins.
*/

with cte as(
select first_player as player_id, first_score as score from matches1
union all
select second_player , second_score from matches1),
final_scores as(
select p.group_id, c.player_id,sum(score) as score
from cte c
inner join players p on c.player_id = p.player_id
group by p.group_id,c.player_id)
select *,rank() over(partition by group_id order by score desc,player_id) as rn
from final_scores

/* Explanation :
Step 1: First we have found scores of first_player and second_player using union all
Step 2: Next we used aggregate,inner join and group by function to find score of each player in the group
Step 3: to find the player with max score we used rank() function