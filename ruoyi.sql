-- MySQL dump 10.13  Distrib 8.4.6, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ruoyi
-- ------------------------------------------------------
-- Server version	8.4.6

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='代码生成业务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
INSERT INTO `gen_table` VALUES (4,'tourism_news','',NULL,NULL,'TourismNews','crud','','cn.edu.cquet.tourism','tourism','news',NULL,'cquet','0','/',NULL,'admin','2025-10-25 22:36:07','',NULL,NULL);
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='代码生成业务表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
INSERT INTO `gen_table_column` VALUES (42,4,'id','','int','Long','id','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2025-10-25 22:36:07','','2025-10-25 22:37:25'),(43,4,'news_title','','varchar(128)','String','newsTitle','0','0','0','1','1','1','1','EQ','input','',2,'admin','2025-10-25 22:36:07','','2025-10-25 22:37:26'),(44,4,'news_type','','char(1)','String','newsType','0','0','0','1','1','1','1','EQ','select','',3,'admin','2025-10-25 22:36:07','','2025-10-25 22:37:26'),(45,4,'news_content','','longblob','String','newsContent','0','0','0','1','1','1','1','EQ','editor','',4,'admin','2025-10-25 22:36:07','','2025-10-25 22:37:26'),(46,4,'status','','char(1)','String','status','0','0','0','1','1','1','1','EQ','radio','',5,'admin','2025-10-25 22:36:07','','2025-10-25 22:37:26'),(47,4,'create_by','','varchar(64)','String','createBy','0','0','0','1',NULL,NULL,NULL,'EQ','input','',6,'admin','2025-10-25 22:36:07','','2025-10-25 22:37:26'),(48,4,'create_time','创建时间','datetime','Date','createTime','0','0','0','1',NULL,NULL,NULL,'EQ','datetime','',7,'admin','2025-10-25 22:36:07','','2025-10-25 22:37:26'),(49,4,'update_by','','varchar(64)','String','updateBy','0','0','0','1','1',NULL,NULL,'EQ','input','',8,'admin','2025-10-25 22:36:07','','2025-10-25 22:37:26'),(50,4,'update_time','','datetime','Date','updateTime','0','0','0','1','1',NULL,NULL,'EQ','datetime','',9,'admin','2025-10-25 22:36:07','','2025-10-25 22:37:26'),(51,4,'remark','','varchar(255)','String','remark','0','0','0','1','1','1',NULL,'EQ','input','',10,'admin','2025-10-25 22:36:07','','2025-10-25 22:37:26'),(52,4,'del_flag','逻辑删除','int','Long','delFlag','0','0','0','1',NULL,NULL,NULL,'EQ','input','',11,'admin','2025-10-25 22:36:07','','2025-10-25 22:37:26');
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_config` (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `del_flag` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2024-09-04 06:22:52','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow',0,NULL),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2024-09-04 06:22:52','',NULL,'初始化密码 123456',0,NULL),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2024-09-04 06:22:52','',NULL,'深色主题theme-dark，浅色主题theme-light',0,NULL),(4,'账号自助-验证码开关','sys.account.captchaEnabled','false','Y','admin','2024-09-04 06:22:52','admin','2025-10-25 19:57:24','是否开启验证码功能（true开启，false关闭）',0,NULL),(5,'账号自助-是否开启用户注册功能','sys.account.registerUser','true','Y','admin','2024-09-04 06:22:52','admin','2025-10-25 21:01:28','是否开启注册用户功能（true开启，false关闭）',0,NULL),(6,'用户登录-黑名单列表','sys.login.blackIPList','','Y','admin','2024-09-04 06:22:52','',NULL,'设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）',0,NULL);
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,0,'0','CQUET',0,'CQUET','15888888888','XX@qq.com','0','0','admin','2024-09-04 06:22:51','',NULL),(101,100,'0,100','深圳总公司',1,'CQUET','15888888888','XX@qq.com','0','0','admin','2024-09-04 06:22:51','',NULL),(102,100,'0,100','长沙分公司',2,'CQUET','15888888888','XX@qq.com','0','0','admin','2024-09-04 06:22:51','',NULL),(103,101,'0,100,101','研发部门',1,'CQUET','15888888888','XX@qq.com','0','0','admin','2024-09-04 06:22:51','',NULL),(104,101,'0,100,101','市场部门',2,'CQUET','15888888888','XX@qq.com','0','0','admin','2024-09-04 06:22:51','',NULL),(105,101,'0,100,101','测试部门',3,'CQUET','15888888888','XX@qq.com','0','0','admin','2024-09-04 06:22:51','',NULL),(106,101,'0,100,101','财务部门',4,'CQUET','15888888888','XX@qq.com','0','0','admin','2024-09-04 06:22:51','',NULL),(107,101,'0,100,101','运维部门',5,'CQUET','15888888888','XX@qq.com','0','0','admin','2024-09-04 06:22:51','',NULL),(108,102,'0,100,102','市场部门',1,'CQUET','15888888888','XX@qq.com','0','0','admin','2024-09-04 06:22:51','',NULL),(109,102,'0,100,102','财务部门',2,'CQUET','15888888888','XX@qq.com','0','0','admin','2024-09-04 06:22:51','',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2024-09-04 06:22:52','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2024-09-04 06:22:52','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2024-09-04 06:22:52','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2024-09-04 06:22:52','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2024-09-04 06:22:52','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2024-09-04 06:22:52','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2024-09-04 06:22:52','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2024-09-04 06:22:52','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2024-09-04 06:22:52','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2024-09-04 06:22:52','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2024-09-04 06:22:52','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2024-09-04 06:22:52','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2024-09-04 06:22:52','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2024-09-04 06:22:52','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2024-09-04 06:22:52','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2024-09-04 06:22:52','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2024-09-04 06:22:52','',NULL,'关闭状态'),(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2024-09-04 06:22:52','',NULL,'其他操作'),(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2024-09-04 06:22:52','',NULL,'新增操作'),(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2024-09-04 06:22:52','',NULL,'修改操作'),(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2024-09-04 06:22:52','',NULL,'删除操作'),(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2024-09-04 06:22:52','',NULL,'授权操作'),(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2024-09-04 06:22:52','',NULL,'导出操作'),(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2024-09-04 06:22:52','',NULL,'导入操作'),(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2024-09-04 06:22:52','',NULL,'强退操作'),(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2024-09-04 06:22:52','',NULL,'生成操作'),(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2024-09-04 06:22:52','',NULL,'清空操作'),(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2024-09-04 06:22:52','',NULL,'正常状态'),(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2024-09-04 06:22:52','',NULL,'停用状态');
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE KEY `dict_type` (`dict_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2024-09-04 06:22:52','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2024-09-04 06:22:52','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2024-09-04 06:22:52','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2024-09-04 06:22:52','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2024-09-04 06:22:52','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2024-09-04 06:22:52','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2024-09-04 06:22:52','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2024-09-04 06:22:52','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2024-09-04 06:22:52','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2024-09-04 06:22:52','',NULL,'登录状态列表');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job`
--

DROP TABLE IF EXISTS `sys_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='定时任务调度表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job`
--

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job_log`
--

DROP TABLE IF EXISTS `sys_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='定时任务调度日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job_log`
--

LOCK TABLES `sys_job_log` WRITE;
/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  `create_time` datetime DEFAULT NULL,
  `del_flag` int DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`info_id`) USING BTREE,
  KEY `idx_sys_logininfor_s` (`status`) USING BTREE,
  KEY `idx_sys_logininfor_lt` (`login_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (40,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-10-27 14:39:41','2025-10-27 14:39:41',0,NULL),(41,'liyuan','127.0.0.1','内网IP','Chrome 14','Windows 10','0','注册成功','2025-10-27 15:12:23','2025-10-27 15:12:23',0,NULL),(42,'admin','127.0.0.1','内网IP','Unknown','Unknown','1','用户不存在/密码错误','2025-10-27 15:12:54','2025-10-27 15:12:54',0,NULL),(43,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-10-27 15:13:01','2025-10-27 15:13:01',0,NULL),(44,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-10-27 15:13:26','2025-10-27 15:13:26',0,NULL),(45,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-10-27 15:15:01','2025-10-27 15:15:01',0,NULL),(46,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-10-28 15:59:01','2025-10-28 15:59:01',0,NULL),(47,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2025-10-28 16:16:53','2025-10-28 16:16:53',0,NULL),(48,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-10-28 16:16:55','2025-10-28 16:16:55',0,NULL),(49,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-10-28 19:44:05','2025-10-28 19:44:05',0,NULL),(50,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-10-28 19:51:00','2025-10-28 19:51:00',0,NULL),(51,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-10-29 10:31:22','2025-10-29 10:31:22',0,NULL),(52,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-10-29 10:49:14','2025-10-29 10:49:14',0,NULL),(53,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-02 18:51:16','2025-11-02 18:51:16',0,NULL),(54,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-03 10:37:01','2025-11-03 10:37:01',0,NULL),(55,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-03 14:21:59','2025-11-03 14:21:59',0,NULL),(56,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-04 16:24:13','2025-11-04 16:24:13',0,NULL),(57,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-09 21:37:49','2025-11-09 21:37:49',0,NULL),(58,'admin','127.0.0.1','内网IP','Mozilla','Windows 10','0','登录成功','2025-11-09 22:08:55','2025-11-09 22:08:55',0,NULL),(59,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-09 22:13:24','2025-11-09 22:13:24',0,NULL),(60,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-10 14:00:09','2025-11-10 14:00:09',0,NULL),(61,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-10 15:23:26','2025-11-10 15:23:26',0,NULL),(62,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-11 16:10:52','2025-11-11 16:10:52',0,NULL),(63,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-11 18:28:09','2025-11-11 18:28:09',0,NULL),(64,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-11 19:45:08','2025-11-11 19:45:08',0,NULL),(65,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-11 19:54:56','2025-11-11 19:54:56',0,NULL),(66,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-12 10:53:19','2025-11-12 10:53:19',0,NULL),(67,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-12 10:56:35','2025-11-12 10:56:35',0,NULL),(68,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 11:37:32','2025-11-12 11:37:32',0,NULL),(69,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 11:37:57','2025-11-12 11:37:57',0,NULL),(70,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-14 17:03:38','2025-11-14 17:03:38',0,NULL),(71,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-14 17:04:19','2025-11-14 17:04:19',0,NULL),(72,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-14 17:04:25','2025-11-14 17:04:25',0,NULL),(73,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 17:05:48','2025-11-14 17:05:48',0,NULL),(74,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-14 17:06:08','2025-11-14 17:06:08',0,NULL),(75,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 17:56:29','2025-11-14 17:56:29',0,NULL),(76,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-14 18:08:00','2025-11-14 18:08:00',0,NULL),(77,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 22:01:46','2025-11-14 22:01:46',0,NULL),(78,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-14 22:30:34','2025-11-14 22:30:34',0,NULL),(79,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-14 23:21:01','2025-11-14 23:21:01',0,NULL),(80,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-14 23:57:49','2025-11-14 23:57:49',0,NULL),(81,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-15 16:18:29','2025-11-15 16:18:29',0,NULL),(82,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-15 16:25:33','2025-11-15 16:25:33',0,NULL),(83,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-15 16:27:40','2025-11-15 16:27:40',0,NULL),(84,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-15 17:29:32','2025-11-15 17:29:32',0,NULL),(85,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-15 17:32:32','2025-11-15 17:32:32',0,NULL),(86,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-15 17:43:39','2025-11-15 17:43:39',0,NULL),(87,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-15 18:11:54','2025-11-15 18:11:54',0,NULL),(88,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-17 10:41:35','2025-11-17 10:41:35',0,NULL),(89,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-17 11:04:48','2025-11-17 11:04:48',0,NULL),(90,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-17 11:31:37','2025-11-17 11:31:37',0,NULL),(91,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-17 12:01:43','2025-11-17 12:01:43',0,NULL),(92,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-17 14:37:18','2025-11-17 14:37:18',0,NULL);
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '路由名称',
  `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `del_flag` int DEFAULT NULL,
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2075 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,2,'system',NULL,'','',1,0,'M','0','0','','system','admin','2024-09-04 06:22:51','',NULL,'系统管理目录',0),(2,'系统监控',0,3,'monitor',NULL,'','',1,0,'M','0','0','','monitor','admin','2024-09-04 06:22:51','',NULL,'系统监控目录',0),(3,'系统工具',0,4,'tool',NULL,'','',1,0,'M','0','0','','tool','admin','2024-09-04 06:22:51','',NULL,'系统工具目录',0),(100,'用户管理',1,1,'user','system/user/index','','',1,0,'C','0','0','system:user:list','user','admin','2024-09-04 06:22:51','',NULL,'用户管理菜单',0),(101,'角色管理',1,2,'role','system/role/index','','',1,0,'C','0','0','system:role:list','peoples','admin','2024-09-04 06:22:51','',NULL,'角色管理菜单',0),(102,'菜单管理',1,3,'menu','system/menu/index','','',1,0,'C','0','0','system:menu:list','tree-table','admin','2024-09-04 06:22:51','',NULL,'菜单管理菜单',0),(103,'部门管理',1,4,'dept','system/dept/index','','',1,0,'C','0','0','system:dept:list','tree','admin','2024-09-04 06:22:51','',NULL,'部门管理菜单',0),(104,'岗位管理',1,5,'post','system/post/index','','',1,0,'C','0','0','system:post:list','post','admin','2024-09-04 06:22:51','',NULL,'岗位管理菜单',0),(105,'字典管理',1,6,'dict','system/dict/index','','',1,0,'C','0','0','system:dict:list','dict','admin','2024-09-04 06:22:51','',NULL,'字典管理菜单',0),(106,'参数设置',1,7,'config','system/config/index','','',1,0,'C','0','0','system:config:list','edit','admin','2024-09-04 06:22:51','',NULL,'参数设置菜单',0),(107,'通知公告',1,8,'notice','system/notice/index','','',1,0,'C','0','0','system:notice:list','message','admin','2024-09-04 06:22:51','',NULL,'通知公告菜单',0),(108,'日志管理',1,9,'log','','','',1,0,'M','0','0','','log','admin','2024-09-04 06:22:51','',NULL,'日志管理菜单',0),(109,'在线用户',2,1,'online','monitor/online/index','','',1,0,'C','0','0','monitor:online:list','online','admin','2024-09-04 06:22:51','',NULL,'在线用户菜单',0),(111,'数据监控',2,3,'druid','monitor/druid/index','','',1,0,'C','0','0','monitor:druid:list','druid','admin','2024-09-04 06:22:51','',NULL,'数据监控菜单',0),(112,'服务监控',2,4,'server','monitor/server/index','','',1,0,'C','0','0','monitor:server:list','server','admin','2024-09-04 06:22:51','',NULL,'服务监控菜单',0),(113,'缓存监控',2,5,'cache','monitor/cache/index','','',1,0,'C','0','0','monitor:cache:list','redis','admin','2024-09-04 06:22:51','',NULL,'缓存监控菜单',0),(114,'缓存列表',2,6,'cacheList','monitor/cache/list','','',1,0,'C','0','0','monitor:cache:list','redis-list','admin','2024-09-04 06:22:51','',NULL,'缓存列表菜单',0),(115,'表单构建',3,1,'build','tool/build/index','','',1,0,'C','0','0','tool:build:list','build','admin','2024-09-04 06:22:51','',NULL,'表单构建菜单',0),(116,'代码生成',3,2,'gen','tool/gen/index','','',1,0,'C','0','0','tool:gen:list','code','admin','2024-09-04 06:22:51','',NULL,'代码生成菜单',0),(117,'系统接口',3,3,'swagger','tool/swagger/index','','',1,0,'C','0','0','tool:swagger:list','swagger','admin','2024-09-04 06:22:51','',NULL,'系统接口菜单',0),(500,'操作日志',108,1,'operlog','monitor/operlog/index','','',1,0,'C','0','0','monitor:operlog:list','form','admin','2024-09-04 06:22:51','',NULL,'操作日志菜单',0),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','','',1,0,'C','0','0','monitor:logininfor:list','logininfor','admin','2024-09-04 06:22:51','',NULL,'登录日志菜单',0),(1000,'用户查询',100,1,'','','','',1,0,'F','0','0','system:user:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1001,'用户新增',100,2,'','','','',1,0,'F','0','0','system:user:add','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1002,'用户修改',100,3,'','','','',1,0,'F','0','0','system:user:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1003,'用户删除',100,4,'','','','',1,0,'F','0','0','system:user:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1004,'用户导出',100,5,'','','','',1,0,'F','0','0','system:user:export','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1005,'用户导入',100,6,'','','','',1,0,'F','0','0','system:user:import','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1006,'重置密码',100,7,'','','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1007,'角色查询',101,1,'','','','',1,0,'F','0','0','system:role:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1008,'角色新增',101,2,'','','','',1,0,'F','0','0','system:role:add','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1009,'角色修改',101,3,'','','','',1,0,'F','0','0','system:role:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1010,'角色删除',101,4,'','','','',1,0,'F','0','0','system:role:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1011,'角色导出',101,5,'','','','',1,0,'F','0','0','system:role:export','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1012,'菜单查询',102,1,'','','','',1,0,'F','0','0','system:menu:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1013,'菜单新增',102,2,'','','','',1,0,'F','0','0','system:menu:add','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1014,'菜单修改',102,3,'','','','',1,0,'F','0','0','system:menu:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1015,'菜单删除',102,4,'','','','',1,0,'F','0','0','system:menu:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1016,'部门查询',103,1,'','','','',1,0,'F','0','0','system:dept:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1017,'部门新增',103,2,'','','','',1,0,'F','0','0','system:dept:add','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1018,'部门修改',103,3,'','','','',1,0,'F','0','0','system:dept:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1019,'部门删除',103,4,'','','','',1,0,'F','0','0','system:dept:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1020,'岗位查询',104,1,'','','','',1,0,'F','0','0','system:post:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1021,'岗位新增',104,2,'','','','',1,0,'F','0','0','system:post:add','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1022,'岗位修改',104,3,'','','','',1,0,'F','0','0','system:post:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1023,'岗位删除',104,4,'','','','',1,0,'F','0','0','system:post:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1024,'岗位导出',104,5,'','','','',1,0,'F','0','0','system:post:export','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1025,'字典查询',105,1,'#','','','',1,0,'F','0','0','system:dict:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1026,'字典新增',105,2,'#','','','',1,0,'F','0','0','system:dict:add','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1027,'字典修改',105,3,'#','','','',1,0,'F','0','0','system:dict:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1028,'字典删除',105,4,'#','','','',1,0,'F','0','0','system:dict:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1029,'字典导出',105,5,'#','','','',1,0,'F','0','0','system:dict:export','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1030,'参数查询',106,1,'#','','','',1,0,'F','0','0','system:config:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1031,'参数新增',106,2,'#','','','',1,0,'F','0','0','system:config:add','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1032,'参数修改',106,3,'#','','','',1,0,'F','0','0','system:config:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1033,'参数删除',106,4,'#','','','',1,0,'F','0','0','system:config:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1034,'参数导出',106,5,'#','','','',1,0,'F','0','0','system:config:export','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1035,'公告查询',107,1,'#','','','',1,0,'F','0','0','system:notice:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1036,'公告新增',107,2,'#','','','',1,0,'F','0','0','system:notice:add','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1037,'公告修改',107,3,'#','','','',1,0,'F','0','0','system:notice:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1038,'公告删除',107,4,'#','','','',1,0,'F','0','0','system:notice:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1039,'操作查询',500,1,'#','','','',1,0,'F','0','0','monitor:operlog:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1040,'操作删除',500,2,'#','','','',1,0,'F','0','0','monitor:operlog:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1041,'日志导出',500,3,'#','','','',1,0,'F','0','0','monitor:operlog:export','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1042,'登录查询',501,1,'#','','','',1,0,'F','0','0','monitor:logininfor:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1043,'登录删除',501,2,'#','','','',1,0,'F','0','0','monitor:logininfor:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1044,'日志导出',501,3,'#','','','',1,0,'F','0','0','monitor:logininfor:export','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1045,'账户解锁',501,4,'#','','','',1,0,'F','0','0','monitor:logininfor:unlock','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1046,'在线查询',109,1,'#','','','',1,0,'F','0','0','monitor:online:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1047,'批量强退',109,2,'#','','','',1,0,'F','0','0','monitor:online:batchLogout','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1048,'单条强退',109,3,'#','','','',1,0,'F','0','0','monitor:online:forceLogout','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1055,'生成查询',116,1,'#','','','',1,0,'F','0','0','tool:gen:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1056,'生成修改',116,2,'#','','','',1,0,'F','0','0','tool:gen:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1057,'生成删除',116,3,'#','','','',1,0,'F','0','0','tool:gen:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1058,'导入代码',116,4,'#','','','',1,0,'F','0','0','tool:gen:import','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1059,'预览代码',116,5,'#','','','',1,0,'F','0','0','tool:gen:preview','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1060,'生成代码',116,6,'#','','','',1,0,'F','0','0','tool:gen:code','#','admin','2024-09-04 06:22:51','',NULL,'',0),(2072,'文旅管理',0,5,'tourism',NULL,NULL,'',1,0,'M','0','0',NULL,'online','admin','2025-11-03 14:22:53','admin','2025-11-03 14:23:03','',0),(2073,'新闻管理',2072,0,'news','tourism/news/index','','',1,0,'C','0','0','tourism:news:list','date-range','admin','2025-11-03 14:24:01','admin','2025-11-10 14:04:06','',0),(2074,'旅游景点',2072,1,'scenicSpot','tourism/scenicSpot/index',NULL,'',1,0,'C','0','0','tourism:scenicSpot:list','clipboard','admin','2025-11-10 14:01:25','admin','2025-11-10 14:06:39','',0);
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `del_flag` int DEFAULT '0',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '返回参数',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
  `create_time` datetime DEFAULT NULL,
  `del_flag` int DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`oper_id`) USING BTREE,
  KEY `idx_sys_oper_log_bt` (`business_type`) USING BTREE,
  KEY `idx_sys_oper_log_s` (`status`) USING BTREE,
  KEY `idx_sys_oper_log_ot` (`oper_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (114,'菜单管理',1,'cn.edu.cquet.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:22:53\",\"delFlag\":\"0\",\"icon\":\"online\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2072,\"menuName\":\"文旅管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"tourism\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,90,'2025-11-03 14:22:53',0,NULL),(115,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:22:53\",\"delFlag\":\"0\",\"icon\":\"online\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2072,\"menuName\":\"文旅管理\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"tourism\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:23:02\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,50,'2025-11-03 14:23:03',0,NULL),(116,'菜单管理',1,'cn.edu.cquet.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"query\":\"tourism/news\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,18,'2025-11-03 14:24:01',0,NULL),(117,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:25:18\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,19,'2025-11-03 14:25:18',0,NULL),(118,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:27:04\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,242,'2025-11-03 14:27:05',0,NULL),(119,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:28:26\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,40,'2025-11-03 14:28:26',0,NULL),(120,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:29:57\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,22,'2025-11-03 14:29:57',0,NULL),(121,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:30:14\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,34,'2025-11-03 14:30:14',0,NULL),(122,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:30:29\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,32,'2025-11-03 14:30:30',0,NULL),(123,'菜单管理',1,'cn.edu.cquet.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/scenicSpot/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-10 14:01:24\",\"delFlag\":\"0\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2074,\"menuName\":\"旅游景点\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:scenicSpot:list\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,30,'2025-11-10 14:01:25',0,NULL),(124,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/scenicSpot/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-10 14:01:25\",\"delFlag\":\"0\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2074,\"menuName\":\"旅游景点\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"tourisms\",\"perms\":\"tourism:scenicSpot:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-10 14:03:04\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,19,'2025-11-10 14:03:05',0,NULL),(125,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/scenicSpot/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-10 14:01:25\",\"delFlag\":\"0\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2074,\"menuName\":\"旅游景点\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"tourismspot\",\"perms\":\"tourism:scenicSpot:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-10 14:03:43\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,19,'2025-11-10 14:03:43',0,NULL),(126,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"news\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-10 14:04:06\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,12,'2025-11-10 14:04:06',0,NULL),(127,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/scenicSpot/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-10 14:01:25\",\"delFlag\":\"0\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2074,\"menuName\":\"旅游景点\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"scenicSpot\",\"perms\":\"tourism:scenicSpot:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-10 14:06:39\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,15,'2025-11-10 14:06:39',0,NULL),(128,'A级景区',1,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()','POST',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"四川省阿坝藏族羌族自治州九寨沟县\",\"city\":\"阿坝州\",\"createBy\":\"admin\",\"createTime\":\"2025-11-14 17:14:15\",\"delFlag\":\"0\",\"description\":\"九寨沟是世界自然遗产、国家重点风景名胜区、国家AAAAA级旅游景区、国家级自然保护区、国家地质公园、世界生物圈保护区网络，是中国第一个以保护自然风景为主要目的的自然保护区。\",\"district\":\"九寨沟县\",\"id\":23,\"latitude\":33.254,\"level\":\"5A\",\"longitude\":103.918,\"name\":\"九寨沟风景名胜区\",\"openingHours\":\"08:00-18:00\",\"params\":{},\"status\":\"0\",\"ticketPrice\":169.00}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,44,'2025-11-14 17:14:16',0,NULL),(129,'A级景区',1,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()','POST',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"测试001\",\"city\":\"测试001\",\"createBy\":\"admin\",\"createTime\":\"2025-11-14 17:57:55\",\"delFlag\":\"0\",\"description\":\"测试001\",\"id\":24,\"level\":\"AAA\",\"name\":\"测试001\",\"params\":{},\"ticketPrice\":0}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,87,'2025-11-14 17:57:56',0,NULL),(130,'设备设施管理',1,'cn.edu.cquet.tourism.controller.TourismFacilitiesController.add()','POST',1,'admin','研发部门','/tourism/facilities','127.0.0.1','内网IP','{\"facilitiesName\":\"笔记本电脑\",\"id\":3}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,18,'2025-11-15 00:00:33',0,NULL),(131,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[\"1.jpg\",\"2.jpg\",\"3.jpg\"]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":3,\"url\":\"1.jpg\"},{\"id\":4,\"url\":\"2.jpg\"},{\"id\":5,\"url\":\"3.jpg\"}]}','0','',NULL,43,'2025-11-15 16:29:21',0,NULL),(132,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/1/status/0','127.0.0.1','内网IP','1 \"0\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,21,'2025-11-15 16:59:08',0,NULL),(133,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/1/status/1','127.0.0.1','内网IP','1 \"1\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,20,'2025-11-15 16:59:29',0,NULL),(134,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/1/status/1','127.0.0.1','内网IP','1 \"1\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,48,'2025-11-15 17:32:48',0,NULL),(135,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"contactPhone\":\"023-12345678\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:36:02\",\"delFlag\":\"0\",\"description\":\"体验正宗重庆火锅文化，品尝地道美食\",\"endTime\":\"2024-06-03 18:00:00\",\"name\":\"重庆火锅文化节\",\"organizer\":\"重庆美食协会\",\"params\":{},\"startTime\":\"2024-06-01 09:00:00\",\"status\":\"ACTIVE\",\"venueId\":1}','','1','\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'status\' at row 1\r\n### The error may exist in cn/edu/cquet/tourism/mapper/TourismActivityMapper.java (best guess)\r\n### The error may involve cn.edu.cquet.tourism.mapper.TourismActivityMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO tourism_activity  ( name,  start_time, end_time,  venue_id, organizer, contact_phone, description, status,   create_time,  del_flag, create_by )  VALUES (  ?,  ?, ?,  ?, ?, ?, ?, ?,   ?,  ?, ?  )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'status\' at row 1\n; Data truncation: Data too long for column \'status\' at row 1',NULL,188,'2025-11-15 17:36:02',0,NULL),(136,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"pending\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/activity/winter-exhibit.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:40:28\",\"delFlag\":\"0\",\"description\":\"围绕城市文明的冬季专题展。\",\"endTime\":\"2026-01-10 18:00:00\",\"name\":\"城市博物馆冬季展览\",\"organizer\":\"城市博物馆\",\"params\":{},\"startTime\":\"2025-12-05 09:00:00\",\"status\":\"0\",\"venueId\":1}','','1','\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'audit_status\' at row 1\r\n### The error may exist in cn/edu/cquet/tourism/mapper/TourismActivityMapper.java (best guess)\r\n### The error may involve cn.edu.cquet.tourism.mapper.TourismActivityMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO tourism_activity  ( name, cover_image, start_time, end_time, category, venue_id, organizer, contact_phone, description, status, audit_status,  create_time,  del_flag, create_by )  VALUES (  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,  ?,  ?, ?  )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'audit_status\' at row 1\n; Data truncation: Data too long for column \'audit_status\' at row 1',NULL,8,'2025-11-15 17:40:28',0,NULL),(137,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"pending\",\"category\":\"讲座\",\"contactPhone\":\"13900001234\",\"coverImage\":\"https://cdn.example.com/images/winter-lecture.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:43:41\",\"delFlag\":\"0\",\"description\":\"邀请专家学者分享巴渝文化发展脉络与重要节点。\",\"endTime\":\"2025-12-20 21:00:00\",\"name\":\"冬季文化讲座：巴渝历史谈\",\"organizer\":\"重庆市文化馆\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-20 19:00:00\",\"status\":\"0\",\"venueId\":2}','','1','\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'audit_status\' at row 1\r\n### The error may exist in cn/edu/cquet/tourism/mapper/TourismActivityMapper.java (best guess)\r\n### The error may involve cn.edu.cquet.tourism.mapper.TourismActivityMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO tourism_activity  ( name, cover_image, start_time, end_time, category, venue_id, organizer, contact_phone, description, status, audit_status, remark, create_time,  del_flag, create_by )  VALUES (  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,  ?, ?  )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'audit_status\' at row 1\n; Data truncation: Data too long for column \'audit_status\' at row 1',NULL,228,'2025-11-15 17:43:42',0,NULL),(138,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:45:06\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":2,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,25,'2025-11-15 17:45:07',0,NULL),(139,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"展览123\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:46:46\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":3,\"name\":\"重庆非遗展览季123\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,34,'2025-11-15 17:46:46',0,NULL),(140,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.edit()','PUT',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"展览123\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":2,\"name\":\"重庆非遗展览季123\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-15 17:47:28\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,14,'2025-11-15 17:47:28',0,NULL),(141,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.approve()','POST',1,'admin','研发部门','/tourism/activity/2/approve','127.0.0.1','内网IP','2','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,20,'2025-11-15 17:49:00',0,NULL),(142,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.approve()','POST',1,'admin','研发部门','/tourism/activity/3/approve','127.0.0.1','内网IP','3','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,11,'2025-11-15 17:50:10',0,NULL),(143,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:50:50\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":4,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,22,'2025-11-15 17:50:51',0,NULL),(144,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:55:24\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":5,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,19,'2025-11-15 17:55:25',0,NULL),(145,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:55:26\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":6,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,6,'2025-11-15 17:55:27',0,NULL),(146,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:58:32\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":7,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,279,'2025-11-15 17:58:33',0,NULL),(147,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:58:34\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":8,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,22,'2025-11-15 17:58:34',0,NULL),(148,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.approve()','POST',1,'admin','研发部门','/tourism/activity/2/approve','127.0.0.1','内网IP','2','{\"msg\":\"操作失败\",\"code\":500}','0','',NULL,99,'2025-11-15 17:59:07',0,NULL),(149,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.reject()','POST',1,'admin','研发部门','/tourism/activity/3/reject','127.0.0.1','内网IP','3','{\"msg\":\"请提供审核不通过原因\",\"code\":601}','0','',NULL,0,'2025-11-15 17:59:20',0,NULL),(150,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.approve()','POST',1,'admin','研发部门','/tourism/activity/2/approve','127.0.0.1','内网IP','2 {\"opinion\":\"内容完整，予以通过\"}','{\"msg\":\"操作失败\",\"code\":500}','0','',NULL,168,'2025-11-15 18:03:16',0,NULL),(151,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.reject()','POST',1,'admin','研发部门','/tourism/activity/3/reject','127.0.0.1','内网IP','3 {\"reason\":\"资料不完整\"}','{\"msg\":\"操作失败\",\"code\":500}','0','',NULL,9,'2025-11-15 18:03:35',0,NULL),(152,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.approve()','POST',1,'admin','研发部门','/tourism/activity/2/approve','127.0.0.1','内网IP','2 {\"opinion\":\"内容完整，予以通过\"}','{\"msg\":\"操作失败\",\"code\":500}','0','',NULL,30,'2025-11-15 18:11:57',0,NULL),(153,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.approve()','POST',1,'admin','研发部门','/tourism/activity/2/approve','127.0.0.1','内网IP','2 {\"opinion\":\"内容完整，予以通过\"}','{\"msg\":\"操作失败\",\"code\":500}','0','',NULL,42,'2025-11-15 18:15:39',0,NULL),(154,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/1/status/2','127.0.0.1','内网IP','1 \"2\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,28,'2025-11-17 10:48:14',0,NULL),(155,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/1/status/7','127.0.0.1','内网IP','1 \"7\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,18,'2025-11-17 10:48:32',0,NULL),(156,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/7/status/1','127.0.0.1','内网IP','7 \"1\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,20,'2025-11-17 10:49:26',0,NULL),(157,'特色活动申报',2,'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.approve()','POST',1,'admin','研发部门','/tourism/activity-application/1/approve','127.0.0.1','内网IP','1 {\"opinion\":\"内容完整，予以通过\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,25,'2025-11-17 11:05:56',0,NULL),(158,'特色活动申报',2,'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.reject()','POST',1,'admin','研发部门','/tourism/activity-application/7/reject','127.0.0.1','内网IP','7 {\"reason\":\"资料不完整\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,30,'2025-11-17 11:07:14',0,NULL),(159,'特色活动申报',2,'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.approve()','POST',1,'admin','研发部门','/tourism/activity-application/1/approve','127.0.0.1','内网IP','1 {\"opinion\":\"内容完整，予以通过\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,71,'2025-11-17 11:12:37',0,NULL),(160,'特色活动申报',2,'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.reject()','POST',1,'admin','研发部门','/tourism/activity-application/7/reject','127.0.0.1','内网IP','7 {\"reason\":\"资料不完整\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,35,'2025-11-17 11:12:51',0,NULL),(161,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[\"1.jpg\",\"2.jpg\",\"3.jpg\"]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":6,\"url\":\"1.jpg\"},{\"id\":7,\"url\":\"2.jpg\"},{\"id\":8,\"url\":\"3.jpg\"}]}','0','',NULL,14,'2025-11-17 11:17:08',0,NULL),(162,'场馆管理',1,'cn.edu.cquet.tourism.controller.tourismVenueController.add()','POST',1,'admin','研发部门','/tourism/venue','127.0.0.1','内网IP','{\"address\":\"重庆市渝北区黄山大道中段\",\"category\":\"科技馆\",\"contactPhone\":\"12345678890\",\"coverImage\":\"http://example.com/images/venue1.jpg\",\"description\":\"重庆科技馆是重庆市重要的科普教育基地\",\"latitude\":29.123456,\"longitude\":106.123456,\"name\":\"重庆科技馆2\",\"params\":{},\"status\":\"1\",\"website\":\"http://www.cqstm.org.cn\"}','{\"msg\":\"操作失败\",\"code\":500}','0','',NULL,52,'2025-11-17 11:44:25',0,NULL),(163,'场馆管理',1,'cn.edu.cquet.tourism.controller.tourismVenueController.add()','POST',1,'admin','研发部门','/tourism/venue','127.0.0.1','内网IP','{\"address\":\"重庆市渝北区黄山大道中段\",\"category\":\"科技馆\",\"contactPhone\":\"12345678890\",\"coverImage\":\"http://example.com/images/venue1.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 11:44:30\",\"delFlag\":\"0\",\"description\":\"重庆科技馆是重庆市重要的科普教育基地\",\"id\":7,\"latitude\":29.123456,\"longitude\":106.123456,\"name\":\"重庆科技馆3\",\"params\":{},\"status\":\"1\",\"website\":\"http://www.cqstm.org.cn\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,53,'2025-11-17 11:44:30',0,NULL),(164,'特色活动申报',2,'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.approve()','POST',1,'admin','研发部门','/tourism/activity-application/8/approve','127.0.0.1','内网IP','8 {\"opinion\":\"内容完整，予以通过\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,44,'2025-11-17 11:46:37',0,NULL),(165,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[\"1.jpg\"]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":9,\"url\":\"1.jpg\"}]}','0','',NULL,39,'2025-11-17 12:01:46',0,NULL);
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_post`
--

DROP TABLE IF EXISTS `sys_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_post` (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='岗位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_post`
--

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` VALUES (1,'ceo','董事长',1,'0','admin','2024-09-04 06:22:51','',NULL,'','0'),(2,'se','项目经理',2,'0','admin','2024-09-04 06:22:51','',NULL,'','0'),(3,'hr','人力资源',3,'0','admin','2024-09-04 06:22:51','admin','2024-09-09 11:55:13','','0'),(4,'user','普通员工',4,'0','admin','2024-09-04 06:22:51','admin','2024-09-09 11:53:31','','0');
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1',1,1,'0','0','admin','2024-09-04 06:22:51','',NULL,'超级管理员'),(2,'普通角色','common',2,'2',1,1,'0','0','admin','2024-09-04 06:22:51','admin','2025-10-25 21:22:14','普通角色');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='角色和部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
INSERT INTO `sys_role_dept` VALUES (2,100),(2,101),(2,105);
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (2,1),(2,100),(2,101),(2,102),(2,103),(2,104),(2,105),(2,106),(2,107),(2,108),(2,500),(2,501),(2,1000),(2,1001),(2,1002),(2,1003),(2,1004),(2,1005),(2,1006),(2,1007),(2,1008),(2,1009),(2,1010),(2,1011),(2,1012),(2,1013),(2,1014),(2,1015),(2,1016),(2,1017),(2,1018),(2,1019),(2,1020),(2,1021),(2,1022),(2,1023),(2,1024),(2,1025),(2,1026),(2,1027),(2,1028),(2,1029),(2,1030),(2,1031),(2,1032),(2,1033),(2,1034),(2,1035),(2,1036),(2,1037),(2,1038),(2,1039),(2,1040),(2,1041),(2,1042),(2,1043),(2,1044),(2,1045);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,103,'admin','CQUET','00','CQUET@163.com','15888888888','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2025-11-17 14:37:18','admin','2024-09-04 06:22:51',NULL,'2025-11-17 14:37:18','管理员'),(2,105,'ry','测试','00','ry@qq.com','15666666666','1','','$2a$10$TZh50TgviSV8zEftiwy7ZuNHrdw7a.yloDmWLbNSDO1PSTacSvLRG','0','0','127.0.0.1','2025-10-25 21:23:26','admin','2024-09-04 06:22:51',NULL,'2025-10-25 21:23:26','测试员1'),(105,NULL,'liyuan','liyuan','00','','','0','','$2a$10$tgq/ctqpuY/moLaKttk/peQyxTfsy1X7nRW3MVYNCZYIuNvbqfVGK','0','0','127.0.0.1','2025-11-14 17:03:38',NULL,'2025-10-27 15:12:23',NULL,'2025-11-14 17:03:38',NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户与岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1),(2,2),(2,3);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_activity`
--

DROP TABLE IF EXISTS `tourism_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourism_activity` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '活动ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '活动名称',
  `cover_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '活动封面图片URL',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '活动类别（文化体验、艺术表演、教育活动等）',
  `venue_id` bigint DEFAULT NULL COMMENT '举办场馆ID',
  `organizer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '主办方',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '联系电话',
  `start_time` datetime DEFAULT NULL COMMENT '活动开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '活动结束时间',
  `registration_start` datetime DEFAULT NULL COMMENT '报名开始时间',
  `registration_end` datetime DEFAULT NULL COMMENT '报名结束时间',
  `max_participants` int DEFAULT '0' COMMENT '最大参与人数（0表示不限制）',
  `current_participants` int DEFAULT '0' COMMENT '当前报名人数',
  `fee` decimal(10,2) DEFAULT '0.00' COMMENT '活动费用（0表示免费）',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '活动详细介绍',
  `requirements` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '参与要求',
  `view_count` int DEFAULT '0' COMMENT '浏览次数',
  `comment_count` int DEFAULT '0' COMMENT '评论次数',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `audit_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '审核状态（0待审核 1审核通过 2审核拒绝）',
  `audit_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '审核意见',
  `auditor` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '审核人',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_name` (`name`) USING BTREE,
  KEY `idx_category` (`category`) USING BTREE,
  KEY `idx_venue_id` (`venue_id`) USING BTREE,
  KEY `idx_start_time` (`start_time`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_audit_status` (`audit_status`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE,
  CONSTRAINT `fk_activity_venue` FOREIGN KEY (`venue_id`) REFERENCES `tourism_venue` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='特色活动信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_activity`
--

LOCK TABLES `tourism_activity` WRITE;
/*!40000 ALTER TABLE `tourism_activity` DISABLE KEYS */;
INSERT INTO `tourism_activity` VALUES (1,'测试001','1','文化体验',1,'测试001','12344556677','2025-11-16 16:52:45','2025-11-15 16:52:48','2025-11-15 16:52:53','2025-11-15 16:52:54',0,0,0.00,NULL,NULL,0,0,'0','1','内容完整，予以通过','admin',NULL,'',NULL,'admin','2025-11-17 11:12:36','内容完整，予以通过','0'),(7,'重庆非遗展览季','https://cdn.example.com/images/feiyi-expo.jpg','展览',1,'重庆市文化和旅游委员会','13800138000','2025-12-01 09:00:00','2025-12-15 17:30:00',NULL,NULL,0,0,0.00,'集中展示川渝地区非遗项目与工艺，含互动体验。',NULL,0,0,'1','2','资料不完整','admin',NULL,'admin','2025-11-15 17:58:32','admin','2025-11-17 11:12:51','资料不完整','0'),(8,'重庆非遗展览季','https://cdn.example.com/images/feiyi-expo.jpg','展览',1,'重庆市文化和旅游委员会','13800138000','2025-12-01 09:00:00','2025-12-15 17:30:00',NULL,NULL,0,0,0.00,'集中展示川渝地区非遗项目与工艺，含互动体验。',NULL,0,0,'0','1','内容完整，予以通过','admin',NULL,'admin','2025-11-15 17:58:34','','2025-11-17 11:46:37','','0');
/*!40000 ALTER TABLE `tourism_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_activity_application`
--

DROP TABLE IF EXISTS `tourism_activity_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourism_activity_application` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '报名ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `applicant_id` bigint NOT NULL COMMENT '报名用户ID',
  `applicant_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '报名人姓名',
  `applicant_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '报名人电话',
  `application_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '报名理由',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '报名状态（0待审核 1审核通过 2审核拒绝 3已取消）',
  `audit_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '审核意见',
  `auditor` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '审核人',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_activity_applicant` (`activity_id`,`applicant_id`) USING BTREE,
  KEY `idx_activity_id` (`activity_id`) USING BTREE,
  KEY `idx_applicant_id` (`applicant_id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE,
  CONSTRAINT `fk_application_activity` FOREIGN KEY (`activity_id`) REFERENCES `tourism_activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_application_user` FOREIGN KEY (`applicant_id`) REFERENCES `sys_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='特色活动报名表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_activity_application`
--

LOCK TABLES `tourism_activity_application` WRITE;
/*!40000 ALTER TABLE `tourism_activity_application` DISABLE KEYS */;
/*!40000 ALTER TABLE `tourism_activity_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_activity_comment`
--

DROP TABLE IF EXISTS `tourism_activity_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourism_activity_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `user_id` bigint NOT NULL COMMENT '评论用户ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '评论用户名',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '评论内容',
  `parent_id` bigint DEFAULT '0' COMMENT '父评论ID（0表示顶级评论）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_activity_id` (`activity_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_parent_id` (`parent_id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE,
  CONSTRAINT `fk_comment_activity` FOREIGN KEY (`activity_id`) REFERENCES `tourism_activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comment_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='活动评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_activity_comment`
--

LOCK TABLES `tourism_activity_comment` WRITE;
/*!40000 ALTER TABLE `tourism_activity_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `tourism_activity_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_facilities`
--

DROP TABLE IF EXISTS `tourism_facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourism_facilities` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '设备主键',
  `facilities` text NOT NULL COMMENT '设备名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='设备信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_facilities`
--

LOCK TABLES `tourism_facilities` WRITE;
/*!40000 ALTER TABLE `tourism_facilities` DISABLE KEYS */;
INSERT INTO `tourism_facilities` VALUES (1,'游泳池'),(2,'电视机'),(3,'笔记本电脑');
/*!40000 ALTER TABLE `tourism_facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_image`
--

DROP TABLE IF EXISTS `tourism_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourism_image` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '图片主键',
  `image_url` varchar(255) NOT NULL COMMENT '图片URL地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='旅游图片信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_image`
--

LOCK TABLES `tourism_image` WRITE;
/*!40000 ALTER TABLE `tourism_image` DISABLE KEYS */;
INSERT INTO `tourism_image` VALUES (1,'1.jpg'),(2,'2.jpg'),(3,'1.jpg'),(4,'2.jpg'),(5,'3.jpg'),(6,'1.jpg'),(7,'2.jpg'),(8,'3.jpg'),(9,'1.jpg');
/*!40000 ALTER TABLE `tourism_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_news`
--

DROP TABLE IF EXISTS `tourism_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourism_news` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '新闻内容',
  `author` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '作者',
  `create_time` datetime DEFAULT NULL COMMENT '发布时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '修改者',
  `del_flag` int DEFAULT NULL COMMENT '删除标识（0：存在，2：删除）',
  `status` int DEFAULT NULL COMMENT '状态（0：正常，1：停用）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='旅游项目表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_news`
--

LOCK TABLES `tourism_news` WRITE;
/*!40000 ALTER TABLE `tourism_news` DISABLE KEYS */;
INSERT INTO `tourism_news` VALUES (1,'测试标题001（修改后）','测试内容001（修改后）','测试作者001（修改后）','2025-10-28 19:55:09','liyuan','2025-11-04 16:28:01','admin',2,NULL,NULL),(2,'测试标题002','测试内容002','测试作者002','2025-10-29 10:41:38','liyuan','2025-11-04 16:28:01','admin',2,NULL,NULL),(3,'测试标题003','测试内容003','测试作者003','2025-10-29 10:41:46','liyuan',NULL,NULL,0,NULL,NULL),(4,'测试标题004','测试内容004','测试作者004','2025-10-29 10:41:52','liyuan',NULL,NULL,0,NULL,NULL),(5,'测试标题005','测试内容005','测试作者005','2025-10-29 10:41:59','liyuan','2025-10-29 10:58:59','liyuan',2,NULL,NULL),(6,'测试标题006','测试内容006','测试作者006','2025-10-29 10:42:09','liyuan','2025-10-29 10:58:59','liyuan',2,NULL,NULL),(7,'测试标题007','测试内容007','测试作者007','2025-10-29 10:42:16','liyuan','2025-10-29 10:58:27','liyuan',2,NULL,NULL),(8,'测试标题001（修改后）','测试内容001（修改后）','测试作者001（修改后）','2025-11-04 16:39:43','admin','2025-11-17 11:39:29','admin',0,NULL,'适当放松的地方是的');
/*!40000 ALTER TABLE `tourism_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_notice`
--

DROP TABLE IF EXISTS `tourism_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourism_notice` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '公告标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '公告内容',
  `create_time` datetime DEFAULT NULL COMMENT '发布时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '发布人（创建者）',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '修改者',
  `del_flag` int DEFAULT NULL COMMENT '删除标识（0：存在，2：删除）',
  `status` int DEFAULT NULL COMMENT '状态（0：正常，1：停用）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='通知公告管理表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_notice`
--

LOCK TABLES `tourism_notice` WRITE;
/*!40000 ALTER TABLE `tourism_notice` DISABLE KEYS */;
INSERT INTO `tourism_notice` VALUES (1,'测试001','测试001','2025-11-17 11:30:54','测试001','2025-11-17 11:31:05','测试001',0,0,'测试001'),(2,'测试标题003','测试内容003','2025-11-17 11:35:37','admin','2025-11-17 11:37:48','admin',2,NULL,NULL);
/*!40000 ALTER TABLE `tourism_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_scenic_spot`
--

DROP TABLE IF EXISTS `tourism_scenic_spot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourism_scenic_spot` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '景区ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '景区名称',
  `level` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'A' COMMENT '景区等级（A、AA、AAA、AAAA、AAAAA）',
  `cover_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '封面图片URL',
  `ticket_price` decimal(10,2) DEFAULT '0.00' COMMENT '门票价格',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '景区地址',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '所在城市',
  `district` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '所在区县',
  `opening_hours` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '开放时间',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '联系电话',
  `website` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '官方网站',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '景区介绍',
  `longitude` decimal(10,7) DEFAULT NULL COMMENT '经度',
  `latitude` decimal(10,7) DEFAULT NULL COMMENT '纬度',
  `collection_count` int DEFAULT '0' COMMENT '收藏次数',
  `view_count` int DEFAULT '0' COMMENT '浏览次数',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_name` (`name`) USING BTREE,
  KEY `idx_level` (`level`) USING BTREE,
  KEY `idx_city` (`city`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='A级景区信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_scenic_spot`
--

LOCK TABLES `tourism_scenic_spot` WRITE;
/*!40000 ALTER TABLE `tourism_scenic_spot` DISABLE KEYS */;
INSERT INTO `tourism_scenic_spot` VALUES (22,'测试004','AAAA','/profile/upload/2025/11/10/屏幕截图 2025-05-24 192846_20251110152946A016.png',50.00,'大学城东路76号','北京','','','13408206603','',NULL,0.0000000,0.0000000,0,0,'0','admin','2025-11-10 15:29:52','admin','2025-11-11 16:12:05','1111','0'),(23,'九寨沟风景名胜区','5A','',169.00,'四川省阿坝藏族羌族自治州九寨沟县','阿坝州','九寨沟县','08:00-18:00','','','九寨沟是世界自然遗产、国家重点风景名胜区、国家AAAAA级旅游景区、国家级自然保护区、国家地质公园、世界生物圈保护区网络，是中国第一个以保护自然风景为主要目的的自然保护区。',103.9180000,33.2540000,0,0,'0','admin','2025-11-14 17:14:16','',NULL,NULL,'0'),(24,'测试001','AAA','',0.00,'测试001','测试001','','','','','测试001',NULL,NULL,0,0,'0','admin','2025-11-14 17:57:56','',NULL,NULL,'0');
/*!40000 ALTER TABLE `tourism_scenic_spot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_scenic_spot_image`
--

DROP TABLE IF EXISTS `tourism_scenic_spot_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourism_scenic_spot_image` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '关联记录主键',
  `scenic_spot_id` bigint NOT NULL COMMENT '关联的旅游景区ID（外键）',
  `image_id` int NOT NULL COMMENT '关联的图片ID（外键）',
  `sort` int DEFAULT '0' COMMENT '图片排序序号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_venue_image` (`scenic_spot_id`,`image_id`),
  KEY `image_id` (`image_id`),
  CONSTRAINT `tourism_scenic_spot_image_ibfk_1` FOREIGN KEY (`scenic_spot_id`) REFERENCES `tourism_scenic_spot` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tourism_scenic_spot_image_ibfk_2` FOREIGN KEY (`image_id`) REFERENCES `tourism_image` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='旅游景区-图片关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_scenic_spot_image`
--

LOCK TABLES `tourism_scenic_spot_image` WRITE;
/*!40000 ALTER TABLE `tourism_scenic_spot_image` DISABLE KEYS */;
INSERT INTO `tourism_scenic_spot_image` VALUES (1,22,1,1);
/*!40000 ALTER TABLE `tourism_scenic_spot_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_user_collection`
--

DROP TABLE IF EXISTS `tourism_user_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourism_user_collection` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `target_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收藏目标类型（scenic_spot、venue、activity）',
  `target_id` bigint NOT NULL COMMENT '收藏目标ID',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_user_target` (`user_id`,`target_type`,`target_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_target_type` (`target_type`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE,
  CONSTRAINT `fk_collection_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户收藏信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_user_collection`
--

LOCK TABLES `tourism_user_collection` WRITE;
/*!40000 ALTER TABLE `tourism_user_collection` DISABLE KEYS */;
/*!40000 ALTER TABLE `tourism_user_collection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_venue`
--

DROP TABLE IF EXISTS `tourism_venue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourism_venue` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '场馆ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '场馆名称',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '场馆类别（博物馆、图书馆、文化馆、剧院等）',
  `cover_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '封面图片URL',
  `ticket_price` decimal(10,2) DEFAULT '0.00' COMMENT '门票价格（0表示免费）',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '场馆地址',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '所在城市',
  `district` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '所在区县',
  `opening_hours` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '开放时间',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '联系电话',
  `website` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '官方网站',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '场馆介绍',
  `longitude` decimal(10,7) DEFAULT NULL COMMENT '经度',
  `latitude` decimal(10,7) DEFAULT NULL COMMENT '纬度',
  `capacity` int DEFAULT '0' COMMENT '容纳人数',
  `booking_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '是否需要预约（0不需要 1需要）',
  `collection_count` int DEFAULT '0' COMMENT '收藏次数',
  `view_count` int DEFAULT '0' COMMENT '浏览次数',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_name` (`name`) USING BTREE,
  KEY `idx_category` (`category`) USING BTREE,
  KEY `idx_city` (`city`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='场馆信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_venue`
--

LOCK TABLES `tourism_venue` WRITE;
/*!40000 ALTER TABLE `tourism_venue` DISABLE KEYS */;
INSERT INTO `tourism_venue` VALUES (1,'重庆中国三峡博物馆','博物馆','/images/sanxia_museum_cover.jpg',0.00,'重庆市渝中区人民路236号','重庆市','渝中区','09:00-17:00（周一闭馆）','023-63679066','http://www.3gmuseum.cn','重庆中国三峡博物馆是首批国家一级博物馆，展示了三峡历史文化和重庆地方历史文化。',106.5584200,29.5562700,2000,'0',0,0,'0','admin','2025-11-02 12:19:13','',NULL,'国家一级博物馆','0'),(2,'重庆图书馆','图书馆','/images/cq_library_cover.jpg',0.00,'重庆市沙坪坝区凤天大道106号','重庆市','沙坪坝区','09:00-21:00','023-65210070','http://www.cqlib.cn','重庆图书馆是重庆市综合性研究型公共图书馆，为市民提供文献借阅、信息咨询、文化活动等服务。',106.4321000,29.5412000,3000,'1',0,0,'0','admin','2025-11-02 12:19:13','',NULL,'市级综合图书馆','0'),(3,'重庆科技馆','科技馆','',20.00,'重庆市渝北区黄山大道中段','','','','12345432213','http://www.cqstm.org.cn','重庆科技馆是重庆市重要的科普教育基地',NULL,NULL,0,'0',0,0,'0','liyuan','2025-11-11 19:07:46','',NULL,NULL,'0'),(4,'场馆名称','场馆类别','封面图片URL',20.00,'详细地址','','','','13345667788','官方网站','场馆描述',106.1234560,29.1234560,0,'0',0,0,'1','liyuan','2025-11-11 19:55:34','',NULL,NULL,'0'),(5,'重庆科技馆1','科技馆','http://example.com/images/venue1.jpg',0.00,'重庆市渝北区黄山大道中段','','','','12345678890','http://www.cqstm.org.cn','重庆科技馆是重庆市重要的科普教育基地',106.1234560,29.1234560,0,'0',0,0,'1','liyuan','2025-11-11 19:56:37','liyuan','2025-11-12 10:57:47',NULL,'2'),(6,'重庆科技馆2','科技馆','http://example.com/images/venue1.jpg',0.00,'重庆市渝北区黄山大道中段','','','','12345678890','http://www.cqstm.org.cn','重庆科技馆是重庆市重要的科普教育基地',106.1234560,29.1234560,0,'0',0,0,'1','liyuan','2025-11-12 10:58:09','',NULL,NULL,'0'),(7,'重庆科技馆3','科技馆','http://example.com/images/venue1.jpg',0.00,'重庆市渝北区黄山大道中段','','','','12345678890','http://www.cqstm.org.cn','重庆科技馆是重庆市重要的科普教育基地',106.1234560,29.1234560,0,'0',0,0,'1','admin','2025-11-17 11:44:30','',NULL,NULL,'0');
/*!40000 ALTER TABLE `tourism_venue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_venue_facilities`
--

DROP TABLE IF EXISTS `tourism_venue_facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourism_venue_facilities` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '关联记录主键',
  `venue_id` bigint NOT NULL COMMENT '关联的场馆ID（外键）',
  `facilities_id` int NOT NULL COMMENT '关联的设备ID（外键）',
  `sort` int DEFAULT '0' COMMENT '设备排序序号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_venue_facilities` (`venue_id`,`facilities_id`),
  KEY `facilities_id` (`facilities_id`),
  CONSTRAINT `tourism_venue_facilities_ibfk_1` FOREIGN KEY (`venue_id`) REFERENCES `tourism_venue` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tourism_venue_facilities_ibfk_2` FOREIGN KEY (`facilities_id`) REFERENCES `tourism_facilities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='场馆设备-关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_venue_facilities`
--

LOCK TABLES `tourism_venue_facilities` WRITE;
/*!40000 ALTER TABLE `tourism_venue_facilities` DISABLE KEYS */;
INSERT INTO `tourism_venue_facilities` VALUES (1,1,1,1),(2,1,2,2);
/*!40000 ALTER TABLE `tourism_venue_facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_venue_image`
--

DROP TABLE IF EXISTS `tourism_venue_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourism_venue_image` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '关联记录主键',
  `venue_id` bigint NOT NULL COMMENT '关联的旅游场馆ID（外键）',
  `image_id` int NOT NULL COMMENT '关联的图片ID（外键）',
  `sort` int DEFAULT '0' COMMENT '图片排序序号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_venue_image` (`venue_id`,`image_id`),
  KEY `image_id` (`image_id`),
  CONSTRAINT `tourism_venue_image_ibfk_1` FOREIGN KEY (`venue_id`) REFERENCES `tourism_venue` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tourism_venue_image_ibfk_2` FOREIGN KEY (`image_id`) REFERENCES `tourism_image` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='旅游场馆-图片关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_venue_image`
--

LOCK TABLES `tourism_venue_image` WRITE;
/*!40000 ALTER TABLE `tourism_venue_image` DISABLE KEYS */;
INSERT INTO `tourism_venue_image` VALUES (1,1,2,1);
/*!40000 ALTER TABLE `tourism_venue_image` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-17 15:17:40
