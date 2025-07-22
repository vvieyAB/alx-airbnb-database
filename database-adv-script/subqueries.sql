-- Non-Correlated Subquery
SELECT 
    property_id,
    name,
    location
FROM 
    Property
WHERE 
    property_id IN (
        SELECT 
            property_id
        FROM 
            Review
        GROUP BY 
            property_id
        HAVING 
            AVG(rating) > 4.0
    );


--  Correlated Subquery

SELECT 
    user_id,
    first_name,
    last_name,
    email
FROM 
    User U
WHERE 
    (
        SELECT 
            COUNT(*)
        FROM 
            Booking B
        WHERE 
            B.user_id = U.user_id
    ) > 3;
