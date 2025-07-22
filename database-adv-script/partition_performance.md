-- Use the correct database
USE airbnb_clone;

-- ========================================
-- Step 1: Drop & Recreate the Booking Table with Partitioning
-- ========================================
-- NOTE: Table partitioning requires using ENGINE = InnoDB or MyISAM
-- and all partitioned columns must be part of every PRIMARY or UNIQUE key.

DROP TABLE IF EXISTS Booking;

CREATE TABLE Booking (
    booking_id INT PRIMARY KEY,
    user_id INT,
    property_id INT,
    start_date DATE,
    end_date DATE,
    -- Add other columns as needed
    INDEX idx_start_date (start_date)
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION pmax  VALUES LESS THAN MAXVALUE
);
