CREATE TABLE EMPLOYEES
(
ID INT IDENTITY(1,1) NOT NULL,
FIRST_NAME VARCHAR(8000) NOT NULL,
LAST_NAME VARCHAR(8000) NOT NULL,
GENDER BIT NOT NULL,
AGE INT NOT NULL,
OCCUPATION_ID INT NOT NULL,
SALARY INT NOT NULL,
EXPERIENCE_IN_YEARS INT NOT NULL
);

CREATE TABLE OCCUPATIONS
(
ID INT IDENTITY(1,1) NOT NULL ,
OCCUPATION_NAME VARCHAR(8000) NOT NULL
);

CREATE TABLE STORAGES
(
ID INT IDENTITY(1,1) NOT NULL,
TYPE VARCHAR(8000) NOT NULL
);

CREATE TABLE INGREDIANTS
(
ID INT IDENTITY(1,1) NOT NULL,
NAME VARCHAR(8000) NOT NULL,
AMOUNT INT NOT NULL,
QUANTITY_TYPE VARCHAR(8000) NOT NULL,
EXPIRES_AT DATETIME NOT NULL,
PRICE MONEY NOT NULL,
SUPPLIER VARCHAR(8000) NOT NULL
);

CREATE TABLE PRODUCTS
(
ID INT IDENTITY(1,1) NOT NULL,
MENU_ID INT NOT NULL,
NAME VARCHAR(8000) NOT NULL,
DESCRIPTION VARCHAR(8000) ,
PICTURE_URL VARCHAR(8000) ,
PRICE MONEY NOT NULL
);

CREATE TABLE INGREDIANTS_IN_PRODUCTS
(
PRODUCT_ID INT NOT NULL,
INGREDIANT_ID INT NOT NULL,
INGREDIANT_AMOUNT INT NOT NULL
);

CREATE TABLE MENUS
(
ID INT IDENTITY(1,1) NOT NULL,
MENU_TYPE VARCHAR(8000) NOT NULL,
IS_ACTIVE BIT NOT NULL,
CREATED_AT DATETIME NOT NULL,
UPDATED_AT DATETIME NOT NULL
);

CREATE TABLE ORDERS
(
ID INT IDENTITY(1,1) NOT NULL,
EMPLOYEE_ID INT NOT NULL,
CREATED_AT DATETIME NOT NULL,
FINISHED_AT DATETIME NOT NULL
);

CREATE TABLE PRODUCTS_IN_ORDERS
(
PRODUCT_ID INT NOT NULL,
ORDER_ID INT NOT NULL
);

CREATE TABLE PRODUCTS_PRICES
(
PRODUCT_ID INT NOT NULL,
PRICE MONEY NOT NULL,
VALID_FROM DATETIME NOT NULL,
VALID_TO DATETIME NULL,
);

CREATE TABLE INGREDIANTS_PRICES
(
INGREDIANT_ID INT NOT NULL,
PRICE MONEY NOT NULL,
VALID_FROM DATETIME NOT NULL,
VALID_TO DATETIME NULL,
);

ALTER TABLE EMPLOYEES ADD CONSTRAINT PK_EMPLOYEES PRIMARY KEY(ID);
ALTER TABLE STORAGES ADD CONSTRAINT PK_STORAGES PRIMARY KEY(ID);
ALTER TABLE INGREDIANTS ADD CONSTRAINT PK_INGREDIANTS PRIMARY KEY(ID);
ALTER TABLE PRODUCTS ADD CONSTRAINT PK_PRODUCTS PRIMARY KEY (ID);
ALTER TABLE MENUS ADD CONSTRAINT PK_MENUS PRIMARY KEY(ID);
ALTER TABLE ORDERS ADD CONSTRAINT PK_ORDERS PRIMARY KEY(ID);
ALTER TABLE OCCUPATIONS ADD CONSTRAINT PK_OCCUPATIONS PRIMARY KEY(ID);
ALTER TABLE INGREDIANTS_IN_PRODUCTS ADD CONSTRAINT PK_INGREDIANTS_IN_PRODUCTS PRIMARY KEY(INGREDIANT_ID,PRODUCT_ID);
ALTER TABLE PRODUCTS_IN_ORDERS ADD CONSTRAINT PK_PRODUCTS_IN_ORDERS PRIMARY KEY(PRODUCT_ID,ORDER_ID);

ALTER TABLE EMPLOYEES ADD CONSTRAINT FK_EMPLOYEES_OCCUPATIONS FOREIGN KEY (OCCUPATION_ID) REFERENCES OCCUPATIONS(ID);
ALTER TABLE INGREDIANTS_IN_PRODUCTS ADD CONSTRAINT FK_INGREDIANTS_IN_PRODUCT_PRODUCTS FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS(ID);
ALTER TABLE INGREDIANTS_IN_PRODUCTS ADD CONSTRAINT FK_INGREDIANTS_IN_PRODUCT_INGREDIANTS FOREIGN KEY (INGREDIANT_ID) REFERENCES INGREDIANTS(ID);
ALTER TABLE PRODUCTS ADD CONSTRAINT FK_PRODUCTS_MENUS FOREIGN KEY(MENU_ID) REFERENCES MENUS(ID);
ALTER TABLE PRODUCTS_IN_ORDERS ADD CONSTRAINT FK_PRODUCTS_IN_ORDERS_PRODUCTS FOREIGN KEY(PRODUCT_ID) REFERENCES PRODUCTS(ID);
ALTER TABLE PRODUCTS_IN_ORDERS ADD CONSTRAINT FK_PRODUCTS_IN_ORDERS_ORDERS FOREIGN KEY(ORDER_ID) REFERENCES ORDERS(ID);
ALTER TABLE ORDERS ADD CONSTRAINT FK_ORDERS_EMPLOYEES FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES(ID);

ALTER TABLE INGREDIANTS ADD STORAGE_ID INT
ALTER TABLE INGREDIANTS ADD CONSTRAINT FK_INGREDIANTS_STORAGES FOREIGN KEY(STORAGE_ID) REFERENCES STORAGES(ID)

ALTER TABLE INGREDIANTS_IN_PRODUCTS ALTER COLUMN INGREDIANT_AMOUNT DECIMAL(18, 8)

ALTER TABLE PRODUCTS_PRICES ADD CONSTRAINT FK_PRODUCTS_PRICES_PRODUCTS FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS(ID);
ALTER TABLE INGREDIANTS_PRICES ADD CONSTRAINT FK_INGREDIANTS_PRICES_INGREDIANTS FOREIGN KEY (INGREDIANT_ID) REFERENCES INGREDIANTS(ID);


ALTER TABLE PRODUCTS_IN_ORDERS ADD AMOUNT INT NOT NULL CONSTRAINT DF_AMOUNT DEFAULT 1	

ALTER TABLE EMPLOYEES ADD LAST_UPDATED DATETIME DEFAULT NULL