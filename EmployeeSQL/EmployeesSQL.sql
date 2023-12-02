-- Create tables for CSV imports
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

-- #1, list the employees and their salaries
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

-- #2, list the employees and their hire dates if they were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1985-12-31' AND '1987-1-1';

-- #3, list department managers and their departments
SELECT dm.emp_no, e.last_name, e.first_name, dm.dept_no, d.dept_name
FROM dept_manager dm
LEFT JOIN departments d ON dm.dept_no = d.dept_no
LEFT JOIN employees e ON dm.emp_no = e.emp_no;

-- #4, list the employees and their departments
SELECT de.emp_no, e.last_name, e.first_name, de.dept_no, d.dept_name
FROM dept_emp de
LEFT JOIN departments d ON de.dept_no = d.dept_no
LEFT JOIN employees e ON de.emp_no = e.emp_no;

--#5, list the names and sex for employees whose first name is Hercules and whose last name begins with the letter B
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- #6, list each employee in the Sales Department
SELECT emp_no, last_name, first_name
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN (
		SELECT dept_no
		FROM departments
		WHERE dept_name = 'Sales'
		)
	);

-- #7, list each employee in both the Sales and Development departments, as well as their respective department name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM departments d
LEFT JOIN dept_emp de ON d.dept_no = de.dept_no
LEFT JOIN employees e ON de.emp_no = e.emp_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

-- #8, list the frequency counts (descending) of all the employee last names
SELECT last_name, COUNT(last_name) AS Frequency
FROM employees
GROUP BY last_name
ORDER BY Frequency DESC;