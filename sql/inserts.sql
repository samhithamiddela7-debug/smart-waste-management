-- ============================================================
-- SMART WASTE MANAGEMENT SYSTEM
-- Sample Data Insertions
-- ============================================================

-- Insert into Locations
INSERT INTO Locations VALUES (1, 'Downtown', 50000);
INSERT INTO Locations VALUES (2, 'North Sector', 30000);
INSERT INTO Locations VALUES (3, 'East Zone', 45000);
INSERT INTO Locations VALUES (4, 'West End', 25000);
INSERT INTO Locations VALUES (5, 'South Park', 35000);

-- Insert into WasteBins
INSERT INTO WasteBins VALUES (101, 1, 'General',    500.00, 420.00);
INSERT INTO WasteBins VALUES (102, 1, 'Recyclables',300.00, 150.00);
INSERT INTO WasteBins VALUES (103, 2, 'Organic',    400.00, 380.00);
INSERT INTO WasteBins VALUES (104, 3, 'General',    500.00, 200.00);
INSERT INTO WasteBins VALUES (105, 4, 'Recyclables',300.00, 290.00);
INSERT INTO WasteBins VALUES (106, 5, 'Organic',    400.00,  50.00);

-- Insert into Collection
INSERT INTO Collection VALUES (201, 101, '2025-11-01', 400.00, 'Ravi Kumar');
INSERT INTO Collection VALUES (202, 102, '2025-11-02', 140.00, 'Suresh Babu');
INSERT INTO Collection VALUES (203, 103, '2025-11-03', 370.00, 'Ravi Kumar');
INSERT INTO Collection VALUES (204, 104, '2025-11-04', 190.00, 'Anita Sharma');
INSERT INTO Collection VALUES (205, 105, '2025-11-05', 280.00, 'Suresh Babu');
INSERT INTO Collection VALUES (206, 101, '2025-11-06', 380.00, 'Ravi Kumar');

-- Insert into RecyclingCenters
INSERT INTO RecyclingCenters VALUES (301, 'GreenLife Center',  5000.00);
INSERT INTO RecyclingCenters VALUES (302, 'EcoRecycle Hub',    8000.00);
INSERT INTO RecyclingCenters VALUES (303, 'CleanCity Facility',3000.00);
