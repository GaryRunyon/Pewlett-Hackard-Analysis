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

*/

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

__SELECT * FROM retirement_info
