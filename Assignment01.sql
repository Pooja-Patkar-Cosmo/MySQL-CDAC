-- LAB ___________________________________________________________________________________________________________________

CREATE DATABASE IF NOT EXISTS librarydb;
use librarydb;

-- _____________________________________________________________________________
-- DATABASE ASSIGNMENT 1: Schema Design & Table Creation (DDL & DML Commands)
-- _____________________________________________________________________________
-- 1. Define a schema for a Library Management System with the following entities: Books, Authors, Members, Borrow_Records
CREATE DATABASE IF NOT EXISTS librarydb;
use librarydb;

-- 2. Write the SQL command to create a table Authors with the following fields: 
-- author_id (Primary Key, INT), name (VARCHAR(100)), country (VARCHAR(50))
CREATE TABLE authors (
author_id INT PRIMARY KEY,
name VARCHAR(100),
country VARCHAR(50));

show tables;

-- 3. Write the SQL command to create a table Books with the following fields: 
-- book_id (Primary Key, INT), title (VARCHAR(150)), author_id (Foreign Key referencing Authors), published_year (YEAR), available_copies (INT)
CREATE TABLE books(
	book_id INT PRIMARY KEY,
	title VARCHAR(150),
    author_id INT,
	published_year YEAR,
	available_copies INT,
	CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES authors(author_id)
);


-- 4. Write the SQL command to create a table Members with: 
-- member_id (Primary Key, INT), name (VARCHAR(100)), email (VARCHAR(100), unique), phone (VARCHAR(15))
CREATE TABLE members(
	member_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15));

-- 5. Write the SQL command to create a table Borrow_Records with: 
-- record_id (Primary Key, INT), member_id (Foreign Key referencing Members), book_id (Foreign Key referencing Books), borrow_date (DATE), return_date (DATE)
CREATE TABLE borrow_records(
	record_id INT PRIMARY KEY,
	member_id INT,
	book_id INT,
	borrow_date DATE,
	return_date DATE,
    
    CONSTRAINT fk_member FOREIGN KEY(member_id) REFERENCES members(member_id),
    CONSTRAINT fk_book FOREIGN KEY(book_id) REFERENCES books(book_id)
    );

-- 6. Modify the Books table to add a column genre of type VARCHAR(50).
ALTER TABLE books 
ADD COLUMN genre VARCHAR(50);

-- 7. Write the SQL command to drop the Borrow_Records table -----------------------------------------
DROP TABLE IF EXISTS borrow_records;
show tables;
-- Recreating Borrow_Records --------------------------------------------
CREATE TABLE borrow_records(
	record_id INT PRIMARY KEY,
	member_id INT,
	book_id INT,
	borrow_date DATE,
	return_date DATE,
    
    CONSTRAINT fk_member FOREIGN KEY(member_id) REFERENCES members(member_id),
    CONSTRAINT fk_book FOREIGN KEY(book_id) REFERENCES books(book_id)
    );

-- 8. Insert 3 records into the Authors table -------------------------------------------------------
INSERT INTO authors(author_id, name, country) VALUES 
(1, 'John', 'USA'),
(2, 'Daisy', 'USA'),
(3, 'Kate', 'UK');



-- 9. Insert 5 books into the Books table.
INSERT INTO books(book_id, title, author_id, published_year, available_copies, genre) VALUES
(101, 'Database Systems', 1, 2018, 5, 'Education'),
(102, 'Operating Systems', 2, 2012, 3, 'Education'),
(103, 'Echoes of Eternity', 3, 2016, 5, 'Poetry'),
(104, 'Advanced SQL', 1, 2020, 4, 'Education'),
(105, 'The Silent Witness', 3, 2019, 3,'Thriller');


-- 10. Insert 3 members into the Members table.
INSERT INTO members (member_id, name, email, phone) VALUES 
(1001, 'Rosie', 'rosie@gmail.com', '9948043258'),
(1002, 'River', 'river@gmail.com', '8401202985'),
(1003, 'Sam', 'sam@gmail.com', '7904243982');

-- 11. Insert 4 borrow records into the Borrow_Records table.
INSERT INTO borrow_records(record_id, member_id, book_id, borrow_date, return_date) VALUES
(201, 1001, 101, '2026-01-10', '2026-01-20'),
(202, 1003, 102, '2026-02-05', '2026-02-15'),
(203, 1002, 105, '2026-09-01', NULL),
(204, 1001, 103, '2026-10-01', '2023-10-18');

SELECT * FROM authors;
SELECT * FROM books;
SELECT * FROM members;
SELECT * FROM borrow_records;
-- 12. Write an SQL query to select all books where published_year is after 2015.
SELECT * FROM books WHERE published_year > 2015;

-- 13. Write a SQL query to create a foreign key & primary key relationship between two tables.
-- Demonstrated via standalone DDL syntax
CREATE TABLE parent (parent_id INT PRIMARY KEY);
CREATE TABLE child (
	child_id INT PRIMARY KEY, 
    parent_id INT, 
    CONSTRAINT fk_parent FOREIGN KEY (parent_id) REFERENCES parent (parent_id));
    
-- SEQUENCE OF DROPPING THE TABLE WHEN FOREIGN KEY IS PRESENT ******************* 
DROP TABLE IF EXISTS child;
DROP TABLE IF EXISTS parent;

-- 14. Write an SQL query to find all members who have borrowed the book with title 'Database Systems'.
SELECT m.member_id, m.name, m.email, m.phone, br.record_id, b.book_id, b.title
FROM members m
JOIN borrow_records br ON m.member_id = br.member_id
JOIN books b ON br.book_id = b.book_id
WHERE b.title = 'Database Systems';


-- 15. Update the available_copies column of a specific book (choose any book) by reducing it by 1 after it is borrowed.
UPDATE books
SET available_copies = available_copies - 1    --   5 -> becomes 4
WHERE book_id = 103;

-- 16. Delete a record from Members where member_id = 1003.
-- Note: Removing dependent borrow records first to prevent foreign key constraint violations
DELETE FROM borrow_records WHERE member_id = 1003;
DELETE FROM members WHERE member_id = 1003;

-- 17. Update a Book name record from Book table with id = 1.
UPDATE books
SET title = 'Fundamentals of Database Systems' 
WHERE book_id = 101;

select * from books;
select * from authors;
-- 18. Write an SQL query to list all books along with their authors' names.
SELECT b.book_id, b.title, a.name as author_name
FROM books b
JOIN authors a ON b.author_id = a.author_id;

-- 19. Write an SQL query to delete all books from the Books table where the published_year is before 2000.
DELETE FROM borrow_records WHERE book_id IN ( SELECT book_id FROM books WHERE published_year < 2000);
DELETE FROM books WHERE published_year < 2000;
-- 20. Write an SQL query to find all books that are never borrowed (i.e., no records in Borrow_Records).

SELECT * FROM books WHERE book_id NOT IN ( SELECT DISTINCT book_id FROM borrow_records);

