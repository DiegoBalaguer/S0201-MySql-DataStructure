-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         10.11.11-MariaDB-0+deb12u1 - Debian 12
-- SO del servidor:              debian-linux-gnu
-- HeidiSQL Versión:             12.10.0.7000
-- 
-- Author:                       Diego Balaguer
-- Date:                         02/05/2025
-- Database:                     opticians
-- --------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para optica
CREATE DATABASE IF NOT EXISTS opticians /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE opticians;


-- Desactivar claves foráneas
SET FOREIGN_KEY_CHECKS = 0;


-- Volcando estructura para tabla address
DROP TABLE IF EXISTS address;
CREATE TABLE IF NOT EXISTS address (
  address_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  building_number varchar(20) DEFAULT NULL,
  floor varchar(20) DEFAULT NULL,
  door varchar(20) DEFAULT NULL,
  postal_code varchar(20) NOT NULL,
  city_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (address_id),
  KEY address_city_FK (city_id),
  CONSTRAINT address_city_FK FOREIGN KEY (city_id) REFERENCES city (city_Id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla brand
DROP TABLE IF EXISTS brand;
CREATE TABLE IF NOT EXISTS brand (
  brand_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  supplier_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (brand_id),
  UNIQUE KEY brand_unique (name),
  KEY brand_supplier_FK (supplier_id),
  CONSTRAINT brand_supplier_FK FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla city
DROP TABLE IF EXISTS city;
CREATE TABLE IF NOT EXISTS city (
  city_Id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  country_id varchar(3) NOT NULL,
  PRIMARY KEY (city_Id),
  UNIQUE KEY city_unique (name),
  KEY city_country_FK (country_id),
  CONSTRAINT city_country_FK FOREIGN KEY (country_id) REFERENCES country (country_Id)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla colour
DROP TABLE IF EXISTS colour;
CREATE TABLE IF NOT EXISTS colour (
  colour_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(20) NOT NULL,
  PRIMARY KEY (colour_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla country
DROP TABLE IF EXISTS country;
CREATE TABLE IF NOT EXISTS country (
  country_Id varchar(3) NOT NULL,
  name varchar(50) NOT NULL,
  PRIMARY KEY (country_Id),
  UNIQUE KEY country_unique (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla customer
DROP TABLE IF EXISTS customer;
CREATE TABLE IF NOT EXISTS customer (
  customer_Id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  address_id bigint(20) unsigned NOT NULL,
  phone varchar(20) DEFAULT NULL,
  mail varchar(50) DEFAULT NULL,
  registration_date date DEFAULT curdate(),
  referred_by bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (customer_Id),
  UNIQUE KEY customer_unique (name),
  KEY customer_customer_FK (referred_by),
  KEY customer_address_FK (address_id),
  CONSTRAINT customer_address_FK FOREIGN KEY (address_id) REFERENCES address (address_id),
  CONSTRAINT customer_customer_FK FOREIGN KEY (referred_by) REFERENCES customer (customer_Id)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla employee
DROP TABLE IF EXISTS employee;
CREATE TABLE IF NOT EXISTS employee (
  employee_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  address_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (employee_id),
  KEY employee_address_FK (address_id),
  CONSTRAINT employee_address_FK FOREIGN KEY (address_id) REFERENCES address (address_id)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla frame_type
DROP TABLE IF EXISTS frame_type;
CREATE TABLE IF NOT EXISTS frame_type (
  frame_type_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  PRIMARY KEY (frame_type_id),
  UNIQUE KEY frame_type_unique (name)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla glasses
DROP TABLE IF EXISTS glasses;
CREATE TABLE IF NOT EXISTS glasses (
  glasses_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  brand_id bigint(20) unsigned NOT NULL,
  frame_type_id bigint(20) unsigned NOT NULL,
  frame_colour_id bigint(20) unsigned NOT NULL,
  left_lens_graduation decimal(6,2) DEFAULT 0,
  right_lens_graduation decimal(6,2) DEFAULT 0,
  left_lents_colour_id bigint(20) unsigned NOT NULL,
  right_lents_colour_id bigint(20) unsigned NOT NULL,
  price decimal(10,4) NOT NULL,
  PRIMARY KEY (glasses_id),
  UNIQUE KEY glasses_unique (name),
  KEY glasses_brand_FK (brand_id),
  KEY glasses_frame_type_FK (frame_type_id),
  KEY glasses_frame_colour_FK (frame_colour_id),
  KEY glasses_left_lents_colour_FK (left_lents_colour_id),
  KEY glasses_right_lents_colour_FK (right_lents_colour_id),
  CONSTRAINT glasses_brand_FK FOREIGN KEY (brand_id) REFERENCES brand (brand_id),
  CONSTRAINT glasses_frame_colour_FK FOREIGN KEY (frame_colour_id) REFERENCES colour (colour_id),
  CONSTRAINT glasses_frame_type_FK FOREIGN KEY (frame_type_id) REFERENCES frame_type (frame_type_id),
  CONSTRAINT glasses_left_lents_colour_FK FOREIGN KEY (left_lents_colour_id) REFERENCES colour (colour_id),
  CONSTRAINT glasses_right_lents_colour_FK FOREIGN KEY (right_lents_colour_id) REFERENCES colour (colour_id)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla sales
DROP TABLE IF EXISTS sales;
CREATE TABLE IF NOT EXISTS sales (
  sales_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  customer_id bigint(20) unsigned NOT NULL,
  employee_id bigint(20) unsigned NOT NULL,
  registration_date date DEFAULT CURDATE(),
  PRIMARY KEY (sales_id),
  KEY sales_customer_FK (customer_id),
  KEY sales_employee_FK (employee_id),
  CONSTRAINT sales_customer_FK FOREIGN KEY (customer_id) REFERENCES customer (customer_Id),
  CONSTRAINT sales_employee_FK FOREIGN KEY (employee_id) REFERENCES employee (employee_id)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla sales_detail
DROP TABLE IF EXISTS sales_detail;
CREATE TABLE IF NOT EXISTS sales_detail (
  sales_detail_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  sales_id bigint(20) unsigned NOT NULL,
  glasses_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (sales_detail_id),
  KEY sales_detail_glasses_FK (glasses_id),
  KEY sales_detail_sales_FK (sales_id),
  CONSTRAINT sales_detail_glasses_FK FOREIGN KEY (glasses_id) REFERENCES glasses (glasses_id),
  CONSTRAINT sales_detail_sales_FK FOREIGN KEY (sales_id) REFERENCES sales (sales_id)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla supplier
DROP TABLE IF EXISTS supplier;
CREATE TABLE IF NOT EXISTS supplier (
  supplier_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  nif varchar(20) NOT NULL,
  address_id bigint(20) unsigned NOT NULL,
  phone varchar(20) NOT NULL,
  fax varchar(20) NOT NULL,
  PRIMARY KEY (supplier_id),
  UNIQUE KEY supplier_unique_name (name),
  UNIQUE KEY supplier_unique_nif (nif),
  KEY supplier_address_FK (address_id),
  CONSTRAINT supplier_address_FK FOREIGN KEY (address_id) REFERENCES address (address_id)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


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
-- Database:                     opticians
-- --------------------------------------------------------


-- Desactivar claves foráneas
SET FOREIGN_KEY_CHECKS = 0;


-- Borrar datos existentes antes de insertar nuevos registros
TRUNCATE TABLE brand;
TRUNCATE TABLE city;
TRUNCATE TABLE colour;
TRUNCATE TABLE country;
TRUNCATE TABLE customer;
TRUNCATE TABLE employee;
TRUNCATE TABLE frame_type;
TRUNCATE TABLE glasses;
TRUNCATE TABLE sales;
TRUNCATE TABLE sales_detail;
TRUNCATE TABLE supplier;


-- Sentencias INSERT...


-- address
INSERT INTO address (name, building_number, floor, door, postal_code, city_id) VALUES
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


-- Marcas
INSERT INTO brand (name, supplier_id) VALUES
('RayVision', 1),
('EyeMax', 2),
('Lumière', 3),
('ItalLux', 2),
('BlickSmart', 4);


-- Ciudades
INSERT INTO city (name, country_id) VALUES
('Barcelona', 'ESP'),
('Madrid', 'ESP'),
('París', 'FRA'),
('Roma', 'ITA'),
('Milán', 'ITA'),
('Berlín', 'DEU'),
('Hamburgo', 'DEU');


-- coloures
INSERT INTO colour (name) VALUES
('Negro'),
('Plateado'),
('Dorado'),
('Azul'),
('Verde'),
('Rojo'),
('Blanco'),
('Transparente');


-- Países
INSERT INTO country (country_id, name) VALUES
('ESP', 'España'),
('FRA', 'Francia'),
('ITA', 'Italia'),
('DEU', 'Alemania');


-- Clientes
INSERT INTO customer (name, address_id, phone, mail, registration_date, referred_by) VALUES
('Juan Pérez', 2, '600123456', 'juan.perez@example.com', '2024-01-15', NULL),
('María López', 3, '600654321', 'maria.lopez@example.com', '2024-02-20', 1),
('Pedro Ramírez', 4, '600789123', 'pedro.ramirez@example.com', '2024-03-05', NULL),
('Ana Torres', 5, '600987654', 'ana.torres@example.com', '2024-03-25', 2),
('Laura Gómez', 6, '600456789', 'laura.gomez@example.com', '2024-04-10', NULL),
('Javier Ruiz', 7, '600321654', 'javier.ruiz@example.com', '2024-04-18', 3);


-- Empleados
INSERT INTO employee (name, address_id) VALUES
('Carlos García', 8),
('Lucía Fernández', 9),
('Diego Martínez', 10),
('Sofía Navarro', 11);


-- Tipos de Montura
INSERT INTO frame_type (frame_type_id, name) VALUES
(1, 'Plastic'),
(2, 'Metal'),
(3, 'Rimless');


-- Gafas
INSERT INTO glasses (name, brand_id, frame_type_id, frame_colour_id, left_lens_graduation, right_lens_graduation, left_lents_colour_id, right_lents_colour_id, price) VALUES
('RayVision Classic',1 , 1, 1, 1.5, 1.0, 8, 8, 120.00),
('EyeMax Pro',2 , 2, 2, 2.0, 2.5, 8, 8, 150.00),
('Lumière Elegance', 3, 3, 3, 0.5, 0.5, 8, 8, 200.00),
('ItalLux Aqua', 4, 1, 4, 1.25, 1.00, 8, 8, 130.00),
('BlickSmart Urban', 5, 2, 1, 2.75, 3.00, 8, 8, 160.00),
('RayVision Nature', 1, 3, 5, 0.00, 0.75, 8, 8, 140.00),
('EyeMax colour', 2, 1, 6, 1.50, 2.00, 8, 8, 155.00),
('Lumière White', 3, 2, 7, 0.75, 1.00, 8, 8, 175.00);


-- Ventas
INSERT INTO sales (customer_id, employee_id, registration_date) VALUES
(1, 1, '2024-03-10'),
(2, 2, '2024-04-15'),
(1, 1, '2024-05-20'),
(3, 2, '2024-05-01'),
(4, 3, '2024-05-02'),
(2, 4, '2024-05-03'),
(1, 1, '2024-05-04'),
(5, 2, '2024-05-05');


-- Detalles de Venta
INSERT INTO sales_detail (sales_id, glasses_id) VALUES
(1, 2),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(3, 1),
(4, 2),
(4, 3),
(4, 6),
(5, 3),
(6, 3),
(7, 3),
(8, 3);


-- Proveedores
INSERT INTO supplier (name, nif, address_id, phone, fax) VALUES
('OptiProve', 'B12345678', 4, '934567890', '934567891'),
('VisionPlus', 'B87654321', 5, '915678901', '915678902'),
('LunettesFrance', 'F12345678', 6, '014567890', '014567891'),
('ItaliOptic', 'I12345678', 7, '066789012', '066789013'),
('BlickVision', 'D12345678', 8, '0301234567', '0301234568');


-- Reactivar claves foráneas
SET FOREIGN_KEY_CHECKS = 1;


-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         10.11.11-MariaDB-0+deb12u1 - Debian 12
-- SO del servidor:              debian-linux-gnu
-- 
-- Author:                       Diego Balaguer
-- Date:                         02/05/2025
-- Database:                     opticians
-- --------------------------------------------------------


-- List the total sales for a customer in a given period
SELECT c.name customer_name, count(*) count_facturation
FROM customer c 
JOIN sales s on c.customer_Id = s.customer_id
WHERE c.customer_Id = 1 AND s.registration_date between '2024-05-01' and '2024-06-01'
GROUP BY customer_name;


-- List the different models of glasses that an employee has sold during a year
SELECT DISTINCT e.name employee, b.name brand, ft.name frame_type, c.name frame_color
FROM sales s
JOIN employee e ON s.employee_id = e.employee_id
JOIN sales_detail sd ON s.sales_id = sd.sales_id
JOIN glasses g ON sd.glasses_id = g.glasses_id
JOIN frame_type ft ON g.frame_type_id = ft.frame_type_id
JOIN colour c ON g.frame_colour_id = c.colour_id
JOIN brand b ON g.brand_id = b.brand_id 
WHERE YEAR(s.registration_date) = 2024  AND e.employee_id = 2;


-- List the different suppliers who have supplied glasses that have been successfully sold
SELECT DISTINCT sp.name suplier
FROM sales s
JOIN sales_detail sd ON s.sales_id = sd.sales_id
JOIN glasses g ON sd.glasses_id = g.glasses_id 
JOIN brand b ON g.brand_id = b.brand_id
JOIN supplier sp ON b.supplier_id = sp.supplier_id;

