## Identify High-Usage Columns
| Table      | Column        | Usage                               |
| ---------- | ------------- | ----------------------------------- |
| `User`     | `user_id`     | JOIN with Booking, WHERE            |
| `Booking`  | `user_id`     | JOIN with User, WHERE               |
| `Booking`  | `property_id` | JOIN with Property, GROUP BY        |
| `Property` | `property_id` | JOIN with Booking/Review            |
| `Review`   | `property_id` | JOIN with Property, WHERE, GROUP BY |
| `Booking`  | `start_date`  | WHERE, ORDER BY (future use)        |


## Create Indexes

-- Index on user_id in the User table
CREATE INDEX idx_user_user_id ON User(user_id);

-- Index on user_id in the Booking table
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Index on property_id in the Booking table
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Index on property_id in the Property table
CREATE INDEX idx_property_property_id ON Property(property_id);

-- Index on property_id in the Review table
CREATE INDEX idx_review_property_id ON Review(property_id);

-- Optional: Index on start_date in the Booking table for sorting/filtering
CREATE INDEX idx_booking_start_date ON Booking(start_date);


 ## Measure Performance (Before vs After Indexing)

 -- Query to rank properties by total bookings
SELECT 
    property_id,
    COUNT(*) AS total_bookings
FROM 
    Booking
GROUP BY 
    property_id
ORDER BY 
    total_bookings DESC;
