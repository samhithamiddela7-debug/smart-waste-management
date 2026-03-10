# 🗑️ Smart Waste Management System

A relational database system designed to help municipal bodies efficiently manage waste collection, recycling, and disposal operations across urban areas.

---

## 📌 What This Project Does

This system stores and manages data about:
- City locations and their populations
- Waste bins placed in each area (type, capacity, fill level)
- Waste collection events (who collected, how much, when)
- Recycling centers and their capacities

It helps authorities:
- Track which bins are nearly full and need collection
- Monitor collector performance
- Analyze waste generation by area or type
- Optimize recycling center usage

---

## 🗂️ Database Tables

| Table | What it stores |
|-------|---------------|
| `Locations` | City areas with population data |
| `WasteBins` | Bins with waste type, capacity, and current fill level |
| `Collection` | Records of each waste collection event |
| `RecyclingCenters` | Recycling facilities and their capacities |

---

## 📁 File Structure

```
smart-waste-management/
│
├── sql/
│   ├── schema.sql       # Creates all 4 tables
│   ├── inserts.sql      # Sample data for testing
│   ├── queries.sql      # 13 SQL queries for analysis
│   └── plsql.sql        # Procedures, functions, triggers, cursors
│
└── README.md
```

---

## 🔍 Queries Included

- Count bins per area
- Find bins above 80% fill level
- Top 3 locations by total waste collected
- Collector who collected the most waste
- Average fill percentage per area
- Waste type with highest fill percentage
- Bins that have never been collected
- Month with highest total waste collection
- Locations with high population but fewer bins
- Total and above-average recycling capacity

---

## ⚙️ PL/SQL Features

- **Function** — calculates fill percentage for any bin
- **Trigger** — prevents bin fill from exceeding capacity
- **Procedure** — adds a new collection record
- **Cursor** — loops through and displays all locations

---

## 🚀 How to Run

1. Open **Oracle SQL Developer**
2. Run the files in this order:

```
schema.sql → inserts.sql → queries.sql → plsql.sql
```

---

## 🛠️ Technologies Used

- Oracle SQL
- PL/SQL
- Concepts: ER Modeling, Normalization (1NF, 2NF, 3NF), DDL, DML, Triggers, Cursors, Stored Procedures
