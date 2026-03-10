-- ============================================================
-- SMART WASTE MANAGEMENT SYSTEM
-- Sample Queries
-- ============================================================

-- Q1: Count how many bins are assigned to each area
SELECT l.area_name, COUNT(b.bin_id) AS total_bins
FROM Locations l
JOIN WasteBins b ON l.loc_id = b.loc_id
GROUP BY l.area_name;

-- Q2: Collector who collected the maximum total waste
SELECT collector_name, SUM(collected_weight) AS total_collected
FROM Collection
GROUP BY collector_name
ORDER BY total_collected DESC
FETCH FIRST 1 ROWS ONLY;

-- Q3: Average fill percentage of bins in each area
SELECT l.area_name,
       ROUND(AVG((b.current_fill / b.capacity) * 100), 2) AS avg_fill_pct
FROM Locations l
JOIN WasteBins b ON l.loc_id = b.loc_id
GROUP BY l.area_name;

-- Q4: Bins above 80% fill
SELECT bin_id, waste_type,
       ROUND((current_fill / capacity) * 100, 2) AS fill_pct
FROM WasteBins
WHERE (current_fill / capacity) * 100 > 80;

-- Q5: Total waste collected by waste type for a selected month/year
SELECT b.waste_type, SUM(c.collected_weight) AS total_weight
FROM Collection c
JOIN WasteBins b ON c.bin_id = b.bin_id
WHERE EXTRACT(MONTH FROM c.date) = 11
  AND EXTRACT(YEAR  FROM c.date) = 2025
GROUP BY b.waste_type;

-- Q6: Find locations with the highest population but fewer bins
SELECT l.area_name, l.population, COUNT(b.bin_id) AS bin_count
FROM Locations l
LEFT JOIN WasteBins b ON l.loc_id = b.loc_id
GROUP BY l.area_name, l.population
ORDER BY l.population DESC, bin_count ASC;

-- Q7: Top 3 locations by total collected waste
SELECT l.area_name, SUM(c.collected_weight) AS total_waste
FROM Locations l
JOIN WasteBins  b ON l.loc_id = b.loc_id
JOIN Collection c ON b.bin_id = c.bin_id
GROUP BY l.area_name
ORDER BY total_waste DESC
FETCH FIRST 3 ROWS ONLY;

-- Q8: Find collectors and the number of unique areas they worked in
SELECT c.collector_name, COUNT(DISTINCT b.loc_id) AS areas_covered
FROM Collection c
JOIN WasteBins b ON c.bin_id = b.bin_id
GROUP BY c.collector_name;

-- Q9: Waste type with the highest average fill percentage
SELECT waste_type,
       ROUND(AVG((current_fill / capacity) * 100), 2) AS avg_fill_pct
FROM WasteBins
GROUP BY waste_type
ORDER BY avg_fill_pct DESC
FETCH FIRST 1 ROWS ONLY;

-- Q10: Total recycling capacity across all centers
SELECT SUM(capacity) AS total_recycling_capacity
FROM RecyclingCenters;

-- Q11: Centers with above-average recycling capacity
SELECT name, capacity
FROM RecyclingCenters
WHERE capacity > (SELECT AVG(capacity) FROM RecyclingCenters);

-- Q12: Waste bins which have never been collected
SELECT bin_id, waste_type, current_fill
FROM WasteBins
WHERE bin_id NOT IN (SELECT DISTINCT bin_id FROM Collection);

-- Q13: Find the month with the highest total waste collection
SELECT EXTRACT(MONTH FROM date) AS month,
       SUM(collected_weight) AS total_weight
FROM Collection
GROUP BY EXTRACT(MONTH FROM date)
ORDER BY total_weight DESC
FETCH FIRST 1 ROWS ONLY;
