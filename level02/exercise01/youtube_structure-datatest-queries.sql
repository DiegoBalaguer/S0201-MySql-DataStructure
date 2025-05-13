-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         10.11.11-MariaDB-0+deb12u1 - Debian 12
-- SO del servidor:              debian-linux-gnu
-- HeidiSQL Versión:             12.10.0.7000
-- 
-- Author:                       Diego Balaguer
-- Date:                         02/05/2025
-- Database:                     youtube
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para youtube
CREATE DATABASE IF NOT EXISTS youtube /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE youtube;


-- Desactivar claves foráneas
SET FOREIGN_KEY_CHECKS = 0;


-- Volcando estructura para tabla channel
DROP TABLE IF EXISTS channel;
CREATE TABLE IF NOT EXISTS channel (
  channel_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  user_id bigint(20) unsigned NOT NULL,
  name varchar(100) NOT NULL,
  description varchar(255) DEFAULT NULL,
  creation_date datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (channel_id),
  KEY channel_user_FK (user_id),
  CONSTRAINT channel_user_FK FOREIGN KEY (user_id) REFERENCES user (user_id)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla comments
DROP TABLE IF EXISTS comments;
CREATE TABLE IF NOT EXISTS comments (
  comment_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  video_id bigint(20) unsigned NOT NULL,
  user_id bigint(20) unsigned NOT NULL,
  content text NOT NULL,
  creation_date datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (comment_id),
  KEY comments_video_FK (video_id),
  KEY comments_user_FK (user_id),
  CONSTRAINT comments_user_FK FOREIGN KEY (user_id) REFERENCES user (user_id),
  CONSTRAINT comments_video_FK FOREIGN KEY (video_id) REFERENCES video (video_id)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla comment_reactions
DROP TABLE IF EXISTS comment_reactions;
CREATE TABLE IF NOT EXISTS comment_reactions (
  comment_id bigint(20) unsigned NOT NULL,
  user_id bigint(20) unsigned NOT NULL,
  reaction enum('like','dislike') DEFAULT NULL,
  creation_date datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (comment_id,user_id),
  KEY comment_reactions_user_FK (user_id),
  CONSTRAINT comment_reactions_comments_FK FOREIGN KEY (comment_id) REFERENCES comments (comment_id),
  CONSTRAINT comment_reactions_user_FK FOREIGN KEY (user_id) REFERENCES user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla country
DROP TABLE IF EXISTS country;
CREATE TABLE IF NOT EXISTS country (
  country_Id varchar(3) NOT NULL,
  name varchar(50) NOT NULL,
  PRIMARY KEY (country_Id),
  UNIQUE KEY country_unique (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla gender
DROP TABLE IF EXISTS gender;
CREATE TABLE IF NOT EXISTS gender (
  gender_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  PRIMARY KEY (gender_id)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla playlist
DROP TABLE IF EXISTS playlist;
CREATE TABLE IF NOT EXISTS playlist (
  playlist_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  user_id bigint(20) unsigned NOT NULL,
  name varchar(100) NOT NULL,
  creation_date datetime NOT NULL DEFAULT current_timestamp(),
  visibility enum('public','private') NOT NULL DEFAULT 'private',
  PRIMARY KEY (playlist_id),
  KEY playlist_user_FK (user_id),
  CONSTRAINT playlist_user_FK FOREIGN KEY (user_id) REFERENCES user (user_id)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla playlist_videos
DROP TABLE IF EXISTS playlist_videos;
CREATE TABLE IF NOT EXISTS playlist_videos (
  playlist_id bigint(20) unsigned NOT NULL,
  video_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (playlist_id,video_id),
  KEY playlist_videos_video_FK (video_id),
  CONSTRAINT playlist_videos_playlist_FK FOREIGN KEY (playlist_id) REFERENCES playlist (playlist_id),
  CONSTRAINT playlist_videos_video_FK FOREIGN KEY (video_id) REFERENCES video (video_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla subscription
DROP TABLE IF EXISTS subscription;
CREATE TABLE IF NOT EXISTS subscription (
  channel_id bigint(20) unsigned NOT NULL,
  user_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (channel_id,user_id),
  KEY subscription_user_FK (user_id),
  CONSTRAINT subscription_channel_FK FOREIGN KEY (channel_id) REFERENCES channel (channel_id),
  CONSTRAINT subscription_user_FK FOREIGN KEY (user_id) REFERENCES user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla tag
DROP TABLE IF EXISTS tag;
CREATE TABLE IF NOT EXISTS tag (
  tag_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  PRIMARY KEY (tag_id)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla user
DROP TABLE IF EXISTS user;
CREATE TABLE IF NOT EXISTS user (
  user_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  password varchar(60) NOT NULL,
  birth_date date NOT NULL,
  gender_id int(10) unsigned NOT NULL,
  country_id varchar(3) NOT NULL,
  postal_code varchar(20) NOT NULL,
  PRIMARY KEY (user_id),
  KEY user_gender_FK (gender_id),
  KEY user_country_FK (country_id),
  CONSTRAINT user_country_FK FOREIGN KEY (country_id) REFERENCES country (country_Id),
  CONSTRAINT user_gender_FK FOREIGN KEY (gender_id) REFERENCES gender (gender_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla video
DROP TABLE IF EXISTS video;
CREATE TABLE IF NOT EXISTS video (
  video_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  user_id bigint(20) unsigned NOT NULL,
  title varchar(50) NOT NULL,
  description varchar(255) NOT NULL,
  size_mb decimal(10,2) NOT NULL,
  file_name varchar(255) NOT NULL,
  duration_seconds int(11) NOT NULL,
  thumbnail blob DEFAULT NULL,
  views int(11) DEFAULT 0,
  likes int(11) DEFAULT 0,
  dislikes int(11) DEFAULT 0,
  visibility enum('public','private','unlisted') NOT NULL DEFAULT 'public',
  upload_date datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (video_id),
  KEY video_user_FK (user_id),
  CONSTRAINT video_user_FK FOREIGN KEY (user_id) REFERENCES user (user_id)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla video_reactions
DROP TABLE IF EXISTS video_reactions;
CREATE TABLE IF NOT EXISTS video_reactions (
  video_id bigint(20) unsigned NOT NULL,
  user_id bigint(20) unsigned NOT NULL,
  reaction enum('like','dislike') NOT NULL DEFAULT 'like',
  creation_date datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (user_id,video_id),
  KEY video_reactions_video_FK (video_id),
  CONSTRAINT video_reactions_user_FK FOREIGN KEY (user_id) REFERENCES user (user_id),
  CONSTRAINT video_reactions_video_FK FOREIGN KEY (video_id) REFERENCES video (video_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla video_tags
DROP TABLE IF EXISTS video_tags;
CREATE TABLE IF NOT EXISTS video_tags (
  video_id bigint(20) unsigned NOT NULL,
  tag_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (video_id,tag_id),
  KEY video_tags_tag_FK (tag_id),
  CONSTRAINT video_tags_tag_FK FOREIGN KEY (tag_id) REFERENCES tag (tag_id),
  CONSTRAINT video_tags_video_FK FOREIGN KEY (video_id) REFERENCES video (video_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando estructura para tabla video_views
DROP TABLE IF EXISTS video_views;
CREATE TABLE IF NOT EXISTS video_views (
  video_id bigint(20) unsigned NOT NULL,
  user_id bigint(20) unsigned NOT NULL,
  creation_date datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (video_id,user_id),
  KEY video_views_user_FK (user_id),
  CONSTRAINT video_views_user_FK FOREIGN KEY (user_id) REFERENCES user (user_id),
  CONSTRAINT video_views_video_FK FOREIGN KEY (video_id) REFERENCES video (video_id)
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
-- Database:                     youtube
-- --------------------------------------------------------

use youtube;


-- Desactivar claves foráneas
SET FOREIGN_KEY_CHECKS = 0;


-- Borrar datos existentes antes de insertar nuevos registros
TRUNCATE TABLE channel;
TRUNCATE TABLE comments;
TRUNCATE TABLE comment_reactions;
TRUNCATE TABLE country;
TRUNCATE TABLE gender;
TRUNCATE TABLE playlist;
TRUNCATE TABLE playlist_videos;
TRUNCATE TABLE subscription;
TRUNCATE TABLE tag;
TRUNCATE TABLE user;
TRUNCATE TABLE video;
TRUNCATE TABLE video_reactions;
TRUNCATE TABLE video_tags;
TRUNCATE TABLE video_views;


-- Tabla gender
INSERT INTO gender (name) VALUES
('Male'),
('Female');


-- Tabla country
INSERT INTO country (country_Id, name) VALUES
('GBR', 'United Kingdom'),
('USA', 'United States'),
('CAN', 'Canada'),
('AUS', 'Australia'),
('FRA', 'France'),
('DEU', 'Germany'),
('ESP', 'Spain'),
('ITA', 'Italy'),
('JPN', 'Japan'),
('BRA', 'Brazil');


-- Tabla user (20 usuarios)
INSERT INTO user (name, password, birth_date, gender_id, country_id, postal_code) VALUES
('John Smith', 'password123', '1990-05-15', 1, 'GBR', 'SW1A 1AA'),
('Emily Johnson', 'securepass', '1985-08-22', 2, 'GBR', 'EC1A 1BB'),
('Michael Brown', 'mypass123', '1992-11-30', 1, 'USA', '10001'),
('Sarah Davis', 'sarahpass', '1988-03-10', 2, 'USA', '90210'),
('David Wilson', 'david1234', '1995-07-18', 1, 'CAN', 'M5V 2T6'),
('Jessica Lee', 'jesspass', '1991-09-25', 2, 'AUS', '2000'),
('Robert Taylor', 'robertpass', '1987-12-05', 1, 'GBR', 'W1A 0AX'),
('Jennifer Martin', 'jenny123', '1993-04-20', 2, 'USA', '33139'),
('William Anderson', 'willpass', '1989-06-12', 1, 'CAN', 'V6B 1H4'),
('Elizabeth Thomas', 'lizpass', '1994-02-28', 2, 'GBR', 'WC2N 5DU'),
('James Jackson', 'jamespass', '1990-10-08', 1, 'AUS', '3000'),
('Margaret White', 'maggie123', '1986-07-14', 2, 'USA', '94102'),
('Charles Harris', 'charlesp', '1992-01-17', 1, 'GBR', 'E1 6AN'),
('Patricia Clark', 'patricia1', '1984-09-03', 2, 'CAN', 'H3B 2Y5'),
('Thomas Lewis', 'tompass', '1996-12-22', 1, 'GBR', 'SE1 7PB'),
('Susan Walker', 'susie123', '1991-05-19', 2, 'USA', '60601'),
('Daniel Hall', 'danpass', '1988-08-11', 1, 'AUS', '4000'),
('Nancy Allen', 'nancypass', '1993-03-27', 2, 'GBR', 'NW1 6XE'),
('Matthew Young', 'mattpass', '1985-11-09', 1, 'CAN', 'M5J 2T3'),
('Lisa King', 'lisapass', '1997-04-15', 2, 'USA', '10036');


-- Tabla channel
INSERT INTO channel (user_id, name, description, creation_date) VALUES
(1, 'John\'s Adventures', 'Travel and adventure videos from London', '2020-01-15 10:00:00'),
(2, 'Emily\'s Cooking', 'Delicious recipes and cooking tips', '2019-05-20 14:30:00'),
(3, 'Mike Tech Reviews', 'Latest tech gadgets and reviews', '2021-03-10 09:15:00'),
(4, 'Sarah Travels', 'Exploring beautiful destinations', '2018-07-05 16:45:00'),
(5, 'Dave Fitness', 'Workout routines and fitness tips', '2020-11-12 08:20:00'),
(6, 'Jess Photography', 'Photography tutorials and tips', '2019-09-18 11:10:00'),
(7, 'Rob Music', 'Original music and covers', '2021-02-28 19:30:00'),
(8, 'Jenny Crafts', 'DIY crafts and creative projects', '2020-04-05 13:25:00'),
(9, 'Will Gaming', 'Gameplay and gaming news', '2019-12-15 17:40:00'),
(10, 'Liz Lifestyle', 'Lifestyle and wellness content', '2021-01-22 10:50:00'),
(11, 'James Science', 'Science experiments and facts', '2020-08-30 15:15:00'),
(12, 'Maggie Fashion', 'Fashion trends and style tips', '2019-06-10 12:00:00'),
(13, 'Charlie Finance', 'Personal finance advice', '2021-05-05 09:30:00'),
(14, 'Patty Gardening', 'Gardening tips and plant care', '2020-03-18 14:20:00'),
(15, 'Tom Comedy', 'Funny sketches and comedy', '2019-10-25 18:45:00'),
(16, 'Susan Books', 'Book reviews and recommendations', '2021-04-12 11:35:00'),
(17, 'Dan Sports', 'Sports analysis and highlights', '2020-07-22 16:10:00'),
(18, 'Nancy Art', 'Art tutorials and exhibitions', '2019-11-08 10:25:00'),
(19, 'Matt History', 'Historical facts and stories', '2021-06-30 13:50:00'),
(20, 'Lisa Beauty', 'Beauty products and makeup tips', '2020-09-14 15:40:00');


-- Tabla tag
INSERT INTO tag (name) VALUES
('Travel'),
('Food'),
('Technology'),
('Fitness'),
('Photography'),
('Music'),
('DIY'),
('Gaming'),
('Lifestyle'),
('Science'),
('Fashion'),
('Finance'),
('Gardening'),
('Comedy'),
('Books'),
('Sports'),
('Art'),
('History'),
('Beauty'),
('Education');


-- Tabla video (20 videos)
INSERT INTO video (user_id, title, description, size_mb, file_name, duration_seconds, views, likes, dislikes, visibility, upload_date) VALUES
(1, 'London Walking Tour', 'A beautiful walk through central London', 256.50, 'london_walk.mp4', 1250, 15000, 1200, 50, 'public', '2021-02-10 12:00:00'),
(2, 'Easy Pasta Recipe', 'Learn to make delicious pasta in 15 mins', 180.75, 'pasta_recipe.mp4', 900, 25000, 1800, 30, 'public', '2021-03-15 14:30:00'),
(3, 'Smartphone Review 2023', 'Latest flagship smartphone review', 320.25, 'phone_review.mp4', 1500, 50000, 3500, 200, 'public', '2021-04-20 10:15:00'),
(4, 'Paris Vacation Vlog', 'My amazing trip to Paris last summer', 275.80, 'paris_vlog.mp4', 1800, 12000, 950, 20, 'public', '2021-05-05 16:45:00'),
(5, 'Home Workout Routine', 'No equipment needed full body workout', 195.30, 'home_workout.mp4', 1200, 30000, 2500, 40, 'public', '2021-06-12 08:20:00'),
(6, 'Portrait Photography Tips', 'Improve your portrait photography', 225.60, 'photo_tips.mp4', 1350, 18000, 1400, 25, 'public', '2021-07-18 11:10:00'),
(7, 'Original Song Performance', 'My new original song performance', 150.90, 'song_performance.mp4', 600, 8000, 700, 10, 'public', '2021-08-28 19:30:00'),
(8, 'DIY Home Decor', 'Easy home decor ideas on a budget', 210.45, 'diy_decor.mp4', 1100, 22000, 1700, 35, 'public', '2021-09-05 13:25:00'),
(9, 'Gameplay Walkthrough', 'Complete walkthrough of popular game', 450.75, 'game_walkthrough.mp4', 2400, 75000, 5000, 300, 'public', '2021-10-15 17:40:00'),
(10, 'Morning Routine', 'My productive morning routine', 175.20, 'morning_routine.mp4', 950, 15000, 1200, 15, 'public', '2021-11-22 10:50:00'),
(11, 'Science Experiment', 'Cool science experiment at home', 190.80, 'science_experiment.mp4', 1050, 28000, 2200, 45, 'public', '2021-12-30 15:15:00'),
(12, 'Summer Outfit Ideas', 'Fashionable summer outfit ideas', 165.90, 'summer_fashion.mp4', 850, 20000, 1600, 30, 'public', '2022-01-10 12:00:00'),
(13, 'Investing for Beginners', 'How to start investing with little money', 205.60, 'investing_basics.mp4', 1150, 35000, 2800, 60, 'public', '2022-02-05 09:30:00'),
(14, 'Vegetable Garden Tips', 'Growing your own vegetables at home', 185.30, 'garden_tips.mp4', 1000, 17000, 1300, 20, 'public', '2022-03-18 14:20:00'),
(15, 'Funny Standup Comedy', 'My latest standup comedy routine', 240.75, 'standup_comedy.mp4', 1300, 40000, 3200, 80, 'public', '2022-04-25 18:45:00'),
(16, 'Book Recommendations', 'My favorite books of the year', 155.40, 'book_recommendations.mp4', 800, 12000, 900, 10, 'public', '2022-05-12 11:35:00'),
(17, 'Football Highlights', 'Best football moments of the week', 380.90, 'football_highlights.mp4', 2000, 60000, 4500, 150, 'public', '2022-06-22 16:10:00'),
(18, 'Watercolor Tutorial', 'Beginner watercolor painting tutorial', 195.60, 'watercolor_tutorial.mp4', 1100, 19000, 1500, 25, 'public', '2022-07-08 10:25:00'),
(19, 'Ancient Rome History', 'Fascinating facts about Ancient Rome', 225.30, 'rome_history.mp4', 1250, 23000, 1800, 40, 'public', '2022-08-30 13:50:00'),
(20, 'Everyday Makeup Look', 'Quick and easy everyday makeup', 170.80, 'everyday_makeup.mp4', 900, 25000, 2000, 30, 'public', '2022-09-14 15:40:00');


-- Tabla comments
INSERT INTO comments (video_id, user_id, content, creation_date) VALUES
(1, 2, 'Great tour! I love London.', '2021-02-11 10:15:00'),
(1, 3, 'When was this filmed?', '2021-02-12 14:30:00'),
(2, 1, 'Tried this recipe, it was delicious!', '2021-03-16 18:45:00'),
(2, 4, 'Can I substitute the pasta type?', '2021-03-17 12:20:00'),
(3, 5, 'This phone is too expensive for me', '2021-04-21 09:10:00'),
(3, 6, 'Great review, very detailed.', '2021-04-22 16:35:00'),
(4, 7, 'Paris is my dream destination!', '2021-05-06 20:00:00'),
(4, 8, 'Which camera did you use?', '2021-05-07 11:45:00'),
(5, 9, 'This workout killed me!', '2021-06-13 07:30:00'),
(5, 10, 'Perfect for home exercise.', '2021-06-14 15:20:00'),
(6, 11, 'Very helpful tips, thanks!', '2021-07-19 19:10:00'),
(6, 12, 'What lens do you recommend?', '2021-07-20 10:55:00'),
(7, 13, 'Beautiful song, great voice!', '2021-08-29 21:40:00'),
(7, 14, 'When is your album coming out?', '2021-08-30 14:25:00'),
(8, 15, 'I tried this and loved it!', '2021-09-06 18:15:00'),
(8, 16, 'Where did you get those frames?', '2021-09-07 09:50:00'),
(9, 17, 'This game looks amazing!', '2021-10-16 22:30:00'),
(9, 18, 'Stuck on level 5, any tips?', '2021-10-17 13:40:00'),
(10, 19, 'Inspiring routine!', '2021-11-23 08:20:00'),
(10, 20, 'What time do you wake up?', '2021-11-24 17:10:00');


-- Tabla comment_reactions
INSERT INTO comment_reactions (comment_id, user_id, reaction, creation_date) VALUES
(1, 3, 'like', '2021-02-11 11:30:00'),
(1, 4, 'like', '2021-02-12 09:45:00'),
(2, 1, 'dislike', '2021-02-13 14:20:00'),
(3, 5, 'like', '2021-03-17 19:10:00'),
(4, 2, 'like', '2021-03-18 13:25:00'),
(5, 6, 'dislike', '2021-04-22 10:40:00'),
(6, 7, 'like', '2021-04-23 17:15:00'),
(7, 8, 'like', '2021-05-07 21:30:00'),
(8, 9, 'dislike', '2021-05-08 12:45:00'),
(9, 10, 'like', '2021-06-14 08:20:00'),
(10, 11, 'like', '2021-06-15 16:35:00'),
(11, 12, 'dislike', '2021-07-20 20:10:00'),
(12, 13, 'like', '2021-07-21 11:25:00'),
(13, 14, 'like', '2021-08-30 22:40:00'),
(14, 15, 'dislike', '2021-08-31 15:55:00'),
(15, 16, 'like', '2021-09-07 19:20:00'),
(16, 17, 'like', '2021-09-08 10:35:00'),
(17, 18, 'dislike', '2021-10-17 23:50:00'),
(18, 19, 'like', '2021-10-18 14:05:00'),
(19, 20, 'like', '2021-11-24 09:30:00');


-- Tabla playlist
INSERT INTO playlist (user_id, name, creation_date, visibility) VALUES
(1, 'My Favorite Travel Videos', '2021-03-01 10:00:00', 'public'),
(2, 'Cooking Inspiration', '2021-04-05 14:30:00', 'private'),
(3, 'Tech Reviews Collection', '2021-05-10 09:15:00', 'public'),
(4, 'Dream Destinations', '2021-06-15 16:45:00', 'private'),
(5, 'Workout Routines', '2021-07-20 08:20:00', 'public'),
(6, 'Photography Tutorials', '2021-08-25 11:10:00', 'private'),
(7, 'Music to Relax', '2021-09-30 19:30:00', 'public'),
(8, 'DIY Projects', '2021-11-05 13:25:00', 'private'),
(9, 'Game Walkthroughs', '2021-12-10 17:40:00', 'public'),
(10, 'Productivity Tips', '2022-01-15 10:50:00', 'private'),
(11, 'Science Experiments', '2022-02-20 15:15:00', 'public'),
(12, 'Fashion Inspiration', '2022-03-25 12:00:00', 'private'),
(13, 'Financial Education', '2022-04-30 09:30:00', 'public'),
(14, 'Gardening Ideas', '2022-06-05 14:20:00', 'private'),
(15, 'Comedy Sketches', '2022-07-10 18:45:00', 'public'),
(16, 'Books to Read', '2022-08-15 11:35:00', 'private'),
(17, 'Sports Highlights', '2022-09-20 16:10:00', 'public'),
(18, 'Art Tutorials', '2022-10-25 10:25:00', 'private'),
(19, 'History Lessons', '2022-11-30 13:50:00', 'public'),
(20, 'Beauty Tips', '2023-01-05 15:40:00', 'private');


-- Tabla playlist_videos
INSERT INTO playlist_videos (playlist_id, video_id) VALUES
(1, 1),
(1, 4),
(2, 2),
(3, 3),
(4, 1),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20);


-- Tabla subscription
INSERT INTO subscription (channel_id, user_id) VALUES
(1, 2),
(1, 3),
(2, 1),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10),
(6, 11),
(6, 12),
(7, 13),
(7, 14),
(8, 15),
(8, 16),
(9, 17),
(9, 18),
(10, 19),
(10, 20),
(11, 1),
(11, 2),
(12, 3),
(12, 4),
(13, 5),
(13, 6),
(14, 7),
(14, 8),
(15, 9),
(15, 10);


-- Tabla video_tags
INSERT INTO video_tags (video_id, tag_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(5, 4),
(6, 5),
(7, 6),
(8, 7),
(9, 8),
(10, 9),
(11, 10),
(12, 11),
(13, 12),
(14, 13),
(15, 14),
(16, 15),
(17, 16),
(18, 17),
(19, 18),
(20, 19),
(1, 20),
(2, 9),
(3, 20),
(4, 20),
(5, 20),
(6, 20),
(7, 20),
(8, 20),
(9, 20),
(10, 20);


-- Tabla video_reactions
INSERT INTO video_reactions (video_id, user_id, reaction, creation_date) VALUES
(1, 2, 'like', '2021-02-11 10:15:00'),
(1, 3, 'like', '2021-02-12 14:30:00'),
(2, 1, 'like', '2021-03-16 18:45:00'),
(2, 4, 'like', '2021-03-17 12:20:00'),
(3, 5, 'dislike', '2021-04-21 09:10:00'),
(3, 6, 'like', '2021-04-22 16:35:00'),
(4, 7, 'like', '2021-05-06 20:00:00'),
(4, 8, 'like', '2021-05-07 11:45:00'),
(5, 9, 'like', '2021-06-13 07:30:00'),
(5, 10, 'like', '2021-06-14 15:20:00'),
(6, 11, 'like', '2021-07-19 19:10:00'),
(6, 12, 'like', '2021-07-20 10:55:00'),
(7, 13, 'like', '2021-08-29 21:40:00'),
(7, 14, 'like', '2021-08-30 14:25:00'),
(8, 15, 'like', '2021-09-06 18:15:00'),
(8, 16, 'like', '2021-09-07 09:50:00'),
(9, 17, 'dislike', '2021-10-16 22:30:00'),
(9, 18, 'like', '2021-10-17 13:40:00'),
(10, 19, 'like', '2021-11-23 08:20:00'),
(10, 20, 'like', '2021-11-24 17:10:00');


-- Tabla video_views
INSERT INTO video_views (video_id, user_id, creation_date) VALUES
(1, 2, '2021-02-11 10:15:00'),
(1, 3, '2021-02-12 14:30:00'),
(2, 1, '2021-03-16 18:45:00'),
(2, 4, '2021-03-17 12:20:00'),
(3, 5, '2021-04-21 09:10:00'),
(3, 6, '2021-04-22 16:35:00'),
(4, 7, '2021-05-06 20:00:00'),
(4, 8, '2021-05-07 11:45:00'),
(5, 9, '2021-06-13 07:30:00'),
(5, 10, '2021-06-14 15:20:00'),
(6, 11, '2021-07-19 19:10:00'),
(6, 12, '2021-07-20 10:55:00'),
(7, 13, '2021-08-29 21:40:00'),
(7, 14, '2021-08-30 14:25:00'),
(8, 15, '2021-09-06 18:15:00'),
(8, 16, '2021-09-07 09:50:00'),
(9, 17, '2021-10-16 22:30:00'),
(9, 18, '2021-10-17 13:40:00'),
(10, 19, '2021-11-23 08:20:00'),
(10, 20, '2021-11-24 17:10:00');


-- Reactivar claves foráneas
SET FOREIGN_KEY_CHECKS = 1;


-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         10.11.11-MariaDB-0+deb12u1 - Debian 12
-- SO del servidor:              debian-linux-gnu
-- 
-- Author:                       Diego Balaguer
-- Date:                         02/05/2025
-- Database:                     youtube
-- --------------------------------------------------------


USE youtube;


-- 01. Mejor forma de obtener cuantas veces que se ha visto un video o los like's y dislike's que tiene
SELECT 
    v.video_id,
    v.title,
    (SELECT COUNT(*) 
     FROM video_views vv 
     WHERE vv.video_id = v.video_id) AS total_views,
    
    (SELECT COUNT(*) 
     FROM video_reactions vr 
     WHERE vr.video_id = v.video_id AND vr.reaction = 'like') AS total_likes,
    
    (SELECT COUNT(*) 
     FROM video_reactions vr 
     WHERE vr.video_id = v.video_id AND vr.reaction = 'dislike') AS total_dislikes
FROM 
    video v;


-- 02. Validación de Relaciones Básicas
-- Verificar que todos los usuarios tienen un género y país válidos
SELECT u.user_id, u.name, g.name AS gender, c.name AS country
FROM user u
JOIN gender g ON u.gender_id = g.gender_id
JOIN country c ON u.country_id = c.country_Id;


-- 03. Validación de Integridad Referencial
-- revision de la relación de los canales con su usuario
SELECT c.channel_id, c.name, u.name user_name 
FROM channel c
LEFT JOIN user u ON c.user_id = u.user_id;


-- 04. Validación de Relaciones Many-to-Many
-- Verificar videos en playlists sin video existente (debería devolver 0 filas)
SELECT pv.playlist_id, pv.video_id, v.file_name
FROM playlist_videos pv
LEFT JOIN video v ON pv.video_id = v.video_id;


-- 05. Validación de Subconsultas Complejas
-- Usuarios más activos (comentarios + reacciones + subidas de videos)
SELECT 
    u.user_id,
    u.name,
    (SELECT COUNT(*) FROM video WHERE user_id = u.user_id) AS videos_subidos,
    (SELECT COUNT(*) FROM comments WHERE user_id = u.user_id) AS comentarios_hechos,
    (SELECT COUNT(*) FROM video_reactions WHERE user_id = u.user_id) AS reacciones_dadas
FROM user u
ORDER BY (videos_subidos + comentarios_hechos + reacciones_dadas) DESC;


-- 06. Validación tags videos
-- revisión de la relación entre los videos, los nombres de los tag's y cuales tiene aplicados
SELECT 
    v.video_id, v.title, v.description, t.name tag_name
FROM video v
JOIN video_tags vt ON v.video_id = vt.video_id
JOIN tag t ON vt.tag_id = t.tag_id
ORDER BY v.video_id;
