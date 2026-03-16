-- Users Table Must Store:
-- User role (Admin or Customer)
-- Name, email, password, phone number
-- Each email must be unique (no duplicate accounts)

CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    user_role VARCHAR(10) NOT NULL CHECK (user_role IN ('Admin', 'Customer'))
);

-- Vehicles Table Must Store:
-- Vehicle name, type (car/bike/truck), model
-- Registration number (must be unique)
-- Rental price per day
-- Availability status (available/rented/maintenance)

CREATE TABLE Vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    vehicle_name VARCHAR(255) NOT NULL,
    vehicle_type VARCHAR(10) NOT NULL CHECK (vehicle_type IN ('car', 'bike', 'truck')),
    model VARCHAR(255) NOT NULL,
    registration_number VARCHAR(50) NOT NULL UNIQUE,
    rental_price_per_day INTEGER NOT NULL,
    availability_status VARCHAR(20) NOT NULL CHECK (availability_status IN ('available', 'rented', 'maintenance'))
);

-- Bookings Table Must Store:
-- Which user made the booking (link to Users table)
-- Which vehicle was booked (link to Vehicles table)
-- Start date and end date of rental
-- Booking status (pending/confirmed/completed/cancelled)
-- Total cost of the booking
CREATE TABLE Bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    vehicle_id INT NOT NULL REFERENCES Vehicles(vehicle_id) ON DELETE CASCADE,
    rental_start_date DATE NOT NULL,
    rental_end_date DATE NOT NULL,
    booking_status VARCHAR(20) NOT NULL CHECK (booking_status IN ('pending', 'confirmed', 'completed', 'cancelled')),
    total_booking_cost INTEGER NOT NULL
);

INSERT INTO Users (name, email, password, phone_number, user_role) VALUES
('Alice Smith', 'alice.smith@example.com', 'password123', '123-456-7890', 'Customer'),
('Bob Johnson', 'bob.johnson@example.com', 'password456', '098-765-4321', 'Customer'),
('Charlie Brown', 'charlie.brown@example.com', 'password789', '555-555-5555', 'Customer'),
('Admin User', 'admin.user@example.com', 'adminpassword', '555-555-5556', 'Admin'),
('David Lee', 'david.lee@example.com', 'password101', '555-555-5557', 'Customer'),
('Eve Davis', 'eve.davis@example.com', 'password102', '555-555-5558', 'Customer');

INSERT INTO Vehicles (vehicle_name, vehicle_type, model, registration_number, rental_price_per_day, availability_status) VALUES
('Toyota Camry', 'car', '2020', 'ABC123', 50, 'available'),
('Honda Civic', 'car', '2019', 'DEF456', 45, 'available'),
('Ford F-150', 'truck', '2021', 'GHI789', 70, 'available'),
('Yamaha YZF-R3', 'bike', '2020', 'JKL012', 30, 'available'),
('Tesla Model 3', 'car', '2021', 'MNO345', 80, 'available'),
('Harley Davidson Street 750', 'bike', '2019', 'PQR678', 40, 'available');

INSERT INTO Bookings (user_id, vehicle_id, rental_start_date, rental_end_date, booking_status, total_booking_cost) VALUES
(1, 1, '2024-07-01', '2024-07-05', 'confirmed', 250),
(2, 2, '2024-07-10', '2024-07-12', 'pending', 90),
(3, 3, '2024-07-15', '2024-07-20', 'completed', 350),
(1, 4, '2024-08-01', '2024-08-03', 'cancelled', 60),
(2, 5, '2024-08-05', '2024-08-10', 'confirmed', 400),
(3, 6, '2024-08-15', '2024-08-18', 'pending', 120);



-- Part 3: Theory Questions (Viva Practice - Progress, Not Perfection)
-- Note: Answer the questions in your own words and record them on camera in Bengali or English. Spend about two minutes on each question.

-- "This video is a safe space to practice - confidence grows every time you speak."

-- Question 1
-- What is a foreign key and why is it important in relational databases?
-- Ans: A foreign key is a field (or collection of fields) in one table that uniquely identifies a row of another table. It is important because it establishes and enforces a link between the data in the two tables, ensuring referential integrity. This means that the foreign key value must match an existing primary key value in the referenced table, which helps maintain consistency and prevents orphaned records.

-- Question 2
-- What is the difference between WHERE and HAVING clauses in SQL?
-- Ans: The WHERE clause is used to filter rows before any grouping is performed, while the HAVING clause is used to filter groups after the GROUP BY clause has been applied. WHERE operates on individual rows, whereas HAVING operates on aggregated data.


-- Question 3
-- What is a primary key and what are its characteristics?
-- Ans: A primary key is a field (or collection of fields) in a table that uniquely identifies each row in that table. Its characteristics include being unique (no two rows can have the same primary key value) and not null (every row must have a value for the primary key field).

-- Question 4
-- What is the difference between INNER JOIN and LEFT JOIN in SQL?
-- Ans: An INNER JOIN returns only the rows that have matching values in both tables, while a LEFT JOIN returns all rows from the left table and the matched rows from the right table. If there is no match, the result will contain NULL values for columns from the right table in a LEFT JOIN.