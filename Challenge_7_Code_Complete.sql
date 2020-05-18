--Challenge code 
-------------------------------------------------------
--Technical Analysis Delivarable 1
-------------------------------------------------------

--DETERMINE RETIREMENT-ELIGIBLE EMPLOYEES BY TITLE.
--This requires selecting column fields and querying
-- data from four separate tables, combined through 
-- inner-joins. 
-------------------------------------------------------
SELECT e.emp_no,
e.first_name, 
e.last_name, 
t.title,
t.from_date,
s.salary
INTO retirees_by_title_summary
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON(e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
-- -- Next, we specify retirees by DOB and hire dates
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01')
AND (t.to_date = '9999-01-01')
-- -- Then, order by department as requested:
ORDER BY de.dept_no;

-- VIEW TABLE
SELECT *FROM retirees_by_title_summary

--DROP DUPLICATES / PARTITION
-------------------------------------------------------
SELECT emp_no, 
    first_name, 
	last_name, 
	title, 
	from_date,
	salary
INTO unique_retirees_by_title
FROM 
(SELECT emp_no, first_name, last_name, title, from_date, salary, ROW_NUMBER() OVER 
(PARTITION BY (emp_no)
ORDER BY from_date DESC) rn
FROM retirees_by_title_summary
) tmp WHERE rn = 1
ORDER BY title;


--VIEW TABLE
SELECT *FROM unique_retirees_by_title


------------------------------------------------------

--New Table 1- NUMBER of Titles Retiring
SELECT COUNT(emp_no), title
INTO final_retirement_count_by_title
FROM unique_retirees_by_title
GROUP BY title;

--Call Table
SELECT *FROM final_retirement_count_by_title;

------------------------------------------------------


--New Table 2 - Number of Employees with Each Title	

--(A)---GET CURRENT EMPLOYEES BY TITLE ---------------
SELECT emp_no, title, from_date
INTO current_emp_by_title
FROM current_emp as ce
INNER JOIN titles as t
ON (ce.emp_no = t.emp_no);

--Call Table
SELECT * FROM current_emp_by_title

--(B)---DROP DUPLICATES-------------------------------
SELECT emp_no, title, from_date
INTO unique_current_emp_by_title
FROM 
(SELECT emp_no, title, from_date, ROW_NUMBER() OVER 
(PARTITION BY (emp_no)
ORDER BY from_date DESC) rn
FROM current_emp_by_title
) tmp WHERE rn = 1;

--(C)---COUNT BY TITLE--------------------------------
SELECT COUNT(emp_no), title
INTO final_current_employees_by_title
FROM unique_current_emp_by_title
GROUP BY unique_current_emp_by_title.title;

--Call Table
SELECT *FROM final_current_employees_by_title
---------------------------------------------------------


-- New Table 3 - Current Employees at Retirement Age

-- Number of employees retiring
SELECT first_name,
		last_name,
		birth_date
INTO retirement_age_employees
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

--Call Table
SELECT *FROM retirement_age_employees;



---------------------------------------------------------
-- TECHNICAL ANALYSIS DELIVERABLE 2
---------------------------------------------------------

-- Determine candidates eligible for mentorship, that
-- is, with D.O.B. in the year 1965

SELECT e.emp_no,
	e.first_name,
e.last_name,
e.birth_date,
t.title
	INTO mentee_eligibility
FROM employees as e
inner join titles as t
on (e.emp_no=t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
     	 AND (t.to_date = '9999-01-01');
		 
		 
select count(*) from  mentee_eligibility;
-- (=) 1,549

-----------------ANALYSIS COMPLETE --------------------
-------------------------------------------------------








