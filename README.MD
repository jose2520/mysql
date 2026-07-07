# SQL & Dataset Explanation

## Dataset Overview

The dataset `Dataset_EcoMarketRiwi_Jornada_Tarde.csv` contains flat, denormalized order transaction records from EcoMarket Riwi S.A.S., a Colombian logistics company. 

**Key Fields:**
- **ClientName**: Customer/store names (Super Max, Fresh Mart, etc.)
- **City**: Colombian cities (Bogotá, Medellín, Cali, etc.)
- **Product**: Individual product items (Apple Gala, Banana, Whole Milk, etc.)
- **Category**: Product classification (Fruit, Dairy, Meat, Grain, Oil, Vegetable)
- **DistributionCenter**: Regional warehouse locations (Center North, Center West, etc.)
- **OrderID**: Unique transaction identifier (O1001-O1020)
- **OrderDate**: Transaction date (May 2026)
- **Quantity**: Units ordered per transaction
- **UnitPrice**: Price per unit
- **Stock**: Inventory level after transaction

The dataset contains 20 order records showing the afternoon shift ("Jornada Tarde") operations.

---

## SQL Database Architecture

The `bd.sql` script transforms this flat data into a **3rd Normal Form (3NF)** relational structure with 8 normalized tables:

### Core Tables:

| Table | Purpose | Key Columns |
|-------|---------|------------|
| **eco_country** | Nations reference | eco_id, eco_name |
| **eco_cities** | Geographic locations | eco_id, eco_name, eco_country_id (FK) |
| **eco_customers** | Client information | eco_id, eco_name, eco_city_id (FK) |
| **eco_categories** | Product classifications | eco_id, eco_name |
| **eco_products** | Product catalog | eco_id, eco_name, eco_category_id (FK), eco_price |
| **eco_distribution_centers** | Warehouse locations | eco_id, eco_name, eco_city_id (FK) |
| **eco_inventories** | Stock levels per center | eco_id, eco_dc_id (FK), eco_product_id (FK), eco_stock |
| **eco_orders** | Purchase transactions | eco_id, eco_date, eco_customer_id (FK) |
| **eco_order_details** | Line items per order | eco_id, eco_order_id (FK), eco_product_id (FK), eco_quantity, eco_unit_price |

### Design Principles:
- ✅ **Naming Convention**: All tables & columns use `eco_` prefix
- ✅ **Referential Integrity**: Foreign key constraints prevent orphaned records
- ✅ **Data Normalization**: Eliminates redundancy (e.g., city names appear once, not repeated)
- ✅ **Cardinality**: Properly models one-to-many relationships

---

## SQL Operations Included

### 1️⃣ **DDL (Data Definition Language)**
Creates the complete normalized schema with constraints:
```sql
CREATE TABLE eco_customers (
    eco_id INT AUTO_INCREMENT PRIMARY KEY,
    eco_name VARCHAR(100) NOT NULL,
    eco_city_id INT NOT NULL,
    CONSTRAINT fk_eco_customer_city FOREIGN KEY (eco_city_id) 
        REFERENCES eco_cities(eco_id)
);
```

### 2️⃣ **DML (Data Manipulation Language)**
- **INSERT**: Populates tables from CSV data (countries, cities, products, orders)
- **UPDATE**: Modifies existing records (e.g., distribution center names)
- **DELETE**: Removes products with safeguards against referential integrity violations

### 3️⃣ **DQL (Data Query Language) - Business Analytics**

Six key analytical queries address business needs:

| Query | Purpose | Example Use |
|-------|---------|------------|
| **Inventory by Product** | Stock availability planning | Identify items to reorder |
| **Orders by City** | Geographic performance analysis | Which regions generate most sales? |
| **Revenue by Category** | Financial performance tracking | Which product lines are profitable? |
| **Low Stock Products** | Logistics optimization | Which items are running out? |
| **Top Customers** | Customer relationship focus | Who are our most active clients? |
| **Inventory Value by DC** | Asset management | What's the economic value stored in each warehouse? |

### 4️⃣ **Advanced Objects - Views**

Two SQL views provide pre-aggregated business intelligence:

```sql
-- Commercial Product Performance
eco_vw_commercial_product_performance
↳ Shows: Product name, Category, Total units sold, Total revenue

-- Customer Geographic Segments
eco_vw_customer_geo_segments
↳ Shows: City, Number of unique customers, Total orders
```

---

## Data Transformation Example

**CSV Row (Flat):**
```
Super Max, Bogotá, Apple Gala, Fruit, Center North, O1001, 2026-05-01, 10, 2.5, 100
```

**Becomes (Normalized):**
| Table | Record |
|-------|--------|
| eco_customers | (id: 1, name: Super Max, city_id: 1) |
| eco_cities | (id: 1, name: Bogotá, country_id: 1) |
| eco_products | (id: 1, name: Apple Gala, category_id: 1, price: 2.5) |
| eco_orders | (id: 1001, date: 2026-05-01, customer_id: 1) |
| eco_order_details | (order_id: 1001, product_id: 1, qty: 10, price: 2.5) |

This eliminates redundancy: "Bogotá" is stored once, not repeated across 20 rows.

## Repository :
https://github.com/jose2520/mysql.git
