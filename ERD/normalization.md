# Database Normalization – Airbnb Clone

This document explains the normalization process applied to our database design to ensure it satisfies **Third Normal Form (3NF)**. The goal is to eliminate redundancy and ensure data integrity across all tables.

---

## 🔹 First Normal Form (1NF)

### ✅ Criteria:
- Each table must have a primary key.
- All columns must contain atomic (indivisible) values.
- No repeating groups or arrays.

### 🛠 Review:
| Table     | Passes 1NF? | Notes |
|-----------|-------------|-------|
| User      | ✅           | All fields are atomic (e.g., `first_name`, `role`). |
| Property  | ✅           | Each listing has a single host, description, etc. |
| Booking   | ✅           | No multi-valued or repeating fields. |
| Payment   | ✅           | One payment per booking. |
| Message   | ✅           | One message per row. |
| Review    | ✅           | Each row captures a unique review by a user. |

✅ **All tables conform to 1NF.**

---

## 🔹 Second Normal Form (2NF)

### ✅ Criteria:
- Must be in 1NF.
- All non-key columns must depend on the *entire* primary key (no partial dependencies).
- Only relevant for tables with **composite primary keys**.

### 🛠 Review:
Our tables use **single-column primary keys**, so partial dependencies are not possible.

✅ **All tables conform to 2NF.**

---

## 🔹 Third Normal Form (3NF)

### ✅ Criteria:
- Must be in 2NF.
- No **transitive dependencies** (i.e., non-key attributes should not depend on other non-key attributes).

### 🛠 Review:
| Table     | Passes 3NF? | Reason |
|-----------|-------------|--------|
| User      | ✅           | No transitive dependencies. |
| Property  | ✅           | Attributes depend only on `property_id`. |
| Booking   | ✅           | All fields depend directly on `booking_id`. |
| Payment   | ✅           | `amount`, `payment_method` depend only on `payment_id` or `booking_id`. |
| Message   | ✅           | `message_body`, `sent_at` depend on `message_id`. |
| Review    | ✅           | `rating`, `comment` depend directly on `review_id`. |

✅ **All tables conform to 3NF.**

---

## 🧼 Summary of Normalization Steps

| Step | Description |
|------|-------------|
| 1NF  | Ensured atomic fields and unique rows across all tables. |
| 2NF  | Confirmed all non-key attributes depend entirely on their table's primary key. |
| 3NF  | Eliminated any potential transitive dependencies across all entities. |

---

## 📌 Conclusion

The Airbnb Clone database schema is fully normalized up to **Third Normal Form (3NF)**. No redundant or repeating data exists, and all attributes are properly dependent on their primary keys.

