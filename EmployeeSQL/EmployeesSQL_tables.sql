CREATE TABLE departments(
	dept_no		varchar(4) NOT NULL,
	dept_name	varchar(30) NOT NULL,
	PRIMARY KEY(dept_no)
);

CREATE TABLE titles(
	title_id	varchar(5) NOT NULL,
	title		varchar(20) NOT NULL,
	PRIMARY KEY (title_id)
);

CREATE TABLE employees(
	emp_no		int NOT NULL,
	emp_title	varchar(5) NOT NULL,
	birth_date	date NOT NULL,
	first_name	varchar(20) NOT NULL,
	last_name	varchar(20) NOT NULL,
	sex			varchar(1) NOT NULL,
	hire_date	date NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title) REFERENCES titles (title_id)
);

CREATE TABLE dept_emp(
	emp_no		int NOT NULL,
	dept_no		varchar(4) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE dept_manager(
	dept_no		varchar(4) NOT NULL,
	emp_no		int NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE salaries(
	emp_no		int NOT NULL,
	salary		int NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, salary)
);