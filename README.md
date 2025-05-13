# S02.01 - SQL Database Modeling

---

# 🎯 Objectives

- Learn how to model SQL databases.
- Understand database relationships and constraints.
- Practice creating comprehensive database schemas for real-world scenarios.

---

## 🔹 Improvements Added

### 📌 Optimized Data Storage Approach

In several tables where storing counts of values (likes, dislikes, play counts, etc.) was originally required, we've implemented the following improvements:

1. **Dual Implementation Strategy**:
   - Maintained the original count fields in database tables for backward compatibility
   - Developed alternative queries that dynamically calculate these values through table relationships

2. **Key Benefits Achieved**:
   - **Data Integrity**: Eliminates synchronization issues between counters and actual records
   - **Storage Efficiency**: Reduces database size by avoiding redundant count storage
   - **Historical Analysis**: Enables tracking changes over time through relationship tables
   - **Flexibility**: Supports both immediate-count and on-demand-calculation approaches

3. **Implementation Examples** (for reference):
   - Video like/dislike counts now calculated from user interaction records
   - Playlist song counts derived from junction table entries
   - View counts aggregated from playback history logs

This architectural improvement maintains all original functionality while following database normalization best practices.

---

## 🔹 Level 1

### 📘 Exercise 1 - Optician ("Cul d'Ampolla")

An optician called "Cul d'Ampolla" wants to computerize the management of customers and glasses sales.

1. For each supplier, store:
   - Name
   - Address (street, number, floor, door, city, postal code, country)
   - Phone
   - Fax
   - NIF

2. For glasses, store:
   - Brand (each brand has one exclusive supplier)
   - Graduation for each lens
   - Frame type (floating, paste, or metallic)
   - Frame color
   - Lens color
   - Price

3. For customers, store:
   - Name
   - Postal address
   - Phone
   - Email
   - Registration date
   - Referrer customer (if any)
   - Which employee sold each pair of glasses

---

### 📘 Exercise 2 - Pizzeria

Design a database for an online food delivery website.

1. For each customer store:
   - Unique ID
   - Name
   - Surname
   - Address
   - Postal code
   - Location
   - Province
   - Phone number
   - (Locations and provinces in separate tables)

2. For each order store:
   - Unique ID
   - Date/time
   - Delivery or pickup
   - Product quantities
   - Total price
   - (One customer can make many orders)

3. Products can be:
   - Pizzas (with categories that may change names)
   - Hamburgers
   - Drinks
   - (Each with ID, name, description, image, price)

4. For stores:
   - Unique ID
   - Address
   - Postal code
   - Location
   - Province
   - Employees (cooks or delivery staff)

---

## 🔹 Level 2

### 📘 Exercise 1 - YouTube

Model a simplified YouTube database.

1. For users store:
   - Unique ID
   - Email
   - Password
   - Username
   - Birthdate
   - Gender
   - Country
   - Postal code

2. For videos store:
   - Unique ID
   - Title
   - Description
   - Size
   - Filename
   - Duration
   - Thumbnail
   - Views
   - Likes/dislikes
   - Status (public, hidden, private)
   - Tags
   - Uploader and timestamp

3. Additional features:
   - Channels (with subscriptions)
   - Playlists (public/private)
   - Comments (with likes/dislikes)
   - Video ratings tracking

---

## 🔹 Level 3

### 📘 Exercise 1 - Spotify

Model a simplified Spotify database.

1. Two user types: free and premium
   - Both store: ID, email, password, username, birthdate, gender, country, postal code
   - Premium users have subscriptions with payment info (credit card or PayPal)

2. For playlists:
   - Title
   - Song count
   - Unique ID
   - Creation date
   - Active/deleted status
   - Shared playlists tracking

3. Music structure:
   - Songs belong to albums
   - Albums belong to artists
   - Track: ID, title, duration, play count
   - Album: ID, title, year, cover image
   - Artist: ID, name, image

4. Social features:
   - User follows artists
   - Artist relationships
   - Favorite albums/songs

---

# 🛠️ Technologies Used

- MySQL (MariaDb)
- Database Design Principles
- Entity-Relationship Modeling
- Normalization Techniques

---

## ⚙️ Installation & Execution

### 📋 Requirements

To work with these database models, you need:

- Database management system: MySQL (MariaDb).
- Database design tool: DBeaver and HeidiSQL.

---

### 🛠️ Installation

1. Install your preferred database system
2. Use a database design tool to create the schemas
3. Implement the models with SQL scripts

---

### ▶️ Execution

1. Create the database schema
2. Populate with test data
3. Verify relationships with sample queries

---

# 🌐 Deployment

These database models are designed for educational purposes and can be implemented in any SQL environment.

---

## 📦 Repository

You can store your SQL implementation in any version control system like Git.

---

## ✅ Author Notes

These exercises are designed to give you practical experience with database modeling, relationships, and real-world scenario implementation.

After creating the databases, populate the tables with test data to verify that the relationships work correctly.

Happy modeling! 🚀