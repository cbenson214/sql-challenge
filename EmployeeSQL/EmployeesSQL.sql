-- Create tables for CSV imports
CREATE TABLE departments(
	dept_no		varchar(4) NOT NULL,
	dept_name	varchar(30) NOT NULL,
	PRIMARY KEY(dept_no)
);

CREATE TABLE titles(
	title_id	varchar(5),
	title		varchar(20),
	PRIMARY KEY (title_id)
);

CREATE TABLE employees(
	emp_no		int,
	emp_title	varchar(5),
	birth_date	date,
	first_name	varchar(20),
	last_name	varchar(20),
	sex			varchar(1),
	hire_date	date,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title) REFERENCES titles (title_id)
);

CREATE TABLE dept_emp(
	emp_no		int,
	dept_no		varchar(4),
	-- Composite Key?
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

CREATE TABLE dept_manager(
	dept_no		varchar(4),
	emp_no		int,
	-- Composite Key?
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE salaries(
	emp_no		int,
	salary		int,
	-- Composite key?
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

SELECT * FROM dept_emp;