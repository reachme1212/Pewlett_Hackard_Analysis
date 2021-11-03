
--Module 7 Challenge

--1.A query is written and executed to create a Retirement Titles table 
--for employees who are born 
--between January 1, 1952 and December 31, 1955

DROP TABLE

--module did not ask to filter to_date hence made as follows 

SELECT e.emp_no,e.first_name,
e.last_name,t.title,e.birth_date,t.from_date,t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
--AND (t.to_date = '9999-01-01')
ORDER BY e.emp_no;

select * from retirement_titles

---2.exported retirement_titles.csv 



SELECT DISTINCT ON (emp_no) emp_no, first_name,
last_name,title,birth_date,from_date,to_date
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, from_date DESC;

select * from unique_titles

---3.exported unique_titles.csv

---4.exported  retiring_titles_count.csv

SELECT COUNT(emp_no),title
INTO retiring_titles_count
FROM unique_titles
GROUP BY title
ORDER BY count desc;

--90398 employees in unique_titles and retiring_titles_count

select * from retiring_titles_count

----1.2.3.Mentorship Eligibility table
---current employees who were born between 
--January 1, 1965 and December 31, 1965.
--6.7.join primary keys for tables employee,dept_emp and titles
---8.Filter the data on the to_date column order by emp no

drop table 

SELECT e.emp_no,e.first_name,
e.last_name,e.birth_date,de.from_date,de.to_date,t.title
INTO mentorship_eligibilty_raw
FROM employees as e
INNER JOIN dept_emp as de ON (de.emp_no = e.emp_no)
INNER JOIN titles as t ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

select * from mentorship_eligibilty_raw

--4.Use a DISTINCT ON statement to remove duplicate 
--5.Create a new table using the INTO clause.

SELECT DISTINCT ON (emp_no) emp_no, first_name,
last_name,birth_date,from_date,to_date,title
INTO mentorship_eligibilty_clean
FROM mentorship_eligibilty_raw
ORDER BY emp_no, from_date DESC;


select * from mentorship_eligibilty_clean


--two additional queries or tables
--Query to find all current employees born between 
--'1952-01-01' AND '1955-12-31' and hired BETWEEN '1985-01-01' AND '1988-12-31'
--to narrow the list and see how many baby boomers will retire soon 

SELECT DISTINCT ON (e.emp_no)e.emp_no,de.dept_no,
d.dept_name,t.title,e.birth_date,
e.first_name,e.last_name,
e.hire_date,t.from_date,de.to_date
INTO baby_boomer_list
FROM employees as e
INNER JOIN dept_emp as de ON (e.emp_no = de.emp_no)
INNER JOIN titles as t ON (t.emp_no = e.emp_no)
INNER JOIN departments as d ON (d.dept_no = de.dept_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no ,t.from_date DESC;

--there are 33118 employees eligible for retirement as per company criteria 
--
select * from baby_boomer_list

SELECT COUNT(emp_no), title
--INTO baby_boomer_count
FROM baby_boomer_list 
GROUP BY title
ORDER BY count desc;
