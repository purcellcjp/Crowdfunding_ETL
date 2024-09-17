--------------------------------------------------
--------------------------------------------------
-- Database: Employees_db
--------------------------------------------------
--------------------------------------------------
DROP DATABASE IF EXISTS "Crowdfunding_db";

CREATE DATABASE "Crowdfunding_db"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


--------------------------------------------------
--------------------------------------------------
-- Create Tables
--------------------------------------------------
--------------------------------------------------

--------------------------------------------------
--  Drop Tables if they Exists
--------------------------------------------------
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS subcategory;
DROP TABLE IF EXISTS campaign;
DROP TABLE IF EXISTS contacts;


--------------------------------------------------
-- Create table category
--------------------------------------------------
CREATE TABLE category 
(
 category_id		CHAR(4)			PRIMARY KEY,
 titles				VARCHAR(20)		NOT NULL
);


--------------------------------------------------
-- Create table subcategory
--------------------------------------------------
CREATE TABLE subcategory 
(
 subcategory_id		CHAR(8)			PRIMARY KEY,
 titles				VARCHAR(20)		NOT NULL
);


--------------------------------------------------
-- Create table campaign
--------------------------------------------------
CREATE TABLE campaign 
(
 cf_id				SERIAL 			PRIMARY KEY,
 contact_id			INT				NOT NULL,
 company_name		VARCHAR(50)		NOT NULL,
 description		VARCHAR(75)		NOT NULL,
 goal				DECIMAL(18,2)	NOT NULL,
 pledged			DECIMAL(18,2)	NOT NULL,
 outcome			VARCHAR(10)		NOT NULL,
 backers_count		INT				NOT NULL,
 country			CHAR(2)			NOT NULL,
 currency			CHAR(3)			NOT NULL,
 launch_date		DATE		    NOT NULL,
 end_date			DATE		    NOT NULL,
 category_id		CHAR(4)			NOT NULL,
 subcategory_id		CHAR(8)			NOT NULL 
);


--------------------------------------------------
-- Create table contacts
--------------------------------------------------
CREATE TABLE contacts 
(
 contact_id			SERIAL 			PRIMARY KEY,
 first_name			VARCHAR(50)		NOT NULL,
 last_name			VARCHAR(50)		NOT NULL,
 email				VARCHAR(50)		NOT NULL
);


--------------------------------------------------
--------------------------------------------------
-- Table Imports
--------------------------------------------------
--------------------------------------------------
COPY category
FROM 'C:\Users\purce\Documents\GitHub\Crowdfunding_ETL\Resources\category.csv'
DELIMITER ','
CSV HEADER;

COPY subcategory
FROM 'C:\Users\purce\Documents\GitHub\Crowdfunding_ETL\Resources\subcategory.csv'
DELIMITER ','
CSV HEADER;

COPY contacts
FROM 'C:\Users\purce\Documents\GitHub\Crowdfunding_ETL\Resources\contacts.csv'
DELIMITER ','
CSV HEADER;

COPY campaign
FROM 'C:\Users\purce\Documents\GitHub\Crowdfunding_ETL\Resources\campaign.csv'
DELIMITER ','
CSV HEADER;


--------------------------------------------------
--------------------------------------------------
-- Add Table Foreign Keys to table campaign
--------------------------------------------------
--------------------------------------------------
ALTER TABLE campaign
ADD CONSTRAINT fk_contacts_contact_id
FOREIGN KEY(contact_id)
REFERENCES contacts(contact_id)
ON DELETE CASCADE;

		
ALTER TABLE campaign
ADD CONSTRAINT fk_category_id
FOREIGN KEY(category_id)
REFERENCES category(category_id)
ON DELETE CASCADE;

 
ALTER TABLE campaign
ADD CONSTRAINT fk_subcategory_id
FOREIGN KEY(subcategory_id)
REFERENCES subcategory(subcategory_id)
ON DELETE CASCADE;		


--------------------------------------------------
--------------------------------------------------
-- Drop Foreign Key Contraints
--------------------------------------------------
--------------------------------------------------
-- Only needed if tables need to be repopulated
/*
ALTER TABLE salaries
DROP CONSTRAINT fk_salaries_emp_no;
		
ALTER TABLE dept_manager
DROP CONSTRAINT fk_dept_manager_dept_no;
  
ALTER TABLE dept_manager
DROP CONSTRAINT fk_dept_manager_emp_no;	
*/

--------------------------------------------------
--------------------------------------------------
-- truncate Tables
--------------------------------------------------
--------------------------------------------------
/* Needed in case import needs to be re-executed
TRUNCATE TABLE category;
TRUNCATE TABLE subcategory;
TRUNCATE TABLE campaign;
TRUNCATE TABLE contacts;
*/