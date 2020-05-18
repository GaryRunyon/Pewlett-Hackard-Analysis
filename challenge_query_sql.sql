--Challenge code 

--Part 1)

--Determine retirement-eligible employees by title.
--This requires selecting column fields and querying
-- data from four separate tables, combined through 
-- inner-joins. 

--SELECT e.emp_no,
--e.first_name, 
--e.last_name, 
--t.title,
--t.from_date,
--s.salary
--INTO retirees_by_title_summary
--FROM employees as e
--INNER JOIN salaries as s
--ON (e.emp_no = s.emp_no)
--INNER JOIN dept_emp as de
--ON(e.emp_no = de.emp_no)
--INNER JOIN titles as t
--ON (e.emp_no = t.emp_no)
-- -- Next, we specify retirees by DOB and hire dates
--WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
--AND (de.to_date = '9999-01-01')
--AND (t.to_date = '9999-01-01')
-- -- Then, order by department as requested:
--ORDER BY de.dept_no;

-- VIEW TABLE
--SELECT *FROM retirees_by_title_summary

--Drop Duplicates/ Partition;
/*
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
*/


--New Table 1- NUMBER of Titles Retiring
SELECT COUNT(emp_no), title
INTO final_retirement_count_by_title
FROM unique_retirees_by_title
GROUP BY title;

SELECT *FROM final_retirement_count_by_title;



--New Table 2 - Number of Employees with Each Title
--Summarized count of all employees by current title	


-- New Table 3 - Current Employees Born Within Date Range




--Part 2






