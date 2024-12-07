CREATE TABLE publisher (
    pb_ID VARCHAR(8) PRIMARY KEY,
    Name TEXT,
    published INT
);

CREATE TABLE categories (
    ct_ID VARCHAR(8) PRIMARY KEY,
    Name TEXT,
    Book_Count INT
);

CREATE TABLE  staffs (
    staff_ID VARCHAR(7) PRIMARY KEY,
    Name TEXT,
    age INT,
    designation VARCHAR(50),
    salary FLOAT,
    shift TEXT,
    date_joined TEXT
);

CREATE TABLE writers (
  writerId VARCHAR(7) PRIMARY KEY,
  name TEXT,
  date_of_birth TEXT
);


CREATE TABLE members (
    card_No VARCHAR(8) PRIMARY KEY ,
    Name TEXT,
    contact VARCHAR(11),
    borrowed INT,
    returned INT,
    registered TEXT
);

CREATE TABLE books (
    book_ID VARCHAR(10) PRIMARY KEY ,
    Name TEXT,
    publisher VARCHAR(8),
    category VARCHAR(8),
    edition INT,
    writer VARCHAR(7),
    Price INT,
    Count INT,
    FOREIGN KEY (publisher) references publisher(pb_ID),
    FOREIGN KEY (category) references categories(ct_ID),
    FOREIGN KEY (writer) references writers(writerId)
);

CREATE TABLE entries (
    E_No VARCHAR(10) PRIMARY KEY ,
    borrower VARCHAR(8),
    librarian VARCHAR(7),
    Date_Borrowed TEXT,
    Date_Returned TEXT,
    Book VARCHAR(10),
    FOREIGN KEY (borrower) REFERENCES members(card_No),
    FOREIGN KEY (librarian) REFERENCES staffs(staff_ID),
    FOREIGN KEY (Book) REFERENCES books(book_ID)
);