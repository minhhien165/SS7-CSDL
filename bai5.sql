use bai3;

INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Science'),
(2, 'Literature'),
(3, 'History'),
(4, 'Technology'),
(5, 'Psychology');

INSERT INTO Books (book_id, title, author, publication_year, available_quantity, category_id) VALUES
(1, 'The History of Vietnam', 'John Smith', 2001, 10, 1),
(2, 'Python Programming', 'Jane Doe', 2020, 5, 4),
(3, 'Famous Writers', 'Emily Johnson', 2018, 7, 2),
(4, 'Machine Learning Basics', 'Michael Brown', 2022, 3, 4),
(5, 'Psychology and Behavior', 'Sarah Davis', 2019, 6, 5);

INSERT INTO Readers (reader_id, name, phone_number, email) VALUES
(1, 'Alice Williams', '123-456-7890', 'alice.williams@email.com'),
(2, 'Bob Johnson', '987-654-3210', 'bob.johnson@email.com'),
(3, 'Charlie Brown', '555-123-4567', 'charlie.brown@email.com');

INSERT INTO Borrowing (borrow_id, reader_id, book_id, borrow_date, due_date) VALUES
(1, 1, 1, '2025-02-19', '2025-02-15'),
(2, 2, 2, '2025-02-03', '2025-02-17'),
(3, 3, 3, '2025-02-02', '2025-02-16'),
(4, 1, 2, '2025-03-10', '2025-02-24'),
(5, 2, 3, '2025-05-11', '2025-02-25'),
(6, 2, 3, '2025-02-11', '2025-02-25');

INSERT INTO Returning (return_id, borrow_id, return_date) VALUES
(1, 1, '2025-03-14'),
(2, 2, '2025-02-28'),
(3, 3, '2025-02-15'),
(4, 4, '2025-02-20'),  
(5, 4, '2025-02-20');

INSERT INTO Fines (fine_id, return_id, fine_amount) VALUES
(1, 1, 5.00),
(2, 2, 0.00),
(3, 3, 2.00);

-- 2
select
books.title,
books.author,
categorys.category_name
from books
join categorys on categorys.category_id = books.category_id
order by books.title asc;

select 
readers.name,
count(borrowing.book_id) as SoLuongSach
from readers 
join borrowing on borrowing.reader_id = readers.reader_id
group by readers.name;

select avg(fine_amount) as "số tiền phạt trung bình" from fines;

select 
books.title,
max(books.available_quantity) as maxAvailale_quantity
from books
group by books.title limit 1;

select 
readers.name,
fines.fine_amount
from readers
join borrowing on borrowing.reader_id = readers.reader_id
join returning on returning.borrow_id = borrowing.borrow_id
join fines on fines.return_id = returning.return_id
where fines.fine_amount > 0;

select 
books.title,
count(borrowing.book_id) as tongsolanmuonsach
from books
join borrowing on borrowing.book_id = books.book_id
group by books.title
order by tongsolanmuonsach desc
LIMIT 1;

select 
  books.title as book_name,
  readers.name as reader_name,
  borrowing.borrow_date,
  (select count(*) 
   from returning 
   where returning.borrow_id = borrowing.borrow_id) as return_count
from books 
join borrowing on borrowing.book_id = books.book_id
join readers on borrowing.reader_id = readers.reader_id
having return_count = 0 
order by borrowing.borrow_date asc ;

select
readers.name,
books.title
from readers
join borrowing on borrowing.reader_id = readers.reader_id
join books on books.book_id = borrowing.book_id
join returning on borrowing.borrow_id = returning.borrow_id
where borrowing.due_date = returning.return_date 

