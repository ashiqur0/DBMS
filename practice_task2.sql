CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    country VARCHAR(50),
    enrollment_date DATE
);

CREATE TABLE courses (
    course_id INTEGER PRIMARY KEY,
    course_title VARCHAR(150),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    instructor VARCHAR(100),
    published_year INTEGER
);

CREATE TABLE enrollments (
    enrollment_id INTEGER PRIMARY KEY,
    student_id INTEGER,
    course_id INTEGER,
    enrollment_date DATE,
    progress_percentage INTEGER,
    paid_amount DECIMAL(10, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO students (student_id, first_name, last_name, email, phone, country, enrollment_date) VALUES
(1, 'Rahim', 'Uddin', 'rahim@email.com', '01711111111', 'Bangladesh', '2023-01-10'),
(2, 'Karim', 'Ahmed', 'karim@email.com', NULL, 'Bangladesh', '2023-01-15'),
(3, 'Sara', 'Khan', 'sara@email.com', '01822222222', 'Pakistan', '2023-02-01'),
(4, 'John', 'Smith', 'john@email.com', NULL, 'USA', '2023-02-10'),
(5, 'Emma', 'Brown', 'emma@email.com', '01933333333', 'UK', '2023-02-20'),
(6, 'Ayaan', 'Ali', 'ayaan@email.com', NULL, 'India', '2023-03-05'),
(7, 'Lina', 'Rahman', 'lina@email.com', '01644444444', 'Bangladesh', '2023-03-12'),
(8, 'Mark', 'Taylor', 'mark@email.com', NULL, 'Australia', '2023-03-25'),
(9, 'Sophia', 'Lee', 'sophia@email.com', '01555555555', 'USA', '2023-04-01'),
(10, 'Daniel', 'Martinez', 'daniel@email.com', NULL, 'Spain', '2023-04-10');

INSERT INTO courses (course_id, course_title, category, price, instructor, published_year) VALUES
(1, 'Complete SQL Bootcamp', 'Database', 49.99, 'John Carter', 2021),
(2, 'Advanced JavaScript', 'Programming', 59.99, 'Sarah Miller', 2020),
(3, 'Python for Data Science', 'Data Science', 69.99, 'David Kim', 2022),
(4, 'Web Development with React', 'Programming', 54.99, 'Emily Stone', 2021),
(5, 'Machine Learning Basics', 'AI', 79.99, 'Andrew Ng', 2019),
(6, 'Cloud Computing Fundamentals', 'Cloud', 64.99, 'James Allen', 2020),
(7, 'UI/UX Design Essentials', 'Design', 39.99, 'Laura Scott', 2022),
(8, 'DevOps for Beginners', 'DevOps', 74.99, 'Michael Brown', 2023);

INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date, progress_percentage, paid_amount) VALUES
(1, 1, 1, '2023-05-01', 80, 49.99),
(2, 2, 2, '2023-05-03', NULL, 59.99),
(3, 3, 3, '2023-05-05', 60, 69.99),
(4, 4, 1, '2023-05-07', 100, 49.99),
(5, 5, 4, '2023-05-10', 40, 54.99),
(6, 6, 5, '2023-05-12', NULL, 79.99),
(7, 7, 2, '2023-06-01', 90, 59.99),
(8, 8, 6, '2023-06-02', 30, 64.99),
(9, 9, 3, '2023-06-03', 70, 69.99),
(10, 10, 7, '2023-06-04', NULL, 39.99),
(11, 1, 8, '2023-06-05', 20, 74.99),
(12, 2, 1, '2023-06-06', 50, 49.99),
(13, 3, 6, '2023-06-07', NULL, 64.99),
(14, 4, 4, '2023-06-08', 85, 54.99),
(15, 5, 5, '2023-06-09', 60, 79.99);

-- Display all students and their phone numbers. If the phone number is NULL, show 'Not Provided' using COALESCE.
SELECT first_name, coalesce(phone, 'Not Provided') FROM students;

-- Show all courses ordered by price (highest to lowest) and limit the result to 5 courses.
SELECT course_title, price FROM courses ORDER BY price DESC LIMIT 5;

-- Display courses for page 2, assuming 3 courses per page, using LIMIT and OFFSET.
SELECT course_id, course_title FROM courses LIMIT 3 OFFSET 3 * 1;

-- Update the price of all courses in the Programming category by increasing it 10%.
-- select course_title, price from courses WHERE category = 'Programming'; 
UPDATE courses SET price = price + price * .1 WHERE category = 'Programming';

-- Delete all enrollment records where progress_percentage is NULL.
DELETE FROM enrollments WHERE progress_percentage IS NULL

-- Find the total paid amount per course category using GROUP BY.
SELECT c.category, sum(e.paid_amount) AS total_paid 
FROM courses c JOIN enrollments e ON e.enrollment_id = c.course_id 
GROUP BY c.category

-- Show course categories where the average course price is greater than 60 using HAVING.
SELECT category, round(avg(price), 2) FROM courses 
GROUP BY category HAVING avg(price) > 60;

-- Count how many students are enrolled in each course.
SELECT c.course_title, count(e.student_id) AS enrolled_students
FROM courses c LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_title;


-- Explain what happens if you try to insert an enrollment with a student_id that does not exist in the students table.
--Answer: If you try to insert an enrollment with a student_id that does not exist in the students table, it will result in a foreign key constraint violation. The database will prevent the insertion of the enrollment record because it references a student_id that is not present in the students table, ensuring data integrity.

-- Display student full name, course title, and paid amount using an INNER JOIN.
SELECT concat(s.first_name, ' ', s.last_name) AS full_name, c.course_title, e.paid_amount
FROM enrollments e JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id;

-- Display all students and their enrolled courses. Include students who have not enrolled in any course using a LEFT JOIN.
SELECT concat(s.first_name, ' ', s.last_name) AS full_name, c.course_title
FROM students s LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id;


-- Display all courses and their enrolled students. Include courses that have no enrollments using a RIGHT JOIN.
SELECT c.course_title, concat(s.first_name, ' ', s.last_name) AS full_name
FROM courses c RIGHT JOIN enrollments e ON c.course_id = e.course_id
RIGHT JOIN students s ON e.student_id = s.student_id;

-- Display all students and all courses, even if there is no matching enrollment, using a FULL JOIN.
SELECT concat(s.first_name, ' ', s.last_name) AS full_name, c.course_title
FROM students s FULL JOIN enrollments e ON s.student_id = e.student_id
FULL JOIN courses c ON e.course_id = c.course_id;

-- Show the number of enrollments per year based on enrollment_date.
SELECT EXTRACT(YEAR FROM enrollment_date) AS year, count(enrollment_id) AS total_enrollments
FROM enrollments GROUP BY year ORDER BY year;

-- Find the average progress percentage per course, ignoring NULL values.
SELECT c.course_title, round(avg(progress_percentage), 2) AS avg_progress
FROM courses c JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_title;