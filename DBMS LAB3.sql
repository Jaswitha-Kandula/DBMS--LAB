USE taxation_db;
show tables;
select * from financial_year;
select * from income_category;
select * from income_record;
select * from taxpayer;
select full_name, upper(full_name) as name_upper from taxpayer;
select occupation, lower(occupation) as occupation_lower from taxpayer;
select full_name, length(full_name) as name_length from taxpayer;
select pan_number, left(pan_number,4) as pan_first4 from taxpayer;
select concat(full_name,'-', occupation) as name_occupation from taxpayer;
select category_name, replace(category_name, 'Income', 'Inc.') as category_short from income_category;
select full_name, trim(full_name) as trimmed_name from taxpayer;
select full_name,
    case
    when instr(full_name,' ')= 0 then full_name
    else substring(full_name,1,instr(full_name, ' ')-1)
    end as first_name
from taxpayer;
select concat('taxpayer: ', full_name, char(10), 'occupation : ',occupation) as taxpayer_display from taxpayer;
select full_name, pan_number from taxpayer where left(pan_number,2)='AP';

/*part c */
select full_name , annual_income, round(annual_income) as rounded_income from taxpayer;
select full_name, annual_income, abs(annual_income -500000) as abs_diff from taxpayer;
select full_name,annual_income, power(annual_income,2) as income_squared from taxpayer;
select full_name,annual_income, mod(annual_income,1000) as remaider from taxpayer;
select full_name,annual_income, round(annual_income,2) as rounded_2dp from taxpayer;
select full_name,annual_income, ceil(annual_income) as ceiling_value, floor(annual_income) as floor_value from taxpayer;
select floor(1+ rand() *100) as random_integer;
select full_name, floor(1 + rand() * 100) as random_integer from taxpayer;
select full_name, annual_income, sqrt(annual_income) as income_sqrt from taxpayer;
select full_name, annual_income, annual_income * 1.10 as income_after_increment from taxpayer;

/*part d */

select curdate() as todays_date;
select now() as currnt_date_time;
select start_date, year(start_date) as start_year from financial_year;
select start_date, month(start_date) as start_month from financial_year;
select start_date, day(start_date) as start_day from financial_year;
select start_date , date_add(start_date, interval 1 year) as calculated_end_date from financial_year;
select start_date, date_add(start_date, interval 30 day) as start_plus_30 from financial_year;
select start_date, date_sub(start_date, interval 7 day) as start_minus_7 from financial_year;
select * from financial_year where year(start_date) =year(curdate());

/* part e*/

select full_name, annual_income, cast(annual_income as signed) as income_as_integer from taxpayer;
select taxpayer_id, cast(taxpayer_id as char) as id_as_char from taxpayer;
select start_date, cast(start_date as datetime) as start_date_datetime from financial_year;
select full_name, annual_income, cast(annual_income as decimal(10,2)) as income_as_decimal from taxpayer;
select full_name,annual_income, cast(annual_income as char) as income_as_string from taxpayer;
select full_name, annual_income, cast(annual_income as decimal(10,2)) * 0.10 as calculated_tax from taxpayer;
