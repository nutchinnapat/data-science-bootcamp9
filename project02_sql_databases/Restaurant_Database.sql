--create table--
--table1: customers
CREATE TABLE customers(
  customer_id INT UNIQUE PRIMARY KEY,
  name VARCHAR (50),
  phone_number VARCHAR(12),
  email VARCHAR (50)
);

--table2: orders
CREATE TABLE orders(
  order_id INT PRIMARY KEY,
  customer_id INT,
  menu_id INT,
  branch_id INT,
  order_date TIMESTAMP,
  quantity INT,
  total_amount DECIMAL(10, 2),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (menu_id) REFERENCES menus(menu_id),
  FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

--table3: menus
CREATE TABLE menus(
  menu_id INT PRIMARY KEY,
  menu_name VARCHAR(50),
  menu_size VARCHAR(10),
  menu_price DECIMAL(10, 2),
  menu_category VARCHAR(50)
);

--table4: branchs
CREATE TABLE branchs(
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(50),
  branch_address VARCHAR(100),
  branch_city VARCHAR(50),
  branch_country VARCHAR(50)
);

--table5: pizza_ingredient
CREATE TABLE pizza_ingredient(
  ingredient_id INT PRIMARY KEY,
  menu_id INT,
  ingredient_name VARCHAR(50),
  ingredient_category VARCHAR(50),
  ingredient_price DECIMAL(10, 2),
  FOREIGN KEY (menu_id) REFERENCES menus(menu_id)
);

----------------------------------------------------------------------------
--insert mockup dat into table--
-- Insert mockup data into the customers table
INSERT INTO customers
VALUES
    (1, 'Somchai Churnsri', '089-123-4567', 'somchai@gmail.com'),
    (2, 'Jitrlada Sitthiphant', '098-765-4321', 'jitlada@hotmail.com'),
    (3, 'Pichai Phirom', '086-543-2109', 'pichai@yahoo.com'),
    (4, 'Sirin Maneerat', '097-654-3210', 'sirinth@outlook.com'),
    (5, 'Wichai Wongwichit', '088-765-4321', 'wichai@hotmail.com'),
    (6, 'Kanokwan Pongsatit', '099-876-5432', 'kanokwan@tutanota.com'),
    (7, 'Chaiwat Suwanchoti', '087-987-6543', 'chaiwat@zoho.com'),
    (8, 'Sasiwimon Lertsirikul', '090-123-4567', 'sasivimol@yandex.com'),
    (9, 'Worawit Chanprasert', '085-432-1098', 'worawit@icloud.com'),
    (10, 'Pimolan Sriwarah', '091-543-2109', 'pimolwan@gmail.com');

-- Insert mockup data into the orders table
INSERT INTO orders (order_id, customer_id, menu_id, branch_id, order_date, quantity, total_amount)
VALUES
    (1, 1, 4, 2, '2023-11-05 10:28:01', 1, 299.50),
    (2, 1, 4, 2, '2023-11-06 12:28:01', 2, 598.75),
    (3, 2, 3, 3, '2023-11-07 14:28:01', 3, 897.00),
    (4, 3, 4, 4, '2023-11-08 15:28:01', 4, 1196.00),
    (5, 4, 5, 5, '2023-11-09 19:28:01', 5, 1495.00),
    (6, 4, 6, 6, '2023-11-10 15:28:01', 6, 1794.25),
    (7, 6, 7, 2, '2023-11-11 09:38:01', 7, 2093.00),
    (8, 9, 4, 8, '2023-11-12 15:28:01', 8, 2392.00),
    (9, 9, 9, 2, '2023-11-13 15:28:01', 9, 2691.00),
    (10, 10, 10, 10, '2023-11-14 15:28:01', 10, 2990.00);

-- Insert mockup data into the menus table
INSERT INTO menus (menu_id, menu_name, menu_size, menu_price, menu_category)
VALUES
    (1, 'Pizza with Pepperoni', '14 inches', 399.00, 'Classic Pizza'),
    (2, 'Hawaiian Pizza', '10 inches', 249.00, 'Fruit Pizza'),
    (3, 'Pizza with Sausage', '16 inches', 499.00, 'Meat Pizza'),
    (4, 'Pizza with Seafood', '12 inches', 399.00, 'Seafood Pizza'),
    (5, 'Pizza with Mixed Vegetables', '12 inches', 299.00, 'Vegetarian Pizza'),
    (6, 'Pizza with BBQ Chicken', '16 inches', 499.00, 'Meat Pizza'),
    (7, 'Pizza with Grilled Pork', '14 inches', 399.00, 'Meat Pizza'),
    (8, 'Pizza with Grilled Shrimp', '10 inches', 249.00, 'Seafood Pizza'),
    (9, 'Pizza with Pineapple', '12 inches', 349.00, 'Fruit Pizza'),
    (10, 'Pizza with Bacon', '12 inches', 399.00, 'Meat Pizza');

-- Insert mockup data into the branchs table
INSERT INTO branchs (branch_id, branch_name, branch_address, branch_city, branch_country)
VALUES
    (1, 'Ratchadaphisek Branch', '1213 Ratchadaphisek Road, Bangkok 10310', 'Bangkok', 'Thailand'),
    (2, 'Rama IX Branch', '1415 Rama IX Road, Bangkok 10240', 'Bangkok', 'Thailand'),
    (3, 'Pattaya Branch', '1617 Pattaya Nuea Road, Pattaya, Chonburi 20150', 'Pattaya', 'Thailand'),
    (4, 'Phuket Branch', '1819 Ratsada Road, Phuket Town, Phuket 83000', 'Phuket', 'Thailand'),
    (5, 'Chiang Mai Branch', '2021 Charoenmuang Road, Chiang Mai City, Chiang Mai 50200', 'Chiang Mai', 'Thailand'),
    (6, 'Nakhon Ratchasima Branch', '2223 Mittraphap Road, Nakhon Ratchasima City, Nakhon Ratchasima 30000', 'Nakhon Ratchasima', 'Thailand'),
    (7, 'Ayutthaya Branch', '1111 Naresuan Road, Ayutthaya City, Ayutthaya 13000', 'Ayutthaya', 'Thailand'),
    (8, 'Khon Kaen Branch', '2222 Nakhon Kaen Road, Khon Kaen City, Khon Kaen 40000', 'Khon Kaen', 'Thailand'),
    (9, 'Udon Thani Branch', '3333 Udon Thani Road, Udon Thani City, Udon Thani 41000', 'Udon Thani', 'Thailand'),
    (10, 'Chiang Rai Branch', '4444 Chiang Rai Road, Chiang Rai City, Chiang Rai 57000', 'Chiang Rai', 'Thailand'),
    (11, 'Songkhla Branch', '5555 Songkhla Road, Songkhla City, Songkhla 90000', 'Songkhla', 'Thailand');

-- Insert mockup data into the pizza_ingredient table
INSERT INTO pizza_ingredient
VALUES
    (1, 1, 'Tomato Sauce', 'Seasoning', 10.00),
    (2, 1, 'Mozzarella Cheese', 'Topping', 20.00),
    (3, 1, 'Pepperoni', 'Meat', 30.00),
    (4, 2, 'Tomato Sauce', 'Seasoning', 10.00),
    (5, 2, 'Mozzarella Cheese', 'Topping', 20.00),
    (6, 2, 'Sausage with Pepper', 'Meat', 30.00),
    (7, 3, 'Tomato Sauce', 'Seasoning', 10.00),
    (8, 3, 'Mozzarella Cheese', 'Topping', 20.00),
    (9, 3, 'Isan Sausage', 'Meat', 30.00),
    (10, 4, 'Tomato Sauce', 'Seasoning', 10.00);

---------------------------------------------------------------------------
--SQL QUERIES--
.mode box
  
--1. top 4 customers w/ the highest spending
SELECT "Top 4 customers with the highest spending";

WITH customer_spending AS (
  SELECT 
    customers.customer_id, 
    SUM(orders.total_amount) AS total_spending
  FROM customers
  JOIN orders ON customers.customer_id = orders.customer_id
  GROUP BY customers.customer_id  
)

SELECT 
  customers.name, 
  customer_spending.total_spending,
  email
  
FROM customers
JOIN customer_spending ON customers.customer_id = customer_spending.customer_id
ORDER BY customer_spending.total_spending DESC
LIMIT 4;

--2. Which branch has the highest order count / highest total revenues?
SELECT "Which branch has the highest order count / highest total revenues?";

SELECT
  branchs.branch_name,
  COUNT(*) AS order_count,
  SUM(orders.total_amount) AS total_revenues
FROM orders
JOIN branchs ON orders.branch_id = branchs.branch_id
WHERE order_date BETWEEN '2023-11-05 18:00:00' AND '2023-11-14 20:00:00'
GROUP BY branch_name
ORDER BY order_count DESC;

--3. Which menu are most popular -> each branch?
SELECT "Which menu are most popular -> each branch?";

SELECT
  branchs.branch_name,
  menus.menu_name,
  COUNT(*) AS order_count
FROM orders
JOIN branchs ON orders.branch_id = branchs.branch_id
JOIN menus ON orders.menu_id = menus.menu_id
GROUP BY branch_name, menu_name
ORDER BY order_count DESC;
