CREATE DATABASE company_db;
USE company_db;


CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TABLE managers (
    manager_name VARCHAR(50),
    employee_id INT NULL,
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);



INSERT INTO employee (employee_id, first_name, last_name)
VALUES
    (1, 'Ashutosh', 'Behuria'),
    (2, 'Alok', 'Kumar'),
    (3, 'Mike', 'Tyson'),
    (4, 'David', 'Googgins'),
    (5, 'Sara', 'Willams');
    (6, 'Tom', 'Harris');



INSERT INTO managers (manager_name, employee_id)
VALUES
    ('Alice', 1),
    ('Bob', 2),
    ('Alice', 3),
    ('Charlie', 4),
    ('Bob', 5),
    ('David', NULL);

--All Employees Under Each Manager

SELECT 
    m.manager_name,
    e.employee_id,
    e.first_name,
    e.last_name
FROM 
    managers m
JOIN 
    employee e ON m.employee_id = e.employee_id
ORDER BY 
    m.manager_name;

 --Count Employees Are Under a Manager (e.g., Alice)

 SELECT 
    COUNT(e.employee_id) AS employee_count
FROM 
    managers m
JOIN 
    employee e ON m.employee_id = e.employee_id
WHERE 
    m.manager_name = 'Alice';

-- Managers' Details

SELECT 
    m.manager_name,
    e.employee_id,
    e.first_name,
    e.last_name
FROM 
    managers m
LEFT JOIN 
    employee e ON m.employee_id = e.employee_id
ORDER BY 
    m.manager_name;

--Employees Who Are Not Assigned a Manager

SELECT 
    e.employee_id,
    e.first_name,
    e.last_name
FROM 
    employee e
LEFT JOIN 
    managers m ON e.employee_id = m.employee_id
WHERE 
    m.employee_id IS NULL;

--Function to Get Full Name (first_name + last_name)
DELIMITER $$

CREATE FUNCTION get_full_name(emp_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE full_name VARCHAR(100);
    SELECT CONCAT(first_name, ' ', last_name) INTO full_name
    FROM employee
    WHERE employee_id = emp_id;
    RETURN full_name;
END $$

DELIMITER ;

SELECT get_full_name(1) AS full_name;

