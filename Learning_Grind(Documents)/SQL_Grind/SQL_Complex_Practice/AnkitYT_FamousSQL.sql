create table customers  (customer_name varchar(30))
insert into customers values ('Ankit Bansal')
,('Vishal Pratap Singh')
,('Michael'); 

--Q : Retrieve first_name,middle_name and last_name from customer_names
select * from customers;

with cte as(
select *,len(customer_name)-len(replace(customer_name,' ','')) as no_of_spaces
,charindex(' ',customer_name) as first_space_position
,charindex(' ',customer_name,charindex(' ',customer_name)+1) as second_space_position
from customers)
select *,
case when no_of_spaces = 0 then customer_name
else SUBSTRING(customer_name,1,first_space_position-1) end as first_name,
case when no_of_spaces <= 1 then null 
else substring(customer_name,first_space_position+1,second_space_position-first_space_position-1) end as middle_name,
case when no_of_spaces = 0 then null 
when no_of_spaces = 1 then SUBSTRING(customer_name,first_space_position+1,len(customer_name)-first_space_position)
when no_of_spaces = 2  then SUBSTRING(customer_name,second_space_position+1,len(customer_name)-second_space_position) end as ln
from cte

/* Explanation:
Step1 : First we have found no_of_spaces in the customer name using len(customer_name)-len(replace(customer_name,' ',''))
        len of customer_name - len of customer_name with out spaces
Step2 : Next We found Index of space in the customer_name using charIndex..we can easily get first_space_position
Step3 : To get the second_space_position if there's any..we use charIndex(' ' ,from first_space_position) and we
        will frame it in one CTE
Step4 : Now if no_of_spaces = 0 then retrieve customer_name as there are no middle and last_name 
        else retrieve substring from (1, first_space_position-1)..this gives us first_name
Step5 : When no_of_spaces <= 1 then null as there are no middle_name..
        else retreive middle_name using substring(customer_name,first_space_position+1,second_space_position-first_space_position-1)
Step6 : When no_of_spaces = 0 then last_name is null
        else when no_of_spaces = 1 then retrieve SUBSTRING(customer_name,first_space_position+1,len(customer_name)-first_space_position)
		gives last_name if there's one space in customer_name
		else when no_of_spaces = 2 then retrieve SUBSTRING(customer_name,second_space_position+1,len(customer_name)-second_space_position)
		gives last_name if there's two space in customer_name