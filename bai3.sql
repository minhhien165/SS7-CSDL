create database bai3;

use bai3;

create table categories (
    category_id int primary key auto_increment,
    category_name varchar(255) not null
);

create table books (
    book_id int primary key auto_increment,
    title varchar(255) not null,
    author varchar(255) not null,
    publication_year int,
    available_quantity int default 0,
    category_id int,
    foreign key (category_id) references categories(category_id) 
);

create table readers (
    reader_id int primary key auto_increment,
    reader_name varchar(255) not null,
    phone_number varchar(15),
    email varchar(255) unique
);

create table borrowing (
    borrow_id int primary key auto_increment,
    reader_id int,
    book_id int,
    borrow_date date not null,
    due_date date not null,
    foreign key (reader_id) references readers(reader_id),
    foreign key (book_id) references books(book_id)
);

create table returning (
    return_id int primary key auto_increment,
    borrow_id int,
    return_date date not null,
    foreign key (borrow_id) references borrowing(borrow_id) 
);

create table fines (
    fine_id int primary key auto_increment,
    return_id int,
    fine_amount decimal(10,2) not null,
    foreign key (return_id) references returning(return_id)
);

insert into categories (category_id, category_name) values
(1, 'science'),
(2, 'literature'),
(3, 'history'),
(4, 'technology'),
(5, 'psychology');

insert into books (book_id, title, author, publication_year, available_quantity, category_id) values
(1, 'the history of vietnam', 'john smith', 2001, 10, 1),
(2, 'python programming', 'jane doe', 2020, 5, 4),
(3, 'famous writers', 'emily johnson', 2018, 7, 2),
(4, 'machine learning basics', 'michael brown', 2022, 3, 4),
(5, 'psychology and behavior', 'sarah davis', 2019, 6, 5);

insert into readers (reader_id, reader_name, phone_number, email) values
(1, 'alice williams', '123-456-7890', 'alice.williams@email.com'),
(2, 'bob johnson', '987-654-3210', 'bob.johnson@email.com'),
(3, 'charlie brown', '555-123-4567', 'charlie.brown@email.com');

insert into borrowing (borrow_id, reader_id, book_id, borrow_date, due_date) values
(1, 1, 1, '2025-02-19', '2025-02-15'),
(2, 2, 2, '2025-02-03', '2025-02-17'),
(3, 3, 3, '2025-02-02', '2025-02-16'),
(4, 1, 2, '2025-03-10', '2025-02-24'),
(5, 2, 3, '2025-05-11', '2025-02-25'),
(6, 2, 3, '2025-02-11', '2025-02-25');

insert into returning (return_id, borrow_id, return_date) values
(1, 1, '2025-03-14'),
(2, 2, '2025-02-28'),
(3, 3, '2025-02-15'),
(4, 4, '2025-02-20'),  
(5, 4, '2025-02-20');

insert into fines (fine_id, return_id, fine_amount) values
(1, 1, 5.00),
(2, 2, 0.00),
(3, 3, 2.00);

-- 2
select * from books;

select * from readers;

select readers.reader_name, books.title, borrowing.borrow_date
from borrowing
join readers on borrowing.reader_id = readers.reader_id
join books on borrowing.book_id = books.book_id;

select books.title, books.author, categories.category_name
from books
join categories on books.category_id = categories.category_id;

select readers.reader_name, fines.fine_amount, returning.return_date
from fines
join returning on fines.return_id = returning.return_id
join borrowing on returning.borrow_id = borrowing.borrow_id
join readers on borrowing.reader_id = readers.reader_id;

-- 3
update books 
set available_quantity = 15 
where book_id = 1;

delete from readers 
where reader_id = 2;

insert into readers (reader_id, reader_name, phone_number, email) 
values (2, 'bob johnson', '987-654-3210', 'bob.johnson@email.com');
