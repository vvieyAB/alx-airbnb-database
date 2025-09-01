USE airbnb_clone;

-- 1. INNER JOIN – All bookings with their respective users:
SELECT 
    Booking.booking_id,
    Booking.property_id,
    Booking.start_date,
    Booking.end_date,
    User.user_id,
    User.first_name,
    User.last_name,
    User.email
FROM 
    Booking
INNER JOIN 
    User ON Booking.user_id = User.user_id;

-- 2. LEFT JOIN – All properties and their reviews, including those without reviews:
SELECT 
    Property.property_id,
    Property.name,
    Property.location,
    Review.review_id,
    Review.rating,
    Review.comment
FROM 
    Property
LEFT JOIN 
    Review ON Property.property_id = Review.property_id
ORDER BY 
    Property.property_id, Review.review_id;

-- 3. FULL OUTER JOIN – All users and all bookings, even if not linked
-- Note: For MySQL versions that don't support FULL OUTER JOIN, use UNION of LEFT and RIGHT joins
SELECT 
    User.user_id,
    User.first_name,
    User.last_name,
    Booking.booking_id,
    Booking.property_id,
    Booking.start_date,
    Booking.end_date
FROM 
    User
LEFT JOIN 
    Booking ON User.user_id = Booking.user_id

UNION

SELECT 
    User.user_id,
    User.first_name,
    User.last_name,
    Booking.booking_id,
    Booking.property_id,
    Booking.start_date,
    Booking.end_date
FROM 
    User
RIGHT JOIN 
    Booking ON User.user_id = Booking.user_id
WHERE 
    User.user_id IS NULL;

-- 4. Aggregate Bookings by User (COUNT + GROUP BY)
SELECT 
    User.user_id,
    User.first_name,
    User.last_name,
    COUNT(Booking.booking_id) AS total_bookings
FROM 
    User
LEFT JOIN 
    Booking ON User.user_id = Booking.user_id
GROUP BY 
    User.user_id, User.first_name, User.last_name
ORDER BY 
    total_bookings DESC;

-- 5. Rank Properties by Total Bookings (Using RANK window function)
SELECT 
    Property.property_id,
    Property.name AS property_name,
    Property.location,
    COALESCE(COUNT(Booking.booking_id), 0) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(Booking.booking_id) DESC) AS property_rank
FROM 
    Property
LEFT JOIN 
    Booking ON Property.property_id = Booking.property_id
GROUP BY 
    Property.property_id, Property.name, Property.location
ORDER BY 
    total_bookings DESC;