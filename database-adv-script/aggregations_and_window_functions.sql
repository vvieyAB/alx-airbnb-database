--  Aggregate Bookings by User (COUNT + GROUP BY)
SELECT 
    Booking.user_id,
    User.first_name,
    User.last_name,
    COUNT(Booking.booking_id) AS total_bookings
FROM 
    Booking
JOIN 
    User ON Booking.user_id = User.user_id
GROUP BY 
    Booking.user_id, User.first_name, User.last_name;


-- Rank Properties by Total Bookings (Using RANK)
SELECT 
    property_id,
    total_bookings,
    RANK() OVER (ORDER BY total_bookings DESC) AS property_rank
FROM (
    SELECT 
        property_id,
        COUNT(*) AS total_bookings
    FROM 
        Booking
    GROUP BY 
        property_id
) AS PropertyBookings;
