
INSERT INTO fact_stock_snapshot (snapshot_date, product_key, location_key, quantity_on_hand) VALUES
('2026-03-21', 1, 1, 310), ('2026-03-21', 2, 1,  60), ('2026-03-21', 4, 1, 135),
('2026-03-21', 5, 2, 690), ('2026-03-21', 1, 2, 150);

INSERT INTO fact_stock_snapshot (snapshot_date, product_key, location_key, quantity_on_hand) VALUES
('2026-03-22', 1, 1, 300), ('2026-03-22', 2, 1, 200), ('2026-03-22', 4, 1,  45),
('2026-03-22', 5, 2, 680), ('2026-03-22', 1, 2, 140);


SELECT snapshot_date,
       COUNT(*) AS rows_in_snapshot
  FROM fact_stock_snapshot
 GROUP BY snapshot_date
 ORDER BY snapshot_date;
