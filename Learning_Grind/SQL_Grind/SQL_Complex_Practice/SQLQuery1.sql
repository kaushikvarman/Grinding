--Write a query in SQL that will give the first employee name starting with a p letter and h letter and the remaining employee names in ascending order.
--Table employee having employee name column

CREATE TABLE Output (
  Name VARCHAR(255)
);


INSERT INTO Output (Name) VALUES
  ('Akram'),
  ('Calling'),
  ('Hazel'),
  ('Peter'),
  ('Basha'),
  ('Harrison'),
  ('Gerard');


select * from output
order by (case when name like 'P%' then 1
              when name like 'H%' then 2 else 3 end),name asc 






--Output:
--Peter
--Harrison
--Hazel
--Akram
--Basha
--Calling
--Gerard