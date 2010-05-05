CREATE TABLE `restaurants` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `name` VARCHAR (255) NOT NULL ,
  `categories` VARCHAR(255) NULL DEFAULT NULL,
  `lat` FLOAT (10, 6) NULL DEFAULT NULL ,
  `lng` FLOAT (10, 6) NULL DEFAULT NULL ,
  `description` VARCHAR (255) NULL DEFAULT NULL,
  `address` VARCHAR (255) NULL DEFAULT NULL ,
  `zip` INT NULL DEFAULT NULL ,
  `xstreet` VARCHAR (255) NULL DEFAULT NULL,
  `closed` TINYINT(1) NULL DEFAULT 0,
  `link` VARCHAR(255) NULL DEFAULT NULL,
  `updated` DATETIME NULL DEFAULT NULL,
  `phone` VARCHAR(255) NULL DEFAULT NULL  
) ENGINE = INNNODB ;