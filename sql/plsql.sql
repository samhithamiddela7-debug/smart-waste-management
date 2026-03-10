-- ============================================================
-- SMART WASTE MANAGEMENT SYSTEM
-- PL/SQL: Procedures, Functions, Triggers, Cursors
-- ============================================================

-- -------------------------------------------------------
-- 1. PL/SQL Block: Insert a new record into Locations
-- -------------------------------------------------------
BEGIN
    INSERT INTO Locations (loc_id, area_name, population)
    VALUES (6, 'Central Hub', 60000);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Record inserted successfully.');
END;
/

-- -------------------------------------------------------
-- 2. Function: bin_fill_percentage
--    Accepts bin_id, returns fill percentage
-- -------------------------------------------------------
CREATE OR REPLACE FUNCTION bin_fill_percentage(p_bin_id IN INT)
RETURN NUMBER IS
    v_capacity     DECIMAL(6,2);
    v_current_fill DECIMAL(6,2);
    v_percentage   NUMBER;
BEGIN
    SELECT capacity, current_fill
    INTO   v_capacity, v_current_fill
    FROM   WasteBins
    WHERE  bin_id = p_bin_id;

    v_percentage := ROUND((v_current_fill / v_capacity) * 100, 2);
    RETURN v_percentage;
END;
/

-- Usage:
-- SELECT bin_fill_percentage(101) FROM DUAL;

-- -------------------------------------------------------
-- 3. Trigger: Prevent current_fill from exceeding capacity
-- -------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_check_fill
BEFORE UPDATE ON WasteBins
FOR EACH ROW
BEGIN
    IF :NEW.current_fill > :NEW.capacity THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Error: current_fill cannot exceed capacity for bin ' || :NEW.bin_id
        );
    END IF;
END;
/

-- -------------------------------------------------------
-- 4. Explicit Cursor: Display all area names & populations
-- -------------------------------------------------------
DECLARE
    CURSOR loc_cursor IS
        SELECT area_name, population FROM Locations;
    v_area   Locations.area_name%TYPE;
    v_pop    Locations.population%TYPE;
BEGIN
    OPEN loc_cursor;
    LOOP
        FETCH loc_cursor INTO v_area, v_pop;
        EXIT WHEN loc_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Area: ' || v_area || ' | Population: ' || v_pop);
    END LOOP;
    CLOSE loc_cursor;
END;
/

-- -------------------------------------------------------
-- 5. Procedure: add_collection
--    Inserts a new record into the Collection table
-- -------------------------------------------------------
CREATE OR REPLACE PROCEDURE add_collection (
    p_coll_id          IN INT,
    p_bin_id           IN INT,
    p_date             IN DATE,
    p_collected_weight IN DECIMAL,
    p_collector_name   IN VARCHAR2
) IS
BEGIN
    INSERT INTO Collection (coll_id, bin_id, date, collected_weight, collector_name)
    VALUES (p_coll_id, p_bin_id, p_date, p_collected_weight, p_collector_name);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Collection record added successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Usage:
-- EXEC add_collection(207, 103, DATE '2025-11-10', 350.00, 'Ravi Kumar');
