

## ✅ Step 1: **Initial Complex Query**

The following SQL joins `Booking`, `User`, `Property`, and `Payment` to retrieve all booking-related details:

##  Initial complex query with all joins
SELECT 
    B.booking_id,
    B.start_date,
    B.end_date,
    U.user_id,
    U.first_name,
    U.last_name,
    U.email,
    P.property_id,
    P.name AS property_name,
    P.location,
    Pay.payment_id,
    Pay.amount,
    Pay.payment_date,
    Pay.payment_method
FROM 
    Booking B
JOIN 
    User U ON B.user_id = U.user_id
JOIN 
    Property P ON B.property_id = P.property_id
LEFT JOIN 
    Payment Pay ON B.booking_id = Pay.booking_id;
```

---

## ✅ Step 2: **Analyze Performance with `EXPLAIN`**

Run this command in MySQL:

```sql
EXPLAIN
SELECT 
    B.booking_id,
    B.start_date,
    B.end_date,
    U.user_id,
    U.first_name,
    U.last_name,
    U.email,
    P.property_id,
    P.name AS property_name,
    P.location,
    Pay.payment_id,
    Pay.amount,
    Pay.payment_date,
    Pay.payment_method
FROM 
    Booking B
JOIN 
    User U ON B.user_id = U.user_id
JOIN 
    Property P ON B.property_id = P.property_id
LEFT JOIN 
    Payment Pay ON B.booking_id = Pay.booking_id;
```

### 🔍 Look out for:

* `type = ALL` (means full table scan – inefficient)
* `key = NULL` (means no index used)
* High `rows` estimate
* Missing indexes on `user_id`, `property_id`, or `booking_id`

---

## ✅ Step 3: **Refactor and Optimize the Query**

### 🎯 Optimization Strategy:

* Add **indexes** (if not already) on:

  * `Booking.user_id`
  * `Booking.property_id`
  * `Payment.booking_id`
* Avoid unnecessary columns in `SELECT`
* Use **only needed joins**

### ✅ Refactored Query:

```sql
-- Refactored query: optimized joins and columns
SELECT 
    B.booking_id,
    B.start_date,
    B.end_date,
    U.first_name,
    U.last_name,
    P.name AS property_name,
    Pay.amount
FROM 
    Booking B
JOIN 
    User U ON B.user_id = U.user_id
JOIN 
    Property P ON B.property_id = P.property_id
LEFT JOIN 
    Payment Pay ON B.booking_id = Pay.booking_id;
```

> Optional: If payment isn't always required, you can defer loading it or summarize it separately.

---

## ✅ Step 4: **Compare Execution Plans**

Use `EXPLAIN` on both versions and check:

* Lower number of `rows` scanned
* Use of `key` with index name shown
* Reduced `filtered` value
* Improved `Extra` field (e.g., avoid `Using temporary`, `Using filesort`)

---

## ✅ Step 5: **Index Creation (if needed)**

```sql
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);
