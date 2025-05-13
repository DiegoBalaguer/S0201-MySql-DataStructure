-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         10.11.11-MariaDB-0+deb12u1 - Debian 12
-- SO del servidor:              debian-linux-gnu
-- HeidiSQL Versión:             12.10.0.7000
-- 
-- Author:                       Diego Balaguer
-- Date:                         02/05/2025
-- Database:                     pizzeria
-- --------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para pizzeria
CREATE DATABASE IF NOT EXISTS pizzeria /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE pizzeria;


-- Desactivar claves foráneas
SET FOREIGN_KEY_CHECKS = 0;


-- Volcando estructura para address
DROP TABLE IF EXISTS address;
CREATE TABLE IF NOT EXISTS address (
  address_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  building_number varchar(20) DEFAULT NULL,
  floor varchar(20) DEFAULT NULL,
  door varchar(20) DEFAULT NULL,
  postal_code varchar(20) NOT NULL,
  locality_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (address_id),
  KEY address_locality_FK (locality_id),
  CONSTRAINT address_locality_FK FOREIGN KEY (locality_id) REFERENCES locality (locality_id)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para customer
DROP TABLE IF EXISTS customer;
CREATE TABLE IF NOT EXISTS customer (
  customer_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  surname varchar(50) NOT NULL,
  address_id bigint(20) unsigned NOT NULL,
  phone varchar(20) NOT NULL,
  PRIMARY KEY (customer_id),
  UNIQUE KEY customer_unique (name),
  KEY customer_address_FK (address_id),
  CONSTRAINT customer_address_FK FOREIGN KEY (address_id) REFERENCES address (address_id)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para delivery
DROP TABLE IF EXISTS delivery;
CREATE TABLE IF NOT EXISTS delivery (
  delivery_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  PRIMARY KEY (delivery_id),
  UNIQUE KEY delivery_unique (name),
  KEY delivery_name_FK (name)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para employee
DROP TABLE IF EXISTS employee;
CREATE TABLE IF NOT EXISTS employee (
  employee_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  surname varchar(50) DEFAULT NULL,
  address_id bigint(20) unsigned NOT NULL,
  job_position_id bigint(20) unsigned NOT NULL,
  shop_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (employee_id),
  KEY employee_address_FK (address_id),
  KEY employee_job_positions_FK (job_position_id),
  KEY employee_shop_FK (shop_id),
  CONSTRAINT employee_address_FK FOREIGN KEY (address_id) REFERENCES address (address_id),
  CONSTRAINT employee_job_positions_FK FOREIGN KEY (job_position_id) REFERENCES job_position (job_position_id),
  CONSTRAINT employee_shop_FK FOREIGN KEY (shop_id) REFERENCES shop (shop_id)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para job_position
DROP TABLE IF EXISTS job_position;
CREATE TABLE IF NOT EXISTS job_position (
  job_position_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  PRIMARY KEY (job_position_id)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para locality
DROP TABLE IF EXISTS locality;
CREATE TABLE IF NOT EXISTS locality (
  locality_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  province_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (locality_id),
  UNIQUE KEY locality_unique (name),
  KEY locality_province_FK (province_id),
  CONSTRAINT locality_province_FK FOREIGN KEY (province_id) REFERENCES province (province_id)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para pizza_category
DROP TABLE IF EXISTS pizza_category;
CREATE TABLE IF NOT EXISTS pizza_category (
  pizza_category_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  PRIMARY KEY (pizza_category_id)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para pizza_category_version
DROP TABLE IF EXISTS pizza_category_version;
CREATE TABLE IF NOT EXISTS pizza_category_version (
  category_version_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  version bigint(20) unsigned NOT NULL,
  name varchar(50) NOT NULL,
  pizza_category_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (category_version_id),
  KEY pizza_category_version_pizza_category_FK (pizza_category_id),
  CONSTRAINT pizza_category_version_pizza_category_FK FOREIGN KEY (pizza_category_id) REFERENCES pizza_category (pizza_category_id)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para product
DROP TABLE IF EXISTS product;
CREATE TABLE IF NOT EXISTS product (
  product_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  product_type_id bigint(20) unsigned NOT NULL,
  pizza_category_version_id bigint(20) unsigned DEFAULT NULL,
  name varchar(50) NOT NULL,
  description varchar(200) DEFAULT NULL,
  picture blob DEFAULT NULL,
  price decimal(10,4) NOT NULL,
  PRIMARY KEY (product_id),
  KEY product_product_type_FK (product_type_id),
  KEY product_pizza_category_version_FK (pizza_category_version_id),
  CONSTRAINT product_pizza_category_version_FK FOREIGN KEY (pizza_category_version_id) REFERENCES pizza_category_version (category_version_id),
  CONSTRAINT product_product_type_FK FOREIGN KEY (product_type_id) REFERENCES product_type (product_type_id)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para product_type
DROP TABLE IF EXISTS product_type;
CREATE TABLE IF NOT EXISTS product_type (
  product_type_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  description varchar(50) NOT NULL,
  PRIMARY KEY (product_type_id)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para province
DROP TABLE IF EXISTS province;
CREATE TABLE IF NOT EXISTS province (
  province_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  PRIMARY KEY (province_id),
  UNIQUE KEY province_unique (name)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para purchase
DROP TABLE IF EXISTS purchase;
CREATE TABLE IF NOT EXISTS purchase (
  purchase_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  shop_id bigint(20) unsigned NOT NULL,
  customer_id bigint(20) unsigned NOT NULL,
  delivery_id bigint(20) unsigned NOT NULL,
  registration_date datetime NOT NULL DEFAULT current_timestamp(),
  employee_reception_id bigint(20) unsigned NOT NULL,
  employee_delivery_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (purchase_id),
  KEY purchase_shop_FK (shop_id),
  KEY purchase_customer_FK (customer_id),
  KEY purchase_delivery_FK (delivery_id),
  KEY purchase_employee_reception_FK (employee_reception_id),
  KEY purchase_employee_delivery_FK (employee_delivery_id),
  CONSTRAINT purchase_customer_FK FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
  CONSTRAINT purchase_delivery_FK FOREIGN KEY (delivery_id) REFERENCES delivery (delivery_id),
  CONSTRAINT purchase_employee_delivery_FK FOREIGN KEY (employee_delivery_id) REFERENCES employee (employee_id),
  CONSTRAINT purchase_employee_reception_FK FOREIGN KEY (employee_reception_id) REFERENCES employee (employee_id),
  CONSTRAINT purchase_shop_FK FOREIGN KEY (shop_id) REFERENCES shop (shop_id)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para purchase_detail
DROP TABLE IF EXISTS purchase_detail;
CREATE TABLE IF NOT EXISTS purchase_detail (
  purchase_detail_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  purchase_id bigint(20) unsigned NOT NULL,
  product_id bigint(20) unsigned NOT NULL,
  quantity bigint(20) DEFAULT NULL,
  PRIMARY KEY (purchase_detail_id),
  KEY purchase_detail_purchase_FK (purchase_id),
  KEY purchase_detail_product_FK (product_id),
  CONSTRAINT purchase_detail_product_FK FOREIGN KEY (product_id) REFERENCES product (product_id),
  CONSTRAINT purchase_detail_purchase_FK FOREIGN KEY (purchase_id) REFERENCES purchase (purchase_id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para shop
DROP TABLE IF EXISTS shop;
CREATE TABLE IF NOT EXISTS shop (
  shop_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  address_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (shop_id),
  UNIQUE KEY shop_unique (name),
  KEY shop_address_FK (address_id),
  CONSTRAINT shop_address_FK FOREIGN KEY (address_id) REFERENCES address (address_id)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

-- Reactivar claves foráneas
SET FOREIGN_KEY_CHECKS = 1;


-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         10.11.11-MariaDB-0+deb12u1 - Debian 12
-- SO del servidor:              debian-linux-gnu
-- 
-- Author:                       Diego Balaguer
-- Date:                         02/05/2025
-- Database:                     pizzeria
-- --------------------------------------------------------

use pizzeria;


-- Desactivar claves foráneas
SET FOREIGN_KEY_CHECKS = 0;


-- Borrar datos existentes antes de insertar nuevos registros
TRUNCATE TABLE address;
TRUNCATE TABLE customer;
TRUNCATE TABLE delivery;
TRUNCATE TABLE employee;
TRUNCATE TABLE job_position;
TRUNCATE TABLE locality;
TRUNCATE TABLE purchase;
TRUNCATE TABLE purchase_detail;
TRUNCATE TABLE pizza_category;
TRUNCATE TABLE pizza_category_version;
TRUNCATE TABLE product;
TRUNCATE TABLE product_type;
TRUNCATE TABLE province;
TRUNCATE TABLE shop;


-- address
INSERT INTO address (name, building_number, floor, door, postal_code, locality_id) VALUES
('Calle Falsa', '123', NULL, NULL, '08135', 1),
('Avenida Siempre Viva', '742', NULL, NULL, '08135', 1),
('Plaza del Sol', '45', NULL, NULL, '08135', 1),
('Calle Luna', '9', NULL, NULL, '08135', 3),
('Calle Mar', '12', NULL, NULL, '08135', 1),
('Avenida Río', '8', NULL, NULL, '08135', 1), 
('Calle de Mariano Alberti', '78', NULL, NULL, '08001', 3),
('Calle de Alberto Cortina', '108',  NULL, NULL, '08001', 3),
('Calle de Maribel Cascabel', '23', NULL, NULL, '08001', 3),
('Calle de Ana de Armas', '75', NULL, NULL, '08001', 3),
('Calle de Esther Dueñas', '41', NULL, NULL, '08001', 3);


-- Clientes
INSERT INTO customer (name, surname, address_id, phone) VALUES
('Juan', 'Pérez', 1, '600123456'),
('María', 'López', 2, '600654321'),
('Pedro', 'Ramírez', 3, '600789123'),
('Ana', 'Torres', 4, '600987654'),
('Laura', 'Gómez', 5, '600456789'),
('Javier', 'Ruiz', 6, '600321654');


-- delivery
INSERT INTO delivery(name) VALUES
('pick up in store'),
('home delivery');


-- employee
INSERT INTO employee(name, surname, address_id, job_position_id, shop_id) VALUES
('Mariano', 'Serra', 7, 7, 1),
('Alberto', 'Pinto', 8, 7, 1),
('Maribel', 'Exposito', 9, 7, 1),
('Ana', 'Valverde', 10, 4, 1),
('Esther', 'Ramirez', 11, 1, 1),
('Belen', 'Exposito', 6, 4, 1);


-- job_positions
INSERT INTO job_position(name) VALUES
('Store Manager'),
('Assistant Manager'),
('Shift Supervisor'),
('Customer Service Representative'),
('Pizza Maker'),
('Kitchen Staff'),
('Delivery Driver'),
('Cleaner'),
('Cashier');


-- locality
INSERT INTO locality (name, province_id) VALUES
('Santa Coloma de Gramanet', 1),
('Hospitalet', 1),
('Salou', 2);


-- pizza_category_id
INSERT INTO pizza_category (name) VALUES
('Thin crust pizza'),
('Thick crust pizza'),
('Wholemeal pizza'),
('Vegetarian pizza');


-- pizza_category_version
INSERT INTO pizza_category_version (version, name, pizza_category_id) VALUES
(1, 'Thin crust pizza', 1),
(1, 'Thick crust pizza', 2),
(1, 'Wholemeal pizza', 3),
(1, 'Vegetarian pizza', 4),
(2, 'January Thin crust pizza', 1),
(3, 'August Thin crust pizza', 1);


-- product
INSERT INTO product(product_type_id, pizza_category_version_id, name, description, picture, price) VALUES
(1, 6, 'Pizza napolitana', 'Pizzas with tomatoes', NULL, 30),
(1, 4, 'Pizza napolitana vegetarian', 'Pizzas with tomatoes', NULL, 30),
(2, NULL, 'Hamburger cheddar', 'hamburger with cheddar and onions', NULL, 25),
(3, NULL, 'Spring water', 'spring water cold', NULL, 15),
(3, NULL, 'Fanta naranja', 'drink cold', NULL, 15),
(3, NULL, 'Fanta Limon', 'drink cold', NULL, 15),
(3, NULL, 'Sprite', 'drink cold', NULL, 15);


-- product_type
INSERT INTO product_type(name, description) VALUES
('pizzas', 'home pizzas'),
('hamburgers', 'big hamburgers'),
('drinks', 'the most cold drinks');


-- province
INSERT INTO province (name) VALUES
('Barcelona'),
('Tarragona');


-- purchase
INSERT INTO purchase (shop_id, customer_id, delivery_id, employee_reception_id, employee_delivery_id) VALUES
(1, 2, 1, 4, 4),
(1, 2, 1, 6, 4),
(1, 3, 2, 4, 3),
(2, 4, 2, 6, 2);


-- purchase_detail
INSERT INTO purchase_detail (purchase_id, product_id, quantity) VALUES
(1, 1, 4),
(1, 2, 2),
(1, 4, 2),
(1, 5, 2),
(1, 6, 2),
(2, 3, 5),
(2, 1, 1),
(2, 5, 2),
(2, 7, 4),
(3, 1, 4),
(3, 4, 1),
(3, 6, 3),
(4, 3, 4),
(4, 5, 2),
(4, 7, 2);


-- shop
INSERT INTO shop (name, address_id) VALUES
('Pizzeria Maladeta', 3),
('Pizzeria Most', 4);


-- Reactivar claves foráneas
SET FOREIGN_KEY_CHECKS = 1;


-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         10.11.11-MariaDB-0+deb12u1 - Debian 12
-- SO del servidor:              debian-linux-gnu
-- 
-- Author:                       Diego Balaguer
-- Date:                         02/05/2025
-- Database:                     pizzeria
-- --------------------------------------------------------


USE pizzeria;


-- Lists how many products from the 'drinks' category have been sold in a specific locality
SELECT DISTINCT l.name locality, pt.name product_type, pr.name product, SUM(pd.quantity) total_product
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN locality l ON a.locality_id = l.locality_id
JOIN purchase p ON c.customer_Id = p.customer_id
jOIN purchase_detail pd ON p.purchase_id = pd.purchase_id
JOIN product pr ON pd.product_id = pr.product_id
JOIN product_type pt ON pr.product_type_id = pt.product_type_id
WHERE a.locality_id = 1 AND pr.product_type_id = 3
GROUP BY l.name, pt.name, pr.name;


-- Lists how many different orders a specific employee has made
SELECT CONCAT(e.name, ' ', e.surname) employee, p.purchase_id
FROM employee e
JOIN purchase p ON p.employee_reception_id = e.employee_id
WHERE e.employee_id = 6;

