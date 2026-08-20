create database complaint
use complaint
CREATE TABLE Cities (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(100) NOT NULL
);
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,audit_logaudit_logaudit_logaudit_logcomplaint_statuscomplaint_statuscomplaint_assignmentscomplaint_assignments
    department_name VARCHAR(100) NOT NULL
);
CREATE TABLE Complaint_Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);
CREATE TABLE Complaint_Status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL
);
CREATE TABLE Priorities (
    priority_id INT PRIMARY KEY AUTO_INCREMENT,
    priority_name VARCHAR(50) NOT NULL
);
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES Cities(city_id)
);
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);
CREATE TABLE Complaints (
    complaint_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    category_id INT,
    priority_id INT,
    status_id INT,
    complaint_date DATE,
    description VARCHAR(500),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (category_id) REFERENCES Complaint_Categories(category_id),
    FOREIGN KEY (priority_id) REFERENCES Priorities(priority_id),
    FOREIGN KEY (status_id) REFERENCES Complaint_Status(status_id)
);
CREATE TABLE Complaint_Assignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    complaint_id INT,
    employee_id INT,
    assigned_date DATE,
    resolution_date DATE,
    FOREIGN KEY (complaint_id) REFERENCES Complaints(complaint_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);
CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    complaint_id INT,
    rating INT,
    comments VARCHAR(500),
    FOREIGN KEY (complaint_id) REFERENCES Complaints(complaint_id)
);
CREATE TABLE Branches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_name VARCHAR(100) NOT NULL,
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES Cities(city_id)
);
CREATE TABLE Login_Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(100),
    role VARCHAR(30)
);
CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    complaint_id INT,
    message VARCHAR(500),
    notification_date DATETIME,
    FOREIGN KEY (complaint_id) REFERENCES Complaints(complaint_id)
);
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    complaint_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    payment_status VARCHAR(30),
    FOREIGN KEY (complaint_id) REFERENCES Complaints(complaint_id)
);
CREATE TABLE Audit_Log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(100),
    action_type VARCHAR(30),
    action_date DATETIME
);

SELECT 'Cities' AS table_name, COUNT(*) AS records FROM Cities
UNION ALL
SELECT 'Departments', COUNT(*) FROM Departments
UNION ALL
SELECT 'Complaint_Categories', COUNT(*) FROM Complaint_Categories
UNION ALL
SELECT 'Complaint_Status', COUNT(*) FROM Complaint_Status
UNION ALL
SELECT 'Priorities', COUNT(*) FROM Priorities
UNION ALL
SELECT 'Customers', COUNT(*) FROM Customers
UNION ALL
SELECT 'Employees', COUNT(*) FROM Employees
UNION ALL
SELECT 'Branches', COUNT(*) FROM Branches
UNION ALL
SELECT 'Login_Users', COUNT(*) FROM Login_Users
UNION ALL
SELECT 'Complaints', COUNT(*) FROM Complaints
UNION ALL
SELECT 'Complaint_Assignments', COUNT(*) FROM Complaint_Assignments
UNION ALL
SELECT 'Feedback', COUNT(*) FROM Feedback
UNION ALL
SELECT 'Notifications', COUNT(*) FROM Notifications
UNION ALL
SELECT 'Payments', COUNT(*) FROM Payments
UNION ALL
SELECT 'Audit_Log', COUNT(*) FROM Audit_Log;

DELETE FROM Complaint_Assignments;
select * from Complaint_Assignments;
DELETE FROM Complaint_Assignments;
SELECT
    (SELECT COUNT(*) FROM Customers) +
    (SELECT COUNT(*) FROM Employees) +
    (SELECT COUNT(*) FROM Departments) +
    (SELECT COUNT(*) FROM Cities) +
    (SELECT COUNT(*) FROM Complaint_Categories) +
    (SELECT COUNT(*) FROM Complaint_Status) +
    (SELECT COUNT(*) FROM Priorities) +
    (SELECT COUNT(*) FROM Complaints) +
    (SELECT COUNT(*) FROM Complaint_Assignments) +
    (SELECT COUNT(*) FROM Feedback) +
    (SELECT COUNT(*) FROM Branches) +
    (SELECT COUNT(*) FROM Login_Users) +
    (SELECT COUNT(*) FROM Notifications) +
    (SELECT COUNT(*) FROM Payments) +
    (SELECT COUNT(*) FROM Audit_Log)
    AS total_records;
1.Find the total number of customers.
        SELECT COUNT(*) AS total_customers
        FROM Customers;
2.Find the total number of complaints.
		SELECT COUNT(*) AS total_complaints
        FROM Complaints;
3.Display customer name and phone number.
		SELECT customer_name, phone
        FROM Customers;
4.Find customers from Chennai.
		SELECT c.customer_name, ci.city_name
		FROM Customers c
		JOIN Cities ci
		ON c.city_id = ci.city_id
		WHERE ci.city_name = 'Chennai';
5.Find the number of high-priority complaints.
		SELECT COUNT(*) AS high_priority_complaints
		FROM Complaints c
		JOIN Priorities p
		ON c.priority_id = p.priority_id
		WHERE p.priority_name = 'High';
6.Find the number of pending complaints.
		SELECT COUNT(*) AS pending_complaints
		FROM Complaints c
		JOIN Complaint_Status cs
		ON c.status_id = cs.status_id
		WHERE cs.status_name = 'Pending';
7.Find the number of complaints in each category.
		SELECT cc.category_name, COUNT(*) AS total_complaints
		FROM Complaints c
		JOIN Complaint_Categories cc
		ON c.category_id = cc.category_id
		GROUP BY cc.category_name;
8.Find the number of complaints for each status
		SELECT cs.status_name, COUNT(*) AS total_complaints
		FROM Complaints c
		JOIN Complaint_Status cs
		ON c.status_id = cs.status_id
		GROUP BY cs.status_name;
9.Display employees and their departments.
		SELECT e.employee_name, d.department_name
		FROM Employees e
		JOIN Departments d
		ON e.department_id = d.department_id;
10.Find the number of complaints handled by each employee.
		SELECT e.employee_name, COUNT(*) AS total_complaints
		FROM Complaint_Assignments ca
		JOIN Employees e
		ON ca.employee_id = e.employee_id
		GROUP BY e.employee_id, e.employee_name;
11.Find the employee who handled the maximum number of complaints.
		SELECT e.employee_name, COUNT(*) AS total_complaints
		FROM Complaint_Assignments ca
		JOIN Employees e
		ON ca.employee_id = e.employee_id
		GROUP BY e.employee_id, e.employee_name
		ORDER BY total_complaints DESC
		LIMIT 1;
12.Find the number of complaints in each city.
		SELECT ci.city_name, COUNT(*) AS total_complaints
		FROM Complaints c
		JOIN Customers cu
		ON c.customer_id = cu.customer_id
		JOIN Cities ci
		ON cu.city_id = ci.city_id
		GROUP BY ci.city_name
		ORDER BY total_complaints DESC;
13.Find the average customer feedback rating.
		SELECT AVG(rating) AS average_rating
		FROM Feedback;
14.Display complaint ID, customer name, and complaint description.
		SELECT 
		c.complaint_id,
		cu.customer_name,
		c.description
		FROM Complaints c
		JOIN Customers cu
		ON c.customer_id = cu.customer_id;
15.Find employees who have handled at least one complaint.
		SELECT employee_name
		FROM Employees
		WHERE employee_id IN (
		SELECT employee_id
		FROM Complaint_Assignments
		);
16.Find customers who have raised complaints.
		SELECT customer_name
		FROM Customers
		WHERE customer_id IN (
		SELECT customer_id
		FROM Complaints
		);
17.Find customers who have never raised a complaint.
		SELECT customer_name
		FROM Customers
		WHERE customer_id NOT IN (
		SELECT customer_id
		FROM Complaints
		);
18.Find the employee who handled the maximum number of complaints.
		SELECT employee_name
		FROM Employees
		WHERE employee_id = (
		SELECT employee_id
		FROM Complaint_Assignments
		GROUP BY employee_id
		ORDER BY COUNT(*) DESC
		LIMIT 1
		);
19.Find complaints raised by the customer with the highest number of complaints.
		SELECT *
		FROM Complaints
		WHERE customer_id = (
		SELECT customer_id
		FROM Complaints
		GROUP BY customer_id
		ORDER BY COUNT(*) DESC
		LIMIT 1
		);
20.Find employees who handled more complaints than the average employee.
		SELECT employee_id, COUNT(*) AS total_complaints
		FROM Complaint_Assignments
		GROUP BY employee_id
		HAVING COUNT(*) > (
		SELECT AVG(total)
		FROM (
        SELECT COUNT(*) AS total
        FROM Complaint_Assignments
        GROUP BY employee_id
		) AS employee_counts
		);
21.Find whether each complaint is high priority or not.
		SELECT 
		complaint_id,
		priority_id,
		IF(priority_id = 3, 'High', 'Not High') AS priority_level
		FROM Complaints;
22.Display the complaint status using CASE
		SELECT
		complaint_id,
		status_id,
		CASE
        WHEN status_id = 1 THEN 'Pending'
        WHEN status_id = 2 THEN 'In Progress'
        WHEN status_id = 3 THEN 'Resolved'
        WHEN status_id = 4 THEN 'Closed'
        ELSE 'Unknown'
		END AS status_name
		FROM Complaints;
22.Classify customer feedback
		SELECT
		feedback_id,
		rating,
		CASE
        WHEN rating = 5 THEN 'Excellent'
        WHEN rating = 4 THEN 'Very Good'
        WHEN rating = 3 THEN 'Good'
        WHEN rating = 2 THEN 'Poor'
        WHEN rating = 1 THEN 'Very Poor'
        ELSE 'Invalid'
		END AS feedback_level
		FROM Feedback;
23.Find categories having more than 300 complaints
        SELECT
    cc.category_name,
    COUNT(c.complaint_id) AS total_complaints
FROM Complaint_Categories cc
JOIN Complaints c
ON cc.category_id = c.category_id
GROUP BY cc.category_id, cc.category_name
HAVING COUNT(c.complaint_id) > 300;
24.Find customers who have raised more than 2 complaints.
   SELECT
    cu.customer_name,
    COUNT(c.complaint_id) AS total_complaints
FROM Customers cu
JOIN Complaints c
ON cu.customer_id = c.customer_id
GROUP BY cu.customer_id, cu.customer_name
HAVING COUNT(c.complaint_id) > 2;
25.Find employees who have handled more than 5 complaints.
    SELECT
    e.employee_name,
    COUNT(ca.complaint_id) AS total_complaints
FROM Employees e
JOIN Complaint_Assignments ca
ON e.employee_id = ca.employee_id
GROUP BY e.employee_id, e.employee_name
HAVING COUNT(ca.complaint_id) > 5;
26.Find the top 3 complaint categories.
   SELECT
    cc.category_name,
    COUNT(c.complaint_id) AS total_complaints
FROM Complaint_Categories cc
JOIN Complaints c
ON cc.category_id = c.category_id
GROUP BY cc.category_id, cc.category_name
ORDER BY total_complaints DESC
LIMIT 3;
27.Find the city with the highest number of complaints.
   SELECT
    ci.city_name,
    COUNT(c.complaint_id) AS total_complaints
FROM Cities ci
JOIN Customers cu
ON ci.city_id = cu.city_id
JOIN Complaints c
ON cu.customer_id = c.customer_id
GROUP BY ci.city_id, ci.city_name
ORDER BY total_complaints DESC
LIMIT 1;
28.Find the department with the highest number of employees
   SELECT
    d.department_name,
    COUNT(e.employee_id) AS total_employees
FROM Departments d
JOIN Employees e
ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY total_employees DESC
LIMIT 1;
29.Find the average number of complaints handled by employees
   SELECT AVG(total_complaints) AS average_complaints
FROM (
    SELECT employee_id, COUNT(*) AS total_complaints
    FROM Complaint_Assignments
    GROUP BY employee_id
) AS employee_counts;
30.Find employees whose average resolution time is less than the overall average
   SELECT
    e.employee_name,
    AVG(
        DATEDIFF(
            ca.resolution_date,
            ca.assigned_date
        )
    ) AS average_resolution_days
FROM Employees e
JOIN Complaint_Assignments ca
ON e.employee_id = ca.employee_id
GROUP BY e.employee_id, e.employee_name
HAVING AVG(
    DATEDIFF(
        ca.resolution_date,
        ca.assigned_date
    )
) < (
    SELECT AVG(
        DATEDIFF(
            resolution_date,
            assigned_date
        )
    )
    FROM Complaint_Assignments
);
31.Find departments contributing more than 30% of total complaints
    SELECT
    d.department_name,
    COUNT(ca.complaint_id) AS total_complaints,
    ROUND(
        COUNT(ca.complaint_id) * 100.0 /
        (SELECT COUNT(*) FROM Complaint_Assignments),
        2
    ) AS percentage
FROM Departments d
JOIN Employees e
ON d.department_id = e.department_id
JOIN Complaint_Assignments ca
ON e.employee_id = ca.employee_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(ca.complaint_id) * 100.0 /
       (SELECT COUNT(*) FROM Complaint_Assignments) > 30;
32.Find each city percentage contribution to total complaints.
       SELECT
    ci.city_name,
    COUNT(c.complaint_id) AS total_complaints,
    ROUND(
        COUNT(c.complaint_id) * 100.0 /
        (SELECT COUNT(*) FROM Complaints),
        2
    ) AS percentage
FROM Cities ci
JOIN Customers cu
ON ci.city_id = cu.city_id
JOIN Complaints c
ON cu.customer_id = c.customer_id
GROUP BY ci.city_id, ci.city_name
ORDER BY percentage DESC;
33.Find the highest-rated complaint for each customer.
    WITH ranked_feedback AS (
    SELECT
        f.complaint_id,
        c.customer_id,
        f.rating,
        ROW_NUMBER() OVER (
            PARTITION BY c.customer_id
            ORDER BY f.rating DESC
        ) AS rn
    FROM Feedback f
    JOIN Complaints c
    ON f.complaint_id = c.complaint_id
)
SELECT
    customer_id,
    complaint_id,
    rating
FROM ranked_feedback
WHERE rn = 1;
34.Find the monthly resolved complaint count
   SELECT
    YEAR(c.complaint_date) AS complaint_year,
    MONTH(c.complaint_date) AS complaint_month,
    COUNT(*) AS resolved_complaints
FROM Complaints c
JOIN Complaint_Status cs
ON c.status_id = cs.status_id
WHERE cs.status_name = 'Resolved'
GROUP BY
    YEAR(c.complaint_date),
    MONTH(c.complaint_date)
ORDER BY
    complaint_year,
    complaint_month;

35.Create a view containing complete complaint details
		CREATE VIEW complaint_details AS
	SELECT
    c.complaint_id,
    cu.customer_name,
    cc.category_name,
    p.priority_name,
    cs.status_name,
    c.complaint_date,
    c.description
	FROM Complaints c
	JOIN Customers cu
	ON c.customer_id = cu.customer_id
	JOIN Complaint_Categories cc
	ON c.category_id = cc.category_id
	JOIN Priorities p
	ON c.priority_id = p.priority_id
	JOIN Complaint_Status cs
	ON c.status_id = cs.status_id;
    
36.Find employees who handled more than a given number of complaints
DELIMITER //
CREATE PROCEDURE GetEmployeesByComplaintCount(IN min_count INT)
BEGIN
    SELECT
        e.employee_id,
        e.employee_name,
        COUNT(ca.complaint_id) AS total_complaints
    FROM Employees e
    JOIN Complaint_Assignments ca
        ON e.employee_id = ca.employee_id
    GROUP BY e.employee_id, e.employee_name
    HAVING COUNT(ca.complaint_id) > min_count;
END //

DELIMITER ;
CALL GetEmployeesByComplaintCount(5);
        
37.Find average resolution days for an employee
DELIMITER //
CREATE PROCEDURE GetEmployeeResolutionTime(IN emp_id INT)
BEGIN
    SELECT
        e.employee_name,
        AVG(DATEDIFF(ca.resolution_date, ca.assigned_date))
        AS average_resolution_days
    FROM Employees e
    JOIN Complaint_Assignments ca
        ON e.employee_id = ca.employee_id
    WHERE e.employee_id = emp_id
    GROUP BY e.employee_id, e.employee_name;
END //
DELIMITER ;
call GetEmployeeResolutionTime(10);
38.Find complaints between two dates.
 DELIMITER //
CREATE PROCEDURE GetComplaintsBetweenDates(
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    SELECT
        complaint_id,
        customer_id,
        complaint_date,
        description
    FROM Complaints
    WHERE complaint_date BETWEEN start_date AND end_date;
END //
DELIMITER ;
CALL GetComplaintsBetweenDates('2025-01-01', '2025-06-30');
39.Track complaint status update.
DELIMITER //
CREATE TRIGGER after_complaint_status_update
AFTER UPDATE ON Complaints
FOR EACH ROW
BEGIN
    IF OLD.status_id <> NEW.status_id THEN
        INSERT INTO Audit_Log
        (table_name, action_type, action_date)
        VALUES
        ('Complaints', 'STATUS_CHANGE', NOW());
    END IF;
END //
DELIMITER ;

40.Prevent invalid feedback rating.
 DELIMITER //
CREATE TRIGGER before_feedback_insert
BEFORE INSERT ON Feedback
FOR EACH ROW
BEGIN
    IF NEW.rating < 1 OR NEW.rating > 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rating must be between 1 and 5';
    END IF;
END //
DELIMITER ;
41.Audit when complaint is deleted.
DELIMITER //
CREATE TRIGGER after_complaint_delete
AFTER DELETE ON Complaints
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log
    (table_name, action_type, action_date)
    VALUES
    ('Complaints', 'DELETE', NOW());
END //
DELIMITER ;




