# DBMS Query Collection

This document provides a comprehensive guide to the SQL queries in this repository. Each query addresses a specific business requirement using different SQL concepts and techniques.

---

## Query 1: Retrieve Booking Information with Customer and Vehicle Details

### Question
Retrieve booking information along with customer names and vehicle names.

### Objective
This query demonstrates the use of table JOINs to combine data from multiple tables. It retrieves comprehensive booking details by combining information from the `users`, `bookings`, and `vehicles` tables.

### Concepts Used
- **INNER JOIN**: Combines rows from multiple tables based on matching conditions
- **Table Aliases**: Simplified table references (u, b)
- **Subquery**: Nested SELECT statement for intermediate result set

### SQL Query
```sql
SELECT u.name, b.vehicle_name FROM users AS u INNER JOIN 
  (SELECT * FROM bookings INNER JOIN vehicles USING(vehicle_id)) AS b ON u.user_id = b.user_id;
```

### Expected Output
A result set containing:
- Customer name (`u.name`)
- Vehicle name (`b.vehicle_name`)

### Use Case
This query is useful for generating booking reports that provide a complete view of which customer booked which vehicle.

---

## Query 2: Find Vehicles That Have Never Been Booked

### Question
Find all vehicles that have never been booked.

### Objective
Identify vehicles in the system that have no associated bookings. This is useful for inventory management and identifying vehicles that may need marketing attention or maintenance.

### Concepts Used
- **NOT EXISTS**: Negates the existence of a subquery result
- **Subquery Correlation**: Links the outer query to the inner query
- **NULL Handling**: Manages records with no matching data in related tables

### SQL Query
```sql
SELECT * FROM vehicles AS v WHERE NOT EXISTS (SELECT * FROM bookings WHERE bookings.vehicle_id = v.vehicle_id);
```

### Expected Output
All rows from the `vehicles` table where no corresponding booking exists in the `bookings` table.

### Use Case
This query helps identify idle inventory and can be used to:
- Identify vehicles requiring promotional campaigns
- Highlight maintenance opportunities
- Analyze vehicle utilization rates

---

## Query 3: Retrieve Available Vehicles of a Specific Type

### Question
Retrieve all available vehicles of a specific type (e.g., cars).

### Objective
Filter vehicles based on multiple criteria to show only available vehicles of a particular type. This supports customer search functionality in booking systems.

### Concepts Used
- **SELECT**: Column selection from a table
- **WHERE Clause**: Filtering records based on multiple conditions
- **Logical AND Operator**: Combines multiple filter conditions

### SQL Query
```sql
SELECT * FROM vehicles WHERE vehicle_type = 'car' AND availability_status = 'available';
```

### Expected Output
All vehicles that meet both conditions:
- `vehicle_type = 'car'`
- `availability_status = 'available'`

### Use Case
This query is fundamental for:
- Customer-facing vehicle search functionality
- Real-time availability checking
- Filtering options in booking applications

---

## Query 4: Find Total Bookings per Vehicle (Vehicles with More Than 2 Bookings)

### Question
Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.

### Objective
Aggregate booking data to identify the most popular or highly-booked vehicles. This provides insights into vehicle utilization and demand patterns.

### Concepts Used
- **GROUP BY**: Aggregates data into groups based on a column
- **HAVING Clause**: Filters groups based on aggregate function results
- **COUNT Function**: Counts the number of rows in each group
- **Aggregate Functions**: Summarizes data across multiple rows

### SQL Query
```sql
SELECT vehicle_id, COUNT(*) AS total_bookings FROM bookings 
GROUP BY vehicle_id HAVING COUNT(*) > 2;
```

### Expected Output
A result set containing:
- `vehicle_id`: The ID of the vehicle
- `total_bookings`: The count of bookings for that vehicle (only if count > 2)

### Use Case
This query is used for:
- Performance analysis and vehicle ranking
- Identifying top-performing vehicles
- Resource allocation decisions
- Demand forecasting based on booking history
- Profitability analysis by vehicle

---

## Database Schema Overview

The queries utilize the following tables:

| Table | Description |
|-------|------------|
| `users` | Stores customer information including user ID and name |
| `bookings` | Records booking transactions linking users to vehicles |
| `vehicles` | Contains vehicle inventory details including type and availability status |

---

## Key Learning Outcomes

These queries demonstrate essential SQL concepts:

1. **Relational Operations**: Understanding JOINs and how to combine data from multiple tables
2. **Existence Checking**: Using NOT EXISTS to identify missing relationships
3. **Filtering**: Applying WHERE clauses with conditional logic
4. **Data Aggregation**: Using GROUP BY and HAVING for summarization and analysis
5. **Query Optimization**: Writing efficient queries for common business questions

---

## Notes

- Ensure proper indexing on common join columns (`user_id`, `vehicle_id`) for optimal performance
- Test queries on sample data before deploying to production
- Adjust filter conditions (e.g., `vehicle_type = 'car'`) based on specific business requirements
