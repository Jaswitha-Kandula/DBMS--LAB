USE taxation_db;
-- PART A: VERIFY THE EXISTING DATABASE
-- Show all tables in the database
SHOW TABLES;
-- Look at the raw data in every table before summarizing it
SELECT * FROM Taxpayer;
SELECT * FROM Income_Category;
SELECT * FROM Financial_Year;
SELECT * FROM Income_Record;
-- PART B - LEVEL 1: BASIC AGGREGATE FUNCTIONS
-- Task 1: Total number of income records
SELECT COUNT(*) AS total_records
FROM Income_Record;
-- Task 2: Total income amount recorded in the database
SELECT SUM(income_amount) AS total_income
FROM Income_Record;
-- Task 3: Average income amount
SELECT AVG(income_amount) AS average_income
FROM Income_Record;
-- Task 4: Highest income amount recorded
SELECT MAX(income_amount) AS highest_income
FROM Income_Record;

-- Task 5: Lowest income amount recorded
SELECT MIN(income_amount) AS lowest_income
FROM Income_Record;
-- PART B - LEVEL 2: AGGREGATE FUNCTIONS WITH GROUP BY
-- Task 1: Number of income records in each income category
SELECT category_id, COUNT(*) AS number_of_records
FROM Income_Record
GROUP BY category_id;
-- Task 2: Total income for each income category
SELECT category_id, SUM(income_amount) AS total_income
FROM Income_Record
GROUP BY category_id;
-- Task 3: Average income for each income category
SELECT category_id, AVG(income_amount) AS average_income
FROM Income_Record
GROUP BY category_id;
-- Task 4: Highest income recorded in each income category
SELECT category_id, MAX(income_amount) AS highest_income
FROM Income_Record
GROUP BY category_id;
-- Task 5: Lowest income recorded in each income category
SELECT category_id, MIN(income_amount) AS lowest_income
FROM Income_Record
GROUP BY category_id;
-- Task 6: Total income for each financial year
SELECT year_id, SUM(income_amount) AS total_income
FROM Income_Record
GROUP BY year_id;
-- Task 7: Number of income records for each financial year
SELECT year_id, COUNT(*) AS number_of_records
FROM Income_Record
GROUP BY year_id;

-- Task 8: Total income for each income category in each
--         financial year (grouping by TWO columns)
SELECT category_id, year_id, SUM(income_amount) AS total_income
FROM Income_Record
GROUP BY category_id, year_id;
-- PART B - LEVEL 3: HAVING AND ORDER BY WITH GROUP BY
-- Task 1: Income categories whose total income is greater
--         than ₹10,00,000
SELECT category_id, SUM(income_amount) AS total_income
FROM Income_Record
GROUP BY category_id
HAVING SUM(income_amount) > 1000000;
-- Task 2: Income categories whose average income is greater
--         than ₹5,00,000
SELECT category_id, AVG(income_amount) AS average_income
FROM Income_Record
GROUP BY category_id
HAVING AVG(income_amount) > 500000;
-- Task 3: Financial years having more than three income records
SELECT year_id, COUNT(*) AS number_of_records
FROM Income_Record
GROUP BY year_id
HAVING COUNT(*) > 3;

-- Task 4: Income categories in descending order of total income
SELECT category_id, SUM(income_amount) AS total_income
FROM Income_Record
GROUP BY category_id
ORDER BY total_income DESC;

-- Task 5: Income categories whose total income is greater than
--         ₹10,00,000, arranged from highest to lowest
SELECT category_id, SUM(income_amount) AS total_income
FROM Income_Record
GROUP BY category_id
HAVING SUM(income_amount) > 1000000
ORDER BY total_income DESC;
-- Task 6: Total income AND average income for each category
--         (two aggregate functions together)
SELECT category_id,
       SUM(income_amount) AS total_income,
       AVG(income_amount) AS average_income
FROM Income_Record
GROUP BY category_id;
-- Task 7: Category + financial year combination with the
--         highest total income (grouping by two columns,
--         then sorting to bring the highest to the top)
SELECT category_id, year_id, SUM(income_amount) AS total_income
FROM Income_Record
GROUP BY category_id, year_id
ORDER BY total_income DESC;

-- Task 8: Number of taxpayers who have income records in each
--         financial year (JOIN + COUNT + GROUP BY)
SELECT F.financial_year,
       COUNT(DISTINCT I.taxpayer_id) AS number_of_taxpayers
FROM Income_Record I
JOIN Financial_Year F
    ON I.year_id = F.year_id
GROUP BY F.financial_year;
-- SECTION 16: REAL-WORLD TAXATION ANALYSIS
-- Task 1: Income category that generates the highest total
--         income (JOIN used so the name is readable, not just
--         an ID; ORDER BY + LIMIT picks the single top row)
SELECT C.category_name, SUM(I.income_amount) AS total_income
FROM Income_Record I
JOIN Income_Category C
    ON I.category_id = C.category_id
GROUP BY C.category_name
ORDER BY total_income DESC
LIMIT 1;

-- Task 2: Financial year having the highest total recorded income
SELECT F.financial_year, SUM(I.income_amount) AS total_income
FROM Income_Record I
JOIN Financial_Year F
    ON I.year_id = F.year_id
GROUP BY F.financial_year
ORDER BY total_income DESC
LIMIT 1;

-- Task 3: Income category having the highest average income
SELECT C.category_name, AVG(I.income_amount) AS average_income
FROM Income_Record I
JOIN Income_Category C
    ON I.category_id = C.category_id
GROUP BY C.category_name
ORDER BY average_income DESC
LIMIT 1;

-- Task 4: Income categories having more than two income records
SELECT C.category_name, COUNT(*) AS number_of_records
FROM Income_Record I
JOIN Income_Category C
    ON I.category_id = C.category_id
GROUP BY C.category_name
HAVING COUNT(*) > 2;
-- Task 5: Financial years having total income greater than
--         ₹10,00,000
SELECT F.financial_year, SUM(I.income_amount) AS total_income
FROM Income_Record I
JOIN Financial_Year F
    ON I.year_id = F.year_id
GROUP BY F.financial_year
HAVING SUM(I.income_amount) > 1000000;
-- Task 6: Summary report - Income Category, Number of Records,
--         Total Income, Average Income, Highest Income,
--         Lowest Income (all in one query)
SELECT C.category_name,
       COUNT(*)                AS number_of_records,
       SUM(I.income_amount)    AS total_income,
       AVG(I.income_amount)    AS average_income,
       MAX(I.income_amount)    AS highest_income,
       MIN(I.income_amount)    AS lowest_income
FROM Income_Record I
JOIN Income_Category C
    ON I.category_id = C.category_id
GROUP BY C.category_name
ORDER BY total_income DESC;