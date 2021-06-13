
-- Deliverable 1: The number of retiring employees by title
SELECT e.emp_no,
    e.first_name,
e.last_name,
    t.title,
    t.from_date,
    t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- 1.1: Use dictinct with orderby to remove duplicate rows
SELECT DISTINCT ON (r.emp_no) r.emp_no, 
r.first_name,
r.last_name,
r.title
INTO unique_titles
FROM retirement_titles AS r
ORDER BY r.emp_no ASC, r.to_date DESC;

-- 1.2: Retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(u.title), u.title
INTO retiring_titles
FROM unique_titles AS u
GROUP BY u.title
ORDER BY COUNT(u.title) DESC;

-- Deliverable 2: The employees eligible for the mentorship program
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
e.birth_date,
	de.from_date,
    de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	ORDER BY e.emp_no;


-- 2.1: Retrieve mentorship-eligible employees by their most recent job title
SELECT COUNT(me.emp_no), me.title
INTO mentorship_eligible_title
FROM mentorship_eligibilty as me
GROUP BY me.title
-- Update the data output in order
ORDER BY me.title;



-- 3: The number of retirement eLigible employees by title and current data
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
e.last_name,
    t.title,
    t.from_date,
    t.to_date
INTO retirement_current
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (t.to_date = '9999-01-01')
ORDER BY e.emp_no;


-- 3.1: Retrieve current-eligible employees by their most recent job title
SELECT COUNT(rc.title), rc.title
INTO retiring_titles_current
FROM retirement_current AS rc
GROUP BY rc.title
ORDER BY COUNT(rc.title) DESC;




SELECT * FROM retirement_titles;
SELECT * FROM unique_titles;
SELECT * FROM retiring_titles;
SELECT * FROM mentorship_eligibilty;
SELECT * FROM mentorship_eligible_titles;
SELECT * FROM retiring_titles_current;

SELECT * FROM dept_emp;
SELECT * from employees;
SELECT * FROM retirement_info;
SELECT * FROM departments;
SELECT * FROM dept_manager;

SELECT * FROM titles

