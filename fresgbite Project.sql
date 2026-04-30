create database freshbite_db;
use freshbite_db;
Show tables;

# Table creation
# 1. Table Supplier
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    city VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

# 2.raw_materials
CREATE TABLE raw_materials (
    material_id INT AUTO_INCREMENT PRIMARY KEY,
    material_name VARCHAR(100) NOT NULL,
    supplier_id INT,
    unit VARCHAR(20),
    cost_per_unit DECIMAL(10,2),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

# 3.products
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2) CHECK (price >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

# 4.production_batches
CREATE TABLE production_batches (
    batch_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    batch_date DATE,
    quantity_produced INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

#5.distributors
CREATE TABLE distributors (
    distributor_id INT AUTO_INCREMENT PRIMARY KEY,
    distributor_name VARCHAR(100),
    city VARCHAR(50),
    phone VARCHAR(15)
);

#6.customers
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

#7. orders
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

#8. order_items
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
#9. payments
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    payment_mode VARCHAR(30),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

#10.inventory
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    stock_quantity INT,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

# Data Insertion
#1. Supplier
INSERT INTO suppliers (supplier_name, email, phone, city) VALUES
('Agro Farms','agro@farm.com','9876543210','Pune'),
('GreenGrow','green@grow.com','9876543211','Nashik'),
('FreshLeaf','fresh@leaf.com','9876543212','Indore'),
('NatureSource','nature@source.com','9876543213','Bhopal'),
('PureHarvest','pure@harvest.com','9876543214','Nagpur'),
('SunAgro','sun@agro.com','9876543215','Ahmedabad'),
('EcoFoods','eco@foods.com','9876543216','Jaipur'),
('GoldenCrop','golden@crop.com','9876543217','Udaipur'),
('FarmRoots','farm@roots.com','9876543218','Amritsar'),
('OrganicWay','organic@way.com','9876543219','Chandigarh'),
('FreshKart','fresh@kart.com','9876543220','Delhi'),
('AgriPlus','agri@plus.com','9876543221','Lucknow'),
('GreenEarth','green@earth.com','9876543222','Patna'),
('BioFoods','bio@foods.com','9876543223','Ranchi'),
('HealthyGrain','healthy@grain.com','9876543224','Kanpur');

#2. raw_material
INSERT INTO raw_materials (material_name, supplier_id, unit, cost_per_unit) VALUES
('Wheat',1,'Kg',22),
('Rice Paddy',2,'Kg',28),
('Milk',3,'Litre',30),
('Sugarcane',4,'Kg',18),
('Sunflower Seeds',5,'Kg',40),
('Spices',6,'Kg',120),
('Corn',7,'Kg',25),
('Pulses Raw',8,'Kg',55),
('Tea Leaves',9,'Kg',210),
('Coffee Beans',10,'Kg',350);

# 3. products
INSERT INTO products (product_name, category, price) VALUES
('Wheat Flour','Grains',45),
('Rice Premium','Grains',60),
('Brown Bread','Bakery',30),
('Milk Packet','Dairy',25),
('Butter','Dairy',55),
('Cheese Slice','Dairy',80),
('Tomato Sauce','Condiments',40),
('Chilli Sauce','Condiments',45),
('Veg Noodles','Instant Food',35),
('Masala Oats','Instant Food',50),
('Cornflakes','Breakfast',120),
('Muesli','Breakfast',180),
('Cooking Oil','Edible Oil',140),
('Sunflower Oil','Edible Oil',160),
('Toor Dal','Pulses',110),
('Chana Dal','Pulses',95),
('Sugar','Essentials',42),
('Salt','Essentials',20),
('Tea Powder','Beverages',130),
('Coffee','Beverages',220),
('Fruit Juice','Beverages',90),
('Biscuits','Snacks',30),
('Cookies','Snacks',60),
('Namkeen','Snacks',55),
('Frozen Peas','Frozen',85),
('Frozen Corn','Frozen',90),
('Ice Cream','Frozen',120),
('Paneer','Dairy',90),
('Curd','Dairy',35),
('Ghee','Dairy',520);

# 4.production_batches
INSERT INTO production_batches (product_id, batch_date, quantity_produced)
SELECT
    FLOOR(1 + (RAND() * 30)),
    DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 365) DAY),
    FLOOR(200 + (RAND() * 800))
FROM information_schema.tables
LIMIT 100;

# 5. distributors (5 rows)
INSERT INTO distributors (distributor_name, city, phone) VALUES
('North India Distributors','Delhi','9811111111'),
('WestZone Supplies','Mumbai','9822222222'),
('SouthConnect','Bangalore','9833333333'),
('EastTrade Corp','Kolkata','9844444444'),
('CentralReach','Bhopal','9855555555');

#6. customers (100 rows – scalable)
INSERT INTO customers (customer_name, city, phone)
SELECT
    CONCAT('Customer_', n),
    ELT(FLOOR(1 + RAND()*6),
        'Delhi','Mumbai','Pune','Bangalore','Chennai','Hyderabad'),
    CONCAT('98', FLOOR(10000000 + RAND()*89999999))
FROM (
    SELECT @i:=@i+1 AS n
    FROM information_schema.tables, (SELECT @i:=0) t
    LIMIT 100
) x;

#7.orders (500 rows – 1 year data)
INSERT INTO orders (customer_id, order_date, status)
SELECT
    FLOOR(1 + RAND()*100),
    DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*365) DAY),
    ELT(FLOOR(1 + RAND()*3),'Pending','Completed','Cancelled')
FROM information_schema.tables
LIMIT 500;

#8.order_items (1200 rows)
INSERT INTO order_items (order_id, product_id, quantity, price)
SELECT
    o.order_id,
    p.product_id,
    FLOOR(1 + RAND()*5),
    p.price
FROM orders o
JOIN products p
ORDER BY RAND()
LIMIT 1200;

#9.payments (Completed Orders Only)
INSERT INTO payments (order_id, payment_date, amount, payment_mode)
SELECT
    o.order_id,
    o.order_date,
    ROUND(SUM(oi.quantity * oi.price),2),
    ELT(FLOOR(1 + RAND()*3),'UPI','Card','NetBanking')
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY o.order_id;

#10. inventory (Stock for all products)
INSERT INTO inventory (product_id, stock_quantity)
SELECT
    product_id,
    FLOOR(100 + RAND()*500)
FROM products;
use freshbite_db;
Select * from suppliers;
desc suppliers;
Select * from raw_materials;
desc raw_materials;
Select * from products;
Select * from production_batches;
Select * from distributors;
Select * from customers;
Select * from orders;
Select * from order_items;
Select * from payments;
Select * from inventory;

use freshbite_db;



USE freshbite_db;

-- ==============================
-- SECTION 1: BASIC QUERIES
-- ==============================

-- 1
SELECT * FROM products WHERE price > 100;
-- 2
SELECT * FROM customers WHERE city='Delhi';
-- 3
SELECT * FROM orders WHERE status='Completed';
-- 4
SELECT * FROM products WHERE category='Dairy';
-- 5
SELECT * FROM suppliers WHERE city='Ahmedabad';
-- 6
SELECT * FROM customers WHERE created_at >= NOW() - INTERVAL 30 DAY;
-- 7
SELECT * FROM distributors WHERE city='Mumbai';
-- 8
SELECT * FROM raw_materials WHERE cost_per_unit > 50;
-- 9
SELECT * FROM products ORDER BY price DESC;
-- 10
SELECT COUNT(*) AS total_customers FROM customers;

-- ==============================
-- SECTION 2: AGGREGATES
-- ==============================
-- 11
SELECT AVG(price) AS avg_price FROM products;
-- 12
SELECT SUM(stock_quantity) AS total_stock FROM inventory;
-- 13
SELECT * FROM products ORDER BY price DESC LIMIT 1;
-- 14
SELECT * FROM products ORDER BY price ASC LIMIT 1;
-- 15
SELECT status, COUNT(*) total_orders FROM orders GROUP BY status;

-- 16
SELECT ROUND(SUM(amount),2) AS total_payments FROM payments;
-- 17
SELECT product_id,SUM(quantity) qty_sold FROM order_items GROUP BY product_id;
-- 18
SELECT AVG(stock_quantity) avg_stock FROM inventory;
-- 19
SELECT city,COUNT(*) supplier_count FROM suppliers GROUP BY city;
-- 20
SELECT payment_mode,SUM(amount) total FROM payments GROUP BY payment_mode;

-- SECTION 3: JOINS
-- 21
SELECT c.customer_name,o.order_date FROM customers c JOIN orders o ON c.customer_id=o.customer_id;
-- 22
SELECT oi.order_id,p.product_name,oi.quantity FROM order_items oi JOIN products p ON oi.product_id=p.product_id;
-- 23
SELECT s.supplier_name,r.material_name FROM suppliers s JOIN raw_materials r ON s.supplier_id=r.supplier_id;
-- 24
SELECT p.product_name,i.stock_quantity FROM products p JOIN inventory i ON p.product_id=i.product_id;
-- 25
SELECT DISTINCT c.customer_name FROM customers c JOIN orders o ON c.customer_id=o.customer_id JOIN payments p ON o.order_id=p.order_id;

-- SECTION 4: GROUP BY + HAVING
-- 31
SELECT DATE_FORMAT(order_date,'%Y-%m') month,COUNT(*) orders_count FROM orders GROUP BY month;
-- 32
SELECT customer_id,COUNT(*) cnt FROM orders GROUP BY customer_id ORDER BY cnt DESC LIMIT 5;
-- 33
SELECT category,COUNT(*) cnt FROM products GROUP BY category HAVING cnt>3;
-- 34
SELECT city,COUNT(*) cnt FROM customers GROUP BY city HAVING cnt>10;
-- 35
SELECT product_id,SUM(quantity) qty FROM order_items GROUP BY product_id HAVING qty>50;

-- SECTION 5: SUBQUERIES
-- 41
SELECT * FROM products WHERE price>(SELECT AVG(price) FROM products);
-- 42
SELECT c.customer_id,c.customer_name,SUM(oi.quantity*oi.price) spent FROM customers c JOIN orders o ON c.customer_id=o.customer_id JOIN order_items oi ON o.order_id=oi.order_id WHERE o.status='Completed' GROUP BY c.customer_id,c.customer_name HAVING spent>(SELECT AVG(x.total_spent) FROM (SELECT SUM(oi2.quantity*oi2.price) total_spent FROM orders o2 JOIN order_items oi2 ON o2.order_id=oi2.order_id WHERE o2.status='Completed' GROUP BY o2.customer_id) x);
-- 43
SELECT * FROM products ORDER BY price DESC LIMIT 1 OFFSET 1;
-- 44
SELECT * FROM customers WHERE customer_id NOT IN (SELECT customer_id FROM orders);
-- 45
SELECT * FROM products WHERE product_id NOT IN (SELECT product_id FROM order_items);

-- SECTION 6: WINDOW FUNCTIONS
-- 51
SELECT product_id,SUM(quantity*price) revenue,RANK() OVER(ORDER BY SUM(quantity*price) DESC) rnk FROM order_items GROUP BY product_id;
-- 52
SELECT customer_id,SUM(oi.quantity*oi.price) spent,RANK() OVER(ORDER BY SUM(oi.quantity*oi.price) DESC) rnk FROM orders o JOIN order_items oi ON o.order_id=oi.order_id WHERE o.status='Completed' GROUP BY customer_id;
-- 53
WITH m AS (SELECT DATE_FORMAT(order_date,'%Y-%m') month,COUNT(*) cnt FROM orders GROUP BY month) SELECT month,cnt,LAG(cnt) OVER(ORDER BY month) prev_cnt FROM m;
-- 54
WITH m AS (SELECT DATE_FORMAT(order_date,'%Y-%m') month,SUM(oi.quantity*oi.price) rev FROM orders o JOIN order_items oi ON o.order_id=oi.order_id WHERE o.status='Completed' GROUP BY month) SELECT month,rev,ROUND((rev-LAG(rev) OVER(ORDER BY month))*100/LAG(rev) OVER(ORDER BY month),2) growth FROM m;
-- 55
WITH t AS (SELECT p.category,p.product_name,SUM(oi.quantity) qty,RANK() OVER(PARTITION BY p.category ORDER BY SUM(oi.quantity) DESC) rnk FROM products p JOIN order_items oi ON p.product_id=oi.product_id GROUP BY p.category,p.product_name) SELECT * FROM t WHERE rnk<=3;

-- SECTION 7: BUSINESS SCENARIOS
-- 61
SELECT c.city,ROUND(SUM(oi.quantity*oi.price),2) revenue FROM customers c JOIN orders o ON c.customer_id=o.customer_id JOIN order_items oi ON o.order_id=oi.order_id WHERE o.status='Completed' GROUP BY c.city ORDER BY revenue DESC;
-- 62
SELECT p.category,ROUND(SUM(oi.quantity*oi.price),2) revenue FROM products p JOIN order_items oi ON p.product_id=oi.product_id JOIN orders o ON o.order_id=oi.order_id WHERE o.status='Completed' GROUP BY p.category ORDER BY revenue DESC;
-- 63
SELECT customer_id,MAX(order_date) last_order FROM orders GROUP BY customer_id HAVING last_order < CURDATE()-INTERVAL 6 MONTH;
-- 64
SELECT p.product_name,i.stock_quantity FROM inventory i JOIN products p ON i.product_id=p.product_id WHERE i.stock_quantity<100;
-- 65
SELECT p.product_name FROM products p LEFT JOIN order_items oi ON p.product_id=oi.product_id WHERE oi.product_id IS NULL;
-- 66
SELECT DATE_FORMAT(order_date,'%Y-%m') month,COUNT(*) cancelled FROM orders WHERE status='Cancelled' GROUP BY month ORDER BY cancelled DESC;
-- 67
SELECT ROUND(COUNT(DISTINCT CASE WHEN cnt>1 THEN customer_id END)*100/COUNT(*),2) repeat_rate FROM (SELECT customer_id,COUNT(*) cnt FROM orders WHERE status='Completed' GROUP BY customer_id)x;
-- 68
SELECT payment_mode,COUNT(*) cnt FROM payments GROUP BY payment_mode ORDER BY cnt DESC;
-- 69
SELECT supplier_id,MIN(cost_per_unit) min_cost FROM raw_materials GROUP BY supplier_id;
-- 70
SELECT p.category,AVG(oi.quantity) avg_qty FROM products p JOIN order_items oi ON p.product_id=oi.product_id GROUP BY p.category ORDER BY avg_qty DESC;

-- SECTION 8: ADVANCED SQL
-- 71
CREATE OR REPLACE VIEW monthly_sales_report AS SELECT DATE_FORMAT(o.order_date,'%Y-%m') month,SUM(oi.quantity*oi.price) revenue FROM orders o JOIN order_items oi ON o.order_id=oi.order_id WHERE o.status='Completed' GROUP BY month;
-- 72
DELIMITER //
CREATE PROCEDURE top_customers()
BEGIN
SELECT customer_id,SUM(oi.quantity*oi.price) spent FROM orders o JOIN order_items oi ON o.order_id=oi.order_id WHERE o.status='Completed' GROUP BY customer_id ORDER BY spent DESC LIMIT 10;
END //
DELIMITER ;
-- 73
CREATE TRIGGER trg_reduce_inventory AFTER INSERT ON order_items FOR EACH ROW UPDATE inventory SET stock_quantity=stock_quantity-NEW.quantity WHERE product_id=NEW.product_id;
-- 74
CREATE TABLE IF NOT EXISTS payment_audit(id INT AUTO_INCREMENT PRIMARY KEY,payment_id INT,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TRIGGER trg_payment_audit AFTER INSERT ON payments FOR EACH ROW INSERT INTO payment_audit(payment_id) VALUES(NEW.payment_id);
-- 75
CREATE INDEX idx_order_date ON orders(order_date);
-- 76
SELECT 'Partitioning depends on server settings' AS note;
-- 77
SELECT 'Use MySQL EVENT SCHEDULER to archive old orders' AS note;
-- 78
DELIMITER //
CREATE FUNCTION calc_discount(amount DECIMAL(10,2)) RETURNS DECIMAL(10,2)
DETERMINISTIC BEGIN RETURN IF(amount>1000,amount*0.1,0); END //
DELIMITER ;
-- 79
SELECT (SELECT COUNT(*) FROM customers) customers,(SELECT COUNT(*) FROM orders) orders_count,(SELECT SUM(amount) FROM payments) revenue;
-- 80
SELECT phone,COUNT(*) cnt FROM customers GROUP BY phone HAVING cnt>1;

-- SECTION 9: INTERVIEW LEVEL
-- 81
SELECT AVG(price) median_proxy FROM products;
-- 82
SELECT DATE_FORMAT(order_date,'%Y-%m') month,COUNT(DISTINCT customer_id) active_customers FROM orders GROUP BY month;
-- 83
SELECT DATE_FORMAT(MIN(order_date),'%Y-%m') cohort,COUNT(DISTINCT customer_id) users FROM orders GROUP BY customer_id;
-- 84
SELECT product_id,SUM(quantity*price) revenue FROM order_items GROUP BY product_id ORDER BY revenue DESC;
-- 85
SELECT customer_id,DATEDIFF(CURDATE(),MAX(order_date)) recency,COUNT(*) frequency,SUM(oi.quantity*oi.price) monetary FROM orders o JOIN order_items oi ON o.order_id=oi.order_id GROUP BY customer_id;
-- 86
SELECT a.product_id,b.product_id,COUNT(*) together FROM order_items a JOIN order_items b ON a.order_id=b.order_id AND a.product_id<b.product_id GROUP BY a.product_id,b.product_id ORDER BY together DESC;
-- 87
SELECT 'Use moving average / regression for forecasting' AS note;
-- 88
SELECT * FROM payments WHERE amount<=0;
-- 89
SELECT YEAR(order_date) yr,SUM(oi.quantity*oi.price) revenue FROM orders o JOIN order_items oi ON o.order_id=oi.order_id GROUP BY yr;
-- 90
SELECT DATE_FORMAT(o.order_date,'%Y-%m') month,p.category,SUM(oi.quantity*oi.price) revenue FROM orders o JOIN order_items oi ON o.order_id=oi.order_id JOIN products p ON oi.product_id=p.product_id GROUP BY month,p.category ORDER BY month;
