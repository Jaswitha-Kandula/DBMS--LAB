CREATE DATABASE taxation_db;
USE taxation_db;
CREATE TABLE Taxpayer(taxpayer_id INT PRIMARY KEY, 
	pan_number VARCHAR(10) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    occupation VARCHAR(50) NOT NULL,
    annual_income DECIMAL(12,2) NOT NULL,
    email VARCHAR(100) UNIQUE,
    is_active BOOLEAN
);
INSERT INTO Taxpayer VALUES
	(101, 'ABCDE1234F', 'Ravi Kumar', '1995-06-15','Software Engineer',850000,'ravikumar@example.com',TRUE),
    (102,'BCDEF2345G','Priya Sharma','1992-11-22','Doctor',120000,'priyasharma@example.com',TRUE),
    (103,'CDEFG3456H','Arjun Reddy','1998-03-05','Business Owner',180000,'arjunreddy@example.com',TRUE),
    (104,'DEFGH4567J','Sneha Patel','1998-08-05','Teacher',620000,'snehapatel@example.com',TRUE),
    (105,'EFGHI5678K','Kiran Rao','1990-01-18','Freelancer',750000,'kiranrao@example.com',TRUE),
    (106,'FGHIJ6789L','Meera Singh','1985-12-30','Consultant',150000,'meerasingh@example.com',FALSE);
CREATE TABLE Income_category(
	category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description_ VARCHAR(200) NOT NULL,
    taxable BOOLEAN NOT NULL);

INSERT INTO Income_category VALUES
	(1,'Salary','Income received from employement',TRUE),
    (2,'Business','Income earned from business activities',TRUE),
    (3,'House Property','Income Recieved from property or rent',TRUE),
    (4,'Capital Gains','Income from transfer of eligible assets',TRUE),
    (5,'Other Sources','Income such as bank interest',TRUE),
    (6,'Agricultural Income','Income from eligible agricultural activities',FALSE);

CREATE TABLE Financial_Year (
    year_id INT PRIMARY KEY,
    year_label VARCHAR(9) NOT NULL UNIQUE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    filling_deadline DATE,
    is_current BOOLEAN NOT NULL);

INSERT INTO Financial_Year() VALUES
    (1,'2020-2021','2020-04-01','2021-03-31','2021-07-31',FALSE),
    (2,'2021-2022','2021-04-01','2022-03-31','2022-07-31',FALSE),
    (3,'2022-2023','2022-04-01','2023-03-31','2023-07-31',FALSE),
    (4,'2023-2024','2023-04-01','2024-03-31','2024-07-31',FALSE),
    (5,'2024-2025','2024-04-01','2025-03-31','2025-07-31',FALSE),
    (6,'2025-2026','2025-04-01','2026-03-31','2026-07-31',FALSE);

CREATE TABLE Income_Record(
    income_id INT PRIMARY KEY,
    taxpayer_id INT NOT NULL,
    income_source VARCHAR(100) NOT NULL,
    category_name VARCHAR(50) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    recieved_date DATE NOT NULL,
    financial_year VARCHAR(9) NOT NULL
);

INSERT INTO Income_Record() VALUES
    (1001,101,'TechNova Solutions', 'Salary', 850000.00 ,'2026-03-31','2025-2026'),
    (1002, 102, 'City Care Hospital' ,'Salary', 1200000.00,'2026-03-31' ,'2025-2026'),
    (1003,103,'Reddy Enterprises', 'Business', 1800000.00 ,'2026-03-31', '2025-2026'),
    (1004 ,104, 'Sunrise School', 'Salary',620000.00,'2026-03-31','2025-2026'),
    (1005,105,'Web Design Projects','Business',750000.00,'2026-03-31','2025-2026'),
    (1006,106,'Professional Consultanting','Business',1500000.00,'2026-03-31','2025-2026');

INSERT INTO Taxpayer VALUES
    (107,'GHIJKL1234','Gagan Sai','2022-12-30','Topper',150000,'gagansai@example.com',FALSE);

UPDATE Taxpayer SET annual_income=950000 WHERE full_name='Ravi Kumar';

UPDATE Taxpayer SET occupation='Software Consultant' WHERE full_name='Kiran Rao';

UPDATE Taxpayer SET is_active=TRUE WHERE full_name='Meera Singh';

DELETE FROM Taxpayer WHERE taxpayer_id=107;

-- PART E
ALTER TABLE Taxpayer
ADD phone_number VARCHAR(10) NOT NULL;

ALTER TABLE Income_record
ADD remarks VARCHAR(50) NOT NULL;

ALTER TABLE Taxpayer
MODIFY COLUMN occupation VARCHAR(100);

CREATE TABLE Tax_office(
    office_id INT PRIMARY KEY,
    office_name VARCHAR(10) NOT NULL,
    city VARCHAR(15) NOT NULL);

INSERT INTO Tax_office VALUES
    (101,"Microsoft","HiTech City"),
    (102,"Amazon","Vizag");

-- Remove all records from Tax_Office while retaining the table structure.
TRUNCATE TABLE Tax_office; 

DROP TABLE Tax_office;

INSERT INTO Taxpayer VALUES
    (101,"HJIKLMN567","Mahesh Babu","2008-04-28","Gamer",32000,"bablu@example.com",TRUE,1000,7981400994);

INSERT INTO Taxpayer VALUES
    ("108","ABCDE1234F","Gagan Sai","2008-09-11","Footballer",320000,"gagan@example.com",FALSE,10000,8137832231);

SELECT * FROM Taxpayer;