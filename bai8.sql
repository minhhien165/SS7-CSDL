create database bai8;

use bai8;

create table customer (
    cid int primary key,
    name varchar(25),
    cage tinyint
);

create table order_detail (
    oid int,
    pid int,
    odqty int,
    foreign key (oid) references orders(oid),
    foreign key (pid) references product(pid)
);

create table orders (
    oid int primary key,
    cid int,
    odate datetime,
    ototalprice int,
    foreign key (cid) references customer(cid)
);

create table product (
    pid int primary key,
    pname varchar(25),
    pprice int
);

insert into customer (cid, name, cage)
values
(1, 'minh quan', 10),
(2, 'ngoc oanh', 20),
(3, 'hong ha', 50);

insert into orders (oid, cid, odate, ototalprice)
values
(1, 1, '2006-03-21', null),
(2, 2, '2006-03-23', null),
(3, 1, '2006-03-16', null);

insert into product (pid, pname, pprice)
values
(1, 'may giat', 3),
(2, 'tu lanh', 5),
(3, 'dieu hoa', 7),
(4, 'quat', 1),
(5, 'bep dien', 2);

insert into order_detail (oid, pid, odqty)
values
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(3, 5, 4),
(2, 3, 3);

-- 2
select oid, cid, odate, ototalprice
from orders
order by odate desc;

-- 3
select pname, pprice
from product
where pprice = (select max(pprice) from product);

-- 4
select c.name as customername, p.pname as productname
from customer c
join orders o on c.cid = o.cid
join order_detail od on o.oid = od.oid
join product p on od.pid = p.pid;

-- 5
select name
from customer
where cid not in (select distinct cid from orders);

-- 6
select o.oid, c.name as customername, p.pname as productname, od.odqty
from orders o
join customer c on o.cid = c.cid
join order_detail od on o.oid = od.oid
join product p on od.pid = p.pid;

-- 7
select o.oid, o.odate, 
       sum(od.odqty * p.pprice) as totalprice
from orders o
join order_detail od on o.oid = od.oid
join product p on od.pid = p.pid
group by o.oid, o.odate;

-- 8
alter table orders drop foreign key fk_orders_customer;
alter table order_detail drop foreign key fk_orderdetail_orders;
alter table order_detail drop foreign key fk_orderdetail_product;
alter table customer drop primary key;
alter table orders drop primary key;
alter table product drop primary key;
