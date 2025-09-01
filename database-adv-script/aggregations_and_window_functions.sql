USE airbnb_clone;

-- 1. INNER JOIN to retrieve all bookings and respective users
SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id
ORDER BY 
    b.booking_id;

-- 2. LEFT JOIN to retrieve all properties and their reviews (including properties with no reviews)
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at
FROM 
    Property p
LEFT JOIN 
    Review r ON p.property_id = r.property_id
ORDER BY 
    p.property_id, r.review_id;

-- 3. FULL OUTER JOIN for all users and all bookings (MySQL compatible version)
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id

UNION ALL

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM 
    User u
RIGHT JOIN 
    Booking b ON u.user_id = b.user_id
WHERE 
    u.user_id IS NULL
ORDER BY 
    user_id, booking_id;

-- 4. Total number of bookings made by each user (COUNT + GROUP BY)
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name
ORDER BY 
    total_bookings DESC;

-- 5. Rank properties based on total number of bookings (Window function RANK)
SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name
ORDER BY 
    booking_rank;