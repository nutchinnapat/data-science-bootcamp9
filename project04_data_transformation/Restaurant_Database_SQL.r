## HW02 - restaurant pizza SQL
## create 3-5 dataframes => write table into server


## connect to PostgreSQL server
library(RPostgreSQL)
library(tidyverse)

######################################################################

## create connection
con <- dbConnect(
  PostgreSQL(),
  host = 	"arjuna.db.elephantsql.com",
  dbname = "equcxncr",
  user = "equcxncr",
  password = "VmCtXBegZIG9vjn8ZtpnNgu-k6ZzVQQn",
  port = 5432
)

######################################################################

## create table from SQL homework
# dataframe "customers"
df_customers <- data.frame(
  customer_id = c(1:10),
  first_name = c("Somchai", "Jitrlada", "Pichai", "Sirin", "Wichai", "Kanokwan", "Chaiwat", "Sasiwimon", "Worawit", "Pimolan"),
  last_name = c("Churnsri", "Sitthiphant", "Phirom", "Maneerat", "Wongwichit", "Pongsatit", "Suwanchoti", "Lertsirikul", "Chanprasert", "Sriwarah"),
  phone_number = c("089-123-4567", "098-765-4321", "086-543-2109", "097-654-3210", "088-765-4321", "099-876-5432", "087-987-6543", "090-123-4567", "085-432-1098", "091-543-2109"),
  email = c("somchai@gmail.com", "jitlada@hotmail.com", "pichai@yahoo.com", "sirinth@outlook.com", "wichai@hotmail.com", "kanokwan@tutanota.com", "chaiwat@zoho.com", "sasivimol@yandex.com", "worawit@icloud.com", "pimolwan@gmail.com")
)

# dataframe "orders"
df_orders <- data.frame(
  order_id = c(1:10),
  customer_id = c(1, 1, 2, 3, 4, 4, 6, 9, 9, 10),
  menu_id = c(4, 4, 3, 4, 5, 6, 7, 4, 9, 10),
  branch_id = c(2, 2, 3, 4, 5, 6, 2, 8, 2, 10),
  order_date = strptime(
    c("2023-11-05 10:28:01", 
      "2023-11-06 12:28:01", 
      "2023-11-07 14:28:01", 
      "2023-11-08 15:28:01", 
      "2023-11-09 19:28:01", 
      "2023-11-10 15:28:01", 
      "2023-11-11 09:38:01", 
      "2023-11-12 15:28:01", 
      "2023-11-13 15:28:01", 
      "2023-11-14 15:28:01"),
    "%Y-%m-%d %H:%M:%S"),
  quantity = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
  total_amount = c(299.50, 598.75, 897.00, 1196.00, 1495.00, 1794.25, 2093.00, 2392.00, 2691.00, 2990.00)
)

# dataframe "menus"
df_menus <- data.frame(
  menu_id = c(1:10),
  menu_name = c("Pizza with Pepperoni", "Hawaiian Pizza", "Pizza with Sausage", "Pizza with Seafood", "Pizza with Mixed Vegetables", "Pizza with BBQ Chicken", "Pizza with Grilled Pork", "Pizza with Grilled Shrimp", "Pizza with Pineapple", "Pizza with Bacon"),
  meu_size = c("14 inches", "10 inches", "16 inches", "12 inches", "12 inches", "16 inches", "14 inches", "10 inches", "12 inches", "12 inches"),
  menu_price = c(399.00, 249.00, 499.00, 399.00, 299.00, 499.00, 399.00, 249.00, 349.00, 399.00),
  menu_category = c("Classic Pizza", "Fruit Pizza", "Meat Pizza", "Seafood Pizza", "Vegetarian Pizza", "Meat Pizza", "Meat Pizza", "Seafood Pizza", "Fruit Pizza", "Meat Pizza")
)

# dataframe "branches"
df_branches <- data.frame(
  branch_id = c(1:11),
  branch_name = c("Ratchadaphisek Branch", "Rama IX Branch", "Pattaya Branch", "Phuket Branch", "Chiang Mai Branch", "Nakhon Ratchasima Branch", "Ayutthaya Branch", "Khon Kaen Branch", "Udon Thani Branch", "Chiang Rai Branch", "Songkhla Branch"),
  branch_address = c(
    "1213 Ratchadaphisek Road, Bangkok 10310", 
    "1415 Rama IX Road, Bangkok 10240", 
    "1617 Pattaya Nuea Road, Pattaya, Chonburi 20150", 
    "1819 Ratsada Road, Phuket Town, Phuket 83000", 
    "2021 Charoenmuang Road, Chiang Mai City, Chiang Mai 50200", 
    "2223 Mittraphap Road, Nakhon Ratchasima City, Nakhon Ratchasima 30000", 
    "1111 Naresuan Road, Ayutthaya City, Ayutthaya 13000", 
    "2222 Nakhon Kaen Road, Khon Kaen City, Khon Kaen 40000", 
    "3333 Udon Thani Road, Udon Thani City, Udon Thani 41000", 
    "4444 Chiang Rai Road, Chiang Rai City, Chiang Rai 57000", 
    "5555 Universe Road, Metro City, Metrospace 90000"),
  bracnh_city = c("Bangkok", "Bangkok", "Pattaya", "Phuket", "Chiang Mai", "Nakhon Ratchasima", "Ayutthaya", "Khon Kaen", "Udon Thani", "Chiang Rai", "Songkhla"),
  branch_country = c("Thailand", "Thailand", "Thailand", "Thailand", "Thailand", "Thailand", "Thailand", "Thailand", "Thailand", "Thailand", "Universal")
)

# dataframe "pizza_ingredient"
df_pizza_ingredient <- data.frame(
  ingredient_id = c(1:10),
  menu_id = c(1, 1, 1, 2, 2, 2, 3, 3, 3, 4),
  ingredient_name = c("Tomato Sauce", "Mozzarella Cheese", "Pepperoni", "Tomato Sauce", "Mozzarella Cheese", "Sausage with Pepper", "Tomato Sauce", "Mozzarella Cheese", "Isan Sausage", "Tomato Sauce"),
  ingredient_category = c("Seasoning", "Topping", "Meat", "Seasoning", "Topping", "Meat", "Seasoning", "Topping", "Meat", "Seasoning"),
  ingredient_price =c(10.00, 20.00, 30.00, 10.00, 20.00, 30.00, 10.00, 20.00, 30.00, 10.00)
)

######################################################################

# convert to vector for code refactor in dbWriteTable
table_names <- c("customers", "orders", "menus", "branches", "pizza_ingredient")
dataframes <- list(df_customers, df_orders, df_menus, df_branches, df_pizza_ingredient)
# Write data to the tables
for (i in 1:length(table_names)) {
  dbWriteTable(con, table_names[i], dataframes[[i]], row.names = F)
}

## db List Tables
dbListTables(con)
dbListFields(con, "customers")
dbListFields(con, "orders")
######################################################################

## get query data
# 1. Top 4 customers w/ the highest spending

Q1 <- dbGetQuery(con, "
WITH customer_spending AS (
  SELECT 
    customers.customer_id, 
    SUM(orders.total_amount) AS total_spending
  FROM customers
  JOIN orders ON customers.customer_id = orders.customer_id
  GROUP BY customers.customer_id  
)

SELECT 
  customers.first_name,
  customers.last_name,
  customer_spending.total_spending,
  email
  
FROM customers
JOIN customer_spending ON customers.customer_id = customer_spending.customer_id
ORDER BY customer_spending.total_spending DESC
LIMIT 4;")

cat("Top 4 customers with the highest spending\n")
Q1


# 2. Which branch has the highest order count / highest total revenues? (between 5 november and 14 november)

Q2 <- dbGetQuery(con, "
WITH latest_orders AS (
  SELECT
    branch_id,
    MAX(order_date) AS latest_order_date
  FROM orders
  GROUP BY branch_id
)

SELECT
  branches.branch_name,
  COUNT(*) AS order_count,
  SUM(orders.total_amount) AS total_revenues,
  latest_orders.latest_order_date
FROM orders
JOIN branches ON orders.branch_id = branches.branch_id
JOIN latest_orders ON orders.branch_id = latest_orders.branch_id
WHERE order_date BETWEEN '2023-11-05 18:00:00' AND '2023-11-14 20:00:00'
GROUP BY branch_name, latest_orders.latest_order_date
ORDER BY order_count DESC;
")

cat("Which branch has the highest order count / highest total revenues? (between 5 november and 14 november)\n")
Q2


# 3. Which menu is most popular -> each branch?

Q3 <- dbGetQuery(con,"
SELECT
  menus.menu_name,
  branches.branch_name,
  COUNT(*) AS order_count
FROM orders
JOIN branches ON orders.branch_id = branches.branch_id
JOIN menus ON orders.menu_id = menus.menu_id
GROUP BY branch_name, menu_name
ORDER BY order_count DESC;")

cat("Which menu is most popular -> each branch?\n")
Q3

## close connection
dbDisconnect(con)

## Export results to CSV files
write.csv(Q1, "Q1.csv", row.names = F)
write.csv(Q2, "Q2.csv", row.names = F)
write.csv(Q3, "Q3.csv", row.names = F)
