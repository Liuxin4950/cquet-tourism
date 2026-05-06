-- MySQL dump 10.13  Distrib 5.7.26, for Win64 (x86_64)
--
-- Host: localhost    Database: ruoyi
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,0,'0','寰宇文旅公司',0,'Liuxin','18983432250','liuxin@qq.com','0','0','admin','2024-09-04 06:22:51','admin','2026-05-06 15:32:41',NULL),(101,100,'0,100','重庆文旅公司',1,'liuxin','18983432250','1371149587@qq.com','0','0','admin','2024-09-04 06:22:51','admin','2026-05-06 15:33:24',NULL),(102,100,'0,100','长沙分公司',2,'CQUET','15888888888','XX@qq.com','0','2','admin','2024-09-04 06:22:51','',NULL,NULL),(103,101,'0,100,101','研发部门',1,'CQUET','15888888888','XX@qq.com','0','2','admin','2024-09-04 06:22:51','',NULL,NULL),(104,101,'0,100,101','市场部门',2,'CQUET','15888888888','XX@qq.com','0','2','admin','2024-09-04 06:22:51','',NULL,NULL),(105,101,'0,100,101','测试部门',3,'CQUET','15888888888','XX@qq.com','0','2','admin','2024-09-04 06:22:51','',NULL,NULL),(106,101,'0,100,101','财务部门',4,'CQUET','15888888888','XX@qq.com','0','2','admin','2024-09-04 06:22:51','',NULL,NULL),(107,101,'0,100,101','运维部门',5,'CQUET','15888888888','XX@qq.com','0','2','admin','2024-09-04 06:22:51','',NULL,NULL),(108,102,'0,100,102','市场部门',1,'CQUET','15888888888','XX@qq.com','0','2','admin','2024-09-04 06:22:51','',NULL,NULL),(109,102,'0,100,102','财务部门',2,'CQUET','15888888888','XX@qq.com','0','2','admin','2024-09-04 06:22:51','',NULL,NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (40,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-10-27 14:39:41','2025-10-27 14:39:41',0,NULL),(41,'liyuan','127.0.0.1','内网IP','Chrome 14','Windows 10','0','注册成功','2025-10-27 15:12:23','2025-10-27 15:12:23',0,NULL),(42,'admin','127.0.0.1','内网IP','Unknown','Unknown','1','用户不存在/密码错误','2025-10-27 15:12:54','2025-10-27 15:12:54',0,NULL),(43,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-10-27 15:13:01','2025-10-27 15:13:01',0,NULL),(44,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-10-27 15:13:26','2025-10-27 15:13:26',0,NULL),(45,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-10-27 15:15:01','2025-10-27 15:15:01',0,NULL),(46,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-10-28 15:59:01','2025-10-28 15:59:01',0,NULL),(47,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2025-10-28 16:16:53','2025-10-28 16:16:53',0,NULL),(48,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-10-28 16:16:55','2025-10-28 16:16:55',0,NULL),(49,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-10-28 19:44:05','2025-10-28 19:44:05',0,NULL),(50,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-10-28 19:51:00','2025-10-28 19:51:00',0,NULL),(51,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-10-29 10:31:22','2025-10-29 10:31:22',0,NULL),(52,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-10-29 10:49:14','2025-10-29 10:49:14',0,NULL),(53,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-02 18:51:16','2025-11-02 18:51:16',0,NULL),(54,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-03 10:37:01','2025-11-03 10:37:01',0,NULL),(55,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-03 14:21:59','2025-11-03 14:21:59',0,NULL),(56,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-04 16:24:13','2025-11-04 16:24:13',0,NULL),(57,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-09 21:37:49','2025-11-09 21:37:49',0,NULL),(58,'admin','127.0.0.1','内网IP','Mozilla','Windows 10','0','登录成功','2025-11-09 22:08:55','2025-11-09 22:08:55',0,NULL),(59,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-09 22:13:24','2025-11-09 22:13:24',0,NULL),(60,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-10 14:00:09','2025-11-10 14:00:09',0,NULL),(61,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-10 15:23:26','2025-11-10 15:23:26',0,NULL),(62,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-11 16:10:52','2025-11-11 16:10:52',0,NULL),(63,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-11 18:28:09','2025-11-11 18:28:09',0,NULL),(64,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-11 19:45:08','2025-11-11 19:45:08',0,NULL),(65,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-11 19:54:56','2025-11-11 19:54:56',0,NULL),(66,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-12 10:53:19','2025-11-12 10:53:19',0,NULL),(67,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-12 10:56:35','2025-11-12 10:56:35',0,NULL),(68,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 11:37:32','2025-11-12 11:37:32',0,NULL),(69,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-12 11:37:57','2025-11-12 11:37:57',0,NULL),(70,'liyuan','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-14 17:03:38','2025-11-14 17:03:38',0,NULL),(71,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-14 17:04:19','2025-11-14 17:04:19',0,NULL),(72,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2025-11-14 17:04:25','2025-11-14 17:04:25',0,NULL),(73,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 17:05:48','2025-11-14 17:05:48',0,NULL),(74,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-14 17:06:08','2025-11-14 17:06:08',0,NULL),(75,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 17:56:29','2025-11-14 17:56:29',0,NULL),(76,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-14 18:08:00','2025-11-14 18:08:00',0,NULL),(77,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-14 22:01:46','2025-11-14 22:01:46',0,NULL),(78,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-14 22:30:34','2025-11-14 22:30:34',0,NULL),(79,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-14 23:21:01','2025-11-14 23:21:01',0,NULL),(80,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-14 23:57:49','2025-11-14 23:57:49',0,NULL),(81,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-15 16:18:29','2025-11-15 16:18:29',0,NULL),(82,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-11-15 16:25:33','2025-11-15 16:25:33',0,NULL),(83,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-15 16:27:40','2025-11-15 16:27:40',0,NULL),(84,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-15 17:29:32','2025-11-15 17:29:32',0,NULL),(85,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-15 17:32:32','2025-11-15 17:32:32',0,NULL),(86,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-15 17:43:39','2025-11-15 17:43:39',0,NULL),(87,'admin','127.0.0.1','内网IP','Unknown','Unknown','0','登录成功','2025-11-15 18:11:54','2025-11-15 18:11:54',0,NULL),(88,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-16 23:35:10','2025-11-16 23:35:10',0,NULL),(89,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-16 23:43:42','2025-11-16 23:43:42',0,NULL),(90,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-16 23:55:27','2025-11-16 23:55:27',0,NULL),(91,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-17 15:01:31','2025-11-17 15:01:31',0,NULL),(92,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-17 15:28:22','2025-11-17 15:28:22',0,NULL),(93,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-17 16:06:31','2025-11-17 16:06:31',0,NULL),(94,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-18 15:30:13','2025-11-18 15:30:13',0,NULL),(95,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-18 18:01:24','2025-11-18 18:01:24',0,NULL),(96,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-18 20:15:09','2025-11-18 20:15:09',0,NULL),(97,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-19 10:44:04','2025-11-19 10:44:04',0,NULL),(98,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-19 12:06:02','2025-11-19 12:06:02',0,NULL),(99,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-11-19 14:10:48','2025-11-19 14:10:48',0,NULL),(100,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2026-03-24 22:22:23','2026-03-24 22:22:23',0,NULL),(101,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2026-03-24 22:22:30','2026-03-24 22:22:30',0,NULL),(102,'liuxin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','注册成功','2026-03-24 22:22:39','2026-03-24 22:22:39',0,NULL),(103,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','用户不存在/密码错误','2026-03-24 22:22:44','2026-03-24 22:22:44',0,NULL),(104,'liuxin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-03-24 22:22:48','2026-03-24 22:22:48',0,NULL),(105,'liuxin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2026-03-24 22:23:59','2026-03-24 22:23:59',0,NULL),(106,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-03-24 22:24:06','2026-03-24 22:24:06',0,NULL),(107,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-03-24 22:41:47','2026-03-24 22:41:47',0,NULL),(108,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-03-25 00:32:52','2026-03-25 00:32:52',0,NULL),(109,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-03-25 16:31:02','2026-03-25 16:31:02',0,NULL),(110,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-03-25 22:00:37','2026-03-25 22:00:37',0,NULL),(111,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-04-18 18:28:02','2026-04-18 18:28:02',0,NULL),(112,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-04-18 21:20:09','2026-04-18 21:20:09',0,NULL),(113,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-04-18 22:26:23','2026-04-18 22:26:23',0,NULL),(114,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-04-21 15:14:40','2026-04-21 15:14:40',0,NULL),(115,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-04-21 16:25:14','2026-04-21 16:25:14',0,NULL),(116,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-04-21 17:42:13','2026-04-21 17:42:13',0,NULL),(117,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-04-21 20:02:06','2026-04-21 20:02:06',0,NULL),(118,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-04-22 13:50:51','2026-04-22 13:50:51',0,NULL),(119,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-04-22 13:59:54','2026-04-22 13:59:54',0,NULL),(120,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-04-22 14:27:22','2026-04-22 14:27:22',0,NULL),(121,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-05-06 15:06:11','2026-05-06 15:06:11',0,NULL),(122,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-05-06 15:08:24','2026-05-06 15:08:24',0,NULL),(123,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','退出成功','2026-05-06 15:34:54','2026-05-06 15:34:54',0,NULL),(124,'pt','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2026-05-06 15:35:04','2026-05-06 15:35:04',0,NULL);
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,3,'system',NULL,'','',1,0,'M','0','0','','system','admin','2024-09-04 06:22:51','admin','2026-05-06 07:56:22','系统管理目录',0),(2,'系统监控',0,4,'monitor',NULL,'','',1,0,'M','0','0','','monitor','admin','2024-09-04 06:22:51','admin','2026-05-06 07:56:22','系统监控目录',0),(3,'系统工具',0,5,'tool',NULL,'','',1,0,'M','0','0','','tool','admin','2024-09-04 06:22:51','admin','2026-05-06 07:56:22','系统工具目录',0),(100,'用户管理',1,1,'user','system/user/index','','',1,0,'C','0','0','system:user:list','user','admin','2024-09-04 06:22:51','',NULL,'用户管理菜单',0),(101,'角色管理',1,2,'role','system/role/index','','',1,0,'C','0','0','system:role:list','peoples','admin','2024-09-04 06:22:51','',NULL,'角色管理菜单',0),(102,'菜单管理',1,3,'menu','system/menu/index','','',1,0,'C','0','0','system:menu:list','tree-table','admin','2024-09-04 06:22:51','',NULL,'菜单管理菜单',0),(103,'部门管理',1,4,'dept','system/dept/index','','',1,0,'C','0','0','system:dept:list','tree','admin','2024-09-04 06:22:51','',NULL,'部门管理菜单',0),(104,'岗位管理',1,5,'post','system/post/index','','',1,0,'C','0','0','system:post:list','post','admin','2024-09-04 06:22:51','',NULL,'岗位管理菜单',0),(105,'字典管理',1,6,'dict','system/dict/index','','',1,0,'C','0','0','system:dict:list','dict','admin','2024-09-04 06:22:51','',NULL,'字典管理菜单',0),(106,'参数设置',1,7,'config','system/config/index','','',1,0,'C','0','0','system:config:list','edit','admin','2024-09-04 06:22:51','',NULL,'参数设置菜单',0),(107,'通知公告',1,8,'notice','system/notice/index','','',1,0,'C','0','0','system:notice:list','message','admin','2024-09-04 06:22:51','',NULL,'通知公告菜单',0),(108,'日志管理',1,9,'log','','','',1,0,'M','0','0','','log','admin','2024-09-04 06:22:51','',NULL,'日志管理菜单',0),(109,'在线用户',2,1,'online','monitor/online/index','','',1,0,'C','0','0','monitor:online:list','online','admin','2024-09-04 06:22:51','',NULL,'在线用户菜单',0),(111,'数据监控',2,3,'druid','monitor/druid/index','','',1,0,'C','0','0','monitor:druid:list','druid','admin','2024-09-04 06:22:51','',NULL,'数据监控菜单',0),(112,'服务监控',2,4,'server','monitor/server/index','','',1,0,'C','0','0','monitor:server:list','server','admin','2024-09-04 06:22:51','',NULL,'服务监控菜单',0),(113,'缓存监控',2,5,'cache','monitor/cache/index','','',1,0,'C','0','0','monitor:cache:list','redis','admin','2024-09-04 06:22:51','',NULL,'缓存监控菜单',0),(114,'缓存列表',2,6,'cacheList','monitor/cache/list','','',1,0,'C','0','0','monitor:cache:list','redis-list','admin','2024-09-04 06:22:51','',NULL,'缓存列表菜单',0),(115,'表单构建',3,1,'build','tool/build/index','','',1,0,'C','0','0','tool:build:list','build','admin','2024-09-04 06:22:51','',NULL,'表单构建菜单',0),(116,'代码生成',3,2,'gen','tool/gen/index','','',1,0,'C','0','0','tool:gen:list','code','admin','2024-09-04 06:22:51','',NULL,'代码生成菜单',0),(117,'系统接口',3,3,'swagger','tool/swagger/index','','',1,0,'C','0','0','tool:swagger:list','swagger','admin','2024-09-04 06:22:51','',NULL,'系统接口菜单',0),(500,'操作日志',108,1,'operlog','monitor/operlog/index','','',1,0,'C','0','0','monitor:operlog:list','form','admin','2024-09-04 06:22:51','',NULL,'操作日志菜单',0),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','','',1,0,'C','0','0','monitor:logininfor:list','logininfor','admin','2024-09-04 06:22:51','',NULL,'登录日志菜单',0),(1000,'用户查询',100,1,'','','','',1,0,'F','0','0','system:user:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1001,'用户新增',100,2,'','','','',1,0,'F','0','0','system:user:add','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1002,'用户修改',100,3,'','','','',1,0,'F','0','0','system:user:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1003,'用户删除',100,4,'','','','',1,0,'F','0','0','system:user:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1004,'用户导出',100,5,'','','','',1,0,'F','0','0','system:user:export','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1005,'用户导入',100,6,'','','','',1,0,'F','0','0','system:user:import','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1006,'重置密码',100,7,'','','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1007,'角色查询',101,1,'','','','',1,0,'F','0','0','system:role:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1008,'角色新增',101,2,'','','','',1,0,'F','0','0','system:role:add','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1009,'角色修改',101,3,'','','','',1,0,'F','0','0','system:role:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1010,'角色删除',101,4,'','','','',1,0,'F','0','0','system:role:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1011,'角色导出',101,5,'','','','',1,0,'F','0','0','system:role:export','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1012,'菜单查询',102,1,'','','','',1,0,'F','0','0','system:menu:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1013,'菜单新增',102,2,'','','','',1,0,'F','0','0','system:menu:add','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1014,'菜单修改',102,3,'','','','',1,0,'F','0','0','system:menu:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1015,'菜单删除',102,4,'','','','',1,0,'F','0','0','system:menu:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1016,'部门查询',103,1,'','','','',1,0,'F','0','0','system:dept:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1017,'部门新增',103,2,'','','','',1,0,'F','0','0','system:dept:add','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1018,'部门修改',103,3,'','','','',1,0,'F','0','0','system:dept:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1019,'部门删除',103,4,'','','','',1,0,'F','0','0','system:dept:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1020,'岗位查询',104,1,'','','','',1,0,'F','0','0','system:post:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1021,'岗位新增',104,2,'','','','',1,0,'F','0','0','system:post:add','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1022,'岗位修改',104,3,'','','','',1,0,'F','0','0','system:post:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1023,'岗位删除',104,4,'','','','',1,0,'F','0','0','system:post:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1024,'岗位导出',104,5,'','','','',1,0,'F','0','0','system:post:export','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1025,'字典查询',105,1,'#','','','',1,0,'F','0','0','system:dict:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1026,'字典新增',105,2,'#','','','',1,0,'F','0','0','system:dict:add','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1027,'字典修改',105,3,'#','','','',1,0,'F','0','0','system:dict:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1028,'字典删除',105,4,'#','','','',1,0,'F','0','0','system:dict:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1029,'字典导出',105,5,'#','','','',1,0,'F','0','0','system:dict:export','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1030,'参数查询',106,1,'#','','','',1,0,'F','0','0','system:config:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1031,'参数新增',106,2,'#','','','',1,0,'F','0','0','system:config:add','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1032,'参数修改',106,3,'#','','','',1,0,'F','0','0','system:config:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1033,'参数删除',106,4,'#','','','',1,0,'F','0','0','system:config:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1034,'参数导出',106,5,'#','','','',1,0,'F','0','0','system:config:export','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1035,'公告查询',107,1,'#','','','',1,0,'F','0','0','system:notice:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1036,'公告新增',107,2,'#','','','',1,0,'F','0','0','system:notice:add','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1037,'公告修改',107,3,'#','','','',1,0,'F','0','0','system:notice:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1038,'公告删除',107,4,'#','','','',1,0,'F','0','0','system:notice:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1039,'操作查询',500,1,'#','','','',1,0,'F','0','0','monitor:operlog:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1040,'操作删除',500,2,'#','','','',1,0,'F','0','0','monitor:operlog:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1041,'日志导出',500,3,'#','','','',1,0,'F','0','0','monitor:operlog:export','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1042,'登录查询',501,1,'#','','','',1,0,'F','0','0','monitor:logininfor:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1043,'登录删除',501,2,'#','','','',1,0,'F','0','0','monitor:logininfor:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1044,'日志导出',501,3,'#','','','',1,0,'F','0','0','monitor:logininfor:export','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1045,'账户解锁',501,4,'#','','','',1,0,'F','0','0','monitor:logininfor:unlock','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1046,'在线查询',109,1,'#','','','',1,0,'F','0','0','monitor:online:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1047,'批量强退',109,2,'#','','','',1,0,'F','0','0','monitor:online:batchLogout','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1048,'单条强退',109,3,'#','','','',1,0,'F','0','0','monitor:online:forceLogout','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1055,'生成查询',116,1,'#','','','',1,0,'F','0','0','tool:gen:query','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1056,'生成修改',116,2,'#','','','',1,0,'F','0','0','tool:gen:edit','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1057,'生成删除',116,3,'#','','','',1,0,'F','0','0','tool:gen:remove','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1058,'导入代码',116,4,'#','','','',1,0,'F','0','0','tool:gen:import','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1059,'预览代码',116,5,'#','','','',1,0,'F','0','0','tool:gen:preview','#','admin','2024-09-04 06:22:51','',NULL,'',0),(1060,'生成代码',116,6,'#','','','',1,0,'F','0','0','tool:gen:code','#','admin','2024-09-04 06:22:51','',NULL,'',0),(2072,'文旅管理',0,2,'tourism',NULL,NULL,'',1,0,'M','0','0',NULL,'guide','admin','2025-11-03 14:22:53','admin','2026-05-06 07:56:22','重庆景点管理系统主目录',0),(2073,'新闻管理',2072,8,'news','tourism/news/index','','TourismNews',1,0,'C','0','0','tourism:news:list','clipboard','admin','2025-11-03 14:24:01','admin','2026-05-06 15:22:45','',0),(2074,'景点管理',2072,2,'scenicSpot','tourism/scenicSpot/index',NULL,'TourismScenicSpot',1,0,'C','0','0','tourism:scenicSpot:list','guide','admin','2025-11-10 14:01:25','admin','2026-05-06 07:18:58','',0),(2075,'场馆管理',2072,3,'venue','tourism/venue/index',NULL,'TourismVenue',1,0,'C','0','0','tourism:venue:list','education','admin','2025-11-17 15:30:15','admin','2026-05-06 07:18:58','修正文旅场馆菜单权限',0),(2076,'活动管理',2072,5,'activity','tourism/activity/index',NULL,'TourismActivity',1,0,'C','0','0','tourism:activity:list','date','admin','2025-11-17 15:42:40','admin','2026-05-06 07:18:58','',0),(2077,'活动审核',2072,6,'activityApplication','tourism/activityApplication/index',NULL,'TourismActivityApplication',1,0,'C','0','0','tourism:activityApplication:list','edit','admin','2025-11-17 15:43:42','admin','2026-05-06 07:18:58','',0),(2078,'通知管理',2072,9,'notice','tourism/notice/index',NULL,'TourismNotice',1,0,'C','0','0','tourism:notice:list','message','admin','2025-11-17 15:45:01','admin','2026-05-06 07:18:58','',0),(2080,'数据大屏',0,1,'dashboard','tourism/dashboard/index','','TourismDashboard',1,0,'C','0','0','tourism:dashboard:statistics','dashboard','admin','2026-03-24 15:13:05','admin','2026-05-06 07:56:22','重庆文旅数据大屏一级入口',0),(2081,'设施管理',2072,4,'facilities','tourism/facilities/index',NULL,'TourismFacilities',1,0,'C','0','0','tourism:facilities:list','build','admin','2026-04-21 08:19:57','admin','2026-05-06 07:18:58','场馆设施管理页面',0),(2082,'图片管理',2072,7,'images','tourism/images/index',NULL,'TourismImages',1,0,'C','0','0','tourism:image:list','documentation','admin','2026-04-21 08:19:57','admin','2026-05-06 15:22:18','旅游图片管理页面',0),(2084,'查询',2073,1,'',NULL,NULL,'',1,0,'F','0','0','tourism:news:query','#','admin','2026-04-21 08:19:57','',NULL,'新闻详情按钮',0),(2085,'新增',2073,2,'',NULL,NULL,'',1,0,'F','0','0','tourism:news:add','#','admin','2026-04-21 08:19:57','',NULL,'新闻新增按钮',0),(2086,'修改',2073,3,'',NULL,NULL,'',1,0,'F','0','0','tourism:news:edit','#','admin','2026-04-21 08:19:57','',NULL,'新闻修改按钮',0),(2087,'删除',2073,4,'',NULL,NULL,'',1,0,'F','0','0','tourism:news:remove','#','admin','2026-04-21 08:19:57','',NULL,'新闻删除按钮',0),(2088,'查询',2074,1,'',NULL,NULL,'',1,0,'F','0','0','tourism:scenicSpot:query','#','admin','2026-04-21 08:19:57','',NULL,'景区详情按钮',0),(2089,'新增',2074,2,'',NULL,NULL,'',1,0,'F','0','0','tourism:scenicSpot:add','#','admin','2026-04-21 08:19:57','',NULL,'景区新增按钮',0),(2090,'修改',2074,3,'',NULL,NULL,'',1,0,'F','0','0','tourism:scenicSpot:edit','#','admin','2026-04-21 08:19:57','',NULL,'景区修改按钮',0),(2091,'删除',2074,4,'',NULL,NULL,'',1,0,'F','0','0','tourism:scenicSpot:remove','#','admin','2026-04-21 08:19:57','',NULL,'景区删除按钮',0),(2092,'图片列表',2074,5,'',NULL,NULL,'',1,0,'F','0','0','tourism:scenicSpot:image:list','#','admin','2026-04-21 08:19:57','',NULL,'景区图片列表权限',0),(2093,'图片维护',2074,6,'',NULL,NULL,'',1,0,'F','0','0','tourism:scenicSpot:image:edit','#','admin','2026-04-21 08:19:57','',NULL,'景区图片维护权限',0),(2094,'查询',2081,1,'',NULL,NULL,'',1,0,'F','0','0','tourism:facilities:query','#','admin','2026-04-21 08:19:57','',NULL,'设施详情按钮',0),(2095,'新增',2081,2,'',NULL,NULL,'',1,0,'F','0','0','tourism:facilities:add','#','admin','2026-04-21 08:19:57','',NULL,'设施新增按钮',0),(2096,'修改',2081,3,'',NULL,NULL,'',1,0,'F','0','0','tourism:facilities:edit','#','admin','2026-04-21 08:19:57','',NULL,'设施修改按钮',0),(2097,'删除',2081,4,'',NULL,NULL,'',1,0,'F','0','0','tourism:facilities:remove','#','admin','2026-04-21 08:19:57','',NULL,'设施删除按钮',0),(2098,'查询',2075,1,'',NULL,NULL,'',1,0,'F','0','0','tourism:venue:query','#','admin','2026-04-21 08:19:57','',NULL,'场馆详情按钮',0),(2099,'新增',2075,2,'',NULL,NULL,'',1,0,'F','0','0','tourism:venue:add','#','admin','2026-04-21 08:19:57','',NULL,'场馆新增按钮',0),(2100,'修改',2075,3,'',NULL,NULL,'',1,0,'F','0','0','tourism:venue:edit','#','admin','2026-04-21 08:19:57','',NULL,'场馆修改按钮',0),(2101,'删除',2075,4,'',NULL,NULL,'',1,0,'F','0','0','tourism:venue:remove','#','admin','2026-04-21 08:19:57','',NULL,'场馆删除按钮',0),(2102,'查看活动',2075,5,'',NULL,NULL,'',1,0,'F','0','0','tourism:venueActivity:list','#','admin','2026-04-21 08:19:57','',NULL,'场馆活动列表按钮',0),(2103,'图片列表',2075,6,'',NULL,NULL,'',1,0,'F','0','0','tourism:venue:image:list','#','admin','2026-04-21 08:19:57','',NULL,'场馆图片列表权限',0),(2104,'图片维护',2075,7,'',NULL,NULL,'',1,0,'F','0','0','tourism:venue:image:edit','#','admin','2026-04-21 08:19:57','',NULL,'场馆图片维护权限',0),(2105,'查询',2076,1,'',NULL,NULL,'',1,0,'F','0','0','tourism:activity:query','#','admin','2026-04-21 08:19:57','',NULL,'活动详情按钮',0),(2106,'新增',2076,2,'',NULL,NULL,'',1,0,'F','0','0','tourism:activity:add','#','admin','2026-04-21 08:19:57','',NULL,'活动新增按钮',0),(2107,'修改',2076,3,'',NULL,NULL,'',1,0,'F','0','0','tourism:activity:edit','#','admin','2026-04-21 08:19:57','',NULL,'活动修改按钮',0),(2108,'删除',2076,4,'',NULL,NULL,'',1,0,'F','0','0','tourism:activity:remove','#','admin','2026-04-21 08:19:57','',NULL,'活动删除按钮',0),(2109,'审核通过',2076,5,'',NULL,NULL,'',1,0,'F','0','0','tourism:activity:approve','#','admin','2026-04-21 08:19:57','',NULL,'活动审核通过权限',0),(2110,'审核拒绝',2076,6,'',NULL,NULL,'',1,0,'F','0','0','tourism:activity:reject','#','admin','2026-04-21 08:19:57','',NULL,'活动审核拒绝权限',0),(2111,'通过',2077,1,'',NULL,NULL,'',1,0,'F','0','0','tourism:activityApplication:approve','#','admin','2026-04-21 08:19:57','',NULL,'活动审批通过按钮',0),(2112,'拒绝',2077,2,'',NULL,NULL,'',1,0,'F','0','0','tourism:activityApplication:reject','#','admin','2026-04-21 08:19:57','',NULL,'活动审批拒绝按钮',0),(2113,'历史',2077,3,'',NULL,NULL,'',1,0,'F','0','0','tourism:activityApplication:history','#','admin','2026-04-21 08:19:57','',NULL,'活动审批历史按钮',0),(2114,'查询',2082,1,'',NULL,NULL,'',1,0,'F','0','0','tourism:image:query','#','admin','2026-04-21 08:19:57','',NULL,'图片详情按钮',0),(2115,'新增',2082,2,'',NULL,NULL,'',1,0,'F','0','0','tourism:image:add','#','admin','2026-04-21 08:19:57','',NULL,'图片新增按钮',0),(2116,'删除',2082,3,'',NULL,NULL,'',1,0,'F','0','0','tourism:image:remove','#','admin','2026-04-21 08:19:57','',NULL,'图片删除按钮',0),(2117,'查询',2078,1,'',NULL,NULL,'',1,0,'F','0','0','tourism:notice:query','#','admin','2026-04-21 08:19:57','',NULL,'公告详情按钮',0),(2118,'新增',2078,2,'',NULL,NULL,'',1,0,'F','0','0','tourism:notice:add','#','admin','2026-04-21 08:19:57','',NULL,'公告新增按钮',0),(2119,'修改',2078,3,'',NULL,NULL,'',1,0,'F','0','0','tourism:notice:edit','#','admin','2026-04-21 08:19:57','',NULL,'公告修改按钮',0),(2120,'删除',2078,4,'',NULL,NULL,'',1,0,'F','0','0','tourism:notice:remove','#','admin','2026-04-21 08:19:57','',NULL,'公告删除按钮',0),(2121,'区县分布',2080,1,'',NULL,NULL,'',1,0,'F','0','0','tourism:dashboard:district','#','admin','2026-04-21 08:19:57','',NULL,'数据大屏区县分布接口权限',0),(2122,'热度排行',2080,2,'',NULL,NULL,'',1,0,'F','0','0','tourism:dashboard:hotspot','#','admin','2026-04-21 08:19:57','',NULL,'数据大屏热度排行接口权限',0),(2123,'趋势分析',2080,3,'',NULL,NULL,'',1,0,'F','0','0','tourism:dashboard:trend','#','admin','2026-04-21 08:19:57','',NULL,'数据大屏趋势分析接口权限',0),(2124,'地图分布',2080,4,'',NULL,NULL,'',1,0,'F','0','0','tourism:dashboard:map','#','admin','2026-04-21 08:19:57','',NULL,'数据大屏地图接口权限',0);
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=322 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (114,'菜单管理',1,'cn.edu.cquet.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:22:53\",\"delFlag\":\"0\",\"icon\":\"online\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2072,\"menuName\":\"文旅管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"tourism\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,90,'2025-11-03 14:22:53',0,NULL),(115,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:22:53\",\"delFlag\":\"0\",\"icon\":\"online\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2072,\"menuName\":\"文旅管理\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"tourism\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:23:02\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,50,'2025-11-03 14:23:03',0,NULL),(116,'菜单管理',1,'cn.edu.cquet.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"query\":\"tourism/news\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,18,'2025-11-03 14:24:01',0,NULL),(117,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:25:18\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,19,'2025-11-03 14:25:18',0,NULL),(118,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:27:04\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,242,'2025-11-03 14:27:05',0,NULL),(119,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:28:26\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,40,'2025-11-03 14:28:26',0,NULL),(120,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:29:57\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,22,'2025-11-03 14:29:57',0,NULL),(121,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:30:14\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,34,'2025-11-03 14:30:14',0,NULL),(122,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:30:29\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,32,'2025-11-03 14:30:30',0,NULL),(123,'菜单管理',1,'cn.edu.cquet.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/scenicSpot/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-10 14:01:24\",\"delFlag\":\"0\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2074,\"menuName\":\"旅游景点\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:scenicSpot:list\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,30,'2025-11-10 14:01:25',0,NULL),(124,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/scenicSpot/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-10 14:01:25\",\"delFlag\":\"0\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2074,\"menuName\":\"旅游景点\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"tourisms\",\"perms\":\"tourism:scenicSpot:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-10 14:03:04\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,19,'2025-11-10 14:03:05',0,NULL),(125,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/scenicSpot/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-10 14:01:25\",\"delFlag\":\"0\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2074,\"menuName\":\"旅游景点\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"tourismspot\",\"perms\":\"tourism:scenicSpot:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-10 14:03:43\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,19,'2025-11-10 14:03:43',0,NULL),(126,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"news\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-10 14:04:06\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,12,'2025-11-10 14:04:06',0,NULL),(127,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/scenicSpot/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-10 14:01:25\",\"delFlag\":\"0\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2074,\"menuName\":\"旅游景点\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"scenicSpot\",\"perms\":\"tourism:scenicSpot:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-10 14:06:39\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,15,'2025-11-10 14:06:39',0,NULL),(128,'A级景区',1,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()','POST',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"四川省阿坝藏族羌族自治州九寨沟县\",\"city\":\"阿坝州\",\"createBy\":\"admin\",\"createTime\":\"2025-11-14 17:14:15\",\"delFlag\":\"0\",\"description\":\"九寨沟是世界自然遗产、国家重点风景名胜区、国家AAAAA级旅游景区、国家级自然保护区、国家地质公园、世界生物圈保护区网络，是中国第一个以保护自然风景为主要目的的自然保护区。\",\"district\":\"九寨沟县\",\"id\":23,\"latitude\":33.254,\"level\":\"5A\",\"longitude\":103.918,\"name\":\"九寨沟风景名胜区\",\"openingHours\":\"08:00-18:00\",\"params\":{},\"status\":\"0\",\"ticketPrice\":169.00}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,44,'2025-11-14 17:14:16',0,NULL),(129,'A级景区',1,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()','POST',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"测试001\",\"city\":\"测试001\",\"createBy\":\"admin\",\"createTime\":\"2025-11-14 17:57:55\",\"delFlag\":\"0\",\"description\":\"测试001\",\"id\":24,\"level\":\"AAA\",\"name\":\"测试001\",\"params\":{},\"ticketPrice\":0}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,87,'2025-11-14 17:57:56',0,NULL),(130,'设备设施管理',1,'cn.edu.cquet.tourism.controller.TourismFacilitiesController.add()','POST',1,'admin','研发部门','/tourism/facilities','127.0.0.1','内网IP','{\"facilitiesName\":\"笔记本电脑\",\"id\":3}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,18,'2025-11-15 00:00:33',0,NULL),(131,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[\"1.jpg\",\"2.jpg\",\"3.jpg\"]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":3,\"url\":\"1.jpg\"},{\"id\":4,\"url\":\"2.jpg\"},{\"id\":5,\"url\":\"3.jpg\"}]}','0','',NULL,43,'2025-11-15 16:29:21',0,NULL),(132,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/1/status/0','127.0.0.1','内网IP','1 \"0\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,21,'2025-11-15 16:59:08',0,NULL),(133,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/1/status/1','127.0.0.1','内网IP','1 \"1\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,20,'2025-11-15 16:59:29',0,NULL),(134,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/1/status/1','127.0.0.1','内网IP','1 \"1\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,48,'2025-11-15 17:32:48',0,NULL),(135,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"contactPhone\":\"023-12345678\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:36:02\",\"delFlag\":\"0\",\"description\":\"体验正宗重庆火锅文化，品尝地道美食\",\"endTime\":\"2024-06-03 18:00:00\",\"name\":\"重庆火锅文化节\",\"organizer\":\"重庆美食协会\",\"params\":{},\"startTime\":\"2024-06-01 09:00:00\",\"status\":\"ACTIVE\",\"venueId\":1}','','1','\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'status\' at row 1\r\n### The error may exist in cn/edu/cquet/tourism/mapper/TourismActivityMapper.java (best guess)\r\n### The error may involve cn.edu.cquet.tourism.mapper.TourismActivityMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO tourism_activity  ( name,  start_time, end_time,  venue_id, organizer, contact_phone, description, status,   create_time,  del_flag, create_by )  VALUES (  ?,  ?, ?,  ?, ?, ?, ?, ?,   ?,  ?, ?  )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'status\' at row 1\n; Data truncation: Data too long for column \'status\' at row 1',NULL,188,'2025-11-15 17:36:02',0,NULL),(136,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"pending\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/activity/winter-exhibit.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:40:28\",\"delFlag\":\"0\",\"description\":\"围绕城市文明的冬季专题展。\",\"endTime\":\"2026-01-10 18:00:00\",\"name\":\"城市博物馆冬季展览\",\"organizer\":\"城市博物馆\",\"params\":{},\"startTime\":\"2025-12-05 09:00:00\",\"status\":\"0\",\"venueId\":1}','','1','\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'audit_status\' at row 1\r\n### The error may exist in cn/edu/cquet/tourism/mapper/TourismActivityMapper.java (best guess)\r\n### The error may involve cn.edu.cquet.tourism.mapper.TourismActivityMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO tourism_activity  ( name, cover_image, start_time, end_time, category, venue_id, organizer, contact_phone, description, status, audit_status,  create_time,  del_flag, create_by )  VALUES (  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,  ?,  ?, ?  )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'audit_status\' at row 1\n; Data truncation: Data too long for column \'audit_status\' at row 1',NULL,8,'2025-11-15 17:40:28',0,NULL),(137,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"pending\",\"category\":\"讲座\",\"contactPhone\":\"13900001234\",\"coverImage\":\"https://cdn.example.com/images/winter-lecture.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:43:41\",\"delFlag\":\"0\",\"description\":\"邀请专家学者分享巴渝文化发展脉络与重要节点。\",\"endTime\":\"2025-12-20 21:00:00\",\"name\":\"冬季文化讲座：巴渝历史谈\",\"organizer\":\"重庆市文化馆\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-20 19:00:00\",\"status\":\"0\",\"venueId\":2}','','1','\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'audit_status\' at row 1\r\n### The error may exist in cn/edu/cquet/tourism/mapper/TourismActivityMapper.java (best guess)\r\n### The error may involve cn.edu.cquet.tourism.mapper.TourismActivityMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO tourism_activity  ( name, cover_image, start_time, end_time, category, venue_id, organizer, contact_phone, description, status, audit_status, remark, create_time,  del_flag, create_by )  VALUES (  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,  ?, ?  )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'audit_status\' at row 1\n; Data truncation: Data too long for column \'audit_status\' at row 1',NULL,228,'2025-11-15 17:43:42',0,NULL),(138,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:45:06\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":2,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,25,'2025-11-15 17:45:07',0,NULL),(139,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"展览123\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:46:46\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":3,\"name\":\"重庆非遗展览季123\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,34,'2025-11-15 17:46:46',0,NULL),(140,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.edit()','PUT',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"展览123\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":2,\"name\":\"重庆非遗展览季123\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-15 17:47:28\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,14,'2025-11-15 17:47:28',0,NULL),(141,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.approve()','POST',1,'admin','研发部门','/tourism/activity/2/approve','127.0.0.1','内网IP','2','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,20,'2025-11-15 17:49:00',0,NULL),(142,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.approve()','POST',1,'admin','研发部门','/tourism/activity/3/approve','127.0.0.1','内网IP','3','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,11,'2025-11-15 17:50:10',0,NULL),(143,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:50:50\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":4,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,22,'2025-11-15 17:50:51',0,NULL),(144,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:55:24\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":5,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,19,'2025-11-15 17:55:25',0,NULL),(145,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:55:26\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":6,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,6,'2025-11-15 17:55:27',0,NULL),(146,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:58:32\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":7,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,279,'2025-11-15 17:58:33',0,NULL),(147,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:58:34\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":8,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,22,'2025-11-15 17:58:34',0,NULL),(148,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.approve()','POST',1,'admin','研发部门','/tourism/activity/2/approve','127.0.0.1','内网IP','2','{\"msg\":\"操作失败\",\"code\":500}','0','',NULL,99,'2025-11-15 17:59:07',0,NULL),(149,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.reject()','POST',1,'admin','研发部门','/tourism/activity/3/reject','127.0.0.1','内网IP','3','{\"msg\":\"请提供审核不通过原因\",\"code\":601}','0','',NULL,0,'2025-11-15 17:59:20',0,NULL),(150,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.approve()','POST',1,'admin','研发部门','/tourism/activity/2/approve','127.0.0.1','内网IP','2 {\"opinion\":\"内容完整，予以通过\"}','{\"msg\":\"操作失败\",\"code\":500}','0','',NULL,168,'2025-11-15 18:03:16',0,NULL),(151,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.reject()','POST',1,'admin','研发部门','/tourism/activity/3/reject','127.0.0.1','内网IP','3 {\"reason\":\"资料不完整\"}','{\"msg\":\"操作失败\",\"code\":500}','0','',NULL,9,'2025-11-15 18:03:35',0,NULL),(152,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.approve()','POST',1,'admin','研发部门','/tourism/activity/2/approve','127.0.0.1','内网IP','2 {\"opinion\":\"内容完整，予以通过\"}','{\"msg\":\"操作失败\",\"code\":500}','0','',NULL,30,'2025-11-15 18:11:57',0,NULL),(153,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.approve()','POST',1,'admin','研发部门','/tourism/activity/2/approve','127.0.0.1','内网IP','2 {\"opinion\":\"内容完整，予以通过\"}','{\"msg\":\"操作失败\",\"code\":500}','0','',NULL,42,'2025-11-15 18:15:39',0,NULL),(154,'A级景区',3,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.remove()','DELETE',1,'admin','研发部门','/tourism/scenic-spot/24','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,64,'2025-11-16 23:51:33',0,NULL),(155,'菜单管理',1,'cn.edu.cquet.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/venue/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:30:15\",\"delFlag\":\"0\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2075,\"menuName\":\"场馆管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2072,\"path\":\"venue\",\"perms\":\"tourism:venue:list\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,25,'2025-11-17 15:30:15',0,NULL),(156,'场馆管理',3,'cn.edu.cquet.tourism.controller.tourismVenueController.remove()','DELETE',1,'admin','研发部门','/tourism/venue/3','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,39,'2025-11-17 15:30:55',0,NULL),(157,'菜单管理',1,'cn.edu.cquet.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/activity/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:42:39\",\"delFlag\":\"0\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2076,\"menuName\":\"特色活动管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2072,\"path\":\"activity\",\"perms\":\"tourism:activity:list\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,12,'2025-11-17 15:42:40',0,NULL),(158,'菜单管理',1,'cn.edu.cquet.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"/tourism/activityApplication/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:43:41\",\"delFlag\":\"0\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2077,\"menuName\":\"活动审核\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2072,\"path\":\"activityApplication\",\"perms\":\"/tourism:activityApplication:list\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,17,'2025-11-17 15:43:42',0,NULL),(159,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"/tourism/activityApplication/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:43:42\",\"delFlag\":\"0\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2077,\"menuName\":\"活动审核\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2072,\"path\":\"activityApplication\",\"perms\":\"tourism:activityApplication:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-17 15:43:50\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,16,'2025-11-17 15:43:50',0,NULL),(160,'菜单管理',1,'cn.edu.cquet.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"/tourism/notice/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:45:00\",\"delFlag\":\"0\",\"icon\":\"button\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2078,\"menuName\":\"通知管理\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2072,\"path\":\"notice\",\"perms\":\"tourism:notice:list\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,16,'2025-11-17 15:45:01',0,NULL),(161,'菜单管理',1,'cn.edu.cquet.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"/tourism/facilities/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:46:19\",\"delFlag\":\"0\",\"icon\":\"example\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2079,\"menuName\":\"设备管理\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2072,\"path\":\"facilities\",\"perms\":\"tourism:facilities:list\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,15,'2025-11-17 15:46:19',0,NULL),(162,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.approve()','POST',1,'admin','研发部门','/tourism/activity/1/approve','127.0.0.1','内网IP','{\"opinion\":\"可以的\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,23,'2025-11-17 15:46:52',0,NULL),(163,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"/tourism/activityApplication/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:43:42\",\"delFlag\":\"0\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2077,\"menuName\":\"活动审核\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2072,\"path\":\"activityApplication\",\"perms\":\"tourism:activity-application:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-17 15:49:05\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,15,'2025-11-17 15:49:05',0,NULL),(164,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"/tourism/activityApplication/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:43:42\",\"delFlag\":\"0\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2077,\"menuName\":\"活动审核\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2072,\"path\":\"activityApplication\",\"perms\":\"tourism:activityApplication:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-17 15:49:31\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,13,'2025-11-17 15:49:32',0,NULL),(165,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"/tourism/facilities/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:46:19\",\"delFlag\":\"0\",\"icon\":\"example\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2079,\"menuName\":\"设备管理\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2072,\"path\":\"facilities\",\"perms\":\"tourism:facilities:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-17 15:52:23\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,19,'2025-11-17 15:52:24',0,NULL),(166,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"/tourism/activityApplication/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:43:42\",\"delFlag\":\"0\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2077,\"menuName\":\"活动审核\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2072,\"path\":\"activityApplication\",\"perms\":\"tourism:activityApplication:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-17 15:54:42\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,144,'2025-11-17 15:54:42',0,NULL),(167,'设备设施管理',2,'cn.edu.cquet.tourism.controller.TourismFacilitiesController.edit()','PUT',1,'admin','研发部门','/tourism/facilities','127.0.0.1','内网IP','{\"facilitiesName\":\"游泳池\",\"id\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,31,'2025-11-17 16:05:15',0,NULL),(168,'特色活动申报',2,'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.approve()','POST',1,'admin','研发部门','/tourism/activityApplication/8/approve','127.0.0.1','内网IP','{\"opinion\":\"可以的\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,76,'2025-11-17 16:05:32',0,NULL),(169,'特色活动申报',2,'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.reject()','POST',1,'admin','研发部门','/tourism/activityApplication/1/reject','127.0.0.1','内网IP','{\"reason\":\"测试\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,27,'2025-11-17 16:05:41',0,NULL),(170,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.edit()','PUT',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditReason\":\"测试\",\"auditStatus\":\"2\",\"auditor\":\"admin\",\"category\":\"文化体验\",\"contactPhone\":\"12344556677\",\"coverImage\":\"1\",\"createBy\":\"\",\"delFlag\":\"0\",\"description\":\"111\",\"endTime\":\"2025-11-15 16:52:48\",\"id\":1,\"name\":\"测试001\",\"organizer\":\"测试001\",\"params\":{},\"startTime\":\"2025-11-16 16:52:45\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-17 16:07:18\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,49,'2025-11-17 16:07:19',0,NULL),(171,'特色活动申报',2,'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.approve()','POST',1,'admin','研发部门','/tourism/activityApplication/8/approve','127.0.0.1','内网IP','{\"opinion\":\"可以的\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,27,'2025-11-17 16:09:34',0,NULL),(172,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.edit()','PUT',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditReason\":\"测试\",\"auditStatus\":\"2\",\"auditor\":\"admin\",\"category\":\"文化体验\",\"contactPhone\":\"12344556677\",\"coverImage\":\"1\",\"createBy\":\"\",\"delFlag\":\"0\",\"description\":\"111\",\"endTime\":\"2025-11-15 16:52:48\",\"id\":1,\"name\":\"测试001\",\"organizer\":\"测试001\",\"params\":{},\"startTime\":\"2025-11-16 16:52:45\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-17 16:10:48\",\"venueId\":1}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,17,'2025-11-17 16:10:49',0,NULL),(173,'A级景区',3,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.remove()','DELETE',1,'admin','研发部门','/tourism/scenic-spot/22','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,70,'2025-11-18 15:30:55',0,NULL),(174,'A级景区',1,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()','POST',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"重庆市\",\"city\":\"重庆市\",\"contactPhone\":\"18983432250\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 15:32:04\",\"delFlag\":\"0\",\"description\":\"解放碑\",\"district\":\"重庆市\",\"id\":25,\"latitude\":-6,\"level\":\"AAAAA\",\"longitude\":6,\"name\":\"重庆解放碑\",\"openingHours\":\"全天\",\"params\":{},\"ticketPrice\":0,\"website\":\"cq.com\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,47,'2025-11-18 15:32:04',0,NULL),(175,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/1/status/1','127.0.0.1','内网IP','1 \"1\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,26,'2025-11-18 15:42:43',0,NULL),(176,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/1/status/0','127.0.0.1','内网IP','1 \"0\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,15,'2025-11-18 15:42:46',0,NULL),(177,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/venue/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:30:15\",\"delFlag\":\"0\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2075,\"menuName\":\"场馆管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2072,\"path\":\"venue\",\"perms\":\"tourism:venue:activity:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 16:01:07\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,68,'2025-11-18 16:01:07',0,NULL),(178,'场馆管理',3,'cn.edu.cquet.tourism.controller.tourismVenueController.remove()','DELETE',1,'admin','研发部门','/tourism/venue/4','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,46,'2025-11-18 16:06:22',0,NULL),(179,'场馆管理',3,'cn.edu.cquet.tourism.controller.tourismVenueController.remove()','DELETE',1,'admin','研发部门','/tourism/venue/6','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,24,'2025-11-18 16:06:24',0,NULL),(180,'场馆管理',2,'cn.edu.cquet.tourism.controller.tourismVenueController.edit()','PUT',1,'admin','研发部门','/tourism/venue','127.0.0.1','内网IP','{\"id\":1,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 16:07:35\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,79,'2025-11-18 16:07:35',0,NULL),(181,'场馆管理',2,'cn.edu.cquet.tourism.controller.tourismVenueController.edit()','PUT',1,'admin','研发部门','/tourism/venue','127.0.0.1','内网IP','{\"id\":1,\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 16:07:38\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,31,'2025-11-18 16:07:39',0,NULL),(182,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/8/status/1','127.0.0.1','内网IP','8 \"1\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,53,'2025-11-18 16:08:09',0,NULL),(183,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/7/status/1','127.0.0.1','内网IP','7 \"1\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,22,'2025-11-18 16:08:15',0,NULL),(184,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/1/status/1','127.0.0.1','内网IP','1 \"1\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,17,'2025-11-18 16:08:17',0,NULL),(185,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/8/status/0','127.0.0.1','内网IP','8 \"0\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,27,'2025-11-18 16:10:57',0,NULL),(186,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/8/status/1','127.0.0.1','内网IP','8 \"1\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,16,'2025-11-18 16:11:04',0,NULL),(187,'特色活动申报',2,'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.approve()','POST',1,'admin','研发部门','/tourism/activityApplication/7/approve','127.0.0.1','内网IP','{\"opinion\":\"可以\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,32,'2025-11-18 16:11:14',0,NULL),(188,'场馆管理',3,'cn.edu.cquet.tourism.controller.tourismVenueController.remove()','DELETE',1,'admin','研发部门','/tourism/venue/1','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,28,'2025-11-18 16:11:26',0,NULL),(189,'场馆管理',3,'cn.edu.cquet.tourism.controller.tourismVenueController.remove()','DELETE',1,'admin','研发部门','/tourism/venue/2','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,35,'2025-11-18 16:11:28',0,NULL),(190,'特色活动',3,'cn.edu.cquet.tourism.controller.TourismActivityController.remove()','DELETE',1,'admin','研发部门','/tourism/activity/1','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,19,'2025-11-18 16:17:54',0,NULL),(191,'特色活动',3,'cn.edu.cquet.tourism.controller.TourismActivityController.remove()','DELETE',1,'admin','研发部门','/tourism/activity/7','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,18,'2025-11-18 16:17:56',0,NULL),(192,'特色活动',3,'cn.edu.cquet.tourism.controller.TourismActivityController.remove()','DELETE',1,'admin','研发部门','/tourism/activity/8','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,13,'2025-11-18 16:17:57',0,NULL),(193,'场馆管理',1,'cn.edu.cquet.tourism.controller.tourismVenueController.add()','POST',1,'admin','研发部门','/tourism/venue','127.0.0.1','内网IP','{\"address\":\"重庆市\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"文旅\",\"city\":\"重庆市\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 16:28:46\",\"delFlag\":\"0\",\"description\":\"解放碑科技\",\"district\":\"重庆市\",\"id\":7,\"latitude\":-6,\"longitude\":6,\"name\":\"科技馆\",\"openingHours\":\"下午\",\"params\":{},\"ticketPrice\":4}','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"address\":\"重庆市\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"文旅\",\"city\":\"重庆市\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 16:28:46\",\"delFlag\":\"0\",\"description\":\"解放碑科技\",\"district\":\"重庆市\",\"id\":7,\"latitude\":-6,\"longitude\":6,\"name\":\"科技馆\",\"openingHours\":\"下午\",\"params\":{},\"ticketPrice\":4}}','0','',NULL,102,'2025-11-18 16:28:46',0,NULL),(194,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"是的\",\"contactPhone\":\"5562+\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 16:31:28\",\"delFlag\":\"0\",\"endTime\":\"2025-11-21 00:00:00\",\"id\":9,\"name\":\"士大夫\",\"params\":{},\"startTime\":\"2025-11-18 16:31:27\",\"venueId\":7}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,22,'2025-11-18 16:31:29',0,NULL),(195,'特色活动申报',2,'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.approve()','POST',1,'admin','研发部门','/tourism/activityApplication/9/approve','127.0.0.1','内网IP','9','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,24,'2025-11-18 16:31:47',0,NULL),(196,'场馆管理',1,'cn.edu.cquet.tourism.controller.tourismVenueController.add()','POST',1,'admin','研发部门','/tourism/venue','127.0.0.1','内网IP','{\"address\":\"重庆市\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"酒店\",\"city\":\"重庆市\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 16:32:27\",\"delFlag\":\"0\",\"district\":\"重庆市\",\"id\":8,\"latitude\":-6,\"longitude\":6,\"name\":\"就订啊\",\"params\":{},\"ticketPrice\":0}','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"address\":\"重庆市\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"酒店\",\"city\":\"重庆市\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 16:32:27\",\"delFlag\":\"0\",\"district\":\"重庆市\",\"id\":8,\"latitude\":-6,\"longitude\":6,\"name\":\"就订啊\",\"params\":{},\"ticketPrice\":0}}','0','',NULL,21,'2025-11-18 16:32:27',0,NULL),(197,'A级景区',2,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()','PUT',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"重庆市\",\"city\":\"重庆市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 15:32:04\",\"delFlag\":\"0\",\"description\":\"解放碑\",\"district\":\"重庆市\",\"id\":25,\"latitude\":-6,\"level\":\"AAAAA\",\"longitude\":6,\"name\":\"重庆解放碑\",\"openingHours\":\"全天\",\"params\":{},\"status\":\"0\",\"ticketPrice\":0,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 17:08:57\",\"viewCount\":0,\"website\":\"cq.com\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,27,'2025-11-18 17:08:58',0,NULL),(198,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[\"https://ts2.tc.mm.bing.net/th/id/OIP-C.QSb7FtM8GaCgiGC-jD7IawHaEK?rs=1&pid=ImgDetMain&o=7&rm=3\"]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":6,\"url\":\"https://ts2.tc.mm.bing.net/th/id/OIP-C.QSb7FtM8GaCgiGC-jD7IawHaEK?rs=1&pid=ImgDetMain&o=7&rm=3\"}]}','0','',NULL,16,'2025-11-18 17:08:58',0,NULL),(199,'场馆管理',2,'cn.edu.cquet.tourism.controller.tourismVenueController.edit()','PUT',1,'admin','研发部门','/tourism/venue','127.0.0.1','内网IP','{\"address\":\"重庆市\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"文旅\",\"city\":\"重庆市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 16:28:46\",\"delFlag\":\"0\",\"description\":\"解放碑科技\",\"district\":\"重庆市\",\"id\":7,\"latitude\":-6,\"longitude\":6,\"name\":\"科技馆\",\"openingHours\":\"下午\",\"params\":{},\"status\":\"0\",\"ticketPrice\":4,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 17:09:42\",\"viewCount\":0,\"website\":\"\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,21,'2025-11-18 17:09:43',0,NULL),(200,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[\"https://ts2.tc.mm.bing.net/th/id/OIP-C.QSb7FtM8GaCgiGC-jD7IawHaEK?rs=1&pid=ImgDetMain&o=7&rm=3\"]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":7,\"url\":\"https://ts2.tc.mm.bing.net/th/id/OIP-C.QSb7FtM8GaCgiGC-jD7IawHaEK?rs=1&pid=ImgDetMain&o=7&rm=3\"}]}','0','',NULL,13,'2025-11-18 17:09:43',0,NULL),(201,'A级景区',1,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()','POST',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"彩色\",\"city\":\"测试\",\"coverImage\":\"/profile/upload/2025/11/18/mmexport1762929757923_20251118172249A001.jpeg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 17:23:13\",\"delFlag\":\"0\",\"id\":26,\"latitude\":3,\"level\":\"A\",\"longitude\":3,\"name\":\"测试\",\"openingHours\":\"测试\",\"params\":{},\"ticketPrice\":0}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,17,'2025-11-18 17:23:13',0,NULL),(202,'A级景区',1,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()','POST',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"彩色\",\"city\":\"测试\",\"coverImage\":\"/profile/upload/2025/11/18/mmexport1762929757923_20251118172249A001.jpeg\",\"latitude\":3,\"level\":\"A\",\"longitude\":3,\"name\":\"测试\",\"openingHours\":\"测试\",\"params\":{},\"ticketPrice\":0}','{\"msg\":\"景区名称已存在\",\"code\":601}','0','',NULL,8,'2025-11-18 17:23:19',0,NULL),(203,'A级景区',1,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()','POST',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"彩色\",\"city\":\"测试\",\"coverImage\":\"/profile/upload/2025/11/18/mmexport1762929757923_20251118172249A001.jpeg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 17:23:23\",\"delFlag\":\"0\",\"id\":27,\"latitude\":3,\"level\":\"A\",\"longitude\":3,\"name\":\"测试测试\",\"openingHours\":\"测试\",\"params\":{},\"ticketPrice\":0}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,19,'2025-11-18 17:23:23',0,NULL),(204,'A级景区',3,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.remove()','DELETE',1,'admin','研发部门','/tourism/scenic-spot/27','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,30,'2025-11-18 17:29:01',0,NULL),(205,'A级景区',2,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()','PUT',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"彩色\",\"city\":\"测试\",\"collectionCount\":0,\"contactPhone\":\"\",\"coverImage\":\"/profile/upload/2025/11/18/mmexport1762929757923_20251118172249A001.jpeg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 17:23:13\",\"delFlag\":\"0\",\"district\":\"\",\"id\":26,\"latitude\":3,\"level\":\"A\",\"longitude\":3,\"name\":\"测试\",\"openingHours\":\"测试\",\"params\":{},\"status\":\"0\",\"ticketPrice\":0,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 17:29:10\",\"viewCount\":0,\"website\":\"\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,19,'2025-11-18 17:29:11',0,NULL),(206,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[\"/profile/upload/2025/11/18/头像_20251118172905A001.png\",\"/profile/upload/2025/11/18/未标题-1_20251118172908A002.png\"]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":8,\"url\":\"/profile/upload/2025/11/18/头像_20251118172905A001.png\"},{\"id\":9,\"url\":\"/profile/upload/2025/11/18/未标题-1_20251118172908A002.png\"}]}','0','',NULL,16,'2025-11-18 17:29:11',0,NULL),(207,'A级景区',2,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()','PUT',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"彩色\",\"city\":\"测试\",\"collectionCount\":0,\"contactPhone\":\"\",\"coverImage\":\"/profile/upload/2025/11/18/mmexport1762929757923_20251118172249A001.jpeg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 17:23:13\",\"delFlag\":\"0\",\"district\":\"\",\"id\":26,\"latitude\":3,\"level\":\"A\",\"longitude\":3,\"name\":\"测试\",\"openingHours\":\"测试\",\"params\":{},\"status\":\"0\",\"ticketPrice\":0,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:10:59\",\"viewCount\":0,\"website\":\"\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,18,'2025-11-18 18:10:59',0,NULL),(208,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[\"/profile/upload/2025/11/18/未标题-1_20251118172908A002.png\"]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":10,\"url\":\"/profile/upload/2025/11/18/未标题-1_20251118172908A002.png\"}]}','0','',NULL,12,'2025-11-18 18:11:00',0,NULL),(209,'A级景区',3,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.remove()','DELETE',1,'admin','研发部门','/tourism/scenic-spot/26','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,20,'2025-11-18 18:11:13',0,NULL),(210,'A级景区',2,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()','PUT',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"重庆市\",\"city\":\"重庆市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/未标题-1_20251118181325A003.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 15:32:04\",\"delFlag\":\"0\",\"description\":\"解放碑\",\"district\":\"重庆市\",\"id\":25,\"latitude\":-6,\"level\":\"AAAAA\",\"longitude\":6,\"name\":\"重庆解放碑\",\"openingHours\":\"全天\",\"params\":{},\"status\":\"0\",\"ticketPrice\":0,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:13:31\",\"viewCount\":0,\"website\":\"cq.com\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,19,'2025-11-18 18:13:31',0,NULL),(211,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[\"/profile/upload/2025/11/18/头像_20251118181329A004.png\"]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":11,\"url\":\"/profile/upload/2025/11/18/头像_20251118181329A004.png\"}]}','0','',NULL,18,'2025-11-18 18:13:32',0,NULL),(212,'场馆管理',2,'cn.edu.cquet.tourism.controller.tourismVenueController.edit()','PUT',1,'admin','研发部门','/tourism/venue','127.0.0.1','内网IP','{\"address\":\"重庆市\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"文旅\",\"city\":\"重庆市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/未标题-1_20251118181611A005.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 16:28:46\",\"delFlag\":\"0\",\"description\":\"解放碑科技\",\"district\":\"重庆市\",\"id\":7,\"latitude\":-6,\"longitude\":6,\"name\":\"科技馆\",\"openingHours\":\"下午\",\"params\":{},\"status\":\"0\",\"ticketPrice\":4,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:16:18\",\"viewCount\":0,\"website\":\"\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,40,'2025-11-18 18:16:19',0,NULL),(213,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[\"/profile/upload/2025/11/18/头像_20251118181617A006.png\"]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":12,\"url\":\"/profile/upload/2025/11/18/头像_20251118181617A006.png\"}]}','0','',NULL,18,'2025-11-18 18:16:19',0,NULL),(214,'A级景区',2,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()','PUT',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"重庆市\",\"city\":\"重庆市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/未标题-1_20251118181325A003.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 15:32:04\",\"delFlag\":\"0\",\"description\":\"解放碑\",\"district\":\"重庆市\",\"id\":25,\"latitude\":-6,\"level\":\"AAAAA\",\"longitude\":6,\"name\":\"重庆解放碑\",\"openingHours\":\"全天\",\"params\":{},\"status\":\"0\",\"ticketPrice\":0,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:22:14\",\"viewCount\":0,\"website\":\"cq.com\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,18,'2025-11-18 18:22:14',0,NULL),(215,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[\"/profile/upload/2025/11/18/头像_20251118181329A004.png\",\"/profile/upload/2025/11/18/头像_20251118182212A007.png\"]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":13,\"url\":\"/profile/upload/2025/11/18/头像_20251118181329A004.png\"},{\"id\":14,\"url\":\"/profile/upload/2025/11/18/头像_20251118182212A007.png\"}]}','0','',NULL,22,'2025-11-18 18:22:15',0,NULL),(216,'A级景区',2,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()','PUT',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"重庆市\",\"city\":\"重庆市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/未标题-1_20251118181325A003.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 15:32:04\",\"delFlag\":\"0\",\"description\":\"解放碑\",\"district\":\"重庆市\",\"id\":25,\"latitude\":-6,\"level\":\"AAAAA\",\"longitude\":6,\"name\":\"重庆解放碑\",\"openingHours\":\"全天\",\"params\":{},\"status\":\"0\",\"ticketPrice\":0,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:22:21\",\"viewCount\":0,\"website\":\"cq.com\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,20,'2025-11-18 18:22:21',0,NULL),(217,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[\"/profile/upload/2025/11/18/头像_20251118181329A004.png\"]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":15,\"url\":\"/profile/upload/2025/11/18/头像_20251118181329A004.png\"}]}','0','',NULL,11,'2025-11-18 18:22:22',0,NULL),(218,'A级景区',3,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.remove()','DELETE',1,'admin','研发部门','/tourism/scenic-spot/25','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,21,'2025-11-18 18:27:21',0,NULL),(219,'场馆管理',3,'cn.edu.cquet.tourism.controller.tourismVenueController.remove()','DELETE',1,'admin','研发部门','/tourism/venue/7','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,36,'2025-11-18 18:27:30',0,NULL),(220,'场馆管理',3,'cn.edu.cquet.tourism.controller.tourismVenueController.remove()','DELETE',1,'admin','研发部门','/tourism/venue/8','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,30,'2025-11-18 18:27:33',0,NULL),(221,'场馆管理',1,'cn.edu.cquet.tourism.controller.tourismVenueController.add()','POST',1,'admin','研发部门','/tourism/venue','127.0.0.1','内网IP','{\"address\":\"四川省阿坝藏族羌族自治州九寨沟县\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"是的\",\"city\":\"阿坝州\",\"coverImage\":\"/profile/upload/2025/11/18/sala4_20251118182804A008.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 18:28:06\",\"delFlag\":\"0\",\"district\":\"九寨沟县\",\"id\":9,\"latitude\":33.254,\"longitude\":103.918,\"name\":\"是的\",\"params\":{},\"ticketPrice\":0}','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"address\":\"四川省阿坝藏族羌族自治州九寨沟县\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"是的\",\"city\":\"阿坝州\",\"coverImage\":\"/profile/upload/2025/11/18/sala4_20251118182804A008.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 18:28:06\",\"delFlag\":\"0\",\"district\":\"九寨沟县\",\"id\":9,\"latitude\":33.254,\"longitude\":103.918,\"name\":\"是的\",\"params\":{},\"ticketPrice\":0}}','0','',NULL,18,'2025-11-18 18:28:06',0,NULL),(222,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}','0','',NULL,6,'2025-11-18 18:28:07',0,NULL),(223,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"是的\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 18:28:43\",\"delFlag\":\"0\",\"endTime\":\"2025-11-28 00:00:00\",\"id\":10,\"name\":\"水果排队\",\"params\":{},\"startTime\":\"2025-11-18 18:28:42\",\"venueId\":9}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,33,'2025-11-18 18:28:44',0,NULL),(224,'特色活动申报',2,'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.approve()','POST',1,'admin','研发部门','/tourism/activityApplication/10/approve','127.0.0.1','内网IP','{\"opinion\":\"可以\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,28,'2025-11-18 18:28:55',0,NULL),(225,'场馆管理',2,'cn.edu.cquet.tourism.controller.tourismVenueController.edit()','PUT',1,'admin','研发部门','/tourism/venue','127.0.0.1','内网IP','{\"address\":\"四川省阿坝藏族羌族自治州九寨沟县\",\"bookingRequired\":\"0\",\"capacity\":2,\"category\":\"是的\",\"city\":\"阿坝州\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/sala4_20251118182804A008.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 18:28:06\",\"delFlag\":\"0\",\"district\":\"九寨沟县\",\"id\":9,\"latitude\":33.254,\"longitude\":103.918,\"name\":\"是的\",\"openingHours\":\"\",\"params\":{},\"status\":\"0\",\"ticketPrice\":0,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:30:53\",\"viewCount\":0,\"website\":\"\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,18,'2025-11-18 18:30:53',0,NULL),(226,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}','0','',NULL,4,'2025-11-18 18:30:54',0,NULL),(227,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.edit()','PUT',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditReason\":\"可以\",\"auditStatus\":\"1\",\"auditor\":\"admin\",\"category\":\"是的\",\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/ComfyUI_00001__20251118183359A009.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 18:28:44\",\"delFlag\":\"0\",\"endTime\":\"2025-11-28 00:00:00\",\"id\":10,\"name\":\"水果排队\",\"organizer\":\"是的官方\",\"params\":{},\"startTime\":\"2025-11-18 18:28:42\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:34:03\",\"venueId\":9}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,14,'2025-11-18 18:34:03',0,NULL),(228,'A级景区',2,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()','PUT',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"四川省阿坝藏族羌族自治州九寨沟县\",\"city\":\"阿坝州\",\"collectionCount\":0,\"contactPhone\":\"\",\"coverImage\":\"/profile/upload/2025/11/18/redis-cover_20251118183617A010.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-14 17:14:16\",\"delFlag\":\"0\",\"description\":\"九寨沟是世界自然遗产、国家重点风景名胜区、国家AAAAA级旅游景区、国家级自然保护区、国家地质公园、世界生物圈保护区网络，是中国第一个以保护自然风景为主要目的的自然保护区。\",\"district\":\"九寨沟县\",\"id\":23,\"latitude\":33.254,\"level\":\"5A\",\"longitude\":103.918,\"name\":\"九寨沟风景名胜区\",\"openingHours\":\"08:00-18:00\",\"params\":{},\"status\":\"0\",\"ticketPrice\":169,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:36:18\",\"viewCount\":0,\"website\":\"\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,21,'2025-11-18 18:36:19',0,NULL),(229,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}','0','',NULL,10,'2025-11-18 18:36:19',0,NULL),(230,'场馆管理',3,'cn.edu.cquet.tourism.controller.tourismVenueController.remove()','DELETE',1,'admin','研发部门','/tourism/venue/9','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,30,'2025-11-18 18:46:18',0,NULL),(231,'A级景区',3,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.remove()','DELETE',1,'admin','研发部门','/tourism/scenic-spot/23','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,22,'2025-11-18 18:46:26',0,NULL),(232,'菜单管理',3,'cn.edu.cquet.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2079','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,19,'2025-11-18 18:47:50',0,NULL),(233,'菜单管理',3,'cn.edu.cquet.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2079','127.0.0.1','内网IP','{}','{\"msg\":\"操作失败\",\"code\":500}','0','',NULL,6,'2025-11-18 18:47:59',0,NULL),(234,'菜单管理',3,'cn.edu.cquet.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2079','127.0.0.1','内网IP','{}','{\"msg\":\"操作失败\",\"code\":500}','0','',NULL,9,'2025-11-18 18:48:01',0,NULL),(235,'菜单管理',3,'cn.edu.cquet.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2079','127.0.0.1','内网IP','{}','{\"msg\":\"操作失败\",\"code\":500}','0','',NULL,11,'2025-11-18 18:48:32',0,NULL),(236,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/notice/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:45:01\",\"delFlag\":\"0\",\"icon\":\"button\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2078,\"menuName\":\"通知管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"notice\",\"perms\":\"tourism:notice:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:49:15\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,33,'2025-11-18 18:49:15',0,NULL),(237,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/notice/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:45:01\",\"delFlag\":\"0\",\"icon\":\"button\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2078,\"menuName\":\"通知管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"notice\",\"perms\":\"tourism:notice:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:49:28\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,14,'2025-11-18 18:49:29',0,NULL),(238,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"news\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:49:34\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,24,'2025-11-18 18:49:34',0,NULL),(239,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/activity/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:42:40\",\"delFlag\":\"0\",\"icon\":\"row\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2076,\"menuName\":\"活动管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2072,\"path\":\"activity\",\"perms\":\"tourism:activity:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:50:05\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,14,'2025-11-18 18:50:05',0,NULL),(240,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/scenicSpot/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-10 14:01:25\",\"delFlag\":\"0\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2074,\"menuName\":\"旅游景点\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"scenicSpot\",\"perms\":\"tourism:scenicSpot:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:50:27\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,17,'2025-11-18 18:50:28',0,NULL),(241,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/venue/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:30:15\",\"delFlag\":\"0\",\"icon\":\"tree\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2075,\"menuName\":\"场馆管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2072,\"path\":\"venue\",\"perms\":\"tourism:venue:activity:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:51:03\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,12,'2025-11-18 18:51:04',0,NULL),(242,'A级景区',1,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()','POST',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"重庆市两江新区\",\"city\":\"重庆市\",\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/小川_20251118192010A001.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:20:17\",\"delFlag\":\"0\",\"description\":\"重庆市永川区\",\"district\":\"重庆市两江新区\",\"id\":28,\"latitude\":3,\"level\":\"AAAAA\",\"longitude\":2,\"name\":\"重庆电子科技职业大学\",\"openingHours\":\"全天\",\"params\":{},\"remark\":\"测试\",\"ticketPrice\":0,\"website\":\"cquet\"}','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"address\":\"重庆市两江新区\",\"city\":\"重庆市\",\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/小川_20251118192010A001.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:20:17\",\"delFlag\":\"0\",\"description\":\"重庆市永川区\",\"district\":\"重庆市两江新区\",\"id\":28,\"latitude\":3,\"level\":\"AAAAA\",\"longitude\":2,\"name\":\"重庆电子科技职业大学\",\"openingHours\":\"全天\",\"params\":{},\"remark\":\"测试\",\"ticketPrice\":0,\"website\":\"cquet\"}}','0','',NULL,95,'2025-11-18 19:20:18',0,NULL),(243,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}','0','',NULL,9,'2025-11-18 19:20:18',0,NULL),(244,'场馆管理',1,'cn.edu.cquet.tourism.controller.tourismVenueController.add()','POST',1,'admin','研发部门','/tourism/venue','127.0.0.1','内网IP','{\"address\":\"重庆市两江新区\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"教学\",\"city\":\"重庆市\",\"coverImage\":\"/profile/upload/2025/11/18/蓝莓草莓_20251118192135A002.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:21:37\",\"delFlag\":\"0\",\"description\":\"教学\",\"district\":\"重庆市两江新区\",\"id\":10,\"latitude\":3,\"longitude\":2,\"name\":\"教学楼\",\"openingHours\":\"早上8:00-晚上22:00\",\"params\":{},\"ticketPrice\":0}','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"address\":\"重庆市两江新区\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"教学\",\"city\":\"重庆市\",\"coverImage\":\"/profile/upload/2025/11/18/蓝莓草莓_20251118192135A002.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:21:37\",\"delFlag\":\"0\",\"description\":\"教学\",\"district\":\"重庆市两江新区\",\"id\":10,\"latitude\":3,\"longitude\":2,\"name\":\"教学楼\",\"openingHours\":\"早上8:00-晚上22:00\",\"params\":{},\"ticketPrice\":0}}','0','',NULL,38,'2025-11-18 19:21:37',0,NULL),(245,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}','0','',NULL,5,'2025-11-18 19:21:38',0,NULL),(246,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditStatus\":\"0\",\"category\":\"比赛\",\"coverImage\":\"/profile/upload/2025/11/18/椎名_20251118192225A003.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:22:45\",\"delFlag\":\"0\",\"description\":\"低开吗\",\"endTime\":\"2025-11-26 00:00:00\",\"id\":11,\"name\":\"低代码大赛\",\"organizer\":\"重庆市电子科技\",\"params\":{},\"startTime\":\"2025-11-18 00:00:00\",\"venueId\":10}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,26,'2025-11-18 19:22:46',0,NULL),(247,'特色活动申报',2,'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.approve()','POST',1,'admin','研发部门','/tourism/activityApplication/11/approve','127.0.0.1','内网IP','{\"opinion\":\"测试通过\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,26,'2025-11-18 19:24:26',0,NULL),(248,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.edit()','PUT',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditReason\":\"测试通过\",\"auditStatus\":\"1\",\"auditor\":\"admin\",\"category\":\"比赛\",\"contactPhone\":\"\",\"coverImage\":\"/profile/upload/2025/11/18/椎名_20251118192225A003.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:22:46\",\"delFlag\":\"0\",\"description\":\"低开吗\",\"endTime\":\"2025-11-26 00:00:00\",\"id\":11,\"name\":\"低代码大赛\",\"organizer\":\"重庆市电子科技\",\"params\":{},\"startTime\":\"2025-11-18 00:00:00\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 19:25:56\",\"venueId\":10}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,18,'2025-11-18 19:25:57',0,NULL),(249,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.edit()','PUT',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"auditReason\":\"测试通过\",\"auditStatus\":\"1\",\"auditor\":\"admin\",\"category\":\"比赛\",\"contactPhone\":\"\",\"coverImage\":\"/profile/upload/2025/11/18/椎名_20251118192225A003.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:22:46\",\"currentParticipants\":0,\"delFlag\":\"0\",\"description\":\"低开吗\",\"endTime\":\"2025-11-26 00:00:00\",\"id\":11,\"maxParticipants\":4,\"name\":\"低代码大赛\",\"organizer\":\"重庆市电子科技\",\"params\":{},\"startTime\":\"2025-11-18 00:00:00\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 19:29:33\",\"venueId\":10}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,36,'2025-11-18 19:29:33',0,NULL),(250,'A级景区',2,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()','PUT',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"重庆市两江新区\",\"city\":\"重庆市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/小川_20251118192010A001.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:20:17\",\"delFlag\":\"0\",\"description\":\"重庆市永川区\",\"district\":\"重庆市两江新区\",\"id\":28,\"latitude\":3,\"level\":\"AAAAA\",\"longitude\":2,\"name\":\"重庆电子科技职业大学\",\"openingHours\":\"全天\",\"params\":{},\"remark\":\"测试\",\"status\":\"0\",\"ticketPrice\":50,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-19 11:35:46\",\"viewCount\":0,\"website\":\"cquet\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,42,'2025-11-19 11:35:47',0,NULL),(251,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}','0','',NULL,5,'2025-11-19 11:35:47',0,NULL),(252,'A级景区',2,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()','PUT',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"本地辖区\",\"city\":\"广东省广州市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/19/06FD0C357EA5C119D8FA89F6D5C8833F_20251119113731A002.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:20:17\",\"delFlag\":\"0\",\"description\":\"广州著名景点\",\"district\":\"市辖区\",\"id\":28,\"latitude\":3,\"level\":\"AAAAA\",\"longitude\":2,\"name\":\"广州塔\",\"openingHours\":\"全天\",\"params\":{},\"remark\":\"测试\",\"status\":\"0\",\"ticketPrice\":50,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-19 11:37:34\",\"viewCount\":0,\"website\":\"cquet\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,20,'2025-11-19 11:37:35',0,NULL),(253,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}','0','',NULL,4,'2025-11-19 11:37:35',0,NULL),(254,'A级景区',1,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()','POST',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"测试\",\"city\":\"北京市\",\"contactPhone\":\"18988444455\",\"coverImage\":\"/profile/upload/2025/11/19/redis-cover_20251119113845A003.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-19 11:38:54\",\"delFlag\":\"0\",\"district\":\"丰台区\",\"id\":29,\"level\":\"AAAAA\",\"name\":\"测试景区\",\"openingHours\":\"9:00-21:00\",\"params\":{},\"ticketPrice\":0,\"website\":\"测试\"}','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"address\":\"测试\",\"city\":\"北京市\",\"contactPhone\":\"18988444455\",\"coverImage\":\"/profile/upload/2025/11/19/redis-cover_20251119113845A003.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-19 11:38:54\",\"delFlag\":\"0\",\"district\":\"丰台区\",\"id\":29,\"level\":\"AAAAA\",\"name\":\"测试景区\",\"openingHours\":\"9:00-21:00\",\"params\":{},\"ticketPrice\":0,\"website\":\"测试\"}}','0','',NULL,19,'2025-11-19 11:38:55',0,NULL),(255,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}','0','',NULL,4,'2025-11-19 11:38:55',0,NULL),(256,'场馆管理',1,'cn.edu.cquet.tourism.controller.tourismVenueController.add()','POST',1,'admin','研发部门','/tourism/venue','127.0.0.1','内网IP','{\"address\":\"测试\",\"bookingRequired\":\"1\",\"capacity\":15,\"category\":\"教育科研类场馆\",\"city\":\"北京市\",\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/19/704257_143708003_2_20251119115714A001.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-19 11:57:25\",\"delFlag\":\"0\",\"description\":\"测试\",\"district\":\"东城区\",\"id\":11,\"latitude\":-10,\"longitude\":7,\"name\":\"科技馆\",\"openingHours\":\"9:00-17:00\",\"params\":{},\"remark\":\"测试\",\"ticketPrice\":0,\"website\":\"无\"}','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"address\":\"测试\",\"bookingRequired\":\"1\",\"capacity\":15,\"category\":\"教育科研类场馆\",\"city\":\"北京市\",\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/19/704257_143708003_2_20251119115714A001.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-19 11:57:25\",\"delFlag\":\"0\",\"description\":\"测试\",\"district\":\"东城区\",\"id\":11,\"latitude\":-10,\"longitude\":7,\"name\":\"科技馆\",\"openingHours\":\"9:00-17:00\",\"params\":{},\"remark\":\"测试\",\"ticketPrice\":0,\"website\":\"无\"}}','0','',NULL,21,'2025-11-19 11:57:26',0,NULL),(257,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}','0','',NULL,4,'2025-11-19 11:57:26',0,NULL),(258,'A级景区',2,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()','PUT',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"测试\",\"city\":\"北京市\",\"collectionCount\":0,\"contactPhone\":\"18988444455\",\"coverImage\":\"/profile/upload/2025/11/19/redis-cover_20251119113845A003.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-19 11:38:55\",\"delFlag\":\"0\",\"district\":\"东城区\",\"id\":29,\"latitude\":0,\"level\":\"AAAAA\",\"longitude\":0,\"name\":\"测试景区\",\"openingHours\":\"9:00-21:00\",\"params\":{},\"remark\":\"测试\",\"status\":\"0\",\"ticketPrice\":5,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-19 11:59:27\",\"viewCount\":0,\"website\":\"测试\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,20,'2025-11-19 11:59:28',0,NULL),(259,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}','0','',NULL,4,'2025-11-19 11:59:28',0,NULL),(260,'场馆管理',2,'cn.edu.cquet.tourism.controller.tourismVenueController.edit()','PUT',1,'admin','研发部门','/tourism/venue','127.0.0.1','内网IP','{\"address\":\"重庆市两江新区\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"教学\",\"city\":\"重庆市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/蓝莓草莓_20251118192135A002.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:21:37\",\"delFlag\":\"0\",\"description\":\"教学\",\"district\":\"武隆区\",\"id\":10,\"latitude\":3,\"longitude\":2,\"name\":\"教学楼\",\"openingHours\":\"早上8:00-晚上22:00\",\"params\":{},\"status\":\"0\",\"ticketPrice\":0,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-19 12:17:44\",\"viewCount\":0,\"website\":\"\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,42,'2025-11-19 12:17:45',0,NULL),(261,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}','0','',NULL,3,'2025-11-19 12:17:45',0,NULL),(262,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"applicantName\":\"admin\",\"applicantUserId\":1,\"applyReason\":\"需要场地\",\"applyTime\":\"2025-11-19 14:15:43.837\",\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"11144555544\",\"coverImage\":\"/profile/upload/2025/11/19/ComfyUI_00001__20251119141508A001.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-19 14:15:43\",\"currentParticipants\":0,\"delFlag\":\"0\",\"description\":\"测试\",\"endTime\":\"2025-11-28T00:00:00\",\"maxParticipants\":11,\"name\":\"读书会\",\"organizer\":\"学校\",\"params\":{},\"remark\":\"测试\",\"startTime\":\"2025-11-19T14:15:18\",\"status\":\"0\",\"venueId\":10}','','1','\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'applicant_user_id\' in \'field list\'\r\n### The error may exist in cn/edu/cquet/tourism/mapper/TourismActivityMapper.java (best guess)\r\n### The error may involve cn.edu.cquet.tourism.mapper.TourismActivityMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO tourism_activity  ( name, cover_image, start_time, end_time, category, venue_id, organizer, contact_phone, description, status, audit_status,   current_participants, max_participants, applicant_user_id, applicant_name, apply_reason, apply_time, create_time,  del_flag, create_by,  remark )  VALUES (  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,   ?, ?, ?, ?, ?, ?, ?,  ?, ?,  ?  )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'applicant_user_id\' in \'field list\'\n; bad SQL grammar []',NULL,73,'2025-11-19 14:15:44',0,NULL),(263,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"applicantName\":\"admin\",\"applicantUserId\":1,\"applyReason\":\"需要场地\",\"applyTime\":\"2025-11-19 14:33:42.086\",\"category\":\"展览\",\"contactPhone\":\"11144555544\",\"coverImage\":\"/profile/upload/2025/11/19/ComfyUI_00001__20251119141508A001.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-19 14:33:42\",\"currentParticipants\":0,\"delFlag\":\"0\",\"description\":\"测试\",\"endTime\":\"2025-11-28T00:00:00\",\"id\":12,\"maxParticipants\":11,\"name\":\"读书会\",\"organizer\":\"学校\",\"params\":{},\"remark\":\"测试\",\"startTime\":\"2025-11-19T14:15:18\",\"status\":\"0\",\"venueId\":10}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,120,'2025-11-19 14:33:42',0,NULL),(264,'特色活动审批',2,'cn.edu.cquet.tourism.controller.TourismActivityApprovalController.pass()','POST',1,'admin','研发部门','/tourism/activity-approval/12/pass','127.0.0.1','内网IP','{\"opinion\":\"可以通过\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,31,'2025-11-19 14:37:01',0,NULL),(265,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"applyReason\":\"测试\",\"category\":\"演出\",\"contactPhone\":\"18983432250\",\"currentParticipants\":0,\"description\":\"测试\",\"endTime\":\"2025-11-29T00:00:00\",\"maxParticipants\":1,\"name\":\"测试\",\"organizer\":\"我\",\"params\":{},\"remark\":\"测试\",\"startTime\":\"2025-11-26T00:00:00\",\"status\":\"0\",\"venueId\":10}','{\"msg\":\"操作失败\",\"code\":500}','0','',NULL,58,'2025-11-19 14:50:21',0,NULL),(266,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"applyReason\":\"测试\",\"category\":\"演出\",\"contactPhone\":\"18983432250\",\"currentParticipants\":0,\"description\":\"测试\",\"endTime\":\"2025-11-29T00:00:00\",\"maxParticipants\":1,\"name\":\"测试\",\"organizer\":\"我\",\"params\":{},\"remark\":\"测试\",\"startTime\":\"2025-11-26T00:00:00\",\"status\":\"0\",\"venueId\":10}','{\"msg\":\"操作失败\",\"code\":500}','0','',NULL,15,'2025-11-19 14:50:25',0,NULL),(267,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"applyReason\":\"测试\",\"category\":\"演出\",\"contactPhone\":\"18983432250\",\"currentParticipants\":0,\"description\":\"测试\",\"endTime\":\"2025-11-29T00:00:00\",\"maxParticipants\":1,\"name\":\"测试\",\"organizer\":\"我\",\"params\":{},\"remark\":\"测试\",\"startTime\":\"2025-11-26T00:00:00\",\"status\":\"0\",\"venueId\":10}','{\"msg\":\"操作失败\",\"code\":500}','0','',NULL,13,'2025-11-19 14:50:38',0,NULL),(268,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"applyReason\":\"测试\",\"category\":\"演出\",\"contactPhone\":\"18983432250\",\"currentParticipants\":0,\"description\":\"测试\",\"endTime\":\"2025-11-29T00:00:00\",\"maxParticipants\":1,\"name\":\"测试\",\"organizer\":\"我\",\"params\":{},\"remark\":\"测试\",\"startTime\":\"2025-11-26T00:00:00\",\"status\":\"0\",\"venueId\":10}','{\"msg\":\"活动名称重复或同一场馆同时间段已被占用\",\"code\":601}','0','',NULL,40,'2025-11-19 14:53:28',0,NULL),(269,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"applyReason\":\"测试\",\"category\":\"演出\",\"contactPhone\":\"18983432250\",\"currentParticipants\":0,\"description\":\"测试\",\"endTime\":\"2025-11-29T00:00:00\",\"maxParticipants\":1,\"name\":\"测试测试\",\"organizer\":\"我\",\"params\":{},\"remark\":\"测试\",\"startTime\":\"2025-11-26T00:00:00\",\"status\":\"0\",\"venueId\":10}','{\"msg\":\"活动名称重复或同一场馆同时间段已被占用\",\"code\":601}','0','',NULL,16,'2025-11-19 14:53:32',0,NULL),(270,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"applyReason\":\"测试\",\"category\":\"演出\",\"contactPhone\":\"18983432250\",\"currentParticipants\":0,\"description\":\"测试\",\"endTime\":\"2025-11-29T00:00:00\",\"maxParticipants\":1,\"name\":\"测试测试测试\",\"organizer\":\"我\",\"params\":{},\"remark\":\"测试\",\"startTime\":\"2025-11-26T00:00:00\",\"status\":\"0\",\"venueId\":10}','{\"msg\":\"活动名称重复或同一场馆同时间段已被占用\",\"code\":601}','0','',NULL,21,'2025-11-19 14:53:39',0,NULL),(271,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"applyReason\":\"测试\",\"category\":\"演出\",\"contactPhone\":\"18983432250\",\"currentParticipants\":0,\"description\":\"测试\",\"endTime\":\"2025-11-29T00:00:00\",\"maxParticipants\":1,\"name\":\"测试测试测试\",\"organizer\":\"我\",\"params\":{},\"remark\":\"测试\",\"startTime\":\"2025-11-26T00:00:00\",\"status\":\"0\",\"venueId\":10}','{\"msg\":\"活动名称重复或同一场馆同时间段已被占用\",\"code\":601}','0','',NULL,14,'2025-11-19 14:53:41',0,NULL),(272,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"applicantName\":\"admin\",\"applicantUserId\":1,\"applyReason\":\"测试\",\"applyTime\":\"2025-11-19 14:54:05.634\",\"category\":\"演出\",\"contactPhone\":\"18983432250\",\"createBy\":\"admin\",\"createTime\":\"2025-11-19 14:54:05\",\"currentParticipants\":0,\"delFlag\":\"0\",\"description\":\"测试\",\"endTime\":\"2025-12-04T00:00:00\",\"id\":13,\"maxParticipants\":1,\"name\":\"测试测试测试\",\"organizer\":\"我\",\"params\":{},\"remark\":\"测试\",\"startTime\":\"2025-11-30T00:00:00\",\"status\":\"0\",\"venueId\":10}','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"applicantName\":\"admin\",\"applicantUserId\":1,\"applyReason\":\"测试\",\"applyTime\":\"2025-11-19 14:54:05.634\",\"category\":\"演出\",\"contactPhone\":\"18983432250\",\"createBy\":\"admin\",\"createTime\":\"2025-11-19 14:54:05\",\"currentParticipants\":0,\"delFlag\":\"0\",\"description\":\"测试\",\"endTime\":\"2025-12-04T00:00:00\",\"id\":13,\"maxParticipants\":1,\"name\":\"测试测试测试\",\"organizer\":\"我\",\"params\":{},\"remark\":\"测试\",\"startTime\":\"2025-11-30T00:00:00\",\"status\":\"0\",\"venueId\":10}}','0','',NULL,28,'2025-11-19 14:54:06',0,NULL),(273,'特色活动审批',2,'cn.edu.cquet.tourism.controller.TourismActivityApprovalController.reject()','POST',1,'admin','研发部门','/tourism/activity-approval/13/reject','127.0.0.1','内网IP','{\"reason\":\"不行\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,40,'2025-11-19 14:54:20',0,NULL),(274,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"applicantName\":\"admin\",\"applicantUserId\":1,\"applyReason\":\"测试\",\"applyTime\":\"2025-11-19 15:06:15.196\",\"category\":\"展览\",\"contactPhone\":\"17744775544\",\"coverImage\":\"/profile/upload/2025/11/19/redis-cover_20251119150545A001.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-19 15:06:15\",\"currentParticipants\":0,\"delFlag\":\"0\",\"description\":\"测试\",\"endTime\":\"2026-02-11T00:00:00\",\"id\":14,\"maxParticipants\":100,\"name\":\"测试通过\",\"organizer\":\"彩色\",\"params\":{},\"remark\":\"测试\",\"startTime\":\"2025-12-25T00:00:00\",\"status\":\"0\",\"venueId\":11}','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"applicantName\":\"admin\",\"applicantUserId\":1,\"applyReason\":\"测试\",\"applyTime\":\"2025-11-19 15:06:15.196\",\"category\":\"展览\",\"contactPhone\":\"17744775544\",\"coverImage\":\"/profile/upload/2025/11/19/redis-cover_20251119150545A001.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-19 15:06:15\",\"currentParticipants\":0,\"delFlag\":\"0\",\"description\":\"测试\",\"endTime\":\"2026-02-11T00:00:00\",\"id\":14,\"maxParticipants\":100,\"name\":\"测试通过\",\"organizer\":\"彩色\",\"params\":{},\"remark\":\"测试\",\"startTime\":\"2025-12-25T00:00:00\",\"status\":\"0\",\"venueId\":11}}','0','',NULL,100,'2025-11-19 15:06:15',0,NULL),(275,'特色活动审批',2,'cn.edu.cquet.tourism.controller.TourismActivityApprovalController.pass()','POST',1,'admin','研发部门','/tourism/activity-approval/14/pass','127.0.0.1','内网IP','{\"opinion\":\"可以\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,29,'2025-11-19 15:06:27',0,NULL),(276,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/14/status/1','127.0.0.1','内网IP','14 \"1\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,15,'2025-11-19 15:09:51',0,NULL),(277,'特色活动',2,'cn.edu.cquet.tourism.controller.TourismActivityController.edit()','PUT',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"applicantName\":\"admin\",\"applicantUserId\":1,\"applyReason\":\"测试\",\"category\":\"演出\",\"contactPhone\":\"18983432250\",\"coverImage\":\"\",\"currentParticipants\":0,\"description\":\"测试2\",\"endTime\":\"2025-12-04T00:00:00\",\"id\":13,\"maxParticipants\":1,\"name\":\"测试测试测试\",\"organizer\":\"我\",\"params\":{},\"startTime\":\"2025-11-30T00:00:00\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-19 15:16:08\",\"venueId\":10}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,40,'2025-11-19 15:16:09',0,NULL),(278,'特色活动',1,'cn.edu.cquet.tourism.controller.TourismActivityController.add()','POST',1,'admin','研发部门','/tourism/activity','127.0.0.1','内网IP','{\"applicantName\":\"admin\",\"applicantUserId\":1,\"applyReason\":\"测试\",\"applyTime\":\"2025-11-19T15:17:58.314+08:00\",\"category\":\"展览\",\"createBy\":\"admin\",\"createTime\":\"2025-11-19 15:17:58\",\"currentParticipants\":0,\"delFlag\":\"0\",\"endTime\":\"2029-11-16T00:00:00\",\"id\":15,\"maxParticipants\":5,\"name\":\"测\",\"params\":{},\"startTime\":\"2028-11-01T00:00:00\",\"status\":\"0\",\"venueId\":10}','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"applicantName\":\"admin\",\"applicantUserId\":1,\"applyReason\":\"测试\",\"applyTime\":\"2025-11-19T15:17:58.314+08:00\",\"category\":\"展览\",\"createBy\":\"admin\",\"createTime\":\"2025-11-19 15:17:58\",\"currentParticipants\":0,\"delFlag\":\"0\",\"endTime\":\"2029-11-16T00:00:00\",\"id\":15,\"maxParticipants\":5,\"name\":\"测\",\"params\":{},\"startTime\":\"2028-11-01T00:00:00\",\"status\":\"0\",\"venueId\":10}}','0','',NULL,27,'2025-11-19 15:17:58',0,NULL),(279,'特色活动审批',2,'cn.edu.cquet.tourism.controller.TourismActivityApprovalController.reject()','POST',1,'admin','研发部门','/tourism/activity-approval/15/reject','127.0.0.1','内网IP','{\"reason\":\"测\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,195,'2026-03-24 23:46:40',0,NULL),(280,'特色活动',3,'cn.edu.cquet.tourism.controller.TourismActivityController.remove()','DELETE',1,'admin','研发部门','/tourism/activity/15','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,14,'2026-03-24 23:46:50',0,NULL),(281,'A级景区',2,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()','PUT',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"本地辖区\",\"city\":\"广东省广州市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:20:17\",\"delFlag\":\"0\",\"description\":\"广州著名景点\",\"district\":\"市辖区\",\"id\":28,\"latitude\":3,\"level\":\"AAAAA\",\"longitude\":2,\"name\":\"广州塔\",\"openingHours\":\"全天\",\"params\":{},\"remark\":\"测试\",\"status\":\"0\",\"ticketPrice\":50,\"updateBy\":\"admin\",\"updateTime\":\"2026-03-24 23:55:21\",\"viewCount\":0,\"website\":\"cquet\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,59,'2026-03-24 23:55:21',0,NULL),(282,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}','0','',NULL,7,'2026-03-24 23:55:22',0,NULL),(283,'A级景区',2,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()','PUT',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"测试\",\"city\":\"北京市\",\"collectionCount\":0,\"contactPhone\":\"18988444455\",\"coverImage\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-11-19 11:38:55\",\"delFlag\":\"0\",\"district\":\"东城区\",\"id\":29,\"latitude\":0,\"level\":\"AAAAA\",\"longitude\":0,\"name\":\"测试景区\",\"openingHours\":\"9:00-21:00\",\"params\":{},\"remark\":\"测试\",\"status\":\"0\",\"ticketPrice\":5,\"updateBy\":\"admin\",\"updateTime\":\"2026-03-24 23:55:27\",\"viewCount\":0,\"website\":\"测试\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,20,'2026-03-24 23:55:28',0,NULL),(284,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}','0','',NULL,7,'2026-03-24 23:55:28',0,NULL),(285,'A级景区',2,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()','PUT',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"广州塔 广东省广州市海珠区阅江西路222号(广州塔站B出口170米左右)\",\"city\":\"广州市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2026/03/24/生成Kirin头像 (1)_20260324235948A001.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:20:17\",\"delFlag\":\"0\",\"description\":\"广州著名景点\",\"district\":\"海珠区\",\"id\":28,\"latitude\":23.112047190324763,\"level\":\"AAAAA\",\"longitude\":113.33107523708054,\"name\":\"广州塔\",\"openingHours\":\"全天\",\"params\":{},\"remark\":\"测试\",\"status\":\"0\",\"ticketPrice\":0,\"updateBy\":\"admin\",\"updateTime\":\"2026-03-24 23:59:49\",\"viewCount\":0,\"website\":\"cquet\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,18,'2026-03-24 23:59:50',0,NULL),(286,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}','0','',NULL,2,'2026-03-24 23:59:50',0,NULL),(287,'A级景区',1,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()','POST',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"茶山竹海 重庆市永川区413省道\",\"city\":\"重庆市\",\"createBy\":\"admin\",\"createTime\":\"2026-03-25 00:00:50\",\"delFlag\":\"0\",\"description\":\"侧耳\",\"district\":\"永川区\",\"id\":30,\"latitude\":29.424359383185568,\"level\":\"AA\",\"longitude\":105.94172182127348,\"name\":\"茶山竹海\",\"openingHours\":\"6:00-18:30\",\"params\":{},\"ticketPrice\":0}','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"address\":\"茶山竹海 重庆市永川区413省道\",\"city\":\"重庆市\",\"createBy\":\"admin\",\"createTime\":\"2026-03-25 00:00:50\",\"delFlag\":\"0\",\"description\":\"侧耳\",\"district\":\"永川区\",\"id\":30,\"latitude\":29.424359383185568,\"level\":\"AA\",\"longitude\":105.94172182127348,\"name\":\"茶山竹海\",\"openingHours\":\"6:00-18:30\",\"params\":{},\"ticketPrice\":0}}','0','',NULL,21,'2026-03-25 00:00:50',0,NULL),(288,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}','0','',NULL,4,'2026-03-25 00:00:50',0,NULL),(289,'A级景区',3,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.remove()','DELETE',1,'admin','研发部门','/tourism/scenic-spot/28','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,21,'2026-03-25 00:08:08',0,NULL),(290,'A级景区',2,'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()','PUT',1,'admin','研发部门','/tourism/scenic-spot','127.0.0.1','内网IP','{\"address\":\"重庆市沙坪坝区天马路71号\",\"city\":\"重庆市\",\"collectionCount\":0,\"contactPhone\":\"18988444455\",\"coverImage\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-11-19 11:38:55\",\"delFlag\":\"0\",\"district\":\"沙坪坝区\",\"id\":29,\"latitude\":29.545918529814482,\"level\":\"AAAAA\",\"longitude\":106.46618104435987,\"name\":\"测试景区\",\"openingHours\":\"9:00-21:00\",\"params\":{},\"remark\":\"测试\",\"status\":\"0\",\"ticketPrice\":5,\"updateBy\":\"admin\",\"updateTime\":\"2026-03-25 00:11:42\",\"viewCount\":0,\"website\":\"测试\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,16,'2026-03-25 00:11:42',0,NULL),(291,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}','0','',NULL,4,'2026-03-25 00:11:43',0,NULL),(292,'场馆管理',3,'cn.edu.cquet.tourism.controller.tourismVenueController.remove()','DELETE',1,'admin','研发部门','/tourism/venue/11','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,25,'2026-03-25 00:16:11',0,NULL),(293,'特色活动',3,'cn.edu.cquet.tourism.controller.TourismActivityController.remove()','DELETE',1,'admin','研发部门','/tourism/activity/13','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,31,'2026-03-25 00:16:17',0,NULL),(294,'场馆管理',2,'cn.edu.cquet.tourism.controller.tourismVenueController.edit()','PUT',1,'admin','研发部门','/tourism/venue','127.0.0.1','内网IP','{\"address\":\"重庆市江津区\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"教学\",\"city\":\"重庆市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:21:37\",\"delFlag\":\"0\",\"description\":\"教学\",\"district\":\"江津区\",\"id\":10,\"latitude\":29.40908164039547,\"longitude\":106.32762640254664,\"name\":\"教学楼\",\"openingHours\":\"早上8:00-晚上22:00\",\"params\":{},\"status\":\"0\",\"ticketPrice\":0,\"updateBy\":\"admin\",\"updateTime\":\"2026-03-25 00:17:12\",\"viewCount\":0,\"website\":\"\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,26,'2026-03-25 00:17:13',0,NULL),(295,'图片管理',1,'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()','POST',1,'admin','研发部门','/tourism/images/batch','127.0.0.1','内网IP','[]','{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}','0','',NULL,4,'2026-03-25 00:17:13',0,NULL),(296,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/images/index\",\"createBy\":\"admin\",\"createTime\":\"2026-04-21 08:19:57\",\"delFlag\":\"0\",\"icon\":\"tab\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2082,\"menuName\":\"图片管理\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2072,\"path\":\"images\",\"perms\":\"tourism:image:list\",\"remark\":\"旅游图片管理页面\",\"routeName\":\"TourismImages\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-04-21 16:26:23\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,41,'2026-04-21 16:26:24',0,NULL),(297,'图片管理',3,'cn.edu.cquet.tourism.controller.admin.TourismImageController.remove()','DELETE',1,'admin','研发部门','/tourism/images/23,16,17,18,19,20,21,22,28,27','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,47,'2026-04-21 18:06:09',0,NULL),(298,'图片管理',3,'cn.edu.cquet.tourism.controller.admin.TourismImageController.remove()','DELETE',1,'admin','研发部门','/tourism/images/29,26,25,24,10,15,14,13,12,11','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,35,'2026-04-21 18:06:13',0,NULL),(299,'图片管理',3,'cn.edu.cquet.tourism.controller.admin.TourismImageController.remove()','DELETE',1,'admin','研发部门','/tourism/images/1,2,3,4,5,6,7,8,9','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,12,'2026-04-21 18:06:18',0,NULL),(300,'特色活动',2,'cn.edu.cquet.tourism.controller.admin.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/5/status/1','127.0.0.1','内网IP','5 \"1\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,42,'2026-04-21 20:36:14',0,NULL),(301,'特色活动',2,'cn.edu.cquet.tourism.controller.admin.TourismActivityController.updateStatus()','PUT',1,'admin','研发部门','/tourism/activity/5/status/0','127.0.0.1','内网IP','5 \"0\"','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,10,'2026-04-21 20:36:15',0,NULL),(302,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/images/index\",\"createBy\":\"admin\",\"createTime\":\"2026-04-21 08:19:57\",\"delFlag\":\"0\",\"icon\":\"download\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2082,\"menuName\":\"图片管理\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2072,\"path\":\"images\",\"perms\":\"tourism:image:list\",\"remark\":\"旅游图片管理页面\",\"routeName\":\"TourismImages\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-05-06 15:21:13\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,49,'2026-05-06 15:21:14',0,NULL),(303,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/images/index\",\"createBy\":\"admin\",\"createTime\":\"2026-04-21 08:19:57\",\"delFlag\":\"0\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2082,\"menuName\":\"图片管理\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2072,\"path\":\"images\",\"perms\":\"tourism:image:list\",\"remark\":\"旅游图片管理页面\",\"routeName\":\"TourismImages\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-05-06 15:22:18\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,38,'2026-05-06 15:22:18',0,NULL),(304,'菜单管理',2,'cn.edu.cquet.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":8,\"params\":{},\"parentId\":2072,\"path\":\"news\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"TourismNews\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-05-06 15:22:44\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,13,'2026-05-06 15:22:45',0,NULL),(305,'用户管理',3,'cn.edu.cquet.web.controller.system.SysUserController.remove()','DELETE',1,'admin','研发部门','/system/user/2','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,49,'2026-05-06 15:23:22',0,NULL),(306,'部门管理',3,'cn.edu.cquet.web.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/109','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,12,'2026-05-06 15:23:33',0,NULL),(307,'部门管理',3,'cn.edu.cquet.web.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/108','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,15,'2026-05-06 15:23:36',0,NULL),(308,'部门管理',3,'cn.edu.cquet.web.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/102','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,12,'2026-05-06 15:23:38',0,NULL),(309,'部门管理',3,'cn.edu.cquet.web.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/107','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,13,'2026-05-06 15:23:44',0,NULL),(310,'部门管理',3,'cn.edu.cquet.web.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/106','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,13,'2026-05-06 15:23:45',0,NULL),(311,'部门管理',3,'cn.edu.cquet.web.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/105','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,11,'2026-05-06 15:23:47',0,NULL),(312,'部门管理',3,'cn.edu.cquet.web.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/104','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,13,'2026-05-06 15:23:48',0,NULL),(313,'部门管理',3,'cn.edu.cquet.web.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/103','127.0.0.1','内网IP','{}','{\"msg\":\"部门存在用户,不允许删除\",\"code\":601}','0','',NULL,6,'2026-05-06 15:23:51',0,NULL),(314,'部门管理',2,'cn.edu.cquet.web.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"ancestors\":\"0\",\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2024-09-04 06:22:51\",\"delFlag\":\"0\",\"deptId\":100,\"deptName\":\"重庆文旅公司\",\"email\":\"liuxin@qq.com\",\"leader\":\"Liuxin\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-05-06 15:28:58\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,45,'2026-05-06 15:28:58',0,NULL),(315,'部门管理',2,'cn.edu.cquet.web.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"ancestors\":\"0\",\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2024-09-04 06:22:51\",\"delFlag\":\"0\",\"deptId\":100,\"deptName\":\"重庆文旅公司\",\"email\":\"liuxin@qq.com\",\"leader\":\"Liuxin\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"18983432250\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-05-06 15:29:06\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,13,'2026-05-06 15:29:07',0,NULL),(316,'用户管理',2,'cn.edu.cquet.web.controller.system.SysUserController.edit()','PUT',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":true,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2024-09-04 06:22:51\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"CQUET\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":100,\"email\":\"CQUET@163.com\",\"loginDate\":\"2026-05-06 15:08:24\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"CQUET\",\"params\":{},\"phonenumber\":\"15888888888\",\"postIds\":[1],\"remark\":\"管理员\",\"roleIds\":[1],\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":1,\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}','','1','不允许操作超级管理员用户',NULL,1,'2026-05-06 15:29:37',0,NULL),(317,'用户管理',2,'cn.edu.cquet.web.controller.system.SysUserController.edit()','PUT',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":true,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2024-09-04 06:22:51\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"CQUET\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":100,\"email\":\"CQUET@163.com\",\"loginDate\":\"2026-05-06 15:08:24\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"CQUET\",\"params\":{},\"phonenumber\":\"15888888888\",\"postIds\":[1],\"remark\":\"管理员\",\"roleIds\":[1],\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":1,\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}','','1','不允许操作超级管理员用户',NULL,0,'2026-05-06 15:29:44',0,NULL),(318,'部门管理',3,'cn.edu.cquet.web.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/103','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,11,'2026-05-06 15:32:05',0,NULL),(319,'部门管理',2,'cn.edu.cquet.web.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"ancestors\":\"0\",\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2024-09-04 06:22:51\",\"delFlag\":\"0\",\"deptId\":100,\"deptName\":\"寰宇文旅公司\",\"email\":\"liuxin@qq.com\",\"leader\":\"Liuxin\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"18983432250\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-05-06 15:32:41\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,15,'2026-05-06 15:32:41',0,NULL),(320,'部门管理',2,'cn.edu.cquet.web.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2024-09-04 06:22:51\",\"delFlag\":\"0\",\"deptId\":101,\"deptName\":\"重庆文旅公司\",\"email\":\"1371149587@qq.com\",\"leader\":\"liuxin\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"phone\":\"18983432250\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-05-06 15:33:24\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,38,'2026-05-06 15:33:24',0,NULL),(321,'用户管理',1,'cn.edu.cquet.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"createTime\":\"2026-05-06 15:34:45\",\"deptId\":101,\"email\":\"1371149587@qq.com\",\"nickName\":\"平台管理员\",\"params\":{},\"phonenumber\":\"18983432250\",\"postIds\":[],\"remark\":\"我真就是平台管理员啊\",\"roleIds\":[100],\"sex\":\"0\",\"status\":\"0\",\"userId\":107,\"userName\":\"pt\"}','{\"msg\":\"操作成功\",\"code\":200}','0','',NULL,84,'2026-05-06 15:34:45',0,NULL);
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_post`
--

DROP TABLE IF EXISTS `sys_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1',1,1,'0','0','admin','2024-09-04 06:22:51','',NULL,'超级管理员'),(2,'普通角色','common',2,'2',1,1,'0','0','admin','2024-09-04 06:22:51','admin','2025-10-25 21:22:14','普通角色'),(100,'平台管理员','platform_admin',3,'1',1,1,'0','0','admin','2026-05-06 07:16:36','admin','2026-05-06 07:18:58','管理重庆景点平台运营数据、文旅内容与活动审核');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
INSERT INTO `sys_role_menu` VALUES (1,2072),(1,2073),(1,2074),(1,2075),(1,2076),(1,2077),(1,2078),(1,2080),(1,2081),(1,2082),(1,2084),(1,2085),(1,2086),(1,2087),(1,2088),(1,2089),(1,2090),(1,2091),(1,2092),(1,2093),(1,2094),(1,2095),(1,2096),(1,2097),(1,2098),(1,2099),(1,2100),(1,2101),(1,2102),(1,2103),(1,2104),(1,2105),(1,2106),(1,2107),(1,2108),(1,2109),(1,2110),(1,2111),(1,2112),(1,2113),(1,2114),(1,2115),(1,2116),(1,2117),(1,2118),(1,2119),(1,2120),(1,2121),(1,2122),(1,2123),(1,2124),(2,1),(2,100),(2,101),(2,102),(2,103),(2,104),(2,105),(2,106),(2,107),(2,108),(2,500),(2,501),(2,1000),(2,1001),(2,1002),(2,1003),(2,1004),(2,1005),(2,1006),(2,1007),(2,1008),(2,1009),(2,1010),(2,1011),(2,1012),(2,1013),(2,1014),(2,1015),(2,1016),(2,1017),(2,1018),(2,1019),(2,1020),(2,1021),(2,1022),(2,1023),(2,1024),(2,1025),(2,1026),(2,1027),(2,1028),(2,1029),(2,1030),(2,1031),(2,1032),(2,1033),(2,1034),(2,1035),(2,1036),(2,1037),(2,1038),(2,1039),(2,1040),(2,1041),(2,1042),(2,1043),(2,1044),(2,1045),(2,2072),(2,2073),(2,2074),(2,2075),(2,2076),(2,2077),(2,2078),(2,2080),(2,2081),(2,2082),(2,2084),(2,2085),(2,2086),(2,2087),(2,2088),(2,2089),(2,2090),(2,2091),(2,2092),(2,2093),(2,2094),(2,2095),(2,2096),(2,2097),(2,2098),(2,2099),(2,2100),(2,2101),(2,2102),(2,2103),(2,2104),(2,2105),(2,2106),(2,2107),(2,2108),(2,2109),(2,2110),(2,2111),(2,2112),(2,2113),(2,2114),(2,2115),(2,2116),(2,2117),(2,2118),(2,2119),(2,2120),(2,2121),(2,2122),(2,2123),(2,2124),(100,2072),(100,2073),(100,2074),(100,2075),(100,2076),(100,2077),(100,2078),(100,2080),(100,2081),(100,2082),(100,2084),(100,2085),(100,2086),(100,2087),(100,2088),(100,2089),(100,2090),(100,2091),(100,2092),(100,2093),(100,2094),(100,2095),(100,2096),(100,2097),(100,2098),(100,2099),(100,2100),(100,2101),(100,2102),(100,2103),(100,2104),(100,2105),(100,2106),(100,2107),(100,2108),(100,2109),(100,2110),(100,2111),(100,2112),(100,2113),(100,2114),(100,2115),(100,2116),(100,2117),(100,2118),(100,2119),(100,2120),(100,2121),(100,2122),(100,2123),(100,2124);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,100,'admin','CQUET','00','CQUET@163.com','15888888888','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2026-05-06 15:08:24','admin','2024-09-04 06:22:51','admin','2026-05-06 07:30:43','管理员'),(2,105,'ry','测试','00','ry@qq.com','15666666666','1','','$2a$10$TZh50TgviSV8zEftiwy7ZuNHrdw7a.yloDmWLbNSDO1PSTacSvLRG','0','2','127.0.0.1','2025-10-25 21:23:26','admin','2024-09-04 06:22:51',NULL,'2025-10-25 21:23:26','测试员1'),(105,NULL,'liyuan','liyuan','00','','','0','','$2a$10$tgq/ctqpuY/moLaKttk/peQyxTfsy1X7nRW3MVYNCZYIuNvbqfVGK','0','0','127.0.0.1','2025-11-14 17:03:38',NULL,'2025-10-27 15:12:23',NULL,'2025-11-14 17:03:38',NULL),(106,NULL,'liuxin','liuxin','00','','','0','','$2a$10$VZGYnRKhO9WtrwvFOVwPUecAFUwpNTvt8NmsoVRqGz/3MOqpWeU92','0','0','127.0.0.1','2026-03-24 22:22:48',NULL,'2026-03-24 22:22:39',NULL,'2026-03-24 22:22:48',NULL),(107,101,'pt','平台管理员','00','1371149587@qq.com','18983432250','0','','$2a$10$dumGFfOQISnN3mKN1ZyBCegFVXIJLiObAMfKwC2.HJje2F45QyyT2','0','0','127.0.0.1','2026-05-06 15:35:04','admin','2026-05-06 15:34:45',NULL,'2026-05-06 15:35:04','我真就是平台管理员啊');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
INSERT INTO `sys_user_post` VALUES (1,1);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
INSERT INTO `sys_user_role` VALUES (1,1),(107,100);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_activity`
--

DROP TABLE IF EXISTS `tourism_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tourism_activity` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '活动ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '活动名称',
  `cover_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '活动封面图片URL',
  `cover_image_id` bigint DEFAULT NULL COMMENT '封面图片ID',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '活动类别（文化体验、艺术表演、教育活动等）',
  `venue_id` bigint DEFAULT NULL COMMENT '举办场馆ID',
  `organizer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '主办方',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '联系电话',
  `start_time` datetime DEFAULT NULL COMMENT '活动开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '活动结束时间',
  `registration_start` datetime DEFAULT NULL COMMENT '报名开始时间',
  `registration_end` datetime DEFAULT NULL COMMENT '报名结束时间',
  `max_participants` int DEFAULT '0' COMMENT '最大参与人数（0表示不限制）',
  `applicant_user_id` bigint DEFAULT NULL,
  `applicant_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `apply_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `apply_time` datetime DEFAULT NULL,
  `audit_status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '审核状态（0待审核 1通过 2拒绝）',
  `current_participants` int DEFAULT '0' COMMENT '当前报名人数',
  `fee` decimal(10,2) DEFAULT '0.00' COMMENT '活动费用（0表示免费）',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '活动详细介绍',
  `requirements` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '参与要求',
  `view_count` int DEFAULT '0' COMMENT '浏览次数',
  `comment_count` int DEFAULT '0' COMMENT '评论次数',
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
  KEY `idx_venue_id` (`venue_id`) USING BTREE,
  KEY `idx_start_time` (`start_time`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE,
  KEY `idx_activity_time` (`start_time`,`end_time`) USING BTREE,
  KEY `idx_activity_venue` (`venue_id`) USING BTREE,
  KEY `idx_activity_name` (`name`) USING BTREE,
  KEY `idx_tourism_activity_cover_image_id` (`cover_image_id`),
  KEY `idx_tourism_activity_audit_status` (`audit_status`),
  CONSTRAINT `fk_activity_venue` FOREIGN KEY (`venue_id`) REFERENCES `tourism_venue` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='特色活动信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_activity`
--

LOCK TABLES `tourism_activity` WRITE;
/*!40000 ALTER TABLE `tourism_activity` DISABLE KEYS */;
INSERT INTO `tourism_activity` VALUES (1,'川剧变脸沉浸体验课','https://picsum.photos/seed/cq-activity-opera/900/560',13,'演出',3,'重庆大剧院运营中心','023-61863166','2026-05-02 19:30:00','2026-05-02 21:00:00','2026-04-15 09:00:00','2026-05-01 18:00:00',120,1001,'李老师','面向游客展示川剧变脸与戏曲服饰文化，适合作为夜间文旅体验活动。','2026-04-10 10:00:00','1',48,68.00,'专业演员现场演示川剧变脸技法，穿插巴渝戏曲文化讲解和互动体验。','建议提前15分钟入场，活动期间请勿使用闪光灯。',960,6,'0','admin','2026-04-10 10:05:00','admin','2026-04-12 09:00:00','已通过审核活动','0'),(2,'山城阅读分享会','https://picsum.photos/seed/cq-activity-book/900/560',14,'讲座',1,'重庆图书馆阅读推广部','023-65210822','2026-05-06 14:30:00','2026-05-06 16:30:00','2026-04-18 09:00:00','2026-05-05 18:00:00',80,1002,'王策展','结合重庆城市文学作品，开展公共阅读推广。','2026-04-12 09:20:00','0',12,0.00,'邀请本地作家和读者围绕山城记忆、江岸生活进行分享。','需提前预约，入馆请遵守图书馆秩序。',320,1,'0','admin','2026-04-12 09:30:00','admin','2026-04-12 09:30:00','待审核活动','0'),(3,'城市夜跑文化节','https://picsum.photos/seed/cq-activity-marathon/900/560',15,'赛事',4,'九龙坡区体育服务中心','023-68070777','2026-05-10 19:00:00','2026-05-10 21:30:00','2026-04-20 09:00:00','2026-05-08 18:00:00',800,1003,'陈运营','计划在奥体中心开展夜跑活动，带动夜间消费。','2026-04-13 11:00:00','2',0,39.00,'城市夜跑结合音乐补给站和文旅打卡点，面向青年游客和市民。','需身体健康，报名需提交紧急联系人。',120,0,'1','admin','2026-04-13 11:10:00','admin','2026-04-14 10:00:00','审核拒绝活动','0'),(4,'巴渝文化专题展导览','https://picsum.photos/seed/cq-activity-exhibition/900/560',16,'展览',2,'三峡博物馆公共教育部','023-63679066','2026-05-12 10:00:00','2026-05-12 11:30:00','2026-04-16 09:00:00','2026-05-11 18:00:00',60,1004,'周讲解','围绕巴渝历史文化开展专题导览。','2026-04-13 15:30:00','1',35,0.00,'讲解员带领观众走进巴渝文化展厅，认识重庆码头、移民和抗战文化。','请准时到达博物馆一楼集合点。',610,3,'0','admin','2026-04-13 15:40:00','admin','2026-04-15 09:00:00','免费公共教育活动','0'),(5,'非遗手作体验课堂','https://picsum.photos/seed/cq-activity-handcraft/900/560',24,'Workshop',5,'重庆美术馆公共教育中心','023-63920626','2026-05-16 15:00:00','2026-05-16 17:00:00','2026-04-22 09:00:00','2026-05-15 18:00:00',40,1005,'赵老师','通过手作方式让游客理解重庆非遗元素。','2026-04-14 10:30:00','1',18,49.00,'以剪纸、版画和文创纹样为载体开展体验式课程。','适合10岁以上参与，材料包现场领取。',480,2,'0','admin','2026-04-14 10:40:00','admin','2026-04-21 20:36:15','收费小班活动','0'),(6,'重庆火锅文化体验日','https://picsum.photos/seed/cq-activity-food/900/560',25,'节庆',2,'重庆文旅体验联盟','023-63679066','2026-05-20 18:00:00','2026-05-20 20:30:00','2026-04-25 09:00:00','2026-05-18 18:00:00',100,1006,'刘运营','结合三峡博物馆临展做火锅文化体验。','2026-04-15 14:00:00','0',0,88.00,'从火锅器具、码头文化和食材故事切入，展示重庆饮食文化。','活动含试吃，请备注忌口信息。',210,0,'0','admin','2026-04-15 14:10:00','admin','2026-04-15 14:10:00','待审核收费活动','0'),(7,'亲子科学探索营','https://picsum.photos/seed/cq-activity-kids/900/560',26,'亲子',6,'重庆科技馆教育部','023-61863051','2026-05-24 09:30:00','2026-05-24 12:00:00','2026-04-26 09:00:00','2026-05-22 18:00:00',50,1007,'孙老师','面向家庭开展周末科学启蒙活动。','2026-04-16 10:00:00','1',42,0.00,'围绕桥梁结构、山城交通和基础物理实验设计亲子任务。','一名儿童需至少一名监护人陪同。',530,4,'1','admin','2026-04-16 10:10:00','admin','2026-04-17 09:00:00','已通过但场馆停用联动测试','0'),(8,'江畔民谣音乐会','https://picsum.photos/seed/cq-activity-music/900/560',27,'演出',3,'重庆青年音乐社','023-61863166','2026-05-28 20:00:00','2026-05-28 22:00:00','2026-04-28 09:00:00','2026-05-27 18:00:00',300,1008,'何策划','打造面向游客的江畔夜间音乐活动。','2026-04-17 16:00:00','1',126,128.00,'精选重庆本地音乐人，以山城、江岸、夜景为主题进行现场演出。','实名预约，演出开始后迟到观众需等候入场。',890,5,'0','admin','2026-04-17 16:10:00','admin','2026-04-18 09:00:00','高热度活动','0');
/*!40000 ALTER TABLE `tourism_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_activity_approval`
--

DROP TABLE IF EXISTS `tourism_activity_approval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tourism_activity_approval` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '审批记录ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `auditor` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '审核人',
  `audit_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '审核状态（0待审核 1审核通过 2审核拒绝）',
  `reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '审核意见/不通过原因',
  `audit_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '审核时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0存在 2删除）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（预留，兼容基础实体）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_approval_activity_time` (`activity_id`,`audit_time`) USING BTREE,
  CONSTRAINT `fk_approval_activity` FOREIGN KEY (`activity_id`) REFERENCES `tourism_activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='特色活动审批记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_activity_approval`
--

LOCK TABLES `tourism_activity_approval` WRITE;
/*!40000 ALTER TABLE `tourism_activity_approval` DISABLE KEYS */;
INSERT INTO `tourism_activity_approval` VALUES (1,1,'admin','1','活动内容完整，安全与接待方案清晰，同意发布。','2026-04-12 09:00:00','admin','2026-04-12 09:00:00','admin','2026-04-12 09:00:00','通过记录','0','0'),(2,3,'admin','2','夜跑路线、医疗保障和交通疏导方案不完整，暂不通过。','2026-04-14 10:00:00','admin','2026-04-14 10:00:00','admin','2026-04-14 10:00:00','拒绝记录','0','0'),(3,4,'admin','1','公共教育活动内容清晰，符合场馆定位。','2026-04-15 09:00:00','admin','2026-04-15 09:00:00','admin','2026-04-15 09:00:00','通过记录','0','0'),(4,5,'admin','1','活动容量合理，收费说明清楚。','2026-04-16 09:00:00','admin','2026-04-16 09:00:00','admin','2026-04-16 09:00:00','通过记录','0','0'),(5,7,'admin','1','亲子活动有监护要求，同意发布。','2026-04-17 09:00:00','admin','2026-04-17 09:00:00','admin','2026-04-17 09:00:00','通过记录','0','0'),(6,8,'admin','1','演出安排和入场要求明确，同意发布。','2026-04-18 09:00:00','admin','2026-04-18 09:00:00','admin','2026-04-18 09:00:00','通过记录','0','0');
/*!40000 ALTER TABLE `tourism_activity_approval` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_activity_comment`
--

DROP TABLE IF EXISTS `tourism_activity_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='活动评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_activity_comment`
--

LOCK TABLES `tourism_activity_comment` WRITE;
/*!40000 ALTER TABLE `tourism_activity_comment` DISABLE KEYS */;
INSERT INTO `tourism_activity_comment` VALUES (1,1,105,'liyuan','变脸体验很有重庆特色，适合外地朋友第一次来玩。',0,'0','web','2026-04-18 20:10:00','web','2026-04-18 20:10:00',NULL,'0'),(2,1,106,'liuxin','希望后续增加戏服试穿环节。',0,'0','web','2026-04-18 20:30:00','web','2026-04-18 20:30:00',NULL,'0'),(3,4,2,'ry','导览节奏很好，巴渝历史部分很清晰。',0,'0','web','2026-04-19 11:20:00','web','2026-04-19 11:20:00',NULL,'0'),(4,5,105,'liyuan','材料包设计不错，小朋友很喜欢。',0,'0','web','2026-04-19 17:10:00','web','2026-04-19 17:10:00',NULL,'0'),(5,8,106,'liuxin','江边音乐会氛围感很强。',0,'0','web','2026-04-20 21:10:00','web','2026-04-20 21:10:00',NULL,'0');
/*!40000 ALTER TABLE `tourism_activity_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_facilities`
--

DROP TABLE IF EXISTS `tourism_facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tourism_facilities` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '设备主键',
  `facilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '设备名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='设备信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_facilities`
--

LOCK TABLES `tourism_facilities` WRITE;
/*!40000 ALTER TABLE `tourism_facilities` DISABLE KEYS */;
INSERT INTO `tourism_facilities` VALUES (1,'停车场'),(2,'无障碍通道'),(3,'游客服务中心'),(4,'母婴室'),(5,'公共卫生间'),(6,'文创商店'),(7,'讲解服务'),(8,'餐饮区');
/*!40000 ALTER TABLE `tourism_facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_image`
--

DROP TABLE IF EXISTS `tourism_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tourism_image` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '图片主键',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图片URL地址',
  `file_name` varchar(200) DEFAULT NULL COMMENT '系统文件名',
  `original_name` varchar(200) DEFAULT NULL COMMENT '原始文件名',
  `file_ext` varchar(20) DEFAULT NULL COMMENT '文件后缀',
  `mime_type` varchar(100) DEFAULT NULL COMMENT 'MIME类型',
  `file_size` bigint DEFAULT '0' COMMENT '文件大小，单位字节',
  `storage_type` varchar(20) DEFAULT 'local' COMMENT '存储类型：local/oss',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0存在 2删除）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tourism_image_url` (`image_url`),
  KEY `idx_tourism_image_status` (`status`),
  KEY `idx_tourism_image_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='旅游图片信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_image`
--

LOCK TABLES `tourism_image` WRITE;
/*!40000 ALTER TABLE `tourism_image` DISABLE KEYS */;
INSERT INTO `tourism_image` VALUES (1,'https://picsum.photos/seed/cq-hongyadong/900/560','cq_hongyadong_cover.jpg','洪崖洞夜景封面.jpg','jpg','image/jpeg',286720,'remote','0','admin','2026-04-01 09:10:00','','2026-04-21 10:43:39','景区封面','0'),(2,'https://picsum.photos/seed/cq-dazu/900/560','cq_dazu_cover.jpg','大足石刻封面.jpg','jpg','image/jpeg',301056,'remote','0','admin','2026-04-01 09:12:00','','2026-04-21 10:43:39','景区封面','0'),(3,'https://picsum.photos/seed/cq-wulong/900/560','cq_wulong_cover.jpg','武隆天生三桥封面.jpg','jpg','image/jpeg',315392,'remote','0','admin','2026-04-01 09:14:00','','2026-04-21 10:43:39','景区封面','0'),(4,'https://picsum.photos/seed/cq-jinfo/900/560','cq_jinfo_cover.jpg','金佛山封面.jpg','jpg','image/jpeg',294912,'remote','0','admin','2026-04-01 09:16:00','','2026-04-21 10:43:39','景区封面','0'),(5,'https://picsum.photos/seed/cq-ciqikou/900/560','cq_ciqikou_cover.jpg','磁器口古镇封面.jpg','jpg','image/jpeg',258048,'remote','0','admin','2026-04-01 09:18:00','','2026-04-21 10:43:39','景区封面','0'),(6,'https://picsum.photos/seed/cq-nanshan/900/560','cq_nanshan_cover.jpg','南山一棵树封面.jpg','jpg','image/jpeg',270336,'remote','0','admin','2026-04-01 09:20:00','','2026-04-21 10:43:39','景区封面','0'),(7,'https://picsum.photos/seed/cq-library/900/560','cq_library_cover.jpg','重庆图书馆封面.jpg','jpg','image/jpeg',249856,'remote','0','admin','2026-04-01 09:22:00','','2026-04-21 10:43:39','场馆封面','0'),(8,'https://picsum.photos/seed/cq-museum/900/560','cq_museum_cover.jpg','重庆中国三峡博物馆封面.jpg','jpg','image/jpeg',333824,'remote','0','admin','2026-04-01 09:24:00','','2026-04-21 10:43:39','场馆封面','0'),(9,'https://picsum.photos/seed/cq-theatre/900/560','cq_theatre_cover.jpg','重庆大剧院封面.jpg','jpg','image/jpeg',344064,'remote','0','admin','2026-04-01 09:26:00','','2026-04-21 10:43:39','场馆封面','0'),(10,'https://picsum.photos/seed/cq-olympic/900/560','cq_olympic_cover.jpg','重庆奥体中心封面.jpg','jpg','image/jpeg',327680,'remote','0','admin','2026-04-01 09:28:00','','2026-04-21 10:43:39','场馆封面','0'),(11,'https://picsum.photos/seed/cq-art/900/560','cq_art_cover.jpg','重庆美术馆封面.jpg','jpg','image/jpeg',241664,'remote','0','admin','2026-04-01 09:30:00','','2026-04-21 10:43:39','场馆封面','0'),(12,'https://picsum.photos/seed/cq-science/900/560','cq_science_cover.jpg','重庆科技馆封面.jpg','jpg','image/jpeg',319488,'remote','0','admin','2026-04-01 09:32:00','','2026-04-21 10:43:39','场馆封面','0'),(13,'https://picsum.photos/seed/cq-activity-opera/900/560','cq_opera_activity.jpg','川剧变脸体验活动.jpg','jpg','image/jpeg',282624,'remote','0','admin','2026-04-02 10:00:00','','2026-04-21 10:43:39','活动封面','0'),(14,'https://picsum.photos/seed/cq-activity-book/900/560','cq_book_activity.jpg','山城阅读分享会.jpg','jpg','image/jpeg',220160,'remote','0','admin','2026-04-02 10:05:00','','2026-04-21 10:43:39','活动封面','0'),(15,'https://picsum.photos/seed/cq-activity-marathon/900/560','cq_marathon_activity.jpg','城市夜跑活动.jpg','jpg','image/jpeg',389120,'remote','0','admin','2026-04-02 10:10:00','','2026-04-21 10:43:39','活动封面','0'),(16,'https://picsum.photos/seed/cq-activity-exhibition/900/560','cq_exhibition_activity.jpg','巴渝文化展览.jpg','jpg','image/jpeg',286720,'remote','0','admin','2026-04-02 10:15:00','','2026-04-21 10:43:39','活动封面','0'),(17,'https://picsum.photos/seed/cq-news-cover/900/560','cq_news_cover.jpg','新闻封面通用图.jpg','jpg','image/jpeg',205824,'remote','0','admin','2026-04-02 10:20:00','','2026-04-21 10:43:39','新闻封面','0'),(18,'https://picsum.photos/seed/cq-scenic-gallery-a/900/560','cq_gallery_a.jpg','景区内容图A.jpg','jpg','image/jpeg',278528,'remote','0','admin','2026-04-02 10:25:00','','2026-04-21 10:43:39','内容图','0'),(19,'https://picsum.photos/seed/cq-scenic-gallery-b/900/560','cq_gallery_b.jpg','景区内容图B.jpg','jpg','image/jpeg',296960,'remote','0','admin','2026-04-02 10:30:00','','2026-04-21 10:43:39','内容图','0'),(20,'https://picsum.photos/seed/cq-scenic-gallery-c/900/560','cq_gallery_c.jpg','景区内容图C.jpg','jpg','image/jpeg',303104,'remote','0','admin','2026-04-02 10:35:00','','2026-04-21 10:43:39','内容图','0'),(21,'https://picsum.photos/seed/cq-venue-gallery-a/900/560','cq_venue_gallery_a.jpg','场馆内容图A.jpg','jpg','image/jpeg',266240,'remote','0','admin','2026-04-02 10:40:00','','2026-04-21 10:43:39','内容图','0'),(22,'https://picsum.photos/seed/cq-venue-gallery-b/900/560','cq_venue_gallery_b.jpg','场馆内容图B.jpg','jpg','image/jpeg',274432,'remote','0','admin','2026-04-02 10:45:00','','2026-04-21 10:43:39','内容图','0'),(23,'https://picsum.photos/seed/cq-venue-gallery-c/900/560','cq_venue_gallery_c.jpg','场馆内容图C.jpg','jpg','image/jpeg',290816,'remote','0','admin','2026-04-02 10:50:00','','2026-04-21 10:43:39','内容图','0'),(24,'https://picsum.photos/seed/cq-activity-handcraft/900/560','cq_handcraft_activity.jpg','非遗手作课堂.jpg','jpg','image/jpeg',248832,'remote','0','admin','2026-04-02 10:55:00','','2026-04-21 10:43:39','活动封面','0'),(25,'https://picsum.photos/seed/cq-activity-food/900/560','cq_food_activity.jpg','重庆火锅文化体验.jpg','jpg','image/jpeg',310272,'remote','0','admin','2026-04-02 11:00:00','','2026-04-21 10:43:39','活动封面','0'),(26,'https://picsum.photos/seed/cq-activity-kids/900/560','cq_kids_activity.jpg','亲子科学探索营.jpg','jpg','image/jpeg',236544,'remote','0','admin','2026-04-02 11:05:00','','2026-04-21 10:43:39','活动封面','0'),(27,'https://picsum.photos/seed/cq-activity-music/900/560','cq_music_activity.jpg','江畔民谣音乐会.jpg','jpg','image/jpeg',331776,'remote','0','admin','2026-04-02 11:10:00','','2026-04-21 10:43:39','活动封面','0'),(28,'https://picsum.photos/seed/cq-news-policy/900/560','cq_news_policy.jpg','政策新闻封面.jpg','jpg','image/jpeg',225280,'remote','0','admin','2026-04-02 11:15:00','','2026-04-21 10:43:39','新闻封面','0'),(29,'https://picsum.photos/seed/cq-news-season/900/560','cq_news_season.jpg','节庆新闻封面.jpg','jpg','image/jpeg',251904,'remote','0','admin','2026-04-02 11:20:00','','2026-04-21 10:43:39','新闻封面','0'),(30,'https://picsum.photos/seed/cq-news-traffic/900/560','cq_news_traffic.jpg','出行新闻封面.jpg','jpg','image/jpeg',215040,'remote','0','admin','2026-04-02 11:25:00','','2026-04-21 10:43:39','新闻封面','0');
/*!40000 ALTER TABLE `tourism_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_news`
--

DROP TABLE IF EXISTS `tourism_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tourism_news` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '标题',
  `cover_image_id` bigint DEFAULT NULL COMMENT '封面图片ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '新闻内容',
  `author` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '作者',
  `create_time` datetime DEFAULT NULL COMMENT '发布时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '修改者',
  `del_flag` int DEFAULT NULL COMMENT '删除标识（0：存在，2：删除）',
  `status` int DEFAULT NULL COMMENT '状态（0：正常，1：停用）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tourism_news_cover_image_id` (`cover_image_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='旅游项目表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_news`
--

LOCK TABLES `tourism_news` WRITE;
/*!40000 ALTER TABLE `tourism_news` DISABLE KEYS */;
INSERT INTO `tourism_news` VALUES (1,'重庆推出春夏文旅精品线路',17,'<p>围绕都市夜景、红色旅游、非遗体验和亲子研学，重庆推出多条春夏文旅精品线路，方便游客按主题选择行程。</p>','重庆文旅发布','2026-04-05 09:00:00','admin','2026-04-05 09:00:00','admin',0,0,'线路类新闻'),(2,'A级景区服务质量提升专项行动启动',28,'<p>为提升游客体验，相关部门将围绕景区导览、停车、卫生、安全提示等环节开展服务质量提升。</p>','资源管理科','2026-04-06 10:30:00','admin','2026-04-06 10:30:00','admin',0,0,'政策类新闻'),(3,'博物馆夜间开放试点受到市民欢迎',29,'<p>部分文化场馆探索夜间开放与主题导览，丰富城市夜间文旅消费场景。</p>','场馆服务中心','2026-04-07 14:20:00','admin','2026-04-07 14:20:00','admin',0,0,'场馆类新闻'),(4,'重庆非遗体验活动周即将开启',17,'<p>本次活动周将集中展示剪纸、川剧、传统手作等项目，游客可在线查看活动安排。</p>','活动运营组','2026-04-08 16:00:00','admin','2026-04-08 16:00:00','admin',0,0,'活动类新闻'),(5,'五一期间热门景区交通提示',30,'<p>五一假期热门景区周边车流较大，建议游客优先选择公共交通并提前预约。</p>','出行服务组','2026-04-09 08:30:00','admin','2026-04-09 08:30:00','admin',0,0,'出行提示新闻');
/*!40000 ALTER TABLE `tourism_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_notice`
--

DROP TABLE IF EXISTS `tourism_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tourism_notice` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '通知ID',
  `notice_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知标题',
  `notice_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '通知内容',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '通知类型（1通知 2公告）',
  `priority` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '优先级（0普通 1重要 2紧急）',
  `view_count` int DEFAULT '0' COMMENT '浏览次数',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_notice_type` (`notice_type`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE,
  KEY `idx_priority` (`priority`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_notice`
--

LOCK TABLES `tourism_notice` WRITE;
/*!40000 ALTER TABLE `tourism_notice` DISABLE KEYS */;
INSERT INTO `tourism_notice` VALUES (1,'关于完善景区基础信息的通知','<p>请各景区管理员及时核对开放时间、联系电话、门票价格和地图坐标，确保游客端展示准确。</p>','1','1',126,'0','admin','2026-04-05 10:00:00','admin','2026-04-05 10:00:00','管理端测试公告','0'),(2,'活动审核材料提交规范','<p>新增特色活动时，请补充活动时间、场馆、人数上限、安全要求和申报理由，便于后台审核。</p>','1','2',88,'0','admin','2026-04-06 09:30:00','admin','2026-04-06 09:30:00','审核流程公告','0'),(3,'图片资源命名建议','<p>上传图片建议使用资源类型、名称和用途进行命名，例如 scenic_hongyadong_cover.jpg。</p>','2','0',45,'0','admin','2026-04-07 11:00:00','admin','2026-04-07 11:00:00','图片管理公告','0'),(4,'数据大屏测试数据说明','<p>当前业务数据为测试环境构造数据，可用于验证资源分布、活动状态和区县统计展示。</p>','2','1',210,'0','admin','2026-04-08 15:00:00','admin','2026-04-08 15:00:00','测试说明','0'),(5,'停用资源排查提醒','<p>若资源不再开放或场馆临时维护，请及时将状态调整为停用并补充备注说明。</p>','1','0',62,'0','admin','2026-04-09 16:30:00','admin','2026-04-09 16:30:00','状态管理公告','0');
/*!40000 ALTER TABLE `tourism_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_scenic_spot`
--

DROP TABLE IF EXISTS `tourism_scenic_spot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tourism_scenic_spot` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '景区ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '景区名称',
  `level` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'A' COMMENT '景区等级（A、AA、AAA、AAAA、AAAAA）',
  `cover_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '封面图片URL',
  `cover_image_id` bigint DEFAULT NULL COMMENT '封面图片ID',
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
  KEY `idx_create_time` (`create_time`) USING BTREE,
  KEY `idx_tourism_scenic_cover_image_id` (`cover_image_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='A级景区信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_scenic_spot`
--

LOCK TABLES `tourism_scenic_spot` WRITE;
/*!40000 ALTER TABLE `tourism_scenic_spot` DISABLE KEYS */;
INSERT INTO `tourism_scenic_spot` VALUES (1,'洪崖洞民俗风貌区','AAAA','https://picsum.photos/seed/cq-hongyadong/900/560',1,0.00,'重庆市渝中区嘉陵江滨江路88号','重庆市','渝中区','全天开放，亮灯约19:30-23:00','023-63039999','https://www.cq.gov.cn','以巴渝传统吊脚楼为主体，集山城夜景、民俗街区、美食体验于一体，是重庆城市形象的重要窗口。',106.5791450,29.5635400,168,4520,'0','admin','2026-04-03 09:00:00','admin','2026-04-10 10:00:00','夜景热门测试数据','0'),(2,'大足石刻景区','AAAAA','https://picsum.photos/seed/cq-dazu/900/560',2,115.00,'重庆市大足区宝顶镇','重庆市','大足区','08:30-17:30','023-43766699','https://www.dzshike.com','世界文化遗产，以宝顶山、北山石刻造像群为核心，兼具历史、宗教、艺术和研学价值。',105.8001200,29.7112300,96,2380,'0','admin','2026-04-03 09:20:00','admin','2026-04-10 10:10:00','5A景区测试数据','0'),(3,'武隆天生三桥','AAAAA','https://picsum.photos/seed/cq-wulong/900/560',3,125.00,'重庆市武隆区仙女山街道','重庆市','武隆区','08:30-16:30','023-77794266','https://www.wlkst.com','典型喀斯特地貌景观，天龙桥、青龙桥、黑龙桥气势恢宏，适合自然观光与摄影线路测试。',107.7951100,29.4257800,142,3210,'0','admin','2026-04-03 09:40:00','admin','2026-04-10 10:20:00','远郊区县地图点','0'),(4,'金佛山景区','AAAAA','https://picsum.photos/seed/cq-jinfo/900/560',4,80.00,'重庆市南川区三泉镇六组','重庆市','南川区','08:00-17:30','023-71669888','https://www.jinfoshan.com','集高山峡谷、森林步道、冬季冰雪和生物多样性于一体，适合四季旅游资源展示。',107.1716000,29.0289800,88,1765,'0','admin','2026-04-03 10:00:00','admin','2026-04-10 10:30:00','自然景观测试数据','0'),(5,'磁器口古镇','AAAA','https://picsum.photos/seed/cq-ciqikou/900/560',5,0.00,'重庆市沙坪坝区磁南街1号','重庆市','沙坪坝区','09:00-21:00','023-65010003','','历史文化街区，保留巴渝古镇肌理，适合非遗、餐饮、文创和人流热度测试。',106.4513100,29.5828900,131,2876,'0','admin','2026-04-03 10:20:00','admin','2026-04-10 10:40:00','免费景区测试','0'),(6,'南山一棵树观景园','AAA','https://picsum.photos/seed/cq-nanshan/900/560',6,30.00,'重庆市南岸区龙黄公路靠近黄桷垭路段','重庆市','南岸区','09:00-22:30','023-62467710','','俯瞰两江交汇和中心城区夜景的代表性观景点，适合夜游资源展示。',106.6007200,29.5434700,73,1540,'0','admin','2026-04-03 10:40:00','admin','2026-04-10 10:50:00','夜游资源测试','0'),(7,'歌乐山烈士陵园','AAAA','https://picsum.photos/seed/cq-geleshan/900/560',18,0.00,'重庆市沙坪坝区烈士墓政法三村','重庆市','沙坪坝区','09:00-17:00','023-65312300','','红色旅游与爱国主义教育基地，适合红色文化分类和搜索测试。',106.4283200,29.5831500,52,940,'0','admin','2026-04-03 11:00:00','admin','2026-04-10 11:00:00','红色旅游资源','0'),(8,'白公馆景区','AAA','https://picsum.photos/seed/cq-baigongguan/900/560',19,0.00,'重庆市沙坪坝区壮志路治法三村63号','重庆市','沙坪坝区','09:00-16:30','023-65312013','','革命历史遗址，当前设置为停用状态用于测试状态标签和筛选边界。',106.4321700,29.5908600,21,410,'1','admin','2026-04-03 11:20:00','admin','2026-04-10 11:10:00','停用状态测试','0');
/*!40000 ALTER TABLE `tourism_scenic_spot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_scenic_spot_image`
--

DROP TABLE IF EXISTS `tourism_scenic_spot_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tourism_scenic_spot_image` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关联记录主键',
  `scenic_spot_id` bigint NOT NULL COMMENT '关联的旅游景区ID（外键）',
  `image_id` bigint NOT NULL COMMENT '关联的图片ID（外键）',
  `sort` int DEFAULT '0' COMMENT '图片排序序号',
  `sort_order` int DEFAULT '0' COMMENT '排序序号',
  `is_cover` char(1) DEFAULT '0' COMMENT '是否封面（0否 1是）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_venue_image` (`scenic_spot_id`,`image_id`) USING BTREE,
  KEY `image_id` (`image_id`) USING BTREE,
  KEY `idx_tourism_scenic_spot_image_sort_order` (`sort_order`),
  CONSTRAINT `tourism_scenic_spot_image_ibfk_1` FOREIGN KEY (`scenic_spot_id`) REFERENCES `tourism_scenic_spot` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tourism_scenic_spot_image_ibfk_2` FOREIGN KEY (`image_id`) REFERENCES `tourism_image` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='旅游景区-图片关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_scenic_spot_image`
--

LOCK TABLES `tourism_scenic_spot_image` WRITE;
/*!40000 ALTER TABLE `tourism_scenic_spot_image` DISABLE KEYS */;
INSERT INTO `tourism_scenic_spot_image` VALUES (1,1,1,0,0,'1'),(2,1,18,1,1,'0'),(3,1,19,2,2,'0'),(4,2,2,0,0,'1'),(5,2,20,1,1,'0'),(6,3,3,0,0,'1'),(7,3,18,1,1,'0'),(8,3,20,2,2,'0'),(9,4,4,0,0,'1'),(10,4,19,1,1,'0'),(11,5,5,0,0,'1'),(12,5,18,1,1,'0'),(13,6,6,0,0,'1'),(14,6,20,1,1,'0'),(15,7,18,0,0,'1'),(16,7,19,1,1,'0'),(17,8,19,0,0,'1'),(18,8,20,1,1,'0');
/*!40000 ALTER TABLE `tourism_scenic_spot_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_user_collection`
--

DROP TABLE IF EXISTS `tourism_user_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户收藏信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_user_collection`
--

LOCK TABLES `tourism_user_collection` WRITE;
/*!40000 ALTER TABLE `tourism_user_collection` DISABLE KEYS */;
INSERT INTO `tourism_user_collection` VALUES (1,105,'scenic',1,'web','2026-04-18 09:00:00','web','2026-04-18 09:00:00','收藏洪崖洞','0'),(2,105,'scenic',3,'web','2026-04-18 09:05:00','web','2026-04-18 09:05:00','收藏武隆','0'),(3,106,'venue',2,'web','2026-04-18 09:10:00','web','2026-04-18 09:10:00','收藏博物馆','0'),(4,106,'activity',1,'web','2026-04-18 09:15:00','web','2026-04-18 09:15:00','收藏变脸活动','0'),(5,2,'activity',8,'web','2026-04-18 09:20:00','web','2026-04-18 09:20:00','收藏音乐会','0'),(6,105,'venue',1,'web','2026-04-18 09:25:00','web','2026-04-18 09:25:00','收藏图书馆','0');
/*!40000 ALTER TABLE `tourism_user_collection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_venue`
--

DROP TABLE IF EXISTS `tourism_venue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tourism_venue` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '场馆ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '场馆名称',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '场馆类别（博物馆、图书馆、文化馆、剧院等）',
  `cover_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '封面图片URL',
  `cover_image_id` bigint DEFAULT NULL COMMENT '封面图片ID',
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
  KEY `idx_create_time` (`create_time`) USING BTREE,
  KEY `idx_tourism_venue_cover_image_id` (`cover_image_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='场馆信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_venue`
--

LOCK TABLES `tourism_venue` WRITE;
/*!40000 ALTER TABLE `tourism_venue` DISABLE KEYS */;
INSERT INTO `tourism_venue` VALUES (1,'重庆图书馆','文化艺术类场馆','https://picsum.photos/seed/cq-library/900/560',7,0.00,'重庆市沙坪坝区凤天大道106号','重庆市','沙坪坝区','09:00-20:00，周一闭馆','023-65210822','https://www.cqlib.cn','市级公共图书馆，适合阅读推广、讲座和研学活动承载。',106.4612300,29.5428900,3000,'1',84,1980,'0','admin','2026-04-04 09:00:00','admin','2026-04-11 09:00:00','阅读活动主场馆','0'),(2,'重庆中国三峡博物馆','文化艺术类场馆','https://picsum.photos/seed/cq-museum/900/560',8,0.00,'重庆市渝中区人民路236号','重庆市','渝中区','09:00-17:00，周一闭馆','023-63679066','https://www.3gmuseum.cn','展示巴渝历史、三峡文化和城市变迁的重要博物馆。',106.5505200,29.5630100,5000,'1',121,2560,'0','admin','2026-04-04 09:20:00','admin','2026-04-11 09:20:00','展览活动测试','0'),(3,'重庆大剧院','文化艺术类场馆','https://picsum.photos/seed/cq-theatre/900/560',9,80.00,'重庆市江北区文华街东路2号','重庆市','江北区','10:00-22:00','023-61863166','https://www.cqdjy.com','城市级演艺场馆，承接音乐会、话剧、戏曲和城市文化演出。',106.5798100,29.5739300,1800,'1',66,1460,'0','admin','2026-04-04 09:40:00','admin','2026-04-11 09:40:00','收费场馆测试','0'),(4,'重庆奥体中心','体育场馆类','https://picsum.photos/seed/cq-olympic/900/560',10,0.00,'重庆市九龙坡区奥体路1号','重庆市','九龙坡区','08:00-22:00','023-68070777','','综合体育场馆，可承接大型体育赛事、全民健身和城市夜跑活动。',106.5112300,29.5267800,58000,'0',53,1720,'0','admin','2026-04-04 10:00:00','admin','2026-04-11 10:00:00','大容量场馆测试','0'),(5,'重庆美术馆','文化艺术类场馆','https://picsum.photos/seed/cq-art/900/560',11,0.00,'重庆市渝中区临江路1号','重庆市','渝中区','10:00-18:00，周一闭馆','023-63920626','','面向公众开放的艺术展览空间，适合视觉艺术和公共教育活动。',106.5761200,29.5604400,1200,'1',39,880,'0','admin','2026-04-04 10:20:00','admin','2026-04-11 10:20:00','艺术展览测试','0'),(6,'重庆科技馆','教育科研类场馆','https://picsum.photos/seed/cq-science/900/560',12,0.00,'重庆市江北区江北城文星门街7号','重庆市','江北区','09:30-17:00，周一闭馆','023-61863051','https://www.cqkjg.cn','面向青少年和家庭的科普教育场馆，适合亲子、研学活动。',106.5842600,29.5746200,2600,'1',57,1330,'1','admin','2026-04-04 10:40:00','admin','2026-04-11 10:40:00','停用状态测试','0');
/*!40000 ALTER TABLE `tourism_venue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_venue_facilities`
--

DROP TABLE IF EXISTS `tourism_venue_facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tourism_venue_facilities` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关联记录主键',
  `venue_id` bigint NOT NULL COMMENT '关联的场馆ID（外键）',
  `facilities_id` bigint NOT NULL COMMENT '关联的设施ID（外键）',
  `sort` int DEFAULT '0' COMMENT '设备排序序号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_venue_facilities` (`venue_id`,`facilities_id`) USING BTREE,
  KEY `facilities_id` (`facilities_id`) USING BTREE,
  CONSTRAINT `tourism_venue_facilities_ibfk_1` FOREIGN KEY (`venue_id`) REFERENCES `tourism_venue` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tourism_venue_facilities_ibfk_2` FOREIGN KEY (`facilities_id`) REFERENCES `tourism_facilities` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='场馆设备-关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_venue_facilities`
--

LOCK TABLES `tourism_venue_facilities` WRITE;
/*!40000 ALTER TABLE `tourism_venue_facilities` DISABLE KEYS */;
INSERT INTO `tourism_venue_facilities` VALUES (1,1,1,1),(2,1,2,2),(3,1,4,3),(4,1,7,4),(5,2,1,1),(6,2,2,2),(7,2,3,3),(8,2,6,4),(9,2,7,5),(10,3,1,1),(11,3,5,2),(12,3,8,3),(13,4,1,1),(14,4,2,2),(15,4,5,3),(16,4,8,4),(17,5,2,1),(18,5,3,2),(19,5,6,3),(20,6,1,1),(21,6,2,2),(22,6,4,3),(23,6,7,4),(24,6,8,5);
/*!40000 ALTER TABLE `tourism_venue_facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourism_venue_image`
--

DROP TABLE IF EXISTS `tourism_venue_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tourism_venue_image` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关联记录主键',
  `venue_id` bigint NOT NULL COMMENT '关联的场馆ID（外键）',
  `image_id` bigint NOT NULL COMMENT '关联的图片ID（外键）',
  `sort` int DEFAULT '0' COMMENT '图片排序序号',
  `sort_order` int DEFAULT '0' COMMENT '排序序号',
  `is_cover` char(1) DEFAULT '0' COMMENT '是否封面（0否 1是）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_venue_image` (`venue_id`,`image_id`) USING BTREE,
  KEY `image_id` (`image_id`) USING BTREE,
  KEY `idx_tourism_venue_image_sort_order` (`sort_order`),
  CONSTRAINT `tourism_venue_image_ibfk_1` FOREIGN KEY (`venue_id`) REFERENCES `tourism_venue` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tourism_venue_image_ibfk_2` FOREIGN KEY (`image_id`) REFERENCES `tourism_image` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='旅游场馆-图片关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourism_venue_image`
--

LOCK TABLES `tourism_venue_image` WRITE;
/*!40000 ALTER TABLE `tourism_venue_image` DISABLE KEYS */;
INSERT INTO `tourism_venue_image` VALUES (1,1,7,0,0,'1'),(2,1,21,1,1,'0'),(3,2,8,0,0,'1'),(4,2,22,1,1,'0'),(5,3,9,0,0,'1'),(6,3,23,1,1,'0'),(7,4,10,0,0,'1'),(8,4,21,1,1,'0'),(9,5,11,0,0,'1'),(10,5,22,1,1,'0'),(11,6,12,0,0,'1'),(12,6,23,1,1,'0');
/*!40000 ALTER TABLE `tourism_venue_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ruoyi'
--

--
-- Dumping routines for database 'ruoyi'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-06 15:57:43
