# ER Diagram - Airbnb Clone Database

This document explains the Entity-Relationship Diagram (ERD) for the Airbnb clone project. The goal of the ERD is to provide a clear structure of how users, properties, bookings, payments, messages, and reviews interact in the system.

## 🔧 Tool Used

- Diagram created using **Draw.io**
- File saved as `airbnb.drawio.png`

---

## 📦 Entities and Attributes

### 1. **User**
- Represents all users (guests, hosts, admins).
- Attributes:
  - `user_id` (Primary Key): Unique identifier.
  - `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`
- The `role` field helps distinguish whether the user is a **guest**, **host**, or **admin**.

### 2. **Property**
- Represents listings created by hosts.
- Attributes:
  - `property_id` (Primary Key)
  - `name`, `description`, `location`, `pricernight`, `updated_at`, `created_at`
  - `host_id` (Foreign Key): Links to `user_id` in **User** (host who created the listing)

### 3. **Booking**
- Represents a reservation made by a guest for a property.
- Attributes:
  - `booking_id` (Primary Key)
  - `user_id` (FK to User), `property_id` (FK to Property)
  - `start_date`, `end_date`, `total_price`, `status`, `created_at`
- Links a guest to a specific property and timeframe.

### 4. **Payment**
- Tracks payments made for bookings.
- Attributes:
  - `payment_id` (Primary Key)
  - `booking_id` (FK to Booking)
  - `amount`, `payment_date`, `payment_method`

### 5. **Review**
- Users can leave a review on a property after booking.
- Attributes:
  - `review_id` (Primary Key)
  - `property_id` (FK to Property), `user_id` (FK to User)
  - `rating`, `comment`, `created_at`

### 6. **Message**
- Represents messages between users (guest ↔ host).
- Attributes:
  - `message_id` (Primary Key)
  - `sender_id` (FK to User), `recipient_id` (FK to User)
  - `message_body`, `sent_at`

---

## 🔗 Relationships

- **User ↔ Booking**: A user can make multiple bookings (1-to-many).
- **User ↔ Property**: A user (host) can list multiple properties (1-to-many).
- **User ↔ Review**: A user can leave multiple reviews (1-to-many).
- **Property ↔ Booking**: A property can have many bookings (1-to-many).
- **Booking ↔ Payment**: One booking leads to one payment (1-to-1).
- **Property ↔ Review**: A property can receive multiple reviews (1-to-many).
- **User ↔ Message**: Users can send and receive many messages (many-to-many modeled via sender_id and recipient_id).

---

## ✅ Design Justifications

- **Separation of Concerns**: Each entity focuses on a distinct part of the system (user management, listings, transactions, feedback, communication).
- **Role Handling**: Instead of creating separate tables for guests and hosts, the `role` field in `User` supports flexibility and reduces redundancy.
- **Normalization**: The database avoids duplicate data (e.g., no embedding user or property info directly in booking or payment).
- **Extensibility**: Easy to add features like favorites, property images, or booking cancellations later.

---

## 📁 Files Included

- `ERD/airbnb.drawio.png`: ER diagram image.
- `ERD/requirements.md`: This documentation file.

---

## 📌 Summary

This ERD models the essential components of an Airbnb-like platform, including user roles, property listings, bookings, payments, communication, and feedback. The design ensures flexibility, scalability, and clarity in data relationships.

