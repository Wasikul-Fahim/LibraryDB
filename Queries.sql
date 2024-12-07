/* Fetch queries */
SELECT * FROM  members;
SELECT * FROM staffs ORDER BY designation;
SELECT * FROM publisher;
SELECT * FROM categories;
SELECT * FROM books;
SELECT * FROM writers;
SELECT book_ID, Name, (SELECT Name FROM publisher p where p.pb_ID = b.publisher) publisher,
       (SELECT Name FROM categories c where c.ct_ID = b.category) category,
       (SELECT name FROM writers w WHERE w.writerId = b.writer) writer, edition, price, Count
       FROM books b;
SELECT E_No,  (SELECT Name FROM members m where e.borrower = m.card_No) Name,
              (SELECT Name FROM staffs s where e.Librarian = s.staff_ID) Librarian,
              Date_Borrowed, Date_Returned,
              (SELECT Name FROM books b where e.Book = b.book_ID) Book
              FROM entries e;

/* Easy queries */
/* Members who use Robi Sim network */
SELECT Name, contact FROM members where contact LIKE '018%';
/* Librarians who can give books */
SELECT * FROM staffs where designation LIKE '%Librarian';
/* List the names of fictional books */
SELECT book_ID, Name, (SELECT Name FROM publisher p where p.pb_ID = b.publisher) publisher,
       (SELECT Name FROM categories c where c.ct_ID = b.category) category,
       (SELECT name FROM writers w WHERE w.writerId = b.writer) writer
       FROM books b WHERE (SELECT c.ct_ID FROM categories c WHERE c.Name = 'Fiction') = b.category;
/* List how many books are available of each category */
SELECT c.Name,
       (SELECT Count(b.category) FROM books b where c.ct_ID = b.category GROUP BY b.category) Book_Count
FROM categories c;


/* Medium queries */
/* Find the top 5 most borrowed books */
SELECT distinct b.Name, (SELECT Count(e.Book) from entries e WHERE e.Book = b.book_ID group by e.Book) Total_borrowed
    FROM entries e join books b on b.book_ID = e.Book ORDER BY Total_borrowed DESC LIMIT 5;
/* Find the average Borrow duration for books of a specific category */
SELECT m.Name, DATEDIFF(Date_Returned, Date_Borrowed) Avarage_Borrow_Time
FROM entries join members m on entries.borrower = m.card_No ORDER BY Avarage_Borrow_Time ASC LIMIT 8;
/* Find the books written by author born at the 20th century */
SELECT b.Name, w.name, w.date_of_birth FROM books b join writers w on b.writer = w.writerId WHERE w.date_of_birth LIKE '%19%' ORDER BY  date_of_birth;


/* Hard Queries */
/* Identify the top 3 most active members based on the number of books borrowed */
SELECT DISTINCT m.Name, (SELECT Count(borrower) FROM entries e WHERE e.borrower = m.card_No GROUP BY e.borrower) Total_borrowed
FROM entries e join members m on e.borrower = m.card_No ORDER BY Total_borrowed DESC LIMIT 5;
/* Find the most borrowed books of among the category */
SELECT c.Name, Count(b.book_ID)  borrow_count
FROM books b
JOIN entries e on b.book_ID = e.Book
JOIN categories c on c.ct_ID = b.category
GROUP BY b.category
ORDER BY borrow_count DESC;
/* Determine the most popular author based on the number of books borrowed */
SELECT w.name, COUNT(e.Book) totalBorrowed
FROM writers w
JOIN books b on w.writerId = b.writer
JOIN entries e on b.book_ID = e.Book
GROUP BY w.name ORDER BY totalBorrowed DESC Limit 5;



