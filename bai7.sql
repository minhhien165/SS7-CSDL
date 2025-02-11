create database bai7;

use bai7;

create table student (
    rn int primary key,
    name varchar(20),
    age tinyint
);

create table test (
    testid int primary key,
    name varchar(20)
);

create table studenttest (
    rn int,
    testid int,
    date datetime,
    mark float,
    foreign key (rn) references student(rn),
    foreign key (testid) references test(testid)
);

insert into student (rn, name, age) values
(1, 'nguyen hong ha', 20),
(2, 'truong ngoc anh', 30),
(3, 'tuan minh', 25),
(4, 'dan truong', 22);

insert into test (testid, name) values
(1, 'epc'),
(2, 'dwmx'),
(3, 'sql1'),
(4, 'sql2');

insert into studenttest (rn, testid, date, mark) values
(1, 1, '2006-07-17', 8),
(1, 2, '2006-07-18', 5),
(1, 3, '2006-07-19', 7),
(2, 1, '2006-07-17', 7),
(2, 2, '2006-07-18', 4),
(2, 3, '2006-07-19', 2),
(3, 1, '2006-07-17', 10),
(3, 3, '2006-07-18', 1);

alter table student
add constraint ck_student_age check (age between 15 and 55);

alter table studenttest
alter column mark set default 0;

alter table studenttest
add constraint pk_studenttest primary key (rn, testid);

alter table test
add constraint uq_test_name unique (name);

alter table test
drop constraint uq_test_name;

-- 1
select 
    s.name, 
    t.name as testname, 
    st.mark, 
    st.date
from student s
join studenttest st on s.rn = st.rn
join test t on st.testid = t.testid;

-- 2
select s.name
from student s
where s.rn not in (select distinct rn from studenttest);

-- 3
select 
    s.name, 
    t.name as testname, 
    st.mark
from student s
join studenttest st on s.rn = st.rn
join test t on st.testid = t.testid
where st.mark < 5;

-- 4
select 
    s.name, 
    round(avg(st.mark), 2) as averagemark
from student s
join studenttest st on s.rn = st.rn
group by s.name
order by averagemark desc;

-- 5
with avgmarks as (
    select 
        s.name, 
        round(avg(st.mark), 2) as averagemark
    from student s
    join studenttest st on s.rn = st.rn
    group by s.name
)
select name, averagemark
from avgmarks
where averagemark = (select max(averagemark) from avgmarks);

-- 6
select 
    t.name as testname, 
    max(st.mark) as maxmark
from test t
join studenttest st on t.testid = st.testid
group by t.name
order by t.name;

-- 7
select 
    s.name as studentname, 
    t.name as testname
from student s
left join studenttest st on s.rn = st.rn
left join test t on st.testid = t.testid;

-- 8
update student set age = age + 1;
alter table student add status varchar(10);

-- 9
update student 
set status = case 
    when age < 30 then 'young'
    else 'old'
end;

select * from student;

-- 10
select 
    s.name, 
    t.name as testname, 
    st.mark, 
    st.date
from student s
join studenttest st on s.rn = st.rn
join test t on st.testid = t.testid
order by st.date; 

-- 11
select 
    s.name, 
    s.age, 
    round(avg(st.mark), 2) as averagemark
from student s
join studenttest st on s.rn = st.rn
where s.name like 't%'
group by s.name, s.age
having avg(st.mark) > 4.5;

-- 12
with rankedstudents as (
    select 
        s.rn,
        s.name, 
        s.age, 
        round(avg(st.mark), 2) as averagemark,
        dense_rank() over (order by avg(st.mark) desc) as ranking
    from student s
    join studenttest st on s.rn = st.rn
    group by s.rn, s.name, s.age
)
select * from rankedstudents;

-- 13
alter table student
modify name varchar(65535);

-- 14
update student 
set name = 'old ' + name 
where age > 20;

-- 15
update student 
set name = 'young ' + name 
where age <= 20;

-- 16
delete from test 
where testid not in (select distinct testid from studenttest);

-- 17
delete from studenttest 
where mark < 5;
