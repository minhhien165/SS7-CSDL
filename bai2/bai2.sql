create database bai2;

use bai2;

create table employees (
employee_id int primary key,
name varchar(255),
dob date,
department_id int,
salary decimal(10,2)
);
create table departments (
department_id int primary key,
department_name varchar(255),
location varchar(255)
);
create table projects (
project_id int primary key,
project_name varchar(255),
start_date date,
end_date date
);
create table timesheets ( 
timesheet_id int primary key,
employee_id int,
project_id int,
work_date date,
hours_worked decimal(5,2),
foreign key (employee_id) references employees(employee_id),
foreign key (project_id) references projects(project_id)
);
create table workreports (
report_id int primary key,
employee_id int,
report_date date,
report_content varchar(255),
foreign key (employee_id) references employees(employee_id)
);

-- 3
insert into departments(department_id, department_name, location)
values
(1, 'IT', 'Hà Nội'),
(2, 'HR', 'Hồ Chí Minh');

insert into employees(employee_id, name, dob, department_id, salary)
values
(1, 'Nguyễn Văn A', '1990-05-10', 1, 15000000),
(2, 'Trần Thị B', '1995-07-22', 2, 12000000);

insert into projects(project_id, project_name, start_date, end_date)
values
(1, 'Dự án A', '2024-01-01', '2024-12-31'),
(2, 'Dự án B', '2024-02-15', '2024-11-30');

insert into timesheets(timesheet_id, employee_id, project_id, work_date, hours_worked)
values
(1, 1, 1, '2024-02-10', 8),
(2, 2, 2, '2024-02-11', 6);

insert into workreports(report_id, employee_id, report_date, report_content)
values
(1, 1, '2024-02-10', 'Hoàn thành công việc A'),
(2, 2, '2024-02-11', 'Hoàn thành công việc B');

-- 4
update projects 
set project_name = 'Dự án Alpha' 
where project_id = 1;

-- 5
delete from employees 
where employee_id = 2;