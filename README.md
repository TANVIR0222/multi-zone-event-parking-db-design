# Multi-Zone Event Parking System (Comic-Con India)

A comprehensive database architecture and ER design for managing high-traffic parking logistics during large-scale events like Comic-Con India.

## Project Context

A large convention venue hosting **Comic-Con India** needs a robust system to manage thousands of visitors. The system handles various vehicle types, structured parking zones (multiple levels), and specialized reserved categories for VIPs, Cosplayers, Staff, and EV vehicles.

## Core Features

- **Multi-Vehicle Support:** Specialized tracking for Bikes, Cars, SUVs, Cabs, and EVs.
- **Role-Based Reserved Parking:** Dedicated zones for:
  - Cosplayers with props (Extra space requirements).
  - Exhibitors, Creators, and VIP guests.
  - Event Staff and EV Charging stations.
- **Dynamic Session Management:** Real-time entry/exit tracking with unique parking tickets.
- **Automated Fee Calculation:** Pricing based on vehicle type, user category, and duration.
- **Live Availability:** Track spot availability across different zones and levels.

## 🏗️ Database Architecture (ERD Highlights)

The system is built on a highly normalized relational structure:

### **Key Entities:**

- **VehicleRegistration:** Stores owner info and vehicle types.
- **ParkingSession:** The heart of the system; tracks every entry/exit and connects vehicles to slots.
- **ParkingSlot:** Managed by Zones and Levels with `is_occupied` and `category` flags.
- **Payment & EVCharging:** Integrated modules to calculate final bills and charging costs.

### **Relationship Logic:**

- **1:1** - `ParkingSession` ↔ `Payment` (Each session has one final payment).
- **1:N** - `Vehicle` ↔ `ParkingSession` (One vehicle can visit multiple times across days).
- **M:N** - `UserType` ↔ `ParkingZone` (Access control for different user categories across multiple zones).

## 📊 ER Diagram

_(Insert your Eraser.io Diagram Screenshot here)_

> **Tip:** You can view the full architecture in the `/docs` folder.

## 🛠️ Tech Stack & Design Principles

- **Database:** PostgreSQL / MySQL compliant.
- **Modeling:** 3rd Normal Form (3NF) to ensure zero data redundancy.
- **Scaling:** Indexed on `vehicle_number` and `entry_time` for fast retrieval.

## Business Logic Addressed

- [x] Can a vehicle enter multiple times? **Yes, via multiple sessions.**
- [x] Can spots be reused? **Yes, status flips to 'available' after exit.**
- [x] Is EV charging tracked? **Yes, via the EVCharging module linked to the session.**
- [x] Can we identify currently parked vehicles? **Yes, filter by `status = 'active'`.**
