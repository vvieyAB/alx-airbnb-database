USE airbnb_clone;

INSERT INTO User (
    user_id,
    first_name,
    last_name,
    email,
    password_hash,
    phone_number,
    role
) VALUES (
    '2', 
    'mine', 
    'Ndicu', 
    'munun@gmail.com', 
    '789973/3391--', 
    '09876544', 
    'guest'
);

INSERT INTO Property(
    property_id,
    name,
    description,
    location,
    pricernight
)VALUES(
    '1',
    'Donas',
    'A two bedroom apartment',
    'Diani',
    '2000.00'
);
