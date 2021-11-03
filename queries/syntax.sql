-- TO CREATE TABLE 
CREATE TABLE table_name (
col_name1 datatype not null);

---ex CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no));
	
---display table content
SELECT * FROM table_name ;

SELECT COUNT (col_name) 
FROM table_name
WHERE (condition  BETWEEN AND ;
	   
	   
---- create new table while performing other query
INTO

----joins 
FROM table1 as t1
LEFT JOIN table2 as t2 ON t1.col1 =t2.col2
	   
--drop a table 
DROP TABLE table1;

	   
	   