-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
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
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE Dept_Emp (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (dept_no, emp_no)
);
CREATE TABLE Titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no, title, from_date)
);

drop table current_emp_info;

---all retiree table who are currently working with us SOON WILL RETIRE 33118
SELECT e.emp_no,e.birth_date,e.first_name,
e.last_name,e.gender,e.hire_date,de.to_date
INTO current_emp_info
FROM employees as e
INNER JOIN dept_emp as de ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31') AND
(de.to_date = '9999-01-01');




SELECT COUNT (emp_no)
FROM current_emp_info

-- Joining departments name  and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date	
FROM departments
INNER JOIN dept_manager ON departments.dept_no = dept_manager.dept_no;

select * from current_emp_info;

-- Joining retirement_info and dept_emp tables
SELECT current_emp_info.emp_no,
    current_emp_info.first_name,
current_emp_info.last_name,
    dept_emp.to_date
	FROM current_emp_info
	LEFT JOIN dept_emp ON current_emp_info.emp_no = dept_emp.emp_no;

-- Joining retirement_info and dept_emp tables
SELECT ce.emp_no,
    ce.first_name,
	ce.last_name,
    de.to_date
FROM current_emp_info as ce
LEFT JOIN dept_emp as de ON ce.emp_no = de.emp_no;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp_info as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO dept_emp_count
FROM current_emp_info as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT emp_no, first_name, last_name
--INTO retirement_info
FROM employees as e
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT emp_no,
    first_name,
    last_name,
    gender
---INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

---3 joins 

SELECT e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    s.to_date
--INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	  AND (de.to_date = '9999-01-01');

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
--INTO manager_info
FROM dept_manager as dm
INNER JOIN departments AS d ON (dm.dept_no = d.dept_no)
INNER JOIN current_emp_info AS ce ON (dm.emp_no = ce.emp_no);


SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
-- INTO dept_info
FROM current_emp_info as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

---creat department wise info in 

select * from current_emp_info

SELECT COUNT (emp_no) 
FROM current_emp_info