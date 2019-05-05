/*
Navicat MySQL Data Transfer

Source Server         : MySQL
Source Server Version : 50560
Source Host           : localhost:3306
Source Database       : todolist

Target Server Type    : MYSQL
Target Server Version : 50560
File Encoding         : 65001

Date: 2019-05-04 21:00:39
*/
CREATE DATABASE IF NOT EXISTS todolist character set UTF8mb4 collate utf8mb4_bin;

use todolist;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for list
-- ----------------------------
DROP TABLE IF EXISTS `list`;
CREATE TABLE `list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `content` char(255) NOT NULL,
  `status` tinyint(1) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of list
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` char(50) NOT NULL,
  `password` char(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('2', 'molunerfinn', '$2a$10$x3f0Y2SNAmyAfqhKVAV.7uE7RHs3FDGuSYw.LlZhOFoyK7cjfZ.Q6');
INSERT INTO `user` VALUES ('3', 'admin', '$2a$10$x3f0Y2SNAmyAfqhKVAV.7uE7RHs3FDGuSYw.LlZhOFoyK7cjfZ.Q6');

