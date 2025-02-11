create database bai1;

use bai1;

create table categorys ( 
category_id int primary key,
category_name varchar(255) 
);
create table books ( 
book_id int primary key,
title varchar(255),
author varchar(255) ,
publication_year int,
availale_quantity int, 
category_id int,
foreign key (category_id) references categorys(category_id)
);
create table readers (
reader_id int primary key,
name varchar(255),
phone_number varchar(15),
email varchar(255)
);
create table borrowing ( 
borrow_id int primary key,
reader_id int,
book_id int,
borrow_date date,
due_date date,
foreign key (reader_id) references readers(reader_id),
foreign key (book_id) references books(book_id)
);
create table returning (
return_id int primary key,
borrow_id int,
return_date date,
foreign key (borrow_id) references borrowing(borrow_id)
);
create table fines(
fine_id int primary key,
return_id int,
fne_amount decimal(10,2),
foreign key (return_id) references returning(return_id)
);

-- 3
insert into categorys (category_id, category_name) 
values 
(1, 'fiction'),
(2, 'science');

insert into books (book_id, title, author, publication_year, availale_quantity, category_id) 
values 
(1, 'to kill a mockingbird', 'harper lee', 1960, 5, 1),
(2, 'a brief history of time', 'stephen hawking', 1988, 3, 2);

insert into readers (reader_id, name, phone_number, email) 
values 
(1, 'alice johnson', '1234567890', 'alice@example.com'),
(2, 'bob smith', '0987654321', 'bob@example.com');

insert into borrowing (borrow_id, reader_id, book_id, borrow_date, due_date) 
values 
(1, 1, 1, '2025-02-01', '2025-02-15'),
(2, 2, 2, '2025-02-03', '2025-02-17');

insert into returning (return_id, borrow_id, return_date) 
values 
(1, 1, '2025-02-10'),
(2, 2, '2025-02-15');

insert into fines (fine_id, return_id, fne_amount) 
values 
(1, 1, 0.00),
(2, 2, 5.00);

-- 4
update readers 
set name = 'Phạm Trung Hiếu', email = 'ptrunghieu2507@gmail.com'
where reader_id = 1;

-- 5
delete from books 
where book_id = 2;
