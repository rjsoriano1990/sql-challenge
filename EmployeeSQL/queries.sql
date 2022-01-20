-- List the following details of each employee: 
-- employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON salaries.emp_no=employees.emp_no
ORDER BY emp_no;

-- List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%/1986';

-- List the manager of each department with the following information:
-- department number, department name, the manager's employee number, last name, first name.
Select employees.emp_no, employees.first_name, employees.last_name, dept_manager.dept_no,
(Select dept_name FROM departments where departments.dept_no=dept_manager.dept_no)
From employees
INNER JOIN dept_manager on dept_manager.emp_no=employees.emp_no;

-- List the department of each employee with the following information:
-- employee number, last name, first name, and department name.
SELECT employees.emp_no, first_name, last_name,
(SELECT dept_name FROM departments WHERE departments.dept_no=dept_emp.dept_no)
FROM employees
JOIN dept_emp ON dept_emp.emp_no=employees.emp_no;

-- List first name, last name, and sex for employees
-- whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex FROM employees 
WHERE (first_name LIKE 'Hercules' AND last_name LIKE 'B%')
ORDER BY last_name;

-- List all employees in the Sales department, 
-- including their employee number, last name, first name, and department name.
SELECT emp_no, first_name, last_name,
(SELECT dept_name FROM departments WHERE dept_name='Sales')
FROM employees WHERE emp_no IN
	(SELECT emp_no FROM dept_emp WHERE dept_no IN
		(SELECT dept_no FROM departments WHERE dept_name = 'Sales'))
ORDER BY emp_no;

-- List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
SELECT emp_no, first_name, last_name,
(SELECT dept_name FROM departments WHERE dept_name='Sales')
FROM employees WHERE emp_no IN
	(SELECT emp_no FROM dept_emp WHERE dept_no IN
		(SELECT dept_no FROM departments WHERE dept_name = 'Sales'))
UNION

SELECT emp_no, first_name, last_name,
(SELECT dept_name FROM departments WHERE dept_name='Development')
FROM employees WHERE emp_no IN
	(SELECT emp_no FROM dept_emp WHERE dept_no IN
		(SELECT dept_no FROM departments WHERE dept_name = 'Development'));

-- In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.
SELECT last_name, count(last_name) AS name_count from employees
GROUP BY last_name
ORDER by name_count DESC;