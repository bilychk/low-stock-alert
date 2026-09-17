
CREATE TABLE dim_product (
    product_key     INTEGER PRIMARY KEY,   
    product_id      INTEGER NOT NULL,      
    product_name    VARCHAR(100) NOT NULL,
    category        VARCHAR(50)  NOT NULL,
    effective_date  DATE NOT NULL,
    expiry_date     DATE,                  
    is_current      BOOLEAN NOT NULL
);

CREATE TABLE dim_location (
    location_key    INTEGER PRIMARY KEY,
    location_id     INTEGER NOT NULL,
    location_name   VARCHAR(100) NOT NULL,
    region          VARCHAR(50) NOT NULL
);

CREATE TABLE fact_stock_movements (
    movement_id     INTEGER PRIMARY KEY,
    product_key     INTEGER NOT NULL REFERENCES dim_product(product_key),
    location_key    INTEGER NOT NULL REFERENCES dim_location(location_key),
    movement_date   DATE NOT NULL,
    movement_type   VARCHAR(20) NOT NULL,
    quantity        INTEGER NOT NULL
);

CREATE TABLE fact_stock_snapshot (
    snapshot_date     DATE NOT NULL,
    product_key       INTEGER NOT NULL REFERENCES dim_product(product_key),
    location_key      INTEGER NOT NULL REFERENCES dim_location(location_key),
    quantity_on_hand  INTEGER NOT NULL,
    PRIMARY KEY (snapshot_date, product_key, location_key)
);

INSERT INTO dim_product (product_key, product_id, product_name, category, effective_date, expiry_date, is_current) VALUES
(1, 101, 'Steel Bolt M8',     'Hardware',    '2025-01-01', NULL,         TRUE),
(2, 102, 'USB-C Cable 1m',    'Electronics', '2025-01-01', NULL,         TRUE),
(3, 103, 'Wireless Mouse',    'Accessories', '2025-01-01', '2026-03-01', FALSE),
(4, 103, 'Wireless Mouse',    'Electronics', '2026-03-01', NULL,         TRUE),
(5, 104, 'Packing Tape 48mm', 'Packaging',   '2025-01-01', NULL,         TRUE);

INSERT INTO dim_location (location_key, location_id, location_name, region) VALUES
(1, 1, 'Tallinn DC', 'Baltics'),
(2, 2, 'Riga DC',    'Baltics');

INSERT INTO fact_stock_movements (movement_id, product_key, location_key, movement_date, movement_type, quantity) VALUES
(1,  1, 1, '2026-02-01', 'receipt',  500),
(2,  2, 1, '2026-02-01', 'receipt',  200),
(3,  3, 1, '2026-02-03', 'receipt',  150),
(4,  1, 1, '2026-02-10', 'shipment', -120),
(5,  2, 1, '2026-02-12', 'shipment', -80),
(6,  3, 1, '2026-02-20', 'shipment', -40),
(7,  4, 1, '2026-03-05', 'receipt',  200),
(8,  4, 1, '2026-03-15', 'shipment', -60),
(9,  5, 2, '2026-02-05', 'receipt',  1000),
(10, 5, 2, '2026-02-25', 'shipment', -300),
(11, 1, 2, '2026-02-07', 'receipt',  180),
(12, 1, 2, '2026-03-01', 'shipment', -50);

INSERT INTO fact_stock_snapshot (snapshot_date, product_key, location_key, quantity_on_hand) VALUES
('2026-02-28', 1, 1, 380), ('2026-02-28', 2, 1, 120), ('2026-02-28', 3, 1, 110),
('2026-02-28', 5, 2, 700), ('2026-02-28', 1, 2, 130),
('2026-03-20', 1, 1, 330), ('2026-03-20', 2, 1, 120), ('2026-03-20', 4, 1, 140),
('2026-03-20', 5, 2, 700), ('2026-03-20', 1, 2,  80);
