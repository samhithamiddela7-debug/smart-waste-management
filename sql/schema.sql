-- ============================================================
-- SMART WASTE MANAGEMENT SYSTEM
-- Database Schema (DDL)
-- ============================================================

-- Table 1: Locations
CREATE TABLE Locations (
    loc_id    INT PRIMARY KEY,
    area_name VARCHAR(50),
    population INT
);

-- Table 2: WasteBins
CREATE TABLE WasteBins (
    bin_id       INT PRIMARY KEY,
    loc_id       INT,
    waste_type   VARCHAR(20),
    capacity     DECIMAL(6,2),
    current_fill DECIMAL(6,2),
    FOREIGN KEY (loc_id) REFERENCES Locations(loc_id)
);

-- Table 3: Collection
CREATE TABLE Collection (
    coll_id          INT PRIMARY KEY,
    bin_id           INT,
    date             DATE,
    collected_weight DECIMAL(6,2),
    collector_name   VARCHAR(50),
    FOREIGN KEY (bin_id) REFERENCES WasteBins(bin_id)
);

-- Table 4: RecyclingCenters
CREATE TABLE RecyclingCenters (
    center_id INT PRIMARY KEY,
    name      VARCHAR(50),
    capacity  DECIMAL(8,2)
);
