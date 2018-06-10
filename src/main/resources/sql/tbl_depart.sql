/*
 Navicat Premium Data Transfer

 Source Server         : localDB
 Source Server Type    : MySQL
 Source Server Version : 50720
 Source Host           : localhost:3306
 Source Schema         : rc_ssm

 Target Server Type    : MySQL
 Target Server Version : 50720
 File Encoding         : 65001

 Date: 11/06/2018 00:17:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_depart
-- ----------------------------
DROP TABLE IF EXISTS `tbl_depart`;
CREATE TABLE `tbl_depart`  (
  `depart_id` int(11) NOT NULL AUTO_INCREMENT,
  `depart_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`depart_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_depart
-- ----------------------------
INSERT INTO `tbl_depart` VALUES (1, '开发部');
INSERT INTO `tbl_depart` VALUES (2, '产品部');
INSERT INTO `tbl_depart` VALUES (3, '运维部');
INSERT INTO `tbl_depart` VALUES (4, '测试部');
INSERT INTO `tbl_depart` VALUES (5, '设计部');

SET FOREIGN_KEY_CHECKS = 1;
