create table namaste_python (
file_name varchar(25),
content varchar(200)
);



insert into namaste_python values ('python bootcamp1.txt','python for data analytics 0 to hero bootcamp starting on Jan 6th')
,('python bootcamp2.txt','classes will be held on weekends from 11am to 1 pm for 5-6 weeks')
,('python bootcamp3.txt','use code NY2024 to get 33 percent off. You can register from namaste sql website. Link in pinned comment')

--Q : Find the words which are repeating more than once considering all the 
--    rows of content column
select * from namaste_python



select value as word,count(*) as word_count 
from namaste_python
cross apply string_split(content,' ')
group by value
having count(*) > 1 
order by word_count desc



/* Explanation:
step1 : Lets learn a new function here which is string split
Step2 : Its splits the entire string which we pass inside the string split
        function..Actually it is tabular function
		Example : select * from string_split("it it was a gadidha",' ')
		so here it splits the string on ' '
Step3 : In our problem we have to use cross apply and give a column name to 
        string_split
Step4 : Later just use group by on word and count word which appears more than 
        once in the strings