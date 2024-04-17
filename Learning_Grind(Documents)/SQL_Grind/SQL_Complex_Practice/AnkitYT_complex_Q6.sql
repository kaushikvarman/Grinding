/* write a query to find PersonID, Name, number of friends, sum of marks
of person who have friends with total score greater than 100. */

select * from Person$;

select * from Friend$;

with cte as(
select F.PersonID as person, F.FriendID ,P.* from Friend$ F 
left join Person$ p on F.FriendID = p.PersonID),
cte2 as(
select person, count(FriendID) as no_of_frnds, sum(Score) as total_score
from cte 
group by person
having sum(Score) > 100)
select c.*,P.Name from cte2 c 
left join Person$ P on c.person = P.PersonID

/*
Explanation:
Step 1: I joined Friend table and person table on FriendID of Friend table and
PersonID of Person table, to get each person's friend Score and Framed it as a 
table using CTE
Step 2: Found each person's friends and their scores > 100 using aggregate 
function and group by and got all the details except name
Step 3: Finally joined cte2 result with name of Person Table to get the requiered
Output.
**This can be done using one CTE too.
*/
