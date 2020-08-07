Create table departments 
(dept_no varchar, 
 dept_name varchar);

COPY departments FROM 'C:\Users\Public\Documents\01-Import Data\departments.csv' DELIMITER ',' CSV HEADER;

Create table dept_emp 
( emp_no int,
 dept_no varchar);

COPY dept_emp FROM 'C:\Users\Public\Documents\01-Import Data\dept_emp.csv' DELIMITER ',' CSV HEADER;

Create table dept_manager 
(dept_no varchar, 
 emp_no int);

COPY dept_manager FROM 'C:\Users\Public\Documents\01-Import Data\dept_manager.csv' DELIMITER ',' CSV HEADER;

Create table employees 
(emp_no int,
 emp_title varchar,
birth_date date,
first_name varchar,
last_name varchar,
sex varchar,
hire_date date);

COPY employees FROM 'C:\Users\Public\Documents\01-Import Data\employees.csv' DELIMITER ',' CSV HEADER;

Create table salaries 
( emp_no int,
 salary int);

COPY salaries FROM 'C:\Users\Public\Documents\01-Import Data\salaries.csv' DELIMITER ',' CSV HEADER;

Create table titles 
(emp_no int,
 title varchar, 
from_date date,
to_date date);

COPY title FROM 'C:\Users\Public\Documents\01-Import Data\title.csv' DELIMITER ',' CSV HEADER;
---1.	List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary 
FROM employees 
INNER JOIN salaries ON salaries.emp_no = employees.emp_no


---2. List employees who were hired in 1986

SELECT employees.last_name, employees.first_name, employees.hire_date
FROM employees 
WHERE employees.hire_date >= '01/01/1986' AND employees.hire_date <= '12-31-1986'

---3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name and first name.

SELECT 	dept_manager.dept_no as "Department Number",
		departments.dept_name as "Department Name",
		dept_manager.emp_no as "Department Manager Employee Number", 
		employees.last_name as "Department Manager Last Name",
		employees.first_name as "Department Manager First Name"
FROM dept_manager
INNER JOIN employees ON employees.emp_no = dept_manager.emp_no
INNER JOIN departments ON departments.dept_no = dept_manager.dept_no

---4. List the department of each employee with the following information: 
--- employee number, last name, first name, and department name.

SELECT 	employees.emp_no AS "Employee Number",
		employees.last_name AS "Employee Last Name",
		employees.first_name AS "Employee First Name",
		departments.dept_name AS "Department Name"
FROM employees
INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no

---5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT 	employees.emp_no AS "Employee Number",
		employees.first_name AS "Employee First Name",
		employees.last_name AS "Employee Last Name"
FROM employees
WHERE employees.first_name = 'Hercules' AND employees.last_name LIKE 'B%' 

---6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT 	employees.emp_no AS "Employee Number",
		employees.last_name AS "Employee Last Name",
		employees.first_name AS "Employee First Name",
		departments.dept_name AS "Department Name"
FROM employees
INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales'

---7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT 	employees.emp_no AS "Employee Number",
		employees.last_name AS "Employee Last Name",
		employees.first_name AS "Employee First Name",
		departments.dept_name AS "Department Name"
FROM employees
INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development'

---8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT 	employees.last_name, (COUNT(employees.last_name)) AS name_count
FROM employees
GROUP BY employees.last_name 
ORDER BY name_count DESC