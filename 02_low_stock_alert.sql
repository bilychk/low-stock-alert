

SELECT CONCAT(fs.snapshot_date, '-', fs.product_key, '-', fs.location_key) AS id,  
       fs.snapshot_date,
       dp.product_name,
       dl.location_name,
       fs.quantity_on_hand,
       TO_CHAR(CURRENT_TIMESTAMP AT TIME ZONE 'Europe/Tallinn',
               'YYYY-MM-DD HH24:MI:SS') AS queried_at   
  FROM fact_stock_snapshot AS fs
  JOIN dim_product AS dp
    ON dp.product_key = fs.product_key      
  JOIN dim_location AS dl
    ON dl.location_key = fs.location_key
 WHERE fs.snapshot_date = (SELECT MAX(snapshot_date) FROM fact_stock_snapshot)
   AND fs.quantity_on_hand < 100            
 ORDER BY fs.quantity_on_hand;
