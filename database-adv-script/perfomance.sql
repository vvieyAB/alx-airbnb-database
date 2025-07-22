-- Use the correct database
USE airbnb_clone;

-- =====================================
-- Step 1: Initial Complex Query
-- =====================================
-- Retrieves bookings with user, property, and payment details
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

-- =====================================
-- Step 2: Index Creation (Performance Optimization)
-- =====================================
-- These indexes help accelerate JOINs and filtering
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON Booking(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON Booking(property_id);
CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON Payment(booking_id);

-- =====================================
-- Step 3: Refactored Query for Improved Performance
-- =====================================
-- Returns essential booking information using optimized joins
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

-- =====================================
-- Step 4: Optional EXPLAIN to Measure Performance
-- =====================================
-- Run this to compare execution plans before and after indexes
EXPLAIN
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
