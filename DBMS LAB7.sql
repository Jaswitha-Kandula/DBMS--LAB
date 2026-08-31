USE jessy;

SHOW TABLES;

/* LEVEL 1 */

CREATE VIEW highest_income AS
SELECT * FROM income_record
WHERE amount = (
    SELECT MAX(amount) FROM income_record
);

CREATE VIEW lowest_income AS
SELECT * FROM income_record
WHERE amount = (
    SELECT MIN(amount) FROM income_record
);

CREATE VIEW above_average_income AS
SELECT * FROM income_record
WHERE amount > (
    SELECT AVG(amount) FROM income_record
);

CREATE VIEW equal_highest_income AS
SELECT * FROM income_record
WHERE amount = (
    SELECT MAX(amount) FROM income_record
);

CREATE VIEW business_owners AS
SELECT * FROM taxpayer
WHERE occupation = 'business owner';


/* LEVEL 2 */

CREATE VIEW taxpayers_with_income AS
SELECT * FROM taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record
);

CREATE VIEW business_income_taxpayers AS
SELECT * FROM taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record
    WHERE category_id = (
        SELECT category_id FROM income_category
        WHERE category_name = 'business'
    )
);

CREATE VIEW income_2025_2026 AS
SELECT * FROM income_record
WHERE year_id IN (
    SELECT year_id FROM financial_year
    WHERE year_label = '2025-2026'
);

CREATE VIEW above_min_business_income AS
SELECT * FROM income_record
WHERE amount > (
    SELECT MIN(amount) FROM income_record
    WHERE category_id = (
        SELECT category_id FROM income_category
        WHERE category_name = 'Business'
    )
);

CREATE VIEW below_max_salary_income AS
SELECT * FROM income_record
WHERE amount < (
    SELECT MAX(amount) FROM income_record
    WHERE category_id = (
        SELECT category_id FROM income_category
        WHERE category_name = 'salary'
    )
);

CREATE VIEW taxpayers_above_average_income AS
SELECT * FROM taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record
    WHERE amount > (
        SELECT AVG(amount) FROM income_record
    )
);

CREATE VIEW categories_with_income AS
SELECT * FROM income_category
WHERE category_id IN (
    SELECT category_id FROM income_record
);

CREATE VIEW taxpayers_no_investment AS
SELECT * FROM taxpayer
WHERE taxpayer_id NOT IN (
    SELECT taxpayer_id FROM income_record
    WHERE category_id = 3
);


/* LEVEL 3 */

CREATE VIEW taxpayer_highest_income AS
SELECT * FROM taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record
    WHERE amount = (
        SELECT MAX(amount) FROM income_record
    )
);

CREATE VIEW above_average_business_income AS
SELECT * FROM income_record
WHERE amount > (
    SELECT AVG(amount) FROM income_record
    WHERE category_id = 2
);

CREATE VIEW taxpayers_total_above_average AS
SELECT taxpayer_id, SUM(amount) AS total_income
FROM income_record
GROUP BY taxpayer_id
HAVING SUM(amount) > (
    SELECT AVG(total_income)
    FROM (
        SELECT SUM(amount) AS total_income
        FROM income_record
        GROUP BY taxpayer_id
    ) AS taxpayer_totals
);

CREATE VIEW greater_than_any_investment AS
SELECT * FROM income_record
WHERE amount > ANY (
    SELECT amount FROM income_record
    WHERE category_id = 3
);

CREATE VIEW greater_than_all_investment AS
SELECT * FROM income_record
WHERE amount > ALL (
    SELECT amount FROM income_record
    WHERE category_id = 3
);

CREATE VIEW highest_income_category AS
SELECT * FROM income_category
WHERE category_id IN (
    SELECT category_id FROM income_record
    WHERE amount = (
        SELECT MAX(amount) FROM income_record
    )
);

CREATE VIEW highest_total_income_year AS
SELECT * FROM financial_year
WHERE year_id = (
    SELECT year_id FROM income_record
    GROUP BY year_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);

CREATE VIEW taxpayers_total_income_above_average AS
SELECT taxpayer_id, SUM(amount) AS total_income
FROM income_record
GROUP BY taxpayer_id
HAVING SUM(amount) > (
    SELECT AVG(total_income)
    FROM (
        SELECT SUM(amount) AS total_income
        FROM income_record
        GROUP BY taxpayer_id
    ) AS taxpayer_totals
);


/* REAL WORLD TAXATION ANALYSIS */

CREATE VIEW highest_individual_income AS
SELECT * FROM taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record
    WHERE amount = (
        SELECT MAX(amount) FROM income_record
    )
);

CREATE VIEW taxpayers_income_above_average AS
SELECT * FROM taxpayer
WHERE annual_income > (
    SELECT AVG(annual_income) FROM taxpayer
);

CREATE VIEW category_containing_highest_income AS
SELECT * FROM income_category
WHERE category_id = (
    SELECT category_id FROM income_record
    WHERE amount = (
        SELECT MAX(amount) FROM income_record
    )
);

CREATE VIEW business_but_no_investment AS
SELECT * FROM taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record
    WHERE category_id = 2
)
AND taxpayer_id NOT IN (
    SELECT taxpayer_id FROM income_record
    WHERE category_id = 3
);

CREATE VIEW greater_than_every_investment AS
SELECT * FROM income_record
WHERE amount > ALL (
    SELECT amount FROM income_record
    WHERE category_id = 3
);

CREATE VIEW greater_than_one_investment AS
SELECT * FROM income_record
WHERE amount > ANY (
    SELECT amount FROM income_record
    WHERE category_id = 3
);

CREATE VIEW taxpayers_highest_total_income AS
SELECT taxpayer_id, SUM(amount) AS total_income
FROM income_record
GROUP BY taxpayer_id
HAVING SUM(amount) = (
    SELECT MAX(total_income)
    FROM (
        SELECT SUM(amount) AS total_income
        FROM income_record
        GROUP BY taxpayer_id
    ) AS taxpayer_totals
);

CREATE VIEW above_category_average AS
SELECT i.*
FROM income_record i
JOIN (
    SELECT category_id, AVG(amount) AS average_income
    FROM income_record
    GROUP BY category_id
) c ON i.category_id = c.category_id
WHERE i.amount > c.average_income;