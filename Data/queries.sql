/*

-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL, 
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);


CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);



CREATE TABLE titles(
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);


--SELECT *FROM departments;

--SELECT first_name, last_name
--FROM employees
--WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

--SELECT first_name, last_name
--FROM employees
--WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

--SELECT first_name, last_name
--FROM employees
--WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

--SEARCH FOR RETIREMENT ELIGIBILITY 
--SELECT first_name, last_name
--FROM employees
--WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'

--Next, we'll add a hire date to the mix using Parentheses around
--both conditions we want, with an AND in between:

--SELECT first_name, last_name
--FROM employees
--WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Use the COUNT function to determine the length of the table

-- Number of employees retiring
--SELECT COUNT(first_name)
--FROM employees
--WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Next, we need to export this information as a table and CSV file

--SELECT first_name, last_name
--INTO retirement_info
--FROM employees
--WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--SELECT * FROM retirement_info

-- Create a new retirement_info table with emp_no added
-- First, we have to remove the previous retirement_info table
-- With the DROP TABLE command. 


-- Create new table for retiring employees
--SELECT emp_no, first_name, last_name
--INTO retirement_info
--FROM employees
--WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Check the table
--SELECT * FROM retirement_info


-- Joining departments and dept_manager tables
--SELECT departments.dept_name,
--	dept_manager.emp_no,
--	dept_manager.from_date,
--	dept_manager.to_date
--FROM departments
--INNER JOIN dept_manager
--ON departments.dept_no = dept_manager.dept_no;

-- Joining reitrement_info and dept_emp tables
--SELECT retirement_info.emp_no,
--	retirement_info.first_name,
--	retirement_info.last_name,
--	dept_emp.to_date
--FROM retirement_info
--LEFT JOIN dept_emp
--ON retirement_info.emp_no = dept_emp.emp_no;

--Use aliases to complete merge commands
--SELECT d.dept_name,
--	dm.emp_no,
--	dm.from_date,
--	dm.to_date
--FROM departments as d
--INNER JOIN dept_manager as dm
--ON d.dept_no = dm.dept_no;

--Use Left Join for retirement_info and dept_emp tables
--SELECT ri.emp_no,
--	ri.first_name,
--	ri.last_name,
--de.to_date
--INTO current_emp
--FROM retirement_info as ri
--LEFT JOIN dept_emp as de
--ON ri.emp_no = de.emp_no
--WHERE de.to_date = ('9999-01-01')

--SELECT * FROM current_emp;

-- GroupBy Current Employees by Department
-- Employee count by department number
--SELECT COUNT(ce.emp_no), de.dept_no
--FROM current_emp as ce
--LEFT JOIN dept_emp as de
--ON ce.emp_no = de.emp_no
--GROUP BY de.dept_no;

-- Add Order By so we order the DeptNo's instead of
-- having them be random.

SELECT COUNT(ce.emp_no), de.dept_no
INTO retirees_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

--Next, we're looking to make a master chart of retirees
with their salaries. It'll take a couple steps to get there.

SELECT *FROM retirees_by_dept;


SELECT *FROM salaries
ORDER BY to_date DESC;

-- This is what we need but the to_dates are not correct. 
We'll have to pull those from the employees table. 

--Let's reuse the initial code we utilized to get the 
retiree info to begin with, with a couple of modifications.

"SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');"

-- We'll also use a new table_name (employee_info)
*/


-- SELECT e.emp_no,
-- 	e.first_name,
-- e.last_name,
-- 	e.gender,
-- 	s.salary,
-- 	de.to_date
-- INTO employee_info
-- FROM employees as e
-- INNER JOIN salaries as s
-- ON (e.emp_no = s.emp_no)
-- INNER JOIN dept_emp as de
-- ON (e.emp_no = de.emp_no)
-- WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--      AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
-- 	  AND (de.to_date = '9999-01-01');

-- SELECT *FROM employee_info;

-- List of managers per department
-- SELECT  dm.dept_no,
--         d.dept_name,
--         dm.emp_no,
--         ce.last_name,
--         ce.first_name,
--         dm.from_date,
--         dm.to_date
-- INTO manager_info
-- FROM dept_manager AS dm
--     INNER JOIN departments AS d
--         ON (dm.dept_no = d.dept_no)
--     INNER JOIN current_emp AS ce
--         ON (dm.emp_no = ce.emp_no);

-- SELECT *FROM manager_info;

-- The final list needs only to haev the departments
-- added to the current_emp_table. 

-- SELECT *FROM current_emp;

-- SELECT ce.emp_no,
-- ce.first_name,
-- ce.last_name,
-- d.dept_name	
-- INTO dept_info
-- FROM current_emp as ce
-- INNER JOIN dept_emp AS de
-- ON (ce.emp_no = de.emp_no)
-- INNER JOIN departments AS d
-- ON (de.dept_no = d.dept_no);

--MODULE COMPLETE--










