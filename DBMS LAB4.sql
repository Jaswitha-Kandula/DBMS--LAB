use taxation_db;
show tables;
select t.full_name, ir.income_source from taxpayer t inner join income_record ir on t.taxpayer_id=ir.taxpayer_id;

select t.full_name, ic.category_name from taxpayer t inner join income_record ir on t.taxpayer_id=ir.taxpayer_id inner join income_category ic on ic.category_id=ic.category_id;

select ir.income_id, fy.year_label from income_record ir inner join financial_year fy on ir.financial_year=fy.year_id;

select t.full_name, t.annual_income, ir.amount
from taxpayer t inner join income_record ir on t.taxpayer_id=ir.taxpayer_id;

select t.full_name, ir.income_source, ic.category_name, fy.year_label
from taxpayer t inner join income_record ir on t.taxpayer_id=ir.taxpayer_id inner join income_category ic on ir.income_id=ic.category_id inner join financial_year fy on ir.financial_year=fy.year_id;

 --  level2

select t.full_name, ir.income_source
from taxpayer t inner join income_record ir on t.taxpayer_id=ir.taxpayer_id inner join income_category ic on ir.income_id=ic.category_id 
where ic.category_name='salary';

select t.full_name, t.occupation,ir.income_source
from taxpayer t inner join income_record ir on t.taxpayer_id=ir.taxpayer_id inner join income_category ic on ir.income_id=ic.category_id 
where ic.category_name='business';

SELECT t.full_name,
       fy.start_date,
       fy.end_date
FROM Taxpayer t
INNER JOIN Income_Record ir
ON t.taxpayer_id=ir.taxpayer_id
INNER JOIN Financial_Year fy
ON ir.financial_year=fy.year_id;

SELECT t.full_name,
       ic.category_name,
       ic.description
FROM Taxpayer t
INNER JOIN Income_Record ir
ON t.taxpayer_id=ir.taxpayer_id
INNER JOIN Income_Category ic
ON ir.income_id=ic.category_id;

SELECT t.full_name,
       t.pan_number,
       t.occupation,
       ir.income_source,
       ic.category_name,
       ir.amount,
       fy.year_label,
       fy.start_date,
       fy.end_date
FROM Taxpayer t
INNER JOIN Income_Record ir
ON t.taxpayer_id=ir.taxpayer_id
INNER JOIN Income_Category ic
ON ir.income_id=ic.category_id
INNER JOIN Financial_Year fy
ON ir.financial_year=fy.year_id;

show tables
select * from financial_year;