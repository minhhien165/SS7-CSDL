use bai2;

-- 2
select
employees.name,
departments.department_name
from employees
join departments on departments.department_id = employees.department_id
order by employees.name asc;

select
employees.name,
employees.salary
from employees
where salary > 5000 order by salary desc;

select
employees.name,
sum(timesheets.hours_worked) as tongsogiolam
from employees
join timesheets on timesheets.employee_id = employees.employee_id
group by employees.name;

select
departments.department_name,
avg(employees.salary) as mucluongtrungbinh
from departments
join employees on departments.department_id = employees.department_id
group by departments.department_name;

select projects.project_name, sum(timesheets.hours_worked) as total_hours
from projects
join timesheets on projects.project_id = timesheets.project_id
where month(timesheets.work_date) = 2 and year(timesheets.work_date) = 2025
group by projects.project_name;

select employees.name as employee_name, projects.project_name, sum(timesheets.hours_worked) as total_hours
from employees
join timesheets on employees.employee_id = timesheets.employee_id
join projects on timesheets.project_id = projects.project_id
group by employees.name, projects.project_name;

select departments.department_name, count(employees.employee_id) as employee_count
from departments
join employees on departments.department_id = employees.department_id
group by departments.department_name
having count(employees.employee_id) > 1;

select workreports.report_date, employees.name as employee_name, workreports.report_content
from workreports
join employees on workreports.employee_id = employees.employee_id
order by workreports.report_date desc
limit 1, 2;

select workreports.report_date, employees.name as employee_name, count(workreports.report_id) as report_count
from workreports
join employees on workreports.employee_id = employees.employee_id
where workreports.report_content is not null
and workreports.report_date between '2025-01-01' and '2025-02-01'
group by workreports.report_date, employees.name;

select employees.name as employee_name, projects.project_name, sum(timesheets.hours_worked) as total_hours, 
round(sum(timesheets.hours_worked * employees.salary / 160), 2) as total_salary
from employees
join timesheets on employees.employee_id = timesheets.employee_id
join projects on timesheets.project_id = projects.project_id
group by employees.name, projects.project_name
having sum(timesheets.hours_worked) > 5
order by total_salary desc;
