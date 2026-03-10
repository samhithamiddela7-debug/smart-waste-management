# 🗑️ Smart Waste Management System

A Course-Based Project for **Database Management System Laboratory (22PC2AM201)**

**Department of Information Technology**
Vallurupalli Nageswara Rao Vignana Jyothi Institute of Engineering & Technology (VNRVJIET)

---

## 👥 Team Members

| Name         | Roll Number |
|--------------|-------------|
| M. Sathwik   | 24071A1238  |
| M. Praneeth  | 24071A1239  |
| M. Samhitha  | 24071A1240  |
| M. Varshitha | 24071A1241  |

**Guide:** DR. B. Raswitha, Assistant Professor, Dept. of IT

---

## 📌 About the Project

The **Smart Waste Management Database System** is a relational database designed to help municipal bodies and environmental organizations efficiently manage:
- Waste collection and recycling operations
- Bin fill levels and collection scheduling
- Recycling center capacity tracking

---

## 🗂️ Database Schema

| Table            | Description                                  |
|------------------|----------------------------------------------|
| `Locations`      | City areas/zones with population info        |
| `WasteBins`      | Bins with type, capacity, and fill status    |
| `Collection`     | Waste collection events and collector info   |
| `RecyclingCenters` | Recycling facilities with capacity info   |

---

## 📁 File Structure

```
smart-waste-management/
│
├── sql/
│   ├── schema.sql      # DDL - Table creation
│   ├── inserts.sql     # Sample data insertions
│   ├── queries.sql     # SQL queries (13 queries)
│   └── plsql.sql       # PL/SQL blocks, functions, triggers, cursors
│
└── README.md
```

---

## 🚀 How to Run

1. Open Oracle SQL Developer or any Oracle-compatible SQL tool.
2. Run files in this order:
   ```
   schema.sql  →  inserts.sql  →  queries.sql  →  plsql.sql
   ```

---

## 🔧 Technologies Used

- **Database:** Oracle SQL / PL/SQL
- **Concepts:** ER Modeling, Normalization (1NF, 2NF, 3NF), DDL, DML, Stored Procedures, Triggers, Cursors

---

## 📄 License

This project is submitted for academic purposes at VNRVJIET, Hyderabad (2025–2026).
