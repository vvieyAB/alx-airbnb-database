-- Indexes for User table
CREATE INDEX idx_user_id ON User(user_id);
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_first_last_name ON User(first_name, last_name);

-- Indexes for Booking table
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_booking_user_property ON Booking(user_id, property_id);

-- Indexes for Property table
CREATE INDEX idx_property_id ON Property(property_id);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_name ON Property(name);

-- Indexes for Review table
CREATE INDEX idx_review_property_id ON Review(property_id);
CREATE INDEX idx_review_rating ON Review(rating);
CREATE INDEX idx_review_user_id ON Review(user_id);

--before adding
-- Measure performance of common queries before indexes
EXPLAIN ANALYZE
SELECT u.user_id, u.first_name, u.last_name, COUNT(b.booking_id) AS total_bookings
FROM User u
LEFT JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name;

EXPLAIN ANALYZE
SELECT p.property_id, p.name, COUNT(b.booking_id) AS total_bookings
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY total_bookings DESC;

EXPLAIN ANALYZE
SELECT b.booking_id, u.first_name, u.last_name, p.name
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
WHERE b.start_date BETWEEN '2024-01-01' AND '2024-12-31';

EXPLAIN ANALYZE
SELECT p.property_id, p.name, AVG(r.rating) as avg_rating
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name
HAVING AVG(r.rating) >= 4.0;

--after addign indexes
-- Add the indexes first
SOURCE database_index.sql;

-- Then measure performance of the same queries after indexes
EXPLAIN ANALYZE
SELECT u.user_id, u.first_name, u.last_name, COUNT(b.booking_id) AS total_bookings
FROM User u
LEFT JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name;

EXPLAIN ANALYZE
SELECT p.property_id, p.name, COUNT(b.booking_id) AS total_bookings
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY total_bookings DESC;

EXPLAIN ANALYZE
SELECT b.booking_id, u.first_name, u.last_name, p.name
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
WHERE b.start_date BETWEEN '2024-01-01' AND '2024-12-31';

EXPLAIN ANALYZE
SELECT p.property_id, p.name, AVG(r.rating) as avg_rating
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name
HAVING AVG(r.rating) >= 4.0;