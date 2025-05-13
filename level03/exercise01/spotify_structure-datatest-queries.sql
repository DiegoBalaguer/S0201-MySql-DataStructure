-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         10.11.11-MariaDB-0+deb12u1 - Debian 12
-- SO del servidor:              debian-linux-gnu
-- HeidiSQL Versión:             12.10.0.7000
-- 
-- Author:                       Diego Balaguer
-- Date:                         02/05/2025
-- Database:                     spotify
-- --------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para spotify
CREATE DATABASE IF NOT EXISTS spotify /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE spotify;


-- Desactivar claves foráneas
SET FOREIGN_KEY_CHECKS = 0;


-- Volcando estructura para tabla album
DROP TABLE IF EXISTS album;
CREATE TABLE IF NOT EXISTS album (
  album_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  artist_id bigint(20) unsigned NOT NULL,
  title varchar(50) NOT NULL,
  release_year smallint(6) NOT NULL,
  cover_image blob DEFAULT NULL,
  PRIMARY KEY (album_id),
  KEY album_artist_FK (artist_id),
  CONSTRAINT album_artist_FK FOREIGN KEY (artist_id) REFERENCES artist (artist_id)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla artist
DROP TABLE IF EXISTS artist;
CREATE TABLE IF NOT EXISTS artist (
  artist_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  artist_name varchar(50) NOT NULL,
  artist_image blob DEFAULT NULL,
  PRIMARY KEY (artist_id)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla country
DROP TABLE IF EXISTS country;
CREATE TABLE IF NOT EXISTS country (
  country_id varchar(3) NOT NULL,
  name varchar(50) NOT NULL,
  PRIMARY KEY (country_id),
  UNIQUE KEY country_unique (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla credit_card
DROP TABLE IF EXISTS credit_card;
CREATE TABLE IF NOT EXISTS credit_card (
  credit_card_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  subscription_id bigint(20) unsigned NOT NULL,
  card_number varchar(20) NOT NULL,
  expiration_month tinyint(4) NOT NULL,
  expiration_year smallint(6) NOT NULL,
  security_code varchar(4) NOT NULL,
  PRIMARY KEY (credit_card_id),
  KEY credit_card_subscription_FK (subscription_id),
  CONSTRAINT credit_card_subscription_FK FOREIGN KEY (subscription_id) REFERENCES subscription (subscription_id)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla gender
DROP TABLE IF EXISTS gender;
CREATE TABLE IF NOT EXISTS gender (
  gender_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  PRIMARY KEY (gender_id)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla payment
DROP TABLE IF EXISTS payment;
CREATE TABLE IF NOT EXISTS payment (
  payment_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  order_number bigint(20) unsigned NOT NULL,
  subscription_id bigint(20) unsigned NOT NULL,
  payment_date datetime NOT NULL,
  amount decimal(10,2) NOT NULL,
  PRIMARY KEY (payment_id),
  UNIQUE KEY payment_unique (order_number),
  KEY payment_subscription_FK (subscription_id),
  CONSTRAINT payment_subscription_FK FOREIGN KEY (subscription_id) REFERENCES subscription (subscription_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla paypal
DROP TABLE IF EXISTS paypal;
CREATE TABLE IF NOT EXISTS paypal (
  paypal_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  subscription_id bigint(20) unsigned NOT NULL,
  paypal_username varchar(50) NOT NULL,
  PRIMARY KEY (paypal_id),
  KEY paypal_subscription_FK (subscription_id),
  CONSTRAINT paypal_subscription_FK FOREIGN KEY (subscription_id) REFERENCES subscription (subscription_id)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla playlist
DROP TABLE IF EXISTS playlist;
CREATE TABLE IF NOT EXISTS playlist (
  playlist_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  user_id bigint(20) unsigned NOT NULL,
  title varchar(100) NOT NULL,
  song_count int(11) NOT NULL DEFAULT 0,
  created_at date NOT NULL DEFAULT curdate(),
  is_active enum('active','deleted') NOT NULL DEFAULT 'active',
  deleted_at date DEFAULT NULL,
  PRIMARY KEY (playlist_id),
  KEY playlist_user_FK (user_id),
  CONSTRAINT playlist_user_FK FOREIGN KEY (user_id) REFERENCES user (user_id)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla playlist_songs
DROP TABLE IF EXISTS playlist_songs;
CREATE TABLE IF NOT EXISTS playlist_songs (
  playlist_id bigint(20) unsigned NOT NULL,
  song_id bigint(20) unsigned NOT NULL,
  added_by_user_id bigint(20) unsigned NOT NULL,
  created_at date NOT NULL DEFAULT curdate(),
  PRIMARY KEY (playlist_id,song_id),
  KEY playlist_songs_song_FK (song_id),
  KEY playlist_songs_user_FK (added_by_user_id),
  CONSTRAINT playlist_songs_playlist_FK FOREIGN KEY (playlist_id) REFERENCES playlist (playlist_id),
  CONSTRAINT playlist_songs_song_FK FOREIGN KEY (song_id) REFERENCES song (song_id),
  CONSTRAINT playlist_songs_user_FK FOREIGN KEY (added_by_user_id) REFERENCES user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla related_artists
DROP TABLE IF EXISTS related_artists;
CREATE TABLE IF NOT EXISTS related_artists (
  artist_id bigint(20) unsigned NOT NULL,
  related_artist_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (artist_id,related_artist_id),
  KEY related_artists_related_artist_artist_FK (related_artist_id),
  CONSTRAINT related_artists_artist_artist_FK FOREIGN KEY (artist_id) REFERENCES artist (artist_id),
  CONSTRAINT related_artists_related_artist_artist_FK FOREIGN KEY (related_artist_id) REFERENCES artist (artist_id),
  CONSTRAINT CONSTRAINT_1 CHECK (artist_id <> related_artist_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla song
DROP TABLE IF EXISTS song;
CREATE TABLE IF NOT EXISTS song (
  song_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  album_id bigint(20) unsigned NOT NULL,
  title varchar(100) NOT NULL,
  duration_seconds int(11) NOT NULL,
  play_count bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (song_id),
  KEY song_album_FK (album_id),
  CONSTRAINT song_album_FK FOREIGN KEY (album_id) REFERENCES album (album_id)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla subscription
DROP TABLE IF EXISTS subscription;
CREATE TABLE IF NOT EXISTS subscription (
  subscription_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  user_id bigint(20) unsigned NOT NULL,
  start_date date NOT NULL DEFAULT curdate(),
  renewal_date date NOT NULL,
  payment_method enum('Credit Card','Paypal') NOT NULL,
  PRIMARY KEY (subscription_id),
  KEY subscription_user_FK (user_id),
  CONSTRAINT subscription_user_FK FOREIGN KEY (user_id) REFERENCES user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla user
DROP TABLE IF EXISTS user;
CREATE TABLE IF NOT EXISTS user (
  user_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  email varchar(50) NOT NULL,
  password varchar(60) NOT NULL,
  username varchar(50) NOT NULL,
  birth_date date NOT NULL,
  gender_id int(10) unsigned NOT NULL,
  country_id varchar(3) NOT NULL,
  postal_code varchar(10) NOT NULL,
  account_type enum('Free','Premium') NOT NULL DEFAULT 'Free',
  PRIMARY KEY (user_id),
  KEY user_gender_FK (gender_id),
  KEY user_country_FK (country_id),
  CONSTRAINT user_country_FK FOREIGN KEY (country_id) REFERENCES country (country_id),
  CONSTRAINT user_gender_FK FOREIGN KEY (gender_id) REFERENCES gender (gender_id)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla user_favorite_albums
DROP TABLE IF EXISTS user_favorite_albums;
CREATE TABLE IF NOT EXISTS user_favorite_albums (
  user_id bigint(20) unsigned NOT NULL,
  album_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (user_id,album_id),
  KEY user_favorite_albums_album_FK (album_id),
  CONSTRAINT user_favorite_albums_album_FK FOREIGN KEY (album_id) REFERENCES album (album_id),
  CONSTRAINT user_favorite_albums_user_FK FOREIGN KEY (user_id) REFERENCES user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla user_favorite_songs
DROP TABLE IF EXISTS user_favorite_songs;
CREATE TABLE IF NOT EXISTS user_favorite_songs (
  user_id bigint(20) unsigned NOT NULL,
  song_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (user_id,song_id),
  KEY user_favorite_songs_song_FK (song_id),
  CONSTRAINT user_favorite_songs_song_FK FOREIGN KEY (song_id) REFERENCES song (song_id),
  CONSTRAINT user_favorite_songs_user_FK FOREIGN KEY (user_id) REFERENCES user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla user_follows_artist
DROP TABLE IF EXISTS user_follows_artist;
CREATE TABLE IF NOT EXISTS user_follows_artist (
  user_id bigint(20) unsigned NOT NULL,
  artist_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (user_id,artist_id),
  KEY user_follows_artist_artist_FK (artist_id),
  CONSTRAINT user_follows_artist_artist_FK FOREIGN KEY (artist_id) REFERENCES artist (artist_id),
  CONSTRAINT user_follows_artist_user_FK FOREIGN KEY (user_id) REFERENCES user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla user_song_plays
DROP TABLE IF EXISTS user_song_plays;
CREATE TABLE IF NOT EXISTS user_song_plays (
  play_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  user_id bigint(20) unsigned NOT NULL,
  song_id bigint(20) unsigned NOT NULL,
  play_date datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (play_id),
  KEY user_id (user_id,play_date),
  KEY user_song_plays_song_FK (song_id),
  CONSTRAINT user_song_plays_song_FK FOREIGN KEY (song_id) REFERENCES song (song_id),
  CONSTRAINT user_song_plays_user_FK FOREIGN KEY (user_id) REFERENCES user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


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
-- Database:                     spotify
-- --------------------------------------------------------


use spotify;


-- Desactivar claves foráneas
SET FOREIGN_KEY_CHECKS = 0;


-- Borrar datos existentes antes de insertar nuevos registros
TRUNCATE TABLE album;
TRUNCATE TABLE artist;
TRUNCATE TABLE country;
TRUNCATE TABLE credit_card;
TRUNCATE TABLE gender;
TRUNCATE TABLE payment;
TRUNCATE TABLE paypal;
TRUNCATE TABLE playlist;
TRUNCATE TABLE playlist_songs;
TRUNCATE TABLE related_artists;
TRUNCATE TABLE song;
TRUNCATE TABLE paypal;
TRUNCATE TABLE subscription;
TRUNCATE TABLE user;
TRUNCATE TABLE user_favorite_albums;
TRUNCATE TABLE user_favorite_songs;
TRUNCATE TABLE user_follows_artist;
TRUNCATE TABLE user_song_plays;


-- Tabla gender
INSERT INTO gender (name) VALUES
('Male'),
('Female');


-- Tabla Country Table (8 countries)
INSERT INTO country (country_id, name) VALUES
('GBR', 'United Kingdom'),
('USA', 'United States'),
('CAN', 'Canada'),
('AUS', 'Australia'),
('FRA', 'France'),
('DEU', 'Germany'),
('ESP', 'Spain'),
('ITA', 'Italy');


-- Tabla User Table (20 Free + 20 Premium)
INSERT INTO user (email, password, username, birth_date, gender_id, country_id, postal_code, account_type) VALUES
-- Free accounts (1-20)
('john.smith@email.com', 'hashedpass1', 'johnsmith', '1990-05-15', 1, 'GBR', 'SW1A1AA', 'Free'),
('emily.johnson@email.com', 'hashedpass2', 'emilyj', '1985-08-22', 2, 'GBR', 'EC1A1BB', 'Free'),
('michael.brown@email.com', 'hashedpass3', 'mikebrown', '1992-11-30', 1, 'USA', '10001', 'Free'),
('sarah.davis@email.com', 'hashedpass4', 'sarahd', '1988-03-10', 2, 'USA', '90210', 'Free'),
('david.wilson@email.com', 'hashedpass5', 'dwilson', '1995-07-18', 1, 'CAN', 'M5V2T6', 'Free'),
('jessica.lee@email.com', 'hashedpass6', 'jesslee', '1991-09-25', 2, 'AUS', '2000', 'Free'),
('robert.taylor@email.com', 'hashedpass7', 'robtaylor', '1987-12-05', 1, 'GBR', 'W1A0AX', 'Free'),
('jennifer.martin@email.com', 'hashedpass8', 'jenmartin', '1993-04-20', 2, 'USA', '33139', 'Free'),
('william.anderson@email.com', 'hashedpass9', 'willand', '1989-06-12', 1, 'CAN', 'V6B1H4', 'Free'),
('elizabeth.thomas@email.com', 'hashedpass10', 'lizthomas', '1994-02-28', 2, 'GBR', 'WC2N5DU', 'Free'),
('james.jackson@email.com', 'hashedpass11', 'jamesj', '1990-10-08', 1, 'AUS', '3000', 'Free'),
('margaret.white@email.com', 'hashedpass12', 'maggiew', '1986-07-14', 2, 'USA', '94102', 'Free'),
('charles.harris@email.com', 'hashedpass13', 'charlieh', '1992-01-17', 1, 'GBR', 'E16AN', 'Free'),
('patricia.clark@email.com', 'hashedpass14', 'patclark', '1984-09-03', 2, 'CAN', 'H3B2Y5', 'Free'),
('thomas.lewis@email.com', 'hashedpass15', 'tomlewis', '1996-12-22', 1, 'GBR', 'SE17PB', 'Free'),
('susan.walker@email.com', 'hashedpass16', 'suewalker', '1991-05-19', 2, 'USA', '60601', 'Free'),
('daniel.hall@email.com', 'hashedpass17', 'danhall', '1988-08-11', 1, 'AUS', '4000', 'Free'),
('nancy.allen@email.com', 'hashedpass18', 'nancya', '1993-03-27', 2, 'GBR', 'NW16XE', 'Free'),
('matthew.young@email.com', 'hashedpass19', 'mattyoung', '1985-11-09', 1, 'CAN', 'M5J2T3', 'Free'),
('lisa.king@email.com', 'hashedpass20', 'lisaking', '1997-04-15', 2, 'USA', '10036', 'Free'),
-- Premium accounts (21-40)
('alex.turner@email.com', 'hashedpass21', 'alext', '1986-01-06', 1, 'GBR', 'N16BE', 'Premium'),
('olivia.rodrigo@email.com', 'hashedpass22', 'oliviar', '2003-02-20', 2, 'USA', '90028', 'Premium'),
('harry.styles@email.com', 'hashedpass23', 'harrys', '1994-02-01', 1, 'GBR', 'SW72AZ', 'Premium'),
('billie.eilish@email.com', 'hashedpass24', 'billiee', '2001-12-18', 2, 'USA', '90210', 'Premium'),
('drake@email.com', 'hashedpass25', 'drake', '1986-10-24', 1, 'CAN', 'M5V3L9', 'Premium'),
('taylor.swift@email.com', 'hashedpass26', 'taylors', '1989-12-13', 2, 'USA', '10019', 'Premium'),
('ed.sheeran@email.com', 'hashedpass27', 'edsheeran', '1991-02-17', 1, 'GBR', 'IP224DJ', 'Premium'),
('ariana.grande@email.com', 'hashedpass28', 'arianag', '1993-06-26', 2, 'USA', '33139', 'Premium'),
('bruno.mars@email.com', 'hashedpass29', 'brunom', '1985-10-08', 1, 'USA', '96815', 'Premium'),
('adele@email.com', 'hashedpass30', 'adele', '1988-05-05', 2, 'GBR', 'N13JW', 'Premium'),
('the.weeknd@email.com', 'hashedpass31', 'theweeknd', '1990-02-16', 1, 'CAN', 'M5J2T3', 'Premium'),
('dua.lipa@email.com', 'hashedpass32', 'dualipa', '1995-08-22', 2, 'GBR', 'W1K7QR', 'Premium'),
('justin.bieber@email.com', 'hashedpass33', 'justinb', '1994-03-01', 1, 'CAN', 'L5N2R4', 'Premium'),
('lady.gaga@email.com', 'hashedpass34', 'ladygaga', '1986-03-28', 2, 'USA', '10036', 'Premium'),
('post.malone@email.com', 'hashedpass35', 'postmalone', '1995-07-04', 1, 'USA', '75080', 'Premium'),
('rihanna@email.com', 'hashedpass36', 'rihanna', '1988-02-20', 2, 'USA', 'BB15156', 'Premium'),
('shawn.mendes@email.com', 'hashedpass37', 'shawnm', '1998-08-08', 1, 'CAN', 'M5V2H1', 'Premium'),
('beyonce@email.com', 'hashedpass38', 'beyonce', '1981-09-04', 2, 'USA', '77019', 'Premium'),
('kanye.west@email.com', 'hashedpass39', 'kanyew', '1977-06-08', 1, 'USA', '60618', 'Premium'),
('katy.perry@email.com', 'hashedpass40', 'katyp', '1984-10-25', 2, 'USA', '91104', 'Premium');


-- Tabla Artist Table (20 artists)
INSERT INTO artist (artist_name) VALUES
('The Beatles'),
('Queen'),
('Coldplay'),
('Radiohead'),
('Adele'),
('Ed Sheeran'),
('Arctic Monkeys'),
('Dua Lipa'),
('Billie Eilish'),
('Taylor Swift'),
('Drake'),
('Kendrick Lamar'),
('Beyoncé'),
('Rihanna'),
('The Weeknd'),
('Bruno Mars'),
('David Bowie'),
('Pink Floyd'),
('Led Zeppelin'),
('The Rolling Stones');


-- Tabla Album Table (20 albums)
INSERT INTO album (artist_id, title, release_year) VALUES
(1, 'Abbey Road', 1969),
(2, 'A Night at the Opera', 1975),
(3, 'Parachutes', 2000),
(4, 'OK Computer', 1997),
(5, '21', 2011),
(6, '÷', 2017),
(7, 'AM', 2013),
(8, 'Future Nostalgia', 2020),
(9, 'When We All Fall Asleep', 2019),
(10, '1989', 2014),
(11, 'Scorpion', 2018),
(12, 'DAMN.', 2017),
(13, 'Lemonade', 2016),
(14, 'Anti', 2016),
(15, 'After Hours', 2020),
(16, '24K Magic', 2016),
(17, 'The Rise and Fall of Ziggy Stardust', 1972),
(18, 'The Dark Side of the Moon', 1973),
(19, 'Led Zeppelin IV', 1971),
(20, 'Sticky Fingers', 1971);


-- Tabla Song Table (50 songs)
INSERT INTO song (album_id, title, duration_seconds, play_count) VALUES
(1, 'Come Together', 259, 1500000),
(1, 'Something', 183, 1200000),
(2, 'Bohemian Rhapsody', 354, 2500000),
(2, 'Youre My Best Friend', 172, 800000),
(3, 'Yellow', 266, 1800000),
(3, 'Trouble', 277, 900000),
(4, 'Paranoid Android', 383, 1100000),
(4, 'Karma Police', 262, 1300000),
(5, 'Rolling in the Deep', 228, 2200000),
(5, 'Someone Like You', 285, 2100000),
(6, 'Shape of You', 233, 3200000),
(6, 'Castle on the Hill', 261, 1500000),
(7, 'Do I Wanna Know?', 272, 1900000),
(7, 'R U Mine?', 201, 1600000),
(8, 'Dont Start Now', 183, 2400000),
(8, 'Physical', 194, 1200000),
(9, 'bad guy', 194, 2800000),
(9, 'when the party is over', 196, 1500000),
(10, 'Blank Space', 231, 2900000),
(10, 'Shake It Off', 219, 2700000),
(11, 'Gods Plan', 198, 3100000),
(11, 'In My Feelings', 217, 2300000),
(12, 'HUMBLE.', 177, 2600000),
(12, 'LOYALTY.', 222, 1200000),
(13, 'Formation', 226, 1800000),
(13, 'Sorry', 233, 1900000),
(14, 'Work', 219, 2500000),
(14, 'Needed Me', 191, 1700000),
(15, 'Blinding Lights', 200, 3500000),
(15, 'Save Your Tears', 215, 2200000),
(16, '24K Magic', 226, 1900000),
(16, 'Thats What I Like', 226, 2100000),
(17, 'Starman', 258, 900000),
(17, 'Suffragette City', 213, 800000),
(18, 'Money', 382, 1500000),
(18, 'Time', 413, 1300000),
(19, 'Stairway to Heaven', 482, 2400000),
(19, 'Black Dog', 296, 1100000),
(20, 'Brown Sugar', 234, 1200000),
(20, 'Wild Horses', 342, 900000),
(1, 'Here Comes the Sun', 185, 1800000),
(2, 'Love of My Life', 216, 1100000),
(3, 'Shiver', 300, 700000),
(4, 'No Surprises', 229, 1000000),
(5, 'Set Fire to the Rain', 242, 1700000),
(6, 'Perfect', 263, 2300000),
(7, 'Why Do You Only Call Me', 256, 1400000),
(8, 'Levitating', 203, 2600000),
(9, 'everything i wanted', 246, 1900000),
(10, 'Style', 231, 1800000);


-- Tabla Subscription Table (20 subscriptions for premium users)
INSERT INTO subscription (user_id, start_date, renewal_date, payment_method) VALUES
(21, '2022-01-15', '2023-01-15', 'Credit Card'),
(22, '2022-02-20', '2023-02-20', 'Paypal'),
(23, '2022-03-10', '2023-03-10', 'Credit Card'),
(24, '2022-04-05', '2023-04-05', 'Paypal'),
(25, '2022-05-12', '2023-05-12', 'Credit Card'),
(26, '2022-06-18', '2023-06-18', 'Paypal'),
(27, '2022-07-22', '2023-07-22', 'Credit Card'),
(28, '2022-08-30', '2023-08-30', 'Paypal'),
(29, '2022-09-14', '2023-09-14', 'Credit Card'),
(30, '2022-10-25', '2023-10-25', 'Paypal'),
(31, '2022-11-03', '2023-11-03', 'Credit Card'),
(32, '2022-12-12', '2023-12-12', 'Paypal'),
(33, '2023-01-05', '2024-01-05', 'Credit Card'),
(34, '2023-02-18', '2024-02-18', 'Paypal'),
(35, '2023-03-22', '2024-03-22', 'Credit Card'),
(36, '2023-04-10', '2024-04-10', 'Paypal'),
(37, '2023-05-15', '2024-05-15', 'Credit Card'),
(38, '2023-06-20', '2024-06-20', 'Paypal'),
(39, '2023-07-01', '2024-07-01', 'Credit Card'),
(40, '2023-08-08', '2024-08-08', 'Paypal');


-- Tabla Credit Card Table (10 credit cards)
INSERT INTO credit_card (subscription_id, card_number, expiration_month, expiration_year, security_code) VALUES
(1, '4532876543210987', 12, 2025, '123'),
(3, '5555345678901234', 6, 2024, '456'),
(5, '378282246310005', 9, 2026, '789'),
(7, '4111111111111111', 3, 2025, '234'),
(9, '5105105105105100', 8, 2024, '567'),
(11, '6011111111111117', 5, 2026, '890'),
(13, '3566002020360505', 11, 2025, '345'),
(15, '371449635398431', 4, 2024, '678'),
(17, '30569309025904', 7, 2026, '901'),
(19, '38520000023237', 2, 2025, '234');


-- Tabla Paypal Table (10 paypal accounts)
INSERT INTO paypal (subscription_id, paypal_username) VALUES
(2, 'oliviarodrigo_paypal'),
(4, 'billieeilish_paypal'),
(6, 'taylorswift_paypal'),
(8, 'arianagrande_paypal'),
(10, 'adele_paypal'),
(12, 'dualipa_paypal'),
(14, 'ladygaga_paypal'),
(16, 'rihanna_paypal'),
(18, 'beyonce_paypal'),
(20, 'katyperry_paypal');


-- Tabla Payment Table (50 payments)
INSERT INTO payment (order_number, subscription_id, payment_date, amount) VALUES
(10001, 1, '2022-01-15', 9.99),
(10002, 2, '2022-02-20', 9.99),
(10003, 3, '2022-03-10', 9.99),
(10004, 4, '2022-04-05', 9.99),
(10005, 5, '2022-05-12', 9.99),
(10006, 6, '2022-06-18', 9.99),
(10007, 7, '2022-07-22', 9.99),
(10008, 8, '2022-08-30', 9.99),
(10009, 9, '2022-09-14', 9.99),
(10010, 10, '2022-10-25', 9.99),
(10011, 11, '2022-11-03', 9.99),
(10012, 12, '2022-12-12', 9.99),
(10013, 13, '2023-01-05', 9.99),
(10014, 14, '2023-02-18', 9.99),
(10015, 15, '2023-03-22', 9.99),
(10016, 16, '2023-04-10', 9.99),
(10017, 17, '2023-05-15', 9.99),
(10018, 18, '2023-06-20', 9.99),
(10019, 19, '2023-07-01', 9.99),
(10020, 20, '2023-08-08', 9.99),
(10021, 1, '2023-01-15', 9.99),
(10022, 2, '2023-02-20', 9.99),
(10023, 3, '2023-03-10', 9.99),
(10024, 4, '2023-04-05', 9.99),
(10025, 5, '2023-05-12', 9.99),
(10026, 6, '2023-06-18', 9.99),
(10027, 7, '2023-07-22', 9.99),
(10028, 8, '2023-08-30', 9.99),
(10029, 9, '2023-09-14', 9.99),
(10030, 10, '2023-10-25', 9.99),
(10031, 11, '2023-11-03', 9.99),
(10032, 12, '2023-12-12', 9.99),
(10033, 13, '2024-01-05', 9.99),
(10034, 14, '2024-02-18', 9.99),
(10035, 15, '2024-03-22', 9.99),
(10036, 16, '2024-04-10', 9.99),
(10037, 17, '2024-05-15', 9.99),
(10038, 18, '2024-06-20', 9.99),
(10039, 19, '2024-07-01', 9.99),
(10040, 20, '2024-08-08', 9.99),
(10041, 1, '2024-01-15', 9.99),
(10042, 2, '2024-02-20', 9.99),
(10043, 3, '2024-03-10', 9.99),
(10044, 4, '2024-04-05', 9.99),
(10045, 5, '2024-05-12', 9.99),
(10046, 6, '2024-06-18', 9.99),
(10047, 7, '2024-07-22', 9.99),
(10048, 8, '2024-08-30', 9.99),
(10049, 9, '2024-09-14', 9.99),
(10050, 10, '2024-10-25', 9.99);


-- Tabla Playlist Table (20 playlists)
INSERT INTO playlist (user_id, title, song_count, created_at, is_active, deleted_at) VALUES
(1, 'My Favorite Rock Songs', 10, '2022-01-10', 'active', NULL),
(2, 'Workout Mix', 15, '2022-02-15', 'active', NULL),
(3, 'Chill Vibes', 8, '2022-03-20', 'active', NULL),
(4, 'Road Trip', 12, '2022-04-25', 'active', NULL),
(5, 'Party Hits', 20, '2022-05-30', 'active', NULL),
(6, 'Study Focus', 5, '2022-06-05', 'active', NULL),
(7, '90s Nostalgia', 10, '2022-07-10', 'deleted', '2023-01-15'),
(8, 'Summer Beats', 12, '2022-08-15', 'active', NULL),
(9, 'Sleepy Time', 6, '2022-09-20', 'active', NULL),
(10, 'Dinner Music', 8, '2022-10-25', 'active', NULL),
(21, 'Alexs Top Picks', 15, '2022-01-20', 'active', NULL),
(22, 'Olivias Playlist', 10, '2022-02-25', 'active', NULL),
(23, 'Harrys Favorites', 12, '2022-03-30', 'active', NULL),
(24, 'Billie Vibes', 8, '2022-04-05', 'deleted', '2023-02-20'),
(25, 'Drake Essentials', 10, '2022-05-10', 'active', NULL),
(26, 'Taylor Swift Collection', 15, '2022-06-15', 'active', NULL),
(27, 'Ed Sheeran Mix', 10, '2022-07-20', 'active', NULL),
(28, 'Ariana Grande Hits', 12, '2022-08-25', 'active', NULL),
(29, 'Bruno Mars Party', 8, '2022-09-30', 'active', NULL),
(30, 'Adele Soulful', 6, '2022-10-05', 'active', NULL);


-- Tabla Playlist Songs Table (50 entries)
INSERT INTO playlist_songs (playlist_id, song_id, added_by_user_id, created_at) VALUES
(1, 1, 1, '2022-01-10'),
(1, 3, 1, '2022-01-10'),
(1, 19, 1, '2022-01-11'),
(2, 6, 2, '2022-02-15'),
(2, 11, 2, '2022-02-15'),
(2, 15, 2, '2022-02-16'),
(3, 5, 3, '2022-03-20'),
(3, 9, 3, '2022-03-20'),
(4, 7, 4, '2022-04-25'),
(4, 13, 4, '2022-04-25'),
(5, 17, 5, '2022-05-30'),
(5, 21, 5, '2022-05-30'),
(6, 25, 6, '2022-06-05'),
(6, 29, 6, '2022-06-05'),
(7, 33, 7, '2022-07-10'),
(7, 37, 7, '2022-07-10'),
(8, 41, 8, '2022-08-15'),
(8, 45, 8, '2022-08-15'),
(9, 2, 9, '2022-09-20'),
(9, 4, 9, '2022-09-20'),
(10, 8, 10, '2022-10-25'),
(10, 12, 10, '2022-10-25'),
(11, 16, 21, '2022-01-20'),
(11, 20, 21, '2022-01-20'),
(11, 24, 21, '2022-01-21'),
(12, 28, 22, '2022-02-25'),
(12, 32, 22, '2022-02-25'),
(13, 36, 23, '2022-03-30'),
(13, 40, 23, '2022-03-30'),
(14, 44, 24, '2022-04-05'),
(14, 48, 24, '2022-04-05'),
(15, 10, 25, '2022-05-10'),
(15, 14, 25, '2022-05-10'),
(16, 18, 26, '2022-06-15'),
(16, 22, 26, '2022-06-15'),
(17, 26, 27, '2022-07-20'),
(17, 30, 27, '2022-07-20'),
(18, 34, 28, '2022-08-25'),
(18, 38, 28, '2022-08-25'),
(19, 42, 29, '2022-09-30'),
(19, 46, 29, '2022-09-30'),
(20, 50, 30, '2022-10-05'),
(20, 49, 30, '2022-10-05'),
(1, 23, 1, '2022-01-12'),
(2, 27, 2, '2022-02-17'),
(3, 31, 3, '2022-03-22'),
(4, 35, 4, '2022-04-27'),
(5, 39, 5, '2022-06-01');


-- Tabla Related Artists Table (20 entries)
INSERT INTO related_artists (artist_id, related_artist_id) VALUES
(1, 20),
(2, 19),
(3, 4),
(4, 3),
(5, 6),
(6, 5),
(7, 8),
(8, 7),
(9, 10),
(10, 9),
(11, 12),
(12, 11),
(13, 14),
(14, 13),
(15, 16),
(16, 15),
(17, 18),
(18, 17),
(19, 1),
(20, 2);


-- Tabla User Favorite Albums Table (20 entries)
INSERT INTO user_favorite_albums (user_id, album_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(21, 11),
(22, 12),
(23, 13),
(24, 14),
(25, 15),
(26, 16),
(27, 17),
(28, 18),
(29, 19),
(30, 20);


-- Tabla User Favorite Songs Table (20 entries)
INSERT INTO user_favorite_songs (user_id, song_id) VALUES
(1, 1),
(2, 3),
(3, 5),
(4, 7),
(5, 9),
(6, 11),
(7, 13),
(8, 15),
(9, 17),
(10, 19),
(21, 21),
(22, 23),
(23, 25),
(24, 27),
(25, 29),
(26, 31),
(27, 33),
(28, 35),
(29, 37),
(30, 39);


-- Tabla User Follows Artist Table (20 entries)
INSERT INTO user_follows_artist (user_id, artist_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(21, 11),
(22, 12),
(23, 13),
(24, 14),
(25, 15),
(26, 16),
(27, 17),
(28, 18),
(29, 19),
(30, 20);


-- Tabla user_song_play
INSERT INTO user_song_plays (user_id, song_id, play_date) VALUES
-- Usuario 1 (Free) - 5 reproducciones
(1, 1, '2023-01-05 08:15:22'),
(1, 3, '2023-01-05 09:30:45'),
(1, 5, '2023-01-06 12:20:33'),
(1, 19, '2023-01-07 18:45:12'),
(1, 23, '2023-01-08 22:10:05'),
-- Usuario 21 (Premium) - 10 reproducciones
(21, 11, '2023-01-10 07:30:15'),
(21, 15, '2023-01-10 08:45:22'),
(21, 21, '2023-01-11 10:20:33'),
(21, 21, '2023-01-11 12:15:44'), -- Repetida
(21, 24, '2023-01-12 14:30:55'),
(21, 29, '2023-01-13 16:45:11'),
(21, 29, '2023-01-13 18:20:33'), -- Repetida
(21, 32, '2023-01-14 20:15:22'),
(21, 35, '2023-01-15 22:30:44'),
(21, 40, '2023-01-16 23:45:55'),
-- Usuario 2 (Free) - 3 reproducciones
(2, 6, '2023-02-01 09:15:22'),
(2, 11, '2023-02-02 11:30:33'),
(2, 15, '2023-02-03 13:45:44'),
-- Usuario 22 (Premium) - 8 reproducciones
(22, 12, '2023-02-05 10:20:15'),
(22, 17, '2023-02-06 12:35:22'),
(22, 23, '2023-02-07 14:50:33'),
(22, 23, '2023-02-08 16:05:44'), -- Repetida
(22, 28, '2023-02-09 18:20:55'),
(22, 31, '2023-02-10 20:35:11'),
(22, 36, '2023-02-11 22:50:22'),
(22, 39, '2023-02-12 23:05:33'),
-- Usuario 3 (Free) - 4 reproducciones
(3, 5, '2023-03-01 08:10:22'),
(3, 9, '2023-03-02 10:25:33'),
(3, 13, '2023-03-03 12:40:44'),
(3, 17, '2023-03-04 14:55:55'),
-- Usuario 23 (Premium) - 10 reproducciones
(23, 10, '2023-03-05 09:15:15'),
(23, 14, '2023-03-06 11:30:22'),
(23, 18, '2023-03-07 13:45:33'),
(23, 22, '2023-03-08 16:00:44'),
(23, 26, '2023-03-09 18:15:55'),
(23, 30, '2023-03-10 20:30:11'),
(23, 34, '2023-03-11 22:45:22'),
(23, 38, '2023-03-12 23:00:33'),
(23, 42, '2023-03-13 08:15:44'),
(23, 46, '2023-03-14 10:30:55'),
-- Usuario 4 (Free) - 5 reproducciones
(4, 7, '2023-04-01 07:20:22'),
(4, 13, '2023-04-02 09:35:33'),
(4, 19, '2023-04-03 11:50:44'),
(4, 25, '2023-04-04 14:05:55'),
(4, 31, '2023-04-05 16:20:11'),
-- Usuario 24 (Premium) - 5 reproducciones
(24, 8, '2023-04-06 08:25:22'),
(24, 16, '2023-04-07 10:40:33'),
(24, 24, '2023-04-08 12:55:44'),
(24, 32, '2023-04-09 15:10:55'),
(24, 40, '2023-04-10 17:25:11');


-- Reactivar claves foráneas
SET FOREIGN_KEY_CHECKS = 1;


-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         10.11.11-MariaDB-0+deb12u1 - Debian 12
-- SO del servidor:              debian-linux-gnu
-- 
-- Author:                       Diego Balaguer
-- Date:                         02/05/2025
-- Database:                     spotify
-- --------------------------------------------------------


USE spotify;


-- 01. Mejor forma de obtener el número de reproducciones de una canción
SELECT 
    s.song_id, s.title AS song_title, a.title AS album_title, ar.artist_name, COUNT(usp.play_id) AS play_count
FROM song s
JOIN album a ON s.album_id = a.album_id
JOIN artist ar ON a.artist_id = ar.artist_id
LEFT JOIN user_song_plays usp ON s.song_id = usp.song_id
GROUP BY s.song_id, s.title, a.title, ar.artist_name
ORDER BY play_count DESC;


-- 02. Consulta que demuestra la relación entre subscription, payment, paypal y credit_card
SELECT 
    u.user_id, u.username, u.account_type, s.subscription_id, s.start_date, s.renewal_date, s.payment_method,
    COUNT(p.payment_id) AS payments_count, SUM(p.amount) AS total_paid, 
	IFNULL(pp.paypal_username, 'N/A') AS paypal_account,
    IFNULL(CONCAT('****', RIGHT(cc.card_number, 4)), 'N/A') AS card_last_digits
FROM user u
JOIN subscription s ON u.user_id = s.user_id
LEFT JOIN payment p ON s.subscription_id = p.subscription_id
LEFT JOIN paypal pp ON s.subscription_id = pp.subscription_id AND s.payment_method = 'Paypal'
LEFT JOIN credit_card cc ON s.subscription_id = cc.subscription_id AND s.payment_method = 'Credit Card'
GROUP BY u.user_id, u.username, s.subscription_id, s.start_date, s.renewal_date, s.payment_method, 
         pp.paypal_username, cc.card_number
ORDER BY u.user_id;


-- 03. Otra forma de mostrar la relación entre usuarios, suscripciones y métodos de pago
SELECT 
    u.user_id, u.username, u.account_type, s.subscription_id, s.payment_method,
    CASE 
        WHEN s.payment_method = 'Credit Card' THEN CONCAT('****', RIGHT(cc.card_number, 4))
        WHEN s.payment_method = 'Paypal' THEN pp.paypal_username
        ELSE 'No payment method'
    END AS payment_details,
    COUNT(p.payment_id) AS payment_count
FROM user u
LEFT JOIN subscription s ON u.user_id = s.user_id
LEFT JOIN credit_card cc ON s.subscription_id = cc.subscription_id AND s.payment_method = 'Credit Card'
LEFT JOIN paypal pp ON s.subscription_id = pp.subscription_id AND s.payment_method = 'Paypal'
LEFT JOIN payment p ON s.subscription_id = p.subscription_id
GROUP BY u.user_id, u.username, s.subscription_id, s.payment_method, cc.card_number, pp.paypal_username
ORDER BY u.user_id;


-- 04. Top 10 de canciones más populares por reproducciones
SELECT 
    s.song_id, s.title AS cancion, ar.artist_name AS artista, a.title AS album, s.duration_seconds AS duracion_segundos, 
    COUNT(usp.play_id) AS reproducciones
FROM song s
JOIN album a ON s.album_id = a.album_id
JOIN artist ar ON a.artist_id = ar.artist_id
LEFT JOIN user_song_plays usp ON s.song_id = usp.song_id
GROUP BY s.song_id, s.title, ar.artist_name, a.title, s.duration_seconds
ORDER BY reproducciones DESC
LIMIT 10;


-- 05. Playlists más completas con información de creador
SELECT 
    p.playlist_id, p.title AS nombre_playlist, u.username AS creador, p.song_count AS cantidad_canciones,
    SEC_TO_TIME(SUM(s.duration_seconds)) AS duracion_total, 
	GROUP_CONCAT(DISTINCT ar.artist_name SEPARATOR ', ') AS artistas_incluidos
FROM playlist p
JOIN user u ON p.user_id = u.user_id
JOIN playlist_songs ps ON p.playlist_id = ps.playlist_id
JOIN song s ON ps.song_id = s.song_id
JOIN album a ON s.album_id = a.album_id
JOIN artist ar ON a.artist_id = ar.artist_id
WHERE p.is_active = 'active'
GROUP BY p.playlist_id, p.title, u.username, p.song_count
ORDER BY p.song_count DESC
LIMIT 15;


-- 06. Canciones en Playlists con información de usuario y artista
SELECT 
    p.title AS playlist, u.username AS creador, s.title AS cancion, ar.artist_name AS artista, a.title AS album
FROM playlist p
JOIN user u ON p.user_id = u.user_id
JOIN playlist_songs ps ON p.playlist_id = ps.playlist_id
JOIN song s ON ps.song_id = s.song_id
JOIN album a ON s.album_id = a.album_id
JOIN artist ar ON a.artist_id = ar.artist_id
WHERE p.is_active = 'active'
LIMIT 20;


-- 07. Canciones favoritas de usuarios con detalles
SELECT 
    u.username, s.title AS cancion_favorita, ar.artist_name AS artista, a.title AS album, 
	s.duration_seconds AS duracion_segundos
FROM user_favorite_songs ufs
JOIN user u ON ufs.user_id = u.user_id
JOIN song s ON ufs.song_id = s.song_id
JOIN album a ON s.album_id = a.album_id
JOIN artist ar ON a.artist_id = ar.artist_id
ORDER BY u.username
LIMIT 20;


-- 08. Artistas y sus álbumes con conteo de canciones
SELECT 
    ar.artist_name, a.title AS album, a.release_year, 
	COUNT(s.song_id) AS total_canciones,
    SEC_TO_TIME(SUM(s.duration_seconds)) AS duracion_total
FROM artist ar
JOIN album a ON ar.artist_id = a.artist_id
JOIN song s ON a.album_id = s.album_id
GROUP BY ar.artist_name, a.title, a.release_year
ORDER BY ar.artist_name, a.release_year;


-- 09. Ejemplo de JSON_ARRAYAGG() - Agrupar resultados en un array JSON: Obtener todas las canciones de un álbum como array JSON
SELECT 
    a.album_id, a.title AS album_title, ar.artist_name,
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'song_id', s.song_id,
            'title', s.title,
            'duration', s.duration_seconds,
            'play_count', s.play_count
        )
    ) AS songs
FROM album a
JOIN artist ar ON a.artist_id = ar.artist_id
JOIN song s ON a.album_id = s.album_id
WHERE a.album_id = 1  -- Abbey Road de The Beatles
GROUP BY a.album_id, a.title, ar.artist_name;
