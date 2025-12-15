


-- 2. Production.Categories Table
CREATE TABLE Production.Categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);

-- 3. Production.Brands Table
CREATE TABLE Production.Brands (
    brand_id INT IDENTITY(1,1) PRIMARY KEY,
    brand_name VARCHAR(255) NOT NULL
);

-- 4. Sales.Customers Table
CREATE TABLE Sales.Customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone VARCHAR(25),
    email VARCHAR(255) NOT NULL UNIQUE,
    street VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(25),
    zip_code VARCHAR(10)
);

-- 5. Sales.Stores Table (Bu jadval Stocks jadvali uchun asosdir)
CREATE TABLE Sales.Stores (
    store_id INT IDENTITY(1,1) PRIMARY KEY,
    store_name VARCHAR(255) NOT NULL,
    phone VARCHAR(25),
    email VARCHAR(255) UNIQUE,
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(10),
    zip_code VARCHAR(10)
);
GO

-- 6. Production.Products Table
CREATE TABLE Production.Products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DECIMAL(10, 2) NOT NULL,
    
    FOREIGN KEY (brand_id) REFERENCES Production.Brands (brand_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Production.Categories (category_id) ON DELETE CASCADE
);

-- 7. Sales.Staffs Table (Birinchi qism)
CREATE TABLE Sales.Staffs (
    staff_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(25),
    active INT NOT NULL,
    store_id INT NOT NULL,
    manager_id INT NULL, 
    
    -- Sales.Stores ga bog'lanish
    FOREIGN KEY (store_id) REFERENCES Sales.Stores (store_id) ON DELETE NO ACTION
);

-- 7B. Sales.Staffs Table (Ikkinchi qism: O'ziga bog'langan FKni qo'shish)
ALTER TABLE Sales.Staffs
ADD CONSTRAINT FK_Staffs_Manager
FOREIGN KEY (manager_id) 
REFERENCES Sales.Staffs (staff_id) 
ON DELETE NO ACTION
ON UPDATE NO ACTION; 
GO

-- 8. Production.Stocks Table (Endi Sales.Stores allaqachon mavjud)
CREATE TABLE Production.Stocks (
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT,
    
    PRIMARY KEY (store_id, product_id),
    
    -- Sales.Stores ga to'g'ri murojaat
    FOREIGN KEY (store_id) REFERENCES Sales.Stores (store_id) ON DELETE CASCADE, 
    FOREIGN KEY (product_id) REFERENCES Production.Products (product_id) ON DELETE CASCADE
);

-- 9. Sales.Orders Table
CREATE TABLE Sales.Orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    order_status SMALLINT NOT NULL, 
    order_date DATE NOT NULL,
    required_date DATE NOT NULL,
    shipped_date DATE,
    store_id INT NOT NULL,
    staff_id INT NOT NULL,
    
    FOREIGN KEY (customer_id) REFERENCES Sales.Customers (customer_id) ON DELETE NO ACTION,
    FOREIGN KEY (store_id) REFERENCES Sales.Stores (store_id) ON DELETE NO ACTION,
    FOREIGN KEY (staff_id) REFERENCES Sales.Staffs (staff_id) ON DELETE NO ACTION 
);

-- 10. Sales.Order_Items Table (Junction Table)
CREATE TABLE Sales.Order_Items (
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    list_price DECIMAL(10, 2) NOT NULL,
    discount DECIMAL(4, 2) NOT NULL DEFAULT 0,
    
    PRIMARY KEY (order_id, item_id),
    
    FOREIGN KEY (order_id) REFERENCES Sales.Orders (order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Production.Products (product_id) ON DELETE NO ACTION
);
GO