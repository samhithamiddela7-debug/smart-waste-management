CREATE DATABASE IF NOT EXISTS smart_waste_db;
USE smart_waste_db;

DROP TABLE IF EXISTS Collection;
DROP TABLE IF EXISTS WasteBins;
DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS RecyclingCenters;

CREATE TABLE Locations (
    loc_id      INT PRIMARY KEY,
    area_name   VARCHAR(50),
    population  INT
);

CREATE TABLE WasteBins (
    bin_id        INT PRIMARY KEY,
    loc_id        INT,
    waste_type    VARCHAR(20),
    capacity      DECIMAL(6,2),
    current_fill  DECIMAL(6,2),
    FOREIGN KEY (loc_id) REFERENCES Locations(loc_id)
);

CREATE TABLE Collection (
    coll_id           INT PRIMARY KEY,
    bin_id            INT,
    col_date          DATE,
    collected_weight  DECIMAL(6,2),
    collector_name    VARCHAR(50),
    FOREIGN KEY (bin_id) REFERENCES WasteBins(bin_id)
);

CREATE TABLE RecyclingCenters (
    center_id  INT PRIMARY KEY,
    name       VARCHAR(50),
    capacity   DECIMAL(8,2)
);

INSERT INTO Locations VALUES (1, 'Downtown',     85000);
INSERT INTO Locations VALUES (2, 'North Sector', 52000);
INSERT INTO Locations VALUES (3, 'East Zone',    63000);
INSERT INTO Locations VALUES (4, 'West End',     47000);
INSERT INTO Locations VALUES (5, 'South Park',   71000);

INSERT INTO WasteBins VALUES (101, 1, 'General',     500.00, 430.00);
INSERT INTO WasteBins VALUES (102, 1, 'Recyclables', 300.00, 180.00);
INSERT INTO WasteBins VALUES (103, 2, 'Organic',     400.00, 390.00);
INSERT INTO WasteBins VALUES (104, 2, 'General',     500.00, 250.00);
INSERT INTO WasteBins VALUES (105, 3, 'Recyclables', 300.00, 120.00);
INSERT INTO WasteBins VALUES (106, 3, 'General',     500.00, 460.00);
INSERT INTO WasteBins VALUES (107, 4, 'Organic',     400.00, 200.00);
INSERT INTO WasteBins VALUES (108, 5, 'General',     500.00, 350.00);
INSERT INTO WasteBins VALUES (109, 5, 'Recyclables', 300.00,  90.00);
INSERT INTO WasteBins VALUES (110, 4, 'General',     500.00, 500.00);

INSERT INTO Collection VALUES (1001, 101, '2025-01-05', 420.00, 'Ravi Kumar');
INSERT INTO Collection VALUES (1002, 102, '2025-01-06', 175.00, 'Suresh Reddy');
INSERT INTO Collection VALUES (1003, 103, '2025-01-07', 385.00, 'Ravi Kumar');
INSERT INTO Collection VALUES (1004, 104, '2025-01-08', 240.00, 'Anita Sharma');
INSERT INTO Collection VALUES (1005, 105, '2025-02-10', 115.00, 'Suresh Reddy');
INSERT INTO Collection VALUES (1006, 106, '2025-02-11', 455.00, 'Ravi Kumar');
INSERT INTO Collection VALUES (1007, 107, '2025-02-12', 195.00, 'Anita Sharma');
INSERT INTO Collection VALUES (1008, 108, '2025-03-01', 340.00, 'Ravi Kumar');
INSERT INTO Collection VALUES (1009, 101, '2025-03-05', 410.00, 'Suresh Reddy');
INSERT INTO Collection VALUES (1010, 103, '2025-03-08', 380.00, 'Anita Sharma');

INSERT INTO RecyclingCenters VALUES (201, 'GreenCycle Hub',      5000.00);
INSERT INTO RecyclingCenters VALUES (202, 'EcoRecycle Plant',    8000.00);
INSERT INTO RecyclingCenters VALUES (203, 'CleanEarth Facility', 3500.00);
INSERT INTO RecyclingCenters VALUES (204, 'BioRecycle Center',   6200.00);

SELECT l.area_name, COUNT(w.bin_id) AS total_bins
FROM Locations l
LEFT JOIN WasteBins w ON l.loc_id = w.loc_id
GROUP BY l.area_name
ORDER BY total_bins DESC;

SELECT collector_name, SUM(collected_weight) AS total_collected
FROM Collection
GROUP BY collector_name
ORDER BY total_collected DESC
LIMIT 1;

SELECT l.area_name,
       ROUND(AVG((w.current_fill / w.capacity) * 100), 2) AS avg_fill_pct
FROM Locations l
JOIN WasteBins w ON l.loc_id = w.loc_id
GROUP BY l.area_name
ORDER BY avg_fill_pct DESC;

SELECT w.bin_id, l.area_name, w.waste_type,
       ROUND((w.current_fill / w.capacity) * 100, 2) AS fill_pct
FROM WasteBins w
JOIN Locations l ON w.loc_id = l.loc_id
WHERE (w.current_fill / w.capacity) * 100 > 80
ORDER BY fill_pct DESC;

SELECT l.area_name, SUM(c.collected_weight) AS total_waste
FROM Collection c
JOIN WasteBins w ON c.bin_id = w.bin_id
JOIN Locations l ON w.loc_id = l.loc_id
GROUP BY l.area_name
ORDER BY total_waste DESC;

SELECT l.area_name,
       COUNT(w.bin_id) AS num_bins,
       ROUND(AVG((w.current_fill / w.capacity) * 100), 2) AS avg_fill_pct
FROM Locations l
JOIN WasteBins w ON l.loc_id = w.loc_id
GROUP BY l.area_name;

SELECT w.waste_type, SUM(c.collected_weight) AS total_by_type
FROM Collection c
JOIN WasteBins w ON c.bin_id = w.bin_id
WHERE MONTH(c.col_date) = 1
  AND YEAR(c.col_date)  = 2025
GROUP BY w.waste_type;

SELECT l.area_name, l.population, COUNT(w.bin_id) AS bin_count
FROM Locations l
LEFT JOIN WasteBins w ON l.loc_id = w.loc_id
GROUP BY l.area_name, l.population
ORDER BY l.population DESC, bin_count ASC;

SELECT l.area_name, SUM(c.collected_weight) AS total_waste
FROM Collection c
JOIN WasteBins w ON c.bin_id = w.bin_id
JOIN Locations l ON w.loc_id = l.loc_id
GROUP BY l.area_name
ORDER BY total_waste DESC
LIMIT 3;

SELECT c.collector_name, COUNT(DISTINCT l.loc_id) AS unique_areas
FROM Collection c
JOIN WasteBins w ON c.bin_id = w.bin_id
JOIN Locations l ON w.loc_id = l.loc_id
GROUP BY c.collector_name
ORDER BY unique_areas DESC;

SELECT waste_type,
       ROUND(AVG((current_fill / capacity) * 100), 2) AS avg_fill_pct
FROM WasteBins
GROUP BY waste_type
ORDER BY avg_fill_pct DESC
LIMIT 1;

SELECT SUM(capacity) AS total_recycling_capacity
FROM RecyclingCenters;

SELECT name, capacity
FROM RecyclingCenters
WHERE capacity > (SELECT AVG(capacity) FROM RecyclingCenters)
ORDER BY capacity DESC;

SELECT w.bin_id, l.area_name, w.waste_type
FROM WasteBins w
JOIN Locations l ON w.loc_id = l.loc_id
WHERE w.bin_id NOT IN (SELECT DISTINCT bin_id FROM Collection);

SELECT MONTH(col_date) AS month,
       YEAR(col_date)  AS year,
       SUM(collected_weight) AS total_waste
FROM Collection
GROUP BY YEAR(col_date), MONTH(col_date)
ORDER BY total_waste DESC
LIMIT 1;