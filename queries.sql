-- Query 1: JOIN
-- Retrieve booking information along with:

-- Customer name
-- Vehicle name
-- Concepts used: INNER JOIN

SELECT u.name, b.vehicle_name FROM users AS u 
INNER JOIN (SELECT * FROM bookings INNER JOIN vehicles USING(vehicle_id)) AS b ON u.user_id = b.user_id;

-- Query 2: EXISTS
-- Find all vehicles that have never been booked.

-- Concepts used: NOT EXISTS
SELECT * FROM vehicles AS v WHERE NOT EXISTS (SELECT * FROM bookings WHERE bookings.vehicle_id = v.vehicle_id);

-- Query 3: WHERE
-- Retrieve all available vehicles of a specific type (e.g. cars).

-- Concepts used: SELECT, WHERE
SELECT * FROM vehicles WHERE vehicle_type = 'car' AND availability_status = 'available';

-- Query 4: GROUP BY and HAVING
-- Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.

-- Concepts used: GROUP BY, HAVING, COUNT
SELECT vehicle_id, COUNT(*) AS total_bookings FROM bookings GROUP BY vehicle_id HAVING COUNT(*) > 2;