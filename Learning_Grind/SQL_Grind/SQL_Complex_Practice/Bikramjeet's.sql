create table sample1(
FNAME varchar(200),
LNAME varchar(200),
Addr varchar(200),
Lastline Varchar(200),
DTADDED Varchar(200),
ID int
)

insert into sample1(FNAME,LNAME,Addr,Lastline,DTADDED,ID)
values('Paul','Smith','1234 Adams
Road','New York 12345','2023101', 1),
('Tina','Waters','5678 Peach
Street','New York, NY
12345','20220510',2),
('Mark',' ','2345 Gordon
Road','New York, NY
12345','20060305',3),
('Jeanna','Mitchell','6789 Woods Strret','New York, NY
12345','20180309',4)


create table sample2(
FNAME varchar(200),
LNAME varchar(200),
Lastline Varchar(200),
ID int
)

insert into sample2(FNAME,LNAME,Lastline,ID)
values('Janet','Smith','2023101',10),
('Tina','Waters','20220510',20),
('Mark','Brown','20060305',30),
('Jeanna','Mitchell','20160309',40)

select * from sample1
select * from sample2

/* Question #2: Write a join command using any language (SQL preferred) that will find names that do not
match in both tables and combine them into 1 output. Please use Sample dataset 1 and Sample dataset
2 for this question. Please also show what the final output would be.
*/

select * from sample1 s
inner join sample2 s2 on s.FNAME != s2.FNAME and s.Lname != s2.LNAME

/* ISSUES with the data:
1. The ID's column does not match with the same names of two tables
2. The Datepart of janet smith and paul smith is out of date format
*/

select * from sample1 s
inner join sample2 s2 on s.FNAME = s2.FNAME

select FNAME,LNAME,DTADDED,ID from sample1
where FNAME not in(Select FNAME from sample2)  --LNAME not in(select LNAME from sample2) 
union
select * from sample2
where FNAME not in(Select FNAME from sample1)








