/*
 Navicat Premium Dump SQL

 Source Server         : mysql8
 Source Server Type    : MySQL
 Source Server Version : 80407 (8.4.7)
 Source Host           : localhost:3306
 Source Schema         : ruoyi

 Target Server Type    : MySQL
 Target Server Version : 80407 (8.4.7)
 File Encoding         : 65001

 Date: 18/11/2025 19:30:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (4, 'tourism_news', '', NULL, NULL, 'TourismNews', 'crud', '', 'cn.edu.cquet.tourism', 'tourism', 'news', NULL, 'cquet', '0', '/', NULL, 'admin', '2025-10-25 22:36:07', '', NULL, NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (42, 4, 'id', '', 'int', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-10-25 22:36:07', '', '2025-10-25 22:37:25');
INSERT INTO `gen_table_column` VALUES (43, 4, 'news_title', '', 'varchar(128)', 'String', 'newsTitle', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-10-25 22:36:07', '', '2025-10-25 22:37:26');
INSERT INTO `gen_table_column` VALUES (44, 4, 'news_type', '', 'char(1)', 'String', 'newsType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 3, 'admin', '2025-10-25 22:36:07', '', '2025-10-25 22:37:26');
INSERT INTO `gen_table_column` VALUES (45, 4, 'news_content', '', 'longblob', 'String', 'newsContent', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'editor', '', 4, 'admin', '2025-10-25 22:36:07', '', '2025-10-25 22:37:26');
INSERT INTO `gen_table_column` VALUES (46, 4, 'status', '', 'char(1)', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 5, 'admin', '2025-10-25 22:36:07', '', '2025-10-25 22:37:26');
INSERT INTO `gen_table_column` VALUES (47, 4, 'create_by', '', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 6, 'admin', '2025-10-25 22:36:07', '', '2025-10-25 22:37:26');
INSERT INTO `gen_table_column` VALUES (48, 4, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2025-10-25 22:36:07', '', '2025-10-25 22:37:26');
INSERT INTO `gen_table_column` VALUES (49, 4, 'update_by', '', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2025-10-25 22:36:07', '', '2025-10-25 22:37:26');
INSERT INTO `gen_table_column` VALUES (50, 4, 'update_time', '', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2025-10-25 22:36:07', '', '2025-10-25 22:37:26');
INSERT INTO `gen_table_column` VALUES (51, 4, 'remark', '', 'varchar(255)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'input', '', 10, 'admin', '2025-10-25 22:36:07', '', '2025-10-25 22:37:26');
INSERT INTO `gen_table_column` VALUES (52, 4, 'del_flag', '逻辑删除', 'int', 'Long', 'delFlag', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2025-10-25 22:36:07', '', '2025-10-25 22:37:26');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` int NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL,
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2024-09-04 06:22:52', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow', 0, NULL);
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2024-09-04 06:22:52', '', NULL, '初始化密码 123456', 0, NULL);
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2024-09-04 06:22:52', '', NULL, '深色主题theme-dark，浅色主题theme-light', 0, NULL);
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2024-09-04 06:22:52', 'admin', '2025-10-25 19:57:24', '是否开启验证码功能（true开启，false关闭）', 0, NULL);
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2024-09-04 06:22:52', 'admin', '2025-10-25 21:01:28', '是否开启注册用户功能（true开启，false关闭）', 0, NULL);
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2024-09-04 06:22:52', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）', 0, NULL);

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', 'CQUET', 0, 'CQUET', '15888888888', 'XX@qq.com', '0', '0', 'admin', '2024-09-04 06:22:51', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, 'CQUET', '15888888888', 'XX@qq.com', '0', '0', 'admin', '2024-09-04 06:22:51', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, 'CQUET', '15888888888', 'XX@qq.com', '0', '0', 'admin', '2024-09-04 06:22:51', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, 'CQUET', '15888888888', 'XX@qq.com', '0', '0', 'admin', '2024-09-04 06:22:51', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, 'CQUET', '15888888888', 'XX@qq.com', '0', '0', 'admin', '2024-09-04 06:22:51', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, 'CQUET', '15888888888', 'XX@qq.com', '0', '0', 'admin', '2024-09-04 06:22:51', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, 'CQUET', '15888888888', 'XX@qq.com', '0', '0', 'admin', '2024-09-04 06:22:51', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, 'CQUET', '15888888888', 'XX@qq.com', '0', '0', 'admin', '2024-09-04 06:22:51', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, 'CQUET', '15888888888', 'XX@qq.com', '0', '0', 'admin', '2024-09-04 06:22:51', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, 'CQUET', '15888888888', 'XX@qq.com', '0', '0', 'admin', '2024-09-04 06:22:51', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2024-09-04 06:22:52', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  `create_time` datetime NULL DEFAULT NULL,
  `del_flag` int NULL DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 96 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (40, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-27 14:39:41', '2025-10-27 14:39:41', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (41, 'liyuan', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2025-10-27 15:12:23', '2025-10-27 15:12:23', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (42, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '用户不存在/密码错误', '2025-10-27 15:12:54', '2025-10-27 15:12:54', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (43, 'liyuan', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-10-27 15:13:01', '2025-10-27 15:13:01', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (44, 'liyuan', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-10-27 15:13:26', '2025-10-27 15:13:26', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (45, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-27 15:15:01', '2025-10-27 15:15:01', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (46, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-28 15:59:01', '2025-10-28 15:59:01', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (47, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-28 16:16:53', '2025-10-28 16:16:53', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (48, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-28 16:16:55', '2025-10-28 16:16:55', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (49, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-28 19:44:05', '2025-10-28 19:44:05', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (50, 'liyuan', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-10-28 19:51:00', '2025-10-28 19:51:00', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (51, 'liyuan', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-10-29 10:31:22', '2025-10-29 10:31:22', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (52, 'liyuan', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-10-29 10:49:14', '2025-10-29 10:49:14', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (53, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-11-02 18:51:16', '2025-11-02 18:51:16', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (54, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-11-03 10:37:01', '2025-11-03 10:37:01', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (55, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-11-03 14:21:59', '2025-11-03 14:21:59', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (56, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-11-04 16:24:13', '2025-11-04 16:24:13', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (57, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-11-09 21:37:49', '2025-11-09 21:37:49', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (58, 'admin', '127.0.0.1', '内网IP', 'Mozilla', 'Windows 10', '0', '登录成功', '2025-11-09 22:08:55', '2025-11-09 22:08:55', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (59, 'liyuan', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-09 22:13:24', '2025-11-09 22:13:24', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (60, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-10 14:00:09', '2025-11-10 14:00:09', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (61, 'liyuan', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-10 15:23:26', '2025-11-10 15:23:26', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (62, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-11 16:10:52', '2025-11-11 16:10:52', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (63, 'liyuan', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-11 18:28:09', '2025-11-11 18:28:09', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (64, 'liyuan', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-11 19:45:08', '2025-11-11 19:45:08', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (65, 'liyuan', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-11 19:54:56', '2025-11-11 19:54:56', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (66, 'liyuan', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-12 10:53:19', '2025-11-12 10:53:19', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (67, 'liyuan', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-12 10:56:35', '2025-11-12 10:56:35', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (68, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-12 11:37:32', '2025-11-12 11:37:32', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (69, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-12 11:37:57', '2025-11-12 11:37:57', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (70, 'liyuan', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-14 17:03:38', '2025-11-14 17:03:38', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (71, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-14 17:04:19', '2025-11-14 17:04:19', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (72, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-14 17:04:25', '2025-11-14 17:04:25', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (73, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-14 17:05:48', '2025-11-14 17:05:48', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (74, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-14 17:06:08', '2025-11-14 17:06:08', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (75, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-14 17:56:29', '2025-11-14 17:56:29', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (76, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-14 18:08:00', '2025-11-14 18:08:00', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (77, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-14 22:01:46', '2025-11-14 22:01:46', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (78, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-14 22:30:34', '2025-11-14 22:30:34', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (79, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-14 23:21:01', '2025-11-14 23:21:01', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (80, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-14 23:57:49', '2025-11-14 23:57:49', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (81, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-15 16:18:29', '2025-11-15 16:18:29', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (82, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-15 16:25:33', '2025-11-15 16:25:33', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (83, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-15 16:27:40', '2025-11-15 16:27:40', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (84, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-15 17:29:32', '2025-11-15 17:29:32', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (85, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-15 17:32:32', '2025-11-15 17:32:32', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (86, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-15 17:43:39', '2025-11-15 17:43:39', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (87, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-15 18:11:54', '2025-11-15 18:11:54', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (88, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-11-16 23:35:10', '2025-11-16 23:35:10', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (89, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-11-16 23:43:42', '2025-11-16 23:43:42', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (90, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-11-16 23:55:27', '2025-11-16 23:55:27', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (91, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-11-17 15:01:31', '2025-11-17 15:01:31', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (92, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-11-17 15:28:22', '2025-11-17 15:28:22', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (93, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-11-17 16:06:31', '2025-11-17 16:06:31', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (94, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-11-18 15:30:13', '2025-11-18 15:30:13', 0, NULL);
INSERT INTO `sys_logininfor` VALUES (95, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-11-18 18:01:24', '2025-11-18 18:01:24', 0, NULL);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `del_flag` int NULL DEFAULT NULL,
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2080 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 2, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2024-09-04 06:22:51', '', NULL, '系统管理目录', 0);
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 3, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2024-09-04 06:22:51', '', NULL, '系统监控目录', 0);
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 4, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2024-09-04 06:22:51', '', NULL, '系统工具目录', 0);
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2024-09-04 06:22:51', '', NULL, '用户管理菜单', 0);
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2024-09-04 06:22:51', '', NULL, '角色管理菜单', 0);
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2024-09-04 06:22:51', '', NULL, '菜单管理菜单', 0);
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2024-09-04 06:22:51', '', NULL, '部门管理菜单', 0);
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2024-09-04 06:22:51', '', NULL, '岗位管理菜单', 0);
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2024-09-04 06:22:51', '', NULL, '字典管理菜单', 0);
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2024-09-04 06:22:51', '', NULL, '参数设置菜单', 0);
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2024-09-04 06:22:51', '', NULL, '通知公告菜单', 0);
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2024-09-04 06:22:51', '', NULL, '日志管理菜单', 0);
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2024-09-04 06:22:51', '', NULL, '在线用户菜单', 0);
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2024-09-04 06:22:51', '', NULL, '数据监控菜单', 0);
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2024-09-04 06:22:51', '', NULL, '服务监控菜单', 0);
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2024-09-04 06:22:51', '', NULL, '缓存监控菜单', 0);
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2024-09-04 06:22:51', '', NULL, '缓存列表菜单', 0);
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2024-09-04 06:22:51', '', NULL, '表单构建菜单', 0);
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2024-09-04 06:22:51', '', NULL, '代码生成菜单', 0);
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2024-09-04 06:22:51', '', NULL, '系统接口菜单', 0);
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2024-09-04 06:22:51', '', NULL, '操作日志菜单', 0);
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2024-09-04 06:22:51', '', NULL, '登录日志菜单', 0);
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2024-09-04 06:22:51', '', NULL, '', 0);
INSERT INTO `sys_menu` VALUES (2072, '文旅管理', 0, 5, 'tourism', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'online', 'admin', '2025-11-03 14:22:53', 'admin', '2025-11-03 14:23:03', '', 0);
INSERT INTO `sys_menu` VALUES (2073, '新闻管理', 2072, 1, 'news', 'tourism/news/index', '', '', 1, 0, 'C', '0', '0', 'tourism:news:list', 'date-range', 'admin', '2025-11-03 14:24:01', 'admin', '2025-11-18 18:49:34', '', 0);
INSERT INTO `sys_menu` VALUES (2074, '旅游景点', 2072, 1, 'scenicSpot', 'tourism/scenicSpot/index', NULL, '', 1, 0, 'C', '0', '0', 'tourism:scenicSpot:list', 'guide', 'admin', '2025-11-10 14:01:25', 'admin', '2025-11-18 18:50:28', '', 0);
INSERT INTO `sys_menu` VALUES (2075, '场馆管理', 2072, 3, 'venue', 'tourism/venue/index', NULL, '', 1, 0, 'C', '0', '0', 'tourism:venue:activity:list', 'tree', 'admin', '2025-11-17 15:30:15', 'admin', '2025-11-18 18:51:04', '', 0);
INSERT INTO `sys_menu` VALUES (2076, '活动管理', 2072, 4, 'activity', 'tourism/activity/index.vue', NULL, '', 1, 0, 'C', '0', '0', 'tourism:activity:list', 'row', 'admin', '2025-11-17 15:42:40', 'admin', '2025-11-18 18:50:05', '', 0);
INSERT INTO `sys_menu` VALUES (2077, '活动审核', 2072, 5, 'activityApplication', 'tourism/activityApplication/index.vue', NULL, '', 1, 0, 'C', '0', '0', 'tourism:activityApplication:list', 'color', 'admin', '2025-11-17 15:43:42', 'admin', '2025-11-17 15:54:42', '', 0);
INSERT INTO `sys_menu` VALUES (2078, '通知管理', 2072, 0, 'notice', 'tourism/notice/index.vue', NULL, '', 1, 0, 'C', '0', '0', 'tourism:notice:list', 'button', 'admin', '2025-11-17 15:45:01', 'admin', '2025-11-18 18:49:29', '', 0);

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` int NULL DEFAULT 0,
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  `create_time` datetime NULL DEFAULT NULL,
  `del_flag` int NULL DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 250 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (114, '菜单管理', 1, 'cn.edu.cquet.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:22:53\",\"delFlag\":\"0\",\"icon\":\"online\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2072,\"menuName\":\"文旅管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"tourism\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 90, '2025-11-03 14:22:53', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:22:53\",\"delFlag\":\"0\",\"icon\":\"online\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2072,\"menuName\":\"文旅管理\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"tourism\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:23:02\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 50, '2025-11-03 14:23:03', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 1, 'cn.edu.cquet.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"query\":\"tourism/news\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 18, '2025-11-03 14:24:01', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:25:18\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 19, '2025-11-03 14:25:18', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (118, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/news\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:27:04\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 242, '2025-11-03 14:27:05', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (119, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:28:26\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 40, '2025-11-03 14:28:26', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:29:57\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 22, '2025-11-03 14:29:57', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/news\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:30:14\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 34, '2025-11-03 14:30:14', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (122, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-03 14:30:29\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 32, '2025-11-03 14:30:30', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (123, '菜单管理', 1, 'cn.edu.cquet.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/scenicSpot/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-10 14:01:24\",\"delFlag\":\"0\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2074,\"menuName\":\"旅游景点\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"tourism\",\"perms\":\"tourism:scenicSpot:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 30, '2025-11-10 14:01:25', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (124, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/scenicSpot/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-10 14:01:25\",\"delFlag\":\"0\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2074,\"menuName\":\"旅游景点\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"tourisms\",\"perms\":\"tourism:scenicSpot:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-10 14:03:04\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 19, '2025-11-10 14:03:05', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (125, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/scenicSpot/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-10 14:01:25\",\"delFlag\":\"0\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2074,\"menuName\":\"旅游景点\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"tourismspot\",\"perms\":\"tourism:scenicSpot:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-10 14:03:43\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 19, '2025-11-10 14:03:43', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (126, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"news\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-10 14:04:06\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 12, '2025-11-10 14:04:06', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (127, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/scenicSpot/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-10 14:01:25\",\"delFlag\":\"0\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2074,\"menuName\":\"旅游景点\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"scenicSpot\",\"perms\":\"tourism:scenicSpot:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-10 14:06:39\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 15, '2025-11-10 14:06:39', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (128, 'A级景区', 1, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/scenic-spot', '127.0.0.1', '内网IP', '{\"address\":\"四川省阿坝藏族羌族自治州九寨沟县\",\"city\":\"阿坝州\",\"createBy\":\"admin\",\"createTime\":\"2025-11-14 17:14:15\",\"delFlag\":\"0\",\"description\":\"九寨沟是世界自然遗产、国家重点风景名胜区、国家AAAAA级旅游景区、国家级自然保护区、国家地质公园、世界生物圈保护区网络，是中国第一个以保护自然风景为主要目的的自然保护区。\",\"district\":\"九寨沟县\",\"id\":23,\"latitude\":33.254,\"level\":\"5A\",\"longitude\":103.918,\"name\":\"九寨沟风景名胜区\",\"openingHours\":\"08:00-18:00\",\"params\":{},\"status\":\"0\",\"ticketPrice\":169.00}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 44, '2025-11-14 17:14:16', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (129, 'A级景区', 1, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/scenic-spot', '127.0.0.1', '内网IP', '{\"address\":\"测试001\",\"city\":\"测试001\",\"createBy\":\"admin\",\"createTime\":\"2025-11-14 17:57:55\",\"delFlag\":\"0\",\"description\":\"测试001\",\"id\":24,\"level\":\"AAA\",\"name\":\"测试001\",\"params\":{},\"ticketPrice\":0}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 87, '2025-11-14 17:57:56', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (130, '设备设施管理', 1, 'cn.edu.cquet.tourism.controller.TourismFacilitiesController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/facilities', '127.0.0.1', '内网IP', '{\"facilitiesName\":\"笔记本电脑\",\"id\":3}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 18, '2025-11-15 00:00:33', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (131, '图片管理', 1, 'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()', 'POST', 1, 'admin', '研发部门', '/tourism/images/batch', '127.0.0.1', '内网IP', '[\"1.jpg\",\"2.jpg\",\"3.jpg\"]', '{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":3,\"url\":\"1.jpg\"},{\"id\":4,\"url\":\"2.jpg\"},{\"id\":5,\"url\":\"3.jpg\"}]}', '0', '', NULL, 43, '2025-11-15 16:29:21', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (132, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()', 'PUT', 1, 'admin', '研发部门', '/tourism/activity/1/status/0', '127.0.0.1', '内网IP', '1 \"0\"', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 21, '2025-11-15 16:59:08', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (133, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()', 'PUT', 1, 'admin', '研发部门', '/tourism/activity/1/status/1', '127.0.0.1', '内网IP', '1 \"1\"', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 20, '2025-11-15 16:59:29', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (134, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()', 'PUT', 1, 'admin', '研发部门', '/tourism/activity/1/status/1', '127.0.0.1', '内网IP', '1 \"1\"', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 48, '2025-11-15 17:32:48', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (135, '特色活动', 1, 'cn.edu.cquet.tourism.controller.TourismActivityController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"contactPhone\":\"023-12345678\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:36:02\",\"delFlag\":\"0\",\"description\":\"体验正宗重庆火锅文化，品尝地道美食\",\"endTime\":\"2024-06-03 18:00:00\",\"name\":\"重庆火锅文化节\",\"organizer\":\"重庆美食协会\",\"params\":{},\"startTime\":\"2024-06-01 09:00:00\",\"status\":\"ACTIVE\",\"venueId\":1}', '', '1', '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'status\' at row 1\r\n### The error may exist in cn/edu/cquet/tourism/mapper/TourismActivityMapper.java (best guess)\r\n### The error may involve cn.edu.cquet.tourism.mapper.TourismActivityMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO tourism_activity  ( name,  start_time, end_time,  venue_id, organizer, contact_phone, description, status,   create_time,  del_flag, create_by )  VALUES (  ?,  ?, ?,  ?, ?, ?, ?, ?,   ?,  ?, ?  )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'status\' at row 1\n; Data truncation: Data too long for column \'status\' at row 1', NULL, 188, '2025-11-15 17:36:02', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (136, '特色活动', 1, 'cn.edu.cquet.tourism.controller.TourismActivityController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditStatus\":\"pending\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/activity/winter-exhibit.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:40:28\",\"delFlag\":\"0\",\"description\":\"围绕城市文明的冬季专题展。\",\"endTime\":\"2026-01-10 18:00:00\",\"name\":\"城市博物馆冬季展览\",\"organizer\":\"城市博物馆\",\"params\":{},\"startTime\":\"2025-12-05 09:00:00\",\"status\":\"0\",\"venueId\":1}', '', '1', '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'audit_status\' at row 1\r\n### The error may exist in cn/edu/cquet/tourism/mapper/TourismActivityMapper.java (best guess)\r\n### The error may involve cn.edu.cquet.tourism.mapper.TourismActivityMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO tourism_activity  ( name, cover_image, start_time, end_time, category, venue_id, organizer, contact_phone, description, status, audit_status,  create_time,  del_flag, create_by )  VALUES (  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,  ?,  ?, ?  )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'audit_status\' at row 1\n; Data truncation: Data too long for column \'audit_status\' at row 1', NULL, 8, '2025-11-15 17:40:28', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (137, '特色活动', 1, 'cn.edu.cquet.tourism.controller.TourismActivityController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditStatus\":\"pending\",\"category\":\"讲座\",\"contactPhone\":\"13900001234\",\"coverImage\":\"https://cdn.example.com/images/winter-lecture.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:43:41\",\"delFlag\":\"0\",\"description\":\"邀请专家学者分享巴渝文化发展脉络与重要节点。\",\"endTime\":\"2025-12-20 21:00:00\",\"name\":\"冬季文化讲座：巴渝历史谈\",\"organizer\":\"重庆市文化馆\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-20 19:00:00\",\"status\":\"0\",\"venueId\":2}', '', '1', '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'audit_status\' at row 1\r\n### The error may exist in cn/edu/cquet/tourism/mapper/TourismActivityMapper.java (best guess)\r\n### The error may involve cn.edu.cquet.tourism.mapper.TourismActivityMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO tourism_activity  ( name, cover_image, start_time, end_time, category, venue_id, organizer, contact_phone, description, status, audit_status, remark, create_time,  del_flag, create_by )  VALUES (  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,  ?, ?  )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'audit_status\' at row 1\n; Data truncation: Data too long for column \'audit_status\' at row 1', NULL, 228, '2025-11-15 17:43:42', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (138, '特色活动', 1, 'cn.edu.cquet.tourism.controller.TourismActivityController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:45:06\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":2,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 25, '2025-11-15 17:45:07', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (139, '特色活动', 1, 'cn.edu.cquet.tourism.controller.TourismActivityController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditStatus\":\"0\",\"category\":\"展览123\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:46:46\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":3,\"name\":\"重庆非遗展览季123\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 34, '2025-11-15 17:46:46', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (140, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.edit()', 'PUT', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditStatus\":\"0\",\"category\":\"展览123\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":2,\"name\":\"重庆非遗展览季123\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-15 17:47:28\",\"venueId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 14, '2025-11-15 17:47:28', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (141, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.approve()', 'POST', 1, 'admin', '研发部门', '/tourism/activity/2/approve', '127.0.0.1', '内网IP', '2', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 20, '2025-11-15 17:49:00', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (142, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.approve()', 'POST', 1, 'admin', '研发部门', '/tourism/activity/3/approve', '127.0.0.1', '内网IP', '3', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 11, '2025-11-15 17:50:10', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (143, '特色活动', 1, 'cn.edu.cquet.tourism.controller.TourismActivityController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:50:50\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":4,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 22, '2025-11-15 17:50:51', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (144, '特色活动', 1, 'cn.edu.cquet.tourism.controller.TourismActivityController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:55:24\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":5,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 19, '2025-11-15 17:55:25', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (145, '特色活动', 1, 'cn.edu.cquet.tourism.controller.TourismActivityController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:55:26\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":6,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 6, '2025-11-15 17:55:27', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (146, '特色活动', 1, 'cn.edu.cquet.tourism.controller.TourismActivityController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:58:32\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":7,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 279, '2025-11-15 17:58:33', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (147, '特色活动', 1, 'cn.edu.cquet.tourism.controller.TourismActivityController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditStatus\":\"0\",\"category\":\"展览\",\"contactPhone\":\"13800138000\",\"coverImage\":\"https://cdn.example.com/images/feiyi-expo.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-15 17:58:34\",\"delFlag\":\"0\",\"description\":\"集中展示川渝地区非遗项目与工艺，含互动体验。\",\"endTime\":\"2025-12-15 17:30:00\",\"id\":8,\"name\":\"重庆非遗展览季\",\"organizer\":\"重庆市文化和旅游委员会\",\"params\":{},\"rejectReason\":\"\",\"startTime\":\"2025-12-01 09:00:00\",\"status\":\"0\",\"venueId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 22, '2025-11-15 17:58:34', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (148, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.approve()', 'POST', 1, 'admin', '研发部门', '/tourism/activity/2/approve', '127.0.0.1', '内网IP', '2', '{\"msg\":\"操作失败\",\"code\":500}', '0', '', NULL, 99, '2025-11-15 17:59:07', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (149, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.reject()', 'POST', 1, 'admin', '研发部门', '/tourism/activity/3/reject', '127.0.0.1', '内网IP', '3', '{\"msg\":\"请提供审核不通过原因\",\"code\":601}', '0', '', NULL, 0, '2025-11-15 17:59:20', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (150, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.approve()', 'POST', 1, 'admin', '研发部门', '/tourism/activity/2/approve', '127.0.0.1', '内网IP', '2 {\"opinion\":\"内容完整，予以通过\"}', '{\"msg\":\"操作失败\",\"code\":500}', '0', '', NULL, 168, '2025-11-15 18:03:16', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (151, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.reject()', 'POST', 1, 'admin', '研发部门', '/tourism/activity/3/reject', '127.0.0.1', '内网IP', '3 {\"reason\":\"资料不完整\"}', '{\"msg\":\"操作失败\",\"code\":500}', '0', '', NULL, 9, '2025-11-15 18:03:35', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (152, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.approve()', 'POST', 1, 'admin', '研发部门', '/tourism/activity/2/approve', '127.0.0.1', '内网IP', '2 {\"opinion\":\"内容完整，予以通过\"}', '{\"msg\":\"操作失败\",\"code\":500}', '0', '', NULL, 30, '2025-11-15 18:11:57', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (153, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.approve()', 'POST', 1, 'admin', '研发部门', '/tourism/activity/2/approve', '127.0.0.1', '内网IP', '2 {\"opinion\":\"内容完整，予以通过\"}', '{\"msg\":\"操作失败\",\"code\":500}', '0', '', NULL, 42, '2025-11-15 18:15:39', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (154, 'A级景区', 3, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tourism/scenic-spot/24', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 64, '2025-11-16 23:51:33', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (155, '菜单管理', 1, 'cn.edu.cquet.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/venue/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:30:15\",\"delFlag\":\"0\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2075,\"menuName\":\"场馆管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2072,\"path\":\"venue\",\"perms\":\"tourism:venue:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 25, '2025-11-17 15:30:15', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (156, '场馆管理', 3, 'cn.edu.cquet.tourism.controller.tourismVenueController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tourism/venue/3', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 39, '2025-11-17 15:30:55', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (157, '菜单管理', 1, 'cn.edu.cquet.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/activity/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:42:39\",\"delFlag\":\"0\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2076,\"menuName\":\"特色活动管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2072,\"path\":\"activity\",\"perms\":\"tourism:activity:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 12, '2025-11-17 15:42:40', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (158, '菜单管理', 1, 'cn.edu.cquet.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"/tourism/activityApplication/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:43:41\",\"delFlag\":\"0\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2077,\"menuName\":\"活动审核\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2072,\"path\":\"activityApplication\",\"perms\":\"/tourism:activityApplication:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 17, '2025-11-17 15:43:42', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (159, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"/tourism/activityApplication/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:43:42\",\"delFlag\":\"0\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2077,\"menuName\":\"活动审核\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2072,\"path\":\"activityApplication\",\"perms\":\"tourism:activityApplication:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-17 15:43:50\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 16, '2025-11-17 15:43:50', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (160, '菜单管理', 1, 'cn.edu.cquet.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"/tourism/notice/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:45:00\",\"delFlag\":\"0\",\"icon\":\"button\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2078,\"menuName\":\"通知管理\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2072,\"path\":\"notice\",\"perms\":\"tourism:notice:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 16, '2025-11-17 15:45:01', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (161, '菜单管理', 1, 'cn.edu.cquet.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"/tourism/facilities/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:46:19\",\"delFlag\":\"0\",\"icon\":\"example\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2079,\"menuName\":\"设备管理\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2072,\"path\":\"facilities\",\"perms\":\"tourism:facilities:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 15, '2025-11-17 15:46:19', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (162, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.approve()', 'POST', 1, 'admin', '研发部门', '/tourism/activity/1/approve', '127.0.0.1', '内网IP', '{\"opinion\":\"可以的\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 23, '2025-11-17 15:46:52', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (163, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"/tourism/activityApplication/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:43:42\",\"delFlag\":\"0\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2077,\"menuName\":\"活动审核\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2072,\"path\":\"activityApplication\",\"perms\":\"tourism:activity-application:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-17 15:49:05\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 15, '2025-11-17 15:49:05', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (164, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"/tourism/activityApplication/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:43:42\",\"delFlag\":\"0\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2077,\"menuName\":\"活动审核\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2072,\"path\":\"activityApplication\",\"perms\":\"tourism:activityApplication:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-17 15:49:31\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 13, '2025-11-17 15:49:32', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (165, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"/tourism/facilities/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:46:19\",\"delFlag\":\"0\",\"icon\":\"example\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2079,\"menuName\":\"设备管理\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2072,\"path\":\"facilities\",\"perms\":\"tourism:facilities:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-17 15:52:23\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 19, '2025-11-17 15:52:24', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (166, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"/tourism/activityApplication/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:43:42\",\"delFlag\":\"0\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2077,\"menuName\":\"活动审核\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2072,\"path\":\"activityApplication\",\"perms\":\"tourism:activityApplication:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-17 15:54:42\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 144, '2025-11-17 15:54:42', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (167, '设备设施管理', 2, 'cn.edu.cquet.tourism.controller.TourismFacilitiesController.edit()', 'PUT', 1, 'admin', '研发部门', '/tourism/facilities', '127.0.0.1', '内网IP', '{\"facilitiesName\":\"游泳池\",\"id\":1}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 31, '2025-11-17 16:05:15', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (168, '特色活动申报', 2, 'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.approve()', 'POST', 1, 'admin', '研发部门', '/tourism/activityApplication/8/approve', '127.0.0.1', '内网IP', '{\"opinion\":\"可以的\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 76, '2025-11-17 16:05:32', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (169, '特色活动申报', 2, 'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.reject()', 'POST', 1, 'admin', '研发部门', '/tourism/activityApplication/1/reject', '127.0.0.1', '内网IP', '{\"reason\":\"测试\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 27, '2025-11-17 16:05:41', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (170, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.edit()', 'PUT', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditReason\":\"测试\",\"auditStatus\":\"2\",\"auditor\":\"admin\",\"category\":\"文化体验\",\"contactPhone\":\"12344556677\",\"coverImage\":\"1\",\"createBy\":\"\",\"delFlag\":\"0\",\"description\":\"111\",\"endTime\":\"2025-11-15 16:52:48\",\"id\":1,\"name\":\"测试001\",\"organizer\":\"测试001\",\"params\":{},\"startTime\":\"2025-11-16 16:52:45\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-17 16:07:18\",\"venueId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 49, '2025-11-17 16:07:19', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (171, '特色活动申报', 2, 'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.approve()', 'POST', 1, 'admin', '研发部门', '/tourism/activityApplication/8/approve', '127.0.0.1', '内网IP', '{\"opinion\":\"可以的\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 27, '2025-11-17 16:09:34', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (172, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.edit()', 'PUT', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditReason\":\"测试\",\"auditStatus\":\"2\",\"auditor\":\"admin\",\"category\":\"文化体验\",\"contactPhone\":\"12344556677\",\"coverImage\":\"1\",\"createBy\":\"\",\"delFlag\":\"0\",\"description\":\"111\",\"endTime\":\"2025-11-15 16:52:48\",\"id\":1,\"name\":\"测试001\",\"organizer\":\"测试001\",\"params\":{},\"startTime\":\"2025-11-16 16:52:45\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-17 16:10:48\",\"venueId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 17, '2025-11-17 16:10:49', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (173, 'A级景区', 3, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tourism/scenic-spot/22', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 70, '2025-11-18 15:30:55', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (174, 'A级景区', 1, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/scenic-spot', '127.0.0.1', '内网IP', '{\"address\":\"重庆市\",\"city\":\"重庆市\",\"contactPhone\":\"18983432250\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 15:32:04\",\"delFlag\":\"0\",\"description\":\"解放碑\",\"district\":\"重庆市\",\"id\":25,\"latitude\":-6,\"level\":\"AAAAA\",\"longitude\":6,\"name\":\"重庆解放碑\",\"openingHours\":\"全天\",\"params\":{},\"ticketPrice\":0,\"website\":\"cq.com\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 47, '2025-11-18 15:32:04', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (175, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()', 'PUT', 1, 'admin', '研发部门', '/tourism/activity/1/status/1', '127.0.0.1', '内网IP', '1 \"1\"', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 26, '2025-11-18 15:42:43', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (176, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()', 'PUT', 1, 'admin', '研发部门', '/tourism/activity/1/status/0', '127.0.0.1', '内网IP', '1 \"0\"', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 15, '2025-11-18 15:42:46', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (177, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/venue/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:30:15\",\"delFlag\":\"0\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2075,\"menuName\":\"场馆管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2072,\"path\":\"venue\",\"perms\":\"tourism:venue:activity:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 16:01:07\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 68, '2025-11-18 16:01:07', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (178, '场馆管理', 3, 'cn.edu.cquet.tourism.controller.tourismVenueController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tourism/venue/4', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 46, '2025-11-18 16:06:22', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (179, '场馆管理', 3, 'cn.edu.cquet.tourism.controller.tourismVenueController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tourism/venue/6', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 24, '2025-11-18 16:06:24', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (180, '场馆管理', 2, 'cn.edu.cquet.tourism.controller.tourismVenueController.edit()', 'PUT', 1, 'admin', '研发部门', '/tourism/venue', '127.0.0.1', '内网IP', '{\"id\":1,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 16:07:35\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 79, '2025-11-18 16:07:35', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (181, '场馆管理', 2, 'cn.edu.cquet.tourism.controller.tourismVenueController.edit()', 'PUT', 1, 'admin', '研发部门', '/tourism/venue', '127.0.0.1', '内网IP', '{\"id\":1,\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 16:07:38\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 31, '2025-11-18 16:07:39', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (182, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()', 'PUT', 1, 'admin', '研发部门', '/tourism/activity/8/status/1', '127.0.0.1', '内网IP', '8 \"1\"', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 53, '2025-11-18 16:08:09', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (183, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()', 'PUT', 1, 'admin', '研发部门', '/tourism/activity/7/status/1', '127.0.0.1', '内网IP', '7 \"1\"', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 22, '2025-11-18 16:08:15', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (184, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()', 'PUT', 1, 'admin', '研发部门', '/tourism/activity/1/status/1', '127.0.0.1', '内网IP', '1 \"1\"', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 17, '2025-11-18 16:08:17', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (185, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()', 'PUT', 1, 'admin', '研发部门', '/tourism/activity/8/status/0', '127.0.0.1', '内网IP', '8 \"0\"', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 27, '2025-11-18 16:10:57', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (186, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.updateStatus()', 'PUT', 1, 'admin', '研发部门', '/tourism/activity/8/status/1', '127.0.0.1', '内网IP', '8 \"1\"', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 16, '2025-11-18 16:11:04', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (187, '特色活动申报', 2, 'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.approve()', 'POST', 1, 'admin', '研发部门', '/tourism/activityApplication/7/approve', '127.0.0.1', '内网IP', '{\"opinion\":\"可以\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 32, '2025-11-18 16:11:14', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (188, '场馆管理', 3, 'cn.edu.cquet.tourism.controller.tourismVenueController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tourism/venue/1', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 28, '2025-11-18 16:11:26', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (189, '场馆管理', 3, 'cn.edu.cquet.tourism.controller.tourismVenueController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tourism/venue/2', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 35, '2025-11-18 16:11:28', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (190, '特色活动', 3, 'cn.edu.cquet.tourism.controller.TourismActivityController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tourism/activity/1', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 19, '2025-11-18 16:17:54', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (191, '特色活动', 3, 'cn.edu.cquet.tourism.controller.TourismActivityController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tourism/activity/7', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 18, '2025-11-18 16:17:56', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (192, '特色活动', 3, 'cn.edu.cquet.tourism.controller.TourismActivityController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tourism/activity/8', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 13, '2025-11-18 16:17:57', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (193, '场馆管理', 1, 'cn.edu.cquet.tourism.controller.tourismVenueController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/venue', '127.0.0.1', '内网IP', '{\"address\":\"重庆市\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"文旅\",\"city\":\"重庆市\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 16:28:46\",\"delFlag\":\"0\",\"description\":\"解放碑科技\",\"district\":\"重庆市\",\"id\":7,\"latitude\":-6,\"longitude\":6,\"name\":\"科技馆\",\"openingHours\":\"下午\",\"params\":{},\"ticketPrice\":4}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"address\":\"重庆市\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"文旅\",\"city\":\"重庆市\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 16:28:46\",\"delFlag\":\"0\",\"description\":\"解放碑科技\",\"district\":\"重庆市\",\"id\":7,\"latitude\":-6,\"longitude\":6,\"name\":\"科技馆\",\"openingHours\":\"下午\",\"params\":{},\"ticketPrice\":4}}', '0', '', NULL, 102, '2025-11-18 16:28:46', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (194, '特色活动', 1, 'cn.edu.cquet.tourism.controller.TourismActivityController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditStatus\":\"0\",\"category\":\"是的\",\"contactPhone\":\"5562+\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 16:31:28\",\"delFlag\":\"0\",\"endTime\":\"2025-11-21 00:00:00\",\"id\":9,\"name\":\"士大夫\",\"params\":{},\"startTime\":\"2025-11-18 16:31:27\",\"venueId\":7}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 22, '2025-11-18 16:31:29', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (195, '特色活动申报', 2, 'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.approve()', 'POST', 1, 'admin', '研发部门', '/tourism/activityApplication/9/approve', '127.0.0.1', '内网IP', '9', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 24, '2025-11-18 16:31:47', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (196, '场馆管理', 1, 'cn.edu.cquet.tourism.controller.tourismVenueController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/venue', '127.0.0.1', '内网IP', '{\"address\":\"重庆市\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"酒店\",\"city\":\"重庆市\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 16:32:27\",\"delFlag\":\"0\",\"district\":\"重庆市\",\"id\":8,\"latitude\":-6,\"longitude\":6,\"name\":\"就订啊\",\"params\":{},\"ticketPrice\":0}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"address\":\"重庆市\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"酒店\",\"city\":\"重庆市\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 16:32:27\",\"delFlag\":\"0\",\"district\":\"重庆市\",\"id\":8,\"latitude\":-6,\"longitude\":6,\"name\":\"就订啊\",\"params\":{},\"ticketPrice\":0}}', '0', '', NULL, 21, '2025-11-18 16:32:27', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (197, 'A级景区', 2, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()', 'PUT', 1, 'admin', '研发部门', '/tourism/scenic-spot', '127.0.0.1', '内网IP', '{\"address\":\"重庆市\",\"city\":\"重庆市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 15:32:04\",\"delFlag\":\"0\",\"description\":\"解放碑\",\"district\":\"重庆市\",\"id\":25,\"latitude\":-6,\"level\":\"AAAAA\",\"longitude\":6,\"name\":\"重庆解放碑\",\"openingHours\":\"全天\",\"params\":{},\"status\":\"0\",\"ticketPrice\":0,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 17:08:57\",\"viewCount\":0,\"website\":\"cq.com\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 27, '2025-11-18 17:08:58', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (198, '图片管理', 1, 'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()', 'POST', 1, 'admin', '研发部门', '/tourism/images/batch', '127.0.0.1', '内网IP', '[\"https://ts2.tc.mm.bing.net/th/id/OIP-C.QSb7FtM8GaCgiGC-jD7IawHaEK?rs=1&pid=ImgDetMain&o=7&rm=3\"]', '{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":6,\"url\":\"https://ts2.tc.mm.bing.net/th/id/OIP-C.QSb7FtM8GaCgiGC-jD7IawHaEK?rs=1&pid=ImgDetMain&o=7&rm=3\"}]}', '0', '', NULL, 16, '2025-11-18 17:08:58', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (199, '场馆管理', 2, 'cn.edu.cquet.tourism.controller.tourismVenueController.edit()', 'PUT', 1, 'admin', '研发部门', '/tourism/venue', '127.0.0.1', '内网IP', '{\"address\":\"重庆市\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"文旅\",\"city\":\"重庆市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 16:28:46\",\"delFlag\":\"0\",\"description\":\"解放碑科技\",\"district\":\"重庆市\",\"id\":7,\"latitude\":-6,\"longitude\":6,\"name\":\"科技馆\",\"openingHours\":\"下午\",\"params\":{},\"status\":\"0\",\"ticketPrice\":4,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 17:09:42\",\"viewCount\":0,\"website\":\"\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 21, '2025-11-18 17:09:43', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (200, '图片管理', 1, 'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()', 'POST', 1, 'admin', '研发部门', '/tourism/images/batch', '127.0.0.1', '内网IP', '[\"https://ts2.tc.mm.bing.net/th/id/OIP-C.QSb7FtM8GaCgiGC-jD7IawHaEK?rs=1&pid=ImgDetMain&o=7&rm=3\"]', '{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":7,\"url\":\"https://ts2.tc.mm.bing.net/th/id/OIP-C.QSb7FtM8GaCgiGC-jD7IawHaEK?rs=1&pid=ImgDetMain&o=7&rm=3\"}]}', '0', '', NULL, 13, '2025-11-18 17:09:43', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (201, 'A级景区', 1, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/scenic-spot', '127.0.0.1', '内网IP', '{\"address\":\"彩色\",\"city\":\"测试\",\"coverImage\":\"/profile/upload/2025/11/18/mmexport1762929757923_20251118172249A001.jpeg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 17:23:13\",\"delFlag\":\"0\",\"id\":26,\"latitude\":3,\"level\":\"A\",\"longitude\":3,\"name\":\"测试\",\"openingHours\":\"测试\",\"params\":{},\"ticketPrice\":0}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 17, '2025-11-18 17:23:13', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (202, 'A级景区', 1, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/scenic-spot', '127.0.0.1', '内网IP', '{\"address\":\"彩色\",\"city\":\"测试\",\"coverImage\":\"/profile/upload/2025/11/18/mmexport1762929757923_20251118172249A001.jpeg\",\"latitude\":3,\"level\":\"A\",\"longitude\":3,\"name\":\"测试\",\"openingHours\":\"测试\",\"params\":{},\"ticketPrice\":0}', '{\"msg\":\"景区名称已存在\",\"code\":601}', '0', '', NULL, 8, '2025-11-18 17:23:19', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (203, 'A级景区', 1, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/scenic-spot', '127.0.0.1', '内网IP', '{\"address\":\"彩色\",\"city\":\"测试\",\"coverImage\":\"/profile/upload/2025/11/18/mmexport1762929757923_20251118172249A001.jpeg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 17:23:23\",\"delFlag\":\"0\",\"id\":27,\"latitude\":3,\"level\":\"A\",\"longitude\":3,\"name\":\"测试测试\",\"openingHours\":\"测试\",\"params\":{},\"ticketPrice\":0}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 19, '2025-11-18 17:23:23', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (204, 'A级景区', 3, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tourism/scenic-spot/27', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 30, '2025-11-18 17:29:01', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (205, 'A级景区', 2, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()', 'PUT', 1, 'admin', '研发部门', '/tourism/scenic-spot', '127.0.0.1', '内网IP', '{\"address\":\"彩色\",\"city\":\"测试\",\"collectionCount\":0,\"contactPhone\":\"\",\"coverImage\":\"/profile/upload/2025/11/18/mmexport1762929757923_20251118172249A001.jpeg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 17:23:13\",\"delFlag\":\"0\",\"district\":\"\",\"id\":26,\"latitude\":3,\"level\":\"A\",\"longitude\":3,\"name\":\"测试\",\"openingHours\":\"测试\",\"params\":{},\"status\":\"0\",\"ticketPrice\":0,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 17:29:10\",\"viewCount\":0,\"website\":\"\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 19, '2025-11-18 17:29:11', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (206, '图片管理', 1, 'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()', 'POST', 1, 'admin', '研发部门', '/tourism/images/batch', '127.0.0.1', '内网IP', '[\"/profile/upload/2025/11/18/头像_20251118172905A001.png\",\"/profile/upload/2025/11/18/未标题-1_20251118172908A002.png\"]', '{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":8,\"url\":\"/profile/upload/2025/11/18/头像_20251118172905A001.png\"},{\"id\":9,\"url\":\"/profile/upload/2025/11/18/未标题-1_20251118172908A002.png\"}]}', '0', '', NULL, 16, '2025-11-18 17:29:11', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (207, 'A级景区', 2, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()', 'PUT', 1, 'admin', '研发部门', '/tourism/scenic-spot', '127.0.0.1', '内网IP', '{\"address\":\"彩色\",\"city\":\"测试\",\"collectionCount\":0,\"contactPhone\":\"\",\"coverImage\":\"/profile/upload/2025/11/18/mmexport1762929757923_20251118172249A001.jpeg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 17:23:13\",\"delFlag\":\"0\",\"district\":\"\",\"id\":26,\"latitude\":3,\"level\":\"A\",\"longitude\":3,\"name\":\"测试\",\"openingHours\":\"测试\",\"params\":{},\"status\":\"0\",\"ticketPrice\":0,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:10:59\",\"viewCount\":0,\"website\":\"\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 18, '2025-11-18 18:10:59', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (208, '图片管理', 1, 'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()', 'POST', 1, 'admin', '研发部门', '/tourism/images/batch', '127.0.0.1', '内网IP', '[\"/profile/upload/2025/11/18/未标题-1_20251118172908A002.png\"]', '{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":10,\"url\":\"/profile/upload/2025/11/18/未标题-1_20251118172908A002.png\"}]}', '0', '', NULL, 12, '2025-11-18 18:11:00', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (209, 'A级景区', 3, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tourism/scenic-spot/26', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 20, '2025-11-18 18:11:13', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (210, 'A级景区', 2, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()', 'PUT', 1, 'admin', '研发部门', '/tourism/scenic-spot', '127.0.0.1', '内网IP', '{\"address\":\"重庆市\",\"city\":\"重庆市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/未标题-1_20251118181325A003.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 15:32:04\",\"delFlag\":\"0\",\"description\":\"解放碑\",\"district\":\"重庆市\",\"id\":25,\"latitude\":-6,\"level\":\"AAAAA\",\"longitude\":6,\"name\":\"重庆解放碑\",\"openingHours\":\"全天\",\"params\":{},\"status\":\"0\",\"ticketPrice\":0,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:13:31\",\"viewCount\":0,\"website\":\"cq.com\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 19, '2025-11-18 18:13:31', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (211, '图片管理', 1, 'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()', 'POST', 1, 'admin', '研发部门', '/tourism/images/batch', '127.0.0.1', '内网IP', '[\"/profile/upload/2025/11/18/头像_20251118181329A004.png\"]', '{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":11,\"url\":\"/profile/upload/2025/11/18/头像_20251118181329A004.png\"}]}', '0', '', NULL, 18, '2025-11-18 18:13:32', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (212, '场馆管理', 2, 'cn.edu.cquet.tourism.controller.tourismVenueController.edit()', 'PUT', 1, 'admin', '研发部门', '/tourism/venue', '127.0.0.1', '内网IP', '{\"address\":\"重庆市\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"文旅\",\"city\":\"重庆市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/未标题-1_20251118181611A005.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 16:28:46\",\"delFlag\":\"0\",\"description\":\"解放碑科技\",\"district\":\"重庆市\",\"id\":7,\"latitude\":-6,\"longitude\":6,\"name\":\"科技馆\",\"openingHours\":\"下午\",\"params\":{},\"status\":\"0\",\"ticketPrice\":4,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:16:18\",\"viewCount\":0,\"website\":\"\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 40, '2025-11-18 18:16:19', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (213, '图片管理', 1, 'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()', 'POST', 1, 'admin', '研发部门', '/tourism/images/batch', '127.0.0.1', '内网IP', '[\"/profile/upload/2025/11/18/头像_20251118181617A006.png\"]', '{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":12,\"url\":\"/profile/upload/2025/11/18/头像_20251118181617A006.png\"}]}', '0', '', NULL, 18, '2025-11-18 18:16:19', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (214, 'A级景区', 2, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()', 'PUT', 1, 'admin', '研发部门', '/tourism/scenic-spot', '127.0.0.1', '内网IP', '{\"address\":\"重庆市\",\"city\":\"重庆市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/未标题-1_20251118181325A003.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 15:32:04\",\"delFlag\":\"0\",\"description\":\"解放碑\",\"district\":\"重庆市\",\"id\":25,\"latitude\":-6,\"level\":\"AAAAA\",\"longitude\":6,\"name\":\"重庆解放碑\",\"openingHours\":\"全天\",\"params\":{},\"status\":\"0\",\"ticketPrice\":0,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:22:14\",\"viewCount\":0,\"website\":\"cq.com\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 18, '2025-11-18 18:22:14', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (215, '图片管理', 1, 'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()', 'POST', 1, 'admin', '研发部门', '/tourism/images/batch', '127.0.0.1', '内网IP', '[\"/profile/upload/2025/11/18/头像_20251118181329A004.png\",\"/profile/upload/2025/11/18/头像_20251118182212A007.png\"]', '{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":13,\"url\":\"/profile/upload/2025/11/18/头像_20251118181329A004.png\"},{\"id\":14,\"url\":\"/profile/upload/2025/11/18/头像_20251118182212A007.png\"}]}', '0', '', NULL, 22, '2025-11-18 18:22:15', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (216, 'A级景区', 2, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()', 'PUT', 1, 'admin', '研发部门', '/tourism/scenic-spot', '127.0.0.1', '内网IP', '{\"address\":\"重庆市\",\"city\":\"重庆市\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/未标题-1_20251118181325A003.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 15:32:04\",\"delFlag\":\"0\",\"description\":\"解放碑\",\"district\":\"重庆市\",\"id\":25,\"latitude\":-6,\"level\":\"AAAAA\",\"longitude\":6,\"name\":\"重庆解放碑\",\"openingHours\":\"全天\",\"params\":{},\"status\":\"0\",\"ticketPrice\":0,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:22:21\",\"viewCount\":0,\"website\":\"cq.com\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 20, '2025-11-18 18:22:21', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (217, '图片管理', 1, 'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()', 'POST', 1, 'admin', '研发部门', '/tourism/images/batch', '127.0.0.1', '内网IP', '[\"/profile/upload/2025/11/18/头像_20251118181329A004.png\"]', '{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"id\":15,\"url\":\"/profile/upload/2025/11/18/头像_20251118181329A004.png\"}]}', '0', '', NULL, 11, '2025-11-18 18:22:22', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (218, 'A级景区', 3, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tourism/scenic-spot/25', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 21, '2025-11-18 18:27:21', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (219, '场馆管理', 3, 'cn.edu.cquet.tourism.controller.tourismVenueController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tourism/venue/7', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 36, '2025-11-18 18:27:30', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (220, '场馆管理', 3, 'cn.edu.cquet.tourism.controller.tourismVenueController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tourism/venue/8', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 30, '2025-11-18 18:27:33', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (221, '场馆管理', 1, 'cn.edu.cquet.tourism.controller.tourismVenueController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/venue', '127.0.0.1', '内网IP', '{\"address\":\"四川省阿坝藏族羌族自治州九寨沟县\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"是的\",\"city\":\"阿坝州\",\"coverImage\":\"/profile/upload/2025/11/18/sala4_20251118182804A008.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 18:28:06\",\"delFlag\":\"0\",\"district\":\"九寨沟县\",\"id\":9,\"latitude\":33.254,\"longitude\":103.918,\"name\":\"是的\",\"params\":{},\"ticketPrice\":0}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"address\":\"四川省阿坝藏族羌族自治州九寨沟县\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"是的\",\"city\":\"阿坝州\",\"coverImage\":\"/profile/upload/2025/11/18/sala4_20251118182804A008.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 18:28:06\",\"delFlag\":\"0\",\"district\":\"九寨沟县\",\"id\":9,\"latitude\":33.254,\"longitude\":103.918,\"name\":\"是的\",\"params\":{},\"ticketPrice\":0}}', '0', '', NULL, 18, '2025-11-18 18:28:06', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (222, '图片管理', 1, 'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()', 'POST', 1, 'admin', '研发部门', '/tourism/images/batch', '127.0.0.1', '内网IP', '[]', '{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}', '0', '', NULL, 6, '2025-11-18 18:28:07', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (223, '特色活动', 1, 'cn.edu.cquet.tourism.controller.TourismActivityController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditStatus\":\"0\",\"category\":\"是的\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 18:28:43\",\"delFlag\":\"0\",\"endTime\":\"2025-11-28 00:00:00\",\"id\":10,\"name\":\"水果排队\",\"params\":{},\"startTime\":\"2025-11-18 18:28:42\",\"venueId\":9}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 33, '2025-11-18 18:28:44', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (224, '特色活动申报', 2, 'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.approve()', 'POST', 1, 'admin', '研发部门', '/tourism/activityApplication/10/approve', '127.0.0.1', '内网IP', '{\"opinion\":\"可以\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 28, '2025-11-18 18:28:55', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (225, '场馆管理', 2, 'cn.edu.cquet.tourism.controller.tourismVenueController.edit()', 'PUT', 1, 'admin', '研发部门', '/tourism/venue', '127.0.0.1', '内网IP', '{\"address\":\"四川省阿坝藏族羌族自治州九寨沟县\",\"bookingRequired\":\"0\",\"capacity\":2,\"category\":\"是的\",\"city\":\"阿坝州\",\"collectionCount\":0,\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/sala4_20251118182804A008.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 18:28:06\",\"delFlag\":\"0\",\"district\":\"九寨沟县\",\"id\":9,\"latitude\":33.254,\"longitude\":103.918,\"name\":\"是的\",\"openingHours\":\"\",\"params\":{},\"status\":\"0\",\"ticketPrice\":0,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:30:53\",\"viewCount\":0,\"website\":\"\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 18, '2025-11-18 18:30:53', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (226, '图片管理', 1, 'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()', 'POST', 1, 'admin', '研发部门', '/tourism/images/batch', '127.0.0.1', '内网IP', '[]', '{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}', '0', '', NULL, 4, '2025-11-18 18:30:54', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (227, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.edit()', 'PUT', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditReason\":\"可以\",\"auditStatus\":\"1\",\"auditor\":\"admin\",\"category\":\"是的\",\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/ComfyUI_00001__20251118183359A009.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 18:28:44\",\"delFlag\":\"0\",\"endTime\":\"2025-11-28 00:00:00\",\"id\":10,\"name\":\"水果排队\",\"organizer\":\"是的官方\",\"params\":{},\"startTime\":\"2025-11-18 18:28:42\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:34:03\",\"venueId\":9}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 14, '2025-11-18 18:34:03', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (228, 'A级景区', 2, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.update()', 'PUT', 1, 'admin', '研发部门', '/tourism/scenic-spot', '127.0.0.1', '内网IP', '{\"address\":\"四川省阿坝藏族羌族自治州九寨沟县\",\"city\":\"阿坝州\",\"collectionCount\":0,\"contactPhone\":\"\",\"coverImage\":\"/profile/upload/2025/11/18/redis-cover_20251118183617A010.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-14 17:14:16\",\"delFlag\":\"0\",\"description\":\"九寨沟是世界自然遗产、国家重点风景名胜区、国家AAAAA级旅游景区、国家级自然保护区、国家地质公园、世界生物圈保护区网络，是中国第一个以保护自然风景为主要目的的自然保护区。\",\"district\":\"九寨沟县\",\"id\":23,\"latitude\":33.254,\"level\":\"5A\",\"longitude\":103.918,\"name\":\"九寨沟风景名胜区\",\"openingHours\":\"08:00-18:00\",\"params\":{},\"status\":\"0\",\"ticketPrice\":169,\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:36:18\",\"viewCount\":0,\"website\":\"\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 21, '2025-11-18 18:36:19', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (229, '图片管理', 1, 'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()', 'POST', 1, 'admin', '研发部门', '/tourism/images/batch', '127.0.0.1', '内网IP', '[]', '{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}', '0', '', NULL, 10, '2025-11-18 18:36:19', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (230, '场馆管理', 3, 'cn.edu.cquet.tourism.controller.tourismVenueController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tourism/venue/9', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 30, '2025-11-18 18:46:18', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (231, 'A级景区', 3, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tourism/scenic-spot/23', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 22, '2025-11-18 18:46:26', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (232, '菜单管理', 3, 'cn.edu.cquet.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2079', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 19, '2025-11-18 18:47:50', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (233, '菜单管理', 3, 'cn.edu.cquet.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2079', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作失败\",\"code\":500}', '0', '', NULL, 6, '2025-11-18 18:47:59', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (234, '菜单管理', 3, 'cn.edu.cquet.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2079', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作失败\",\"code\":500}', '0', '', NULL, 9, '2025-11-18 18:48:01', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (235, '菜单管理', 3, 'cn.edu.cquet.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2079', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作失败\",\"code\":500}', '0', '', NULL, 11, '2025-11-18 18:48:32', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (236, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/notice/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:45:01\",\"delFlag\":\"0\",\"icon\":\"button\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2078,\"menuName\":\"通知管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"notice\",\"perms\":\"tourism:notice:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:49:15\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 33, '2025-11-18 18:49:15', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (237, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/notice/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:45:01\",\"delFlag\":\"0\",\"icon\":\"button\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2078,\"menuName\":\"通知管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2072,\"path\":\"notice\",\"perms\":\"tourism:notice:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:49:28\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 14, '2025-11-18 18:49:29', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (238, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/news/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 14:24:01\",\"delFlag\":\"0\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"新闻管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"news\",\"perms\":\"tourism:news:list\",\"query\":\"\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:49:34\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 24, '2025-11-18 18:49:34', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (239, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/activity/index.vue\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:42:40\",\"delFlag\":\"0\",\"icon\":\"row\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2076,\"menuName\":\"活动管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2072,\"path\":\"activity\",\"perms\":\"tourism:activity:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:50:05\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 14, '2025-11-18 18:50:05', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (240, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/scenicSpot/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-10 14:01:25\",\"delFlag\":\"0\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2074,\"menuName\":\"旅游景点\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"scenicSpot\",\"perms\":\"tourism:scenicSpot:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:50:27\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 17, '2025-11-18 18:50:28', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (241, '菜单管理', 2, 'cn.edu.cquet.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tourism/venue/index\",\"createBy\":\"admin\",\"createTime\":\"2025-11-17 15:30:15\",\"delFlag\":\"0\",\"icon\":\"tree\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2075,\"menuName\":\"场馆管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2072,\"path\":\"venue\",\"perms\":\"tourism:venue:activity:list\",\"remark\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 18:51:03\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 12, '2025-11-18 18:51:04', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (242, 'A级景区', 1, 'cn.edu.cquet.tourism.controller.TourismScenicSpotController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/scenic-spot', '127.0.0.1', '内网IP', '{\"address\":\"重庆市两江新区\",\"city\":\"重庆市\",\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/小川_20251118192010A001.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:20:17\",\"delFlag\":\"0\",\"description\":\"重庆市永川区\",\"district\":\"重庆市两江新区\",\"id\":28,\"latitude\":3,\"level\":\"AAAAA\",\"longitude\":2,\"name\":\"重庆电子科技职业大学\",\"openingHours\":\"全天\",\"params\":{},\"remark\":\"测试\",\"ticketPrice\":0,\"website\":\"cquet\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"address\":\"重庆市两江新区\",\"city\":\"重庆市\",\"contactPhone\":\"18983432250\",\"coverImage\":\"/profile/upload/2025/11/18/小川_20251118192010A001.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:20:17\",\"delFlag\":\"0\",\"description\":\"重庆市永川区\",\"district\":\"重庆市两江新区\",\"id\":28,\"latitude\":3,\"level\":\"AAAAA\",\"longitude\":2,\"name\":\"重庆电子科技职业大学\",\"openingHours\":\"全天\",\"params\":{},\"remark\":\"测试\",\"ticketPrice\":0,\"website\":\"cquet\"}}', '0', '', NULL, 95, '2025-11-18 19:20:18', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (243, '图片管理', 1, 'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()', 'POST', 1, 'admin', '研发部门', '/tourism/images/batch', '127.0.0.1', '内网IP', '[]', '{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}', '0', '', NULL, 9, '2025-11-18 19:20:18', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (244, '场馆管理', 1, 'cn.edu.cquet.tourism.controller.tourismVenueController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/venue', '127.0.0.1', '内网IP', '{\"address\":\"重庆市两江新区\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"教学\",\"city\":\"重庆市\",\"coverImage\":\"/profile/upload/2025/11/18/蓝莓草莓_20251118192135A002.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:21:37\",\"delFlag\":\"0\",\"description\":\"教学\",\"district\":\"重庆市两江新区\",\"id\":10,\"latitude\":3,\"longitude\":2,\"name\":\"教学楼\",\"openingHours\":\"早上8:00-晚上22:00\",\"params\":{},\"ticketPrice\":0}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"address\":\"重庆市两江新区\",\"bookingRequired\":\"0\",\"capacity\":0,\"category\":\"教学\",\"city\":\"重庆市\",\"coverImage\":\"/profile/upload/2025/11/18/蓝莓草莓_20251118192135A002.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:21:37\",\"delFlag\":\"0\",\"description\":\"教学\",\"district\":\"重庆市两江新区\",\"id\":10,\"latitude\":3,\"longitude\":2,\"name\":\"教学楼\",\"openingHours\":\"早上8:00-晚上22:00\",\"params\":{},\"ticketPrice\":0}}', '0', '', NULL, 38, '2025-11-18 19:21:37', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (245, '图片管理', 1, 'cn.edu.cquet.tourism.controller.TourismImageController.addBatch()', 'POST', 1, 'admin', '研发部门', '/tourism/images/batch', '127.0.0.1', '内网IP', '[]', '{\"msg\":\"操作成功\",\"code\":200,\"data\":[]}', '0', '', NULL, 5, '2025-11-18 19:21:38', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (246, '特色活动', 1, 'cn.edu.cquet.tourism.controller.TourismActivityController.add()', 'POST', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditStatus\":\"0\",\"category\":\"比赛\",\"coverImage\":\"/profile/upload/2025/11/18/椎名_20251118192225A003.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:22:45\",\"delFlag\":\"0\",\"description\":\"低开吗\",\"endTime\":\"2025-11-26 00:00:00\",\"id\":11,\"name\":\"低代码大赛\",\"organizer\":\"重庆市电子科技\",\"params\":{},\"startTime\":\"2025-11-18 00:00:00\",\"venueId\":10}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 26, '2025-11-18 19:22:46', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (247, '特色活动申报', 2, 'cn.edu.cquet.tourism.controller.TourismActivityApplicationController.approve()', 'POST', 1, 'admin', '研发部门', '/tourism/activityApplication/11/approve', '127.0.0.1', '内网IP', '{\"opinion\":\"测试通过\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 26, '2025-11-18 19:24:26', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (248, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.edit()', 'PUT', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditReason\":\"测试通过\",\"auditStatus\":\"1\",\"auditor\":\"admin\",\"category\":\"比赛\",\"contactPhone\":\"\",\"coverImage\":\"/profile/upload/2025/11/18/椎名_20251118192225A003.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:22:46\",\"delFlag\":\"0\",\"description\":\"低开吗\",\"endTime\":\"2025-11-26 00:00:00\",\"id\":11,\"name\":\"低代码大赛\",\"organizer\":\"重庆市电子科技\",\"params\":{},\"startTime\":\"2025-11-18 00:00:00\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 19:25:56\",\"venueId\":10}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 18, '2025-11-18 19:25:57', 0, NULL);
INSERT INTO `sys_oper_log` VALUES (249, '特色活动', 2, 'cn.edu.cquet.tourism.controller.TourismActivityController.edit()', 'PUT', 1, 'admin', '研发部门', '/tourism/activity', '127.0.0.1', '内网IP', '{\"auditReason\":\"测试通过\",\"auditStatus\":\"1\",\"auditor\":\"admin\",\"category\":\"比赛\",\"contactPhone\":\"\",\"coverImage\":\"/profile/upload/2025/11/18/椎名_20251118192225A003.png\",\"createBy\":\"admin\",\"createTime\":\"2025-11-18 19:22:46\",\"currentParticipants\":0,\"delFlag\":\"0\",\"description\":\"低开吗\",\"endTime\":\"2025-11-26 00:00:00\",\"id\":11,\"maxParticipants\":4,\"name\":\"低代码大赛\",\"organizer\":\"重庆市电子科技\",\"params\":{},\"startTime\":\"2025-11-18 00:00:00\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-18 19:29:33\",\"venueId\":10}', '{\"msg\":\"操作成功\",\"code\":200}', '0', '', NULL, 36, '2025-11-18 19:29:33', 0, NULL);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2024-09-04 06:22:51', '', NULL, '', '0');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2024-09-04 06:22:51', '', NULL, '', '0');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2024-09-04 06:22:51', 'admin', '2024-09-09 11:55:13', '', '0');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2024-09-04 06:22:51', 'admin', '2024-09-09 11:53:31', '', '0');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2024-09-04 06:22:51', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2024-09-04 06:22:51', 'admin', '2025-10-25 21:22:14', '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 106 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', 'CQUET', '00', 'CQUET@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-11-18 18:01:24', 'admin', '2024-09-04 06:22:51', NULL, '2025-11-18 18:01:24', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '测试', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$TZh50TgviSV8zEftiwy7ZuNHrdw7a.yloDmWLbNSDO1PSTacSvLRG', '0', '0', '127.0.0.1', '2025-10-25 21:23:26', 'admin', '2024-09-04 06:22:51', NULL, '2025-10-25 21:23:26', '测试员1');
INSERT INTO `sys_user` VALUES (105, NULL, 'liyuan', 'liyuan', '00', '', '', '0', '', '$2a$10$tgq/ctqpuY/moLaKttk/peQyxTfsy1X7nRW3MVYNCZYIuNvbqfVGK', '0', '0', '127.0.0.1', '2025-11-14 17:03:38', NULL, '2025-10-27 15:12:23', NULL, '2025-11-14 17:03:38', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);
INSERT INTO `sys_user_post` VALUES (2, 3);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

-- ----------------------------
-- Table structure for tourism_activity
-- ----------------------------
DROP TABLE IF EXISTS `tourism_activity`;
CREATE TABLE `tourism_activity`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '活动ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '活动名称',
  `cover_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '活动封面图片URL',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '活动类别（文化体验、艺术表演、教育活动等）',
  `venue_id` bigint NULL DEFAULT NULL COMMENT '举办场馆ID',
  `organizer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主办方',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '联系电话',
  `start_time` datetime NULL DEFAULT NULL COMMENT '活动开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '活动结束时间',
  `registration_start` datetime NULL DEFAULT NULL COMMENT '报名开始时间',
  `registration_end` datetime NULL DEFAULT NULL COMMENT '报名结束时间',
  `max_participants` int NULL DEFAULT 0 COMMENT '最大参与人数（0表示不限制）',
  `current_participants` int NULL DEFAULT 0 COMMENT '当前报名人数',
  `fee` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '活动费用（0表示免费）',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '活动详细介绍',
  `requirements` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '参与要求',
  `view_count` int NULL DEFAULT 0 COMMENT '浏览次数',
  `comment_count` int NULL DEFAULT 0 COMMENT '评论次数',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `audit_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '审核状态（0待审核 1审核通过 2审核拒绝）',
  `audit_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '审核意见',
  `auditor` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '审核人',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_name`(`name` ASC) USING BTREE,
  INDEX `idx_category`(`category` ASC) USING BTREE,
  INDEX `idx_venue_id`(`venue_id` ASC) USING BTREE,
  INDEX `idx_start_time`(`start_time` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_audit_status`(`audit_status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  CONSTRAINT `fk_activity_venue` FOREIGN KEY (`venue_id`) REFERENCES `tourism_venue` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '特色活动信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tourism_activity
-- ----------------------------
INSERT INTO `tourism_activity` VALUES (1, '测试001', '1', '文化体验', 1, '测试001', '12344556677', '2025-11-16 16:52:45', '2025-11-15 16:52:48', '2025-11-15 16:52:53', '2025-11-15 16:52:54', 0, 0, 0.00, '111', NULL, 0, 0, '1', '2', '测试', 'admin', NULL, '', NULL, 'admin', '2025-11-18 16:08:17', NULL, '2');
INSERT INTO `tourism_activity` VALUES (7, '重庆非遗展览季', 'https://cdn.example.com/images/feiyi-expo.jpg', '展览', 1, '重庆市文化和旅游委员会', '13800138000', '2025-12-01 09:00:00', '2025-12-15 17:30:00', NULL, NULL, 0, 0, 0.00, '集中展示川渝地区非遗项目与工艺，含互动体验。', NULL, 0, 0, '0', '1', '可以', 'admin', NULL, 'admin', '2025-11-15 17:58:32', 'admin', '2025-11-18 16:11:14', '', '2');
INSERT INTO `tourism_activity` VALUES (8, '重庆非遗展览季', 'https://cdn.example.com/images/feiyi-expo.jpg', '展览', 1, '重庆市文化和旅游委员会', '13800138000', '2025-12-01 09:00:00', '2025-12-15 17:30:00', NULL, NULL, 0, 0, 0.00, '集中展示川渝地区非遗项目与工艺，含互动体验。', NULL, 0, 0, '1', '1', '可以的', 'admin', NULL, 'admin', '2025-11-15 17:58:34', 'admin', '2025-11-18 16:11:04', '', '2');
INSERT INTO `tourism_activity` VALUES (9, '士大夫', '', '是的', 7, '', '5562+', '2025-11-18 16:31:27', '2025-11-21 00:00:00', NULL, NULL, 0, 0, 0.00, NULL, NULL, 0, 0, '0', '1', '', 'admin', NULL, 'admin', '2025-11-18 16:31:29', '', '2025-11-18 16:31:46', NULL, '2');
INSERT INTO `tourism_activity` VALUES (10, '水果排队', '/profile/upload/2025/11/18/ComfyUI_00001__20251118183359A009.png', '是的', 9, '是的官方', '18983432250', '2025-11-18 18:28:42', '2025-11-28 00:00:00', NULL, NULL, 0, 0, 0.00, NULL, NULL, 0, 0, '0', '1', '可以', 'admin', NULL, 'admin', '2025-11-18 18:28:44', 'admin', '2025-11-18 18:34:03', NULL, '2');
INSERT INTO `tourism_activity` VALUES (11, '低代码大赛', '/profile/upload/2025/11/18/椎名_20251118192225A003.png', '比赛', 10, '重庆市电子科技', '', '2025-11-18 00:00:00', '2025-11-26 00:00:00', NULL, NULL, 4, 0, 0.00, '低开吗', NULL, 0, 0, '0', '1', '测试通过', 'admin', NULL, 'admin', '2025-11-18 19:22:46', 'admin', '2025-11-18 19:29:33', NULL, '0');

-- ----------------------------
-- Table structure for tourism_activity_application
-- ----------------------------
DROP TABLE IF EXISTS `tourism_activity_application`;
CREATE TABLE `tourism_activity_application`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '报名ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `applicant_id` bigint NOT NULL COMMENT '报名用户ID',
  `applicant_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '报名人姓名',
  `applicant_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '报名人电话',
  `application_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '报名理由',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '报名状态（0待审核 1审核通过 2审核拒绝 3已取消）',
  `audit_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '审核意见',
  `auditor` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '审核人',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_activity_applicant`(`activity_id` ASC, `applicant_id` ASC) USING BTREE,
  INDEX `idx_activity_id`(`activity_id` ASC) USING BTREE,
  INDEX `idx_applicant_id`(`applicant_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  CONSTRAINT `fk_application_activity` FOREIGN KEY (`activity_id`) REFERENCES `tourism_activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_application_user` FOREIGN KEY (`applicant_id`) REFERENCES `sys_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '特色活动报名表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tourism_activity_application
-- ----------------------------

-- ----------------------------
-- Table structure for tourism_activity_comment
-- ----------------------------
DROP TABLE IF EXISTS `tourism_activity_comment`;
CREATE TABLE `tourism_activity_comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `user_id` bigint NOT NULL COMMENT '评论用户ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '评论用户名',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '评论内容',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父评论ID（0表示顶级评论）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_activity_id`(`activity_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  CONSTRAINT `fk_comment_activity` FOREIGN KEY (`activity_id`) REFERENCES `tourism_activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comment_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '活动评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tourism_activity_comment
-- ----------------------------

-- ----------------------------
-- Table structure for tourism_facilities
-- ----------------------------
DROP TABLE IF EXISTS `tourism_facilities`;
CREATE TABLE `tourism_facilities`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '设备主键',
  `facilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '设备名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '设备信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tourism_facilities
-- ----------------------------
INSERT INTO `tourism_facilities` VALUES (1, '游泳池');
INSERT INTO `tourism_facilities` VALUES (2, '电视机');
INSERT INTO `tourism_facilities` VALUES (3, '笔记本电脑');

-- ----------------------------
-- Table structure for tourism_image
-- ----------------------------
DROP TABLE IF EXISTS `tourism_image`;
CREATE TABLE `tourism_image`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '图片主键',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图片URL地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '旅游图片信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tourism_image
-- ----------------------------
INSERT INTO `tourism_image` VALUES (1, '1.jpg');
INSERT INTO `tourism_image` VALUES (2, '2.jpg');
INSERT INTO `tourism_image` VALUES (3, '1.jpg');
INSERT INTO `tourism_image` VALUES (4, '2.jpg');
INSERT INTO `tourism_image` VALUES (5, '3.jpg');
INSERT INTO `tourism_image` VALUES (6, 'https://ts2.tc.mm.bing.net/th/id/OIP-C.QSb7FtM8GaCgiGC-jD7IawHaEK?rs=1&pid=ImgDetMain&o=7&rm=3');
INSERT INTO `tourism_image` VALUES (7, 'https://ts2.tc.mm.bing.net/th/id/OIP-C.QSb7FtM8GaCgiGC-jD7IawHaEK?rs=1&pid=ImgDetMain&o=7&rm=3');
INSERT INTO `tourism_image` VALUES (8, '/profile/upload/2025/11/18/头像_20251118172905A001.png');
INSERT INTO `tourism_image` VALUES (9, '/profile/upload/2025/11/18/未标题-1_20251118172908A002.png');
INSERT INTO `tourism_image` VALUES (10, '/profile/upload/2025/11/18/未标题-1_20251118172908A002.png');
INSERT INTO `tourism_image` VALUES (11, '/profile/upload/2025/11/18/头像_20251118181329A004.png');
INSERT INTO `tourism_image` VALUES (12, '/profile/upload/2025/11/18/头像_20251118181617A006.png');
INSERT INTO `tourism_image` VALUES (13, '/profile/upload/2025/11/18/头像_20251118181329A004.png');
INSERT INTO `tourism_image` VALUES (14, '/profile/upload/2025/11/18/头像_20251118182212A007.png');
INSERT INTO `tourism_image` VALUES (15, '/profile/upload/2025/11/18/头像_20251118181329A004.png');

-- ----------------------------
-- Table structure for tourism_news
-- ----------------------------
DROP TABLE IF EXISTS `tourism_news`;
CREATE TABLE `tourism_news`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '新闻内容',
  `author` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改者',
  `del_flag` int NULL DEFAULT NULL COMMENT '删除标识（0：存在，2：删除）',
  `status` int NULL DEFAULT NULL COMMENT '状态（0：正常，1：停用）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '旅游项目表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tourism_news
-- ----------------------------
INSERT INTO `tourism_news` VALUES (1, '测试标题001（修改后）', '测试内容001（修改后）', '测试作者001（修改后）', '2025-10-28 19:55:09', 'liyuan', '2025-11-04 16:28:01', 'admin', 2, NULL, NULL);
INSERT INTO `tourism_news` VALUES (2, '测试标题002', '测试内容002', '测试作者002', '2025-10-29 10:41:38', 'liyuan', '2025-11-04 16:28:01', 'admin', 2, NULL, NULL);
INSERT INTO `tourism_news` VALUES (3, '测试标题003', '测试内容003', '测试作者003', '2025-10-29 10:41:46', 'liyuan', '2025-11-18 18:55:21', 'admin', 0, 0, NULL);
INSERT INTO `tourism_news` VALUES (4, '测试标题004', '测试内容004', '测试作者004', '2025-10-29 10:41:52', 'liyuan', NULL, NULL, 0, NULL, NULL);
INSERT INTO `tourism_news` VALUES (5, '测试标题005', '测试内容005', '测试作者005', '2025-10-29 10:41:59', 'liyuan', '2025-10-29 10:58:59', 'liyuan', 2, NULL, NULL);
INSERT INTO `tourism_news` VALUES (6, '测试标题006', '测试内容006', '测试作者006', '2025-10-29 10:42:09', 'liyuan', '2025-10-29 10:58:59', 'liyuan', 2, NULL, NULL);
INSERT INTO `tourism_news` VALUES (7, '测试标题007', '测试内容007', '测试作者007', '2025-10-29 10:42:16', 'liyuan', '2025-10-29 10:58:27', 'liyuan', 2, NULL, NULL);
INSERT INTO `tourism_news` VALUES (8, '适当放松的地方是的', '<p>适当放松的地方是的</p>', '适当放松的地方是的', '2025-11-04 16:39:43', 'admin', NULL, NULL, 0, NULL, '适当放松的地方是的');
INSERT INTO `tourism_news` VALUES (9, '是的发生的发生的', '<p>士大夫是的发送 </p>', '是的发送发的', '2025-11-18 19:18:16', 'admin', NULL, NULL, 0, NULL, '是的发士大夫是');

-- ----------------------------
-- Table structure for tourism_notice
-- ----------------------------
DROP TABLE IF EXISTS `tourism_notice`;
CREATE TABLE `tourism_notice`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '通知ID',
  `notice_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知标题',
  `notice_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '通知内容',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '通知类型（1通知 2公告）',
  `priority` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '优先级（0普通 1重要 2紧急）',
  `view_count` int NULL DEFAULT 0 COMMENT '浏览次数',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_notice_type`(`notice_type` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_priority`(`priority` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tourism_notice
-- ----------------------------
INSERT INTO `tourism_notice` VALUES (1, '重庆文旅网站正式上线', '欢迎使用重庆文化旅游服务平台！本平台为您提供A级景区信息、文化场馆介绍、特色活动报名等服务。', '2', '1', 0, '0', 'admin', '2025-11-02 12:19:13', '', NULL, '系统通知', '0');
INSERT INTO `tourism_notice` VALUES (2, '春节期间活动安排通知', '春节期间，各大景区和文化场馆将举办丰富多彩的文化活动，欢迎广大市民和游客参与。', '1', '0', 0, '0', 'admin', '2025-11-02 12:19:13', '', NULL, '节日通知', '0');
INSERT INTO `tourism_notice` VALUES (3, '测是', '<p>是额</p>', '1', '0', 0, '0', 'admin', '2025-11-18 19:17:52', '', NULL, '是', '0');

-- ----------------------------
-- Table structure for tourism_scenic_spot
-- ----------------------------
DROP TABLE IF EXISTS `tourism_scenic_spot`;
CREATE TABLE `tourism_scenic_spot`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '景区ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '景区名称',
  `level` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'A' COMMENT '景区等级（A、AA、AAA、AAAA、AAAAA）',
  `cover_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '封面图片URL',
  `ticket_price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '门票价格',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '景区地址',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '所在城市',
  `district` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '所在区县',
  `opening_hours` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '开放时间',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '联系电话',
  `website` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '官方网站',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '景区介绍',
  `longitude` decimal(10, 7) NULL DEFAULT NULL COMMENT '经度',
  `latitude` decimal(10, 7) NULL DEFAULT NULL COMMENT '纬度',
  `collection_count` int NULL DEFAULT 0 COMMENT '收藏次数',
  `view_count` int NULL DEFAULT 0 COMMENT '浏览次数',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_name`(`name` ASC) USING BTREE,
  INDEX `idx_level`(`level` ASC) USING BTREE,
  INDEX `idx_city`(`city` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'A级景区信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tourism_scenic_spot
-- ----------------------------
INSERT INTO `tourism_scenic_spot` VALUES (22, '测试004', 'AAAA', '/profile/upload/2025/11/10/屏幕截图 2025-05-24 192846_20251110152946A016.png', 50.00, '大学城东路76号', '北京', '', '', '13408206603', '', NULL, 0.0000000, 0.0000000, 0, 0, '0', 'admin', '2025-11-10 15:29:52', 'admin', '2025-11-11 16:12:05', '1111', '2');
INSERT INTO `tourism_scenic_spot` VALUES (23, '九寨沟风景名胜区', '5A', '/profile/upload/2025/11/18/redis-cover_20251118183617A010.jpg', 169.00, '四川省阿坝藏族羌族自治州九寨沟县', '阿坝州', '九寨沟县', '08:00-18:00', '', '', '九寨沟是世界自然遗产、国家重点风景名胜区、国家AAAAA级旅游景区、国家级自然保护区、国家地质公园、世界生物圈保护区网络，是中国第一个以保护自然风景为主要目的的自然保护区。', 103.9180000, 33.2540000, 0, 0, '0', 'admin', '2025-11-14 17:14:16', 'admin', '2025-11-18 18:36:19', NULL, '2');
INSERT INTO `tourism_scenic_spot` VALUES (24, '测试001', 'AAA', '', 0.00, '测试001', '测试001', '', '', '', '', '测试001', NULL, NULL, 0, 0, '0', 'admin', '2025-11-14 17:57:56', '', NULL, NULL, '2');
INSERT INTO `tourism_scenic_spot` VALUES (25, '重庆解放碑', 'AAAAA', '/profile/upload/2025/11/18/未标题-1_20251118181325A003.png', 0.00, '重庆市', '重庆市', '重庆市', '全天', '18983432250', 'cq.com', '解放碑', 6.0000000, -6.0000000, 0, 0, '0', 'admin', '2025-11-18 15:32:04', 'admin', '2025-11-18 18:22:21', NULL, '2');
INSERT INTO `tourism_scenic_spot` VALUES (26, '测试', 'A', '/profile/upload/2025/11/18/mmexport1762929757923_20251118172249A001.jpeg', 0.00, '彩色', '测试', '', '测试', '', '', NULL, 3.0000000, 3.0000000, 0, 0, '0', 'admin', '2025-11-18 17:23:13', 'admin', '2025-11-18 18:10:59', NULL, '2');
INSERT INTO `tourism_scenic_spot` VALUES (27, '测试测试', 'A', '/profile/upload/2025/11/18/mmexport1762929757923_20251118172249A001.jpeg', 0.00, '彩色', '测试', '', '测试', '', '', NULL, 3.0000000, 3.0000000, 0, 0, '0', 'admin', '2025-11-18 17:23:23', '', NULL, NULL, '2');
INSERT INTO `tourism_scenic_spot` VALUES (28, '重庆电子科技职业大学', 'AAAAA', '/profile/upload/2025/11/18/小川_20251118192010A001.jpg', 0.00, '重庆市两江新区', '重庆市', '重庆市两江新区', '全天', '18983432250', 'cquet', '重庆市永川区', 2.0000000, 3.0000000, 0, 0, '0', 'admin', '2025-11-18 19:20:17', '', NULL, '测试', '0');

-- ----------------------------
-- Table structure for tourism_scenic_spot_image
-- ----------------------------
DROP TABLE IF EXISTS `tourism_scenic_spot_image`;
CREATE TABLE `tourism_scenic_spot_image`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '关联记录主键',
  `scenic_spot_id` bigint NOT NULL COMMENT '关联的旅游景区ID（外键）',
  `image_id` int NOT NULL COMMENT '关联的图片ID（外键）',
  `sort` int NULL DEFAULT 0 COMMENT '图片排序序号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_venue_image`(`scenic_spot_id` ASC, `image_id` ASC) USING BTREE,
  INDEX `image_id`(`image_id` ASC) USING BTREE,
  CONSTRAINT `tourism_scenic_spot_image_ibfk_1` FOREIGN KEY (`scenic_spot_id`) REFERENCES `tourism_scenic_spot` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tourism_scenic_spot_image_ibfk_2` FOREIGN KEY (`image_id`) REFERENCES `tourism_image` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '旅游景区-图片关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tourism_scenic_spot_image
-- ----------------------------

-- ----------------------------
-- Table structure for tourism_user_collection
-- ----------------------------
DROP TABLE IF EXISTS `tourism_user_collection`;
CREATE TABLE `tourism_user_collection`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `target_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收藏目标类型（scenic_spot、venue、activity）',
  `target_id` bigint NOT NULL COMMENT '收藏目标ID',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_target`(`user_id` ASC, `target_type` ASC, `target_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_target_type`(`target_type` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  CONSTRAINT `fk_collection_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户收藏信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tourism_user_collection
-- ----------------------------

-- ----------------------------
-- Table structure for tourism_venue
-- ----------------------------
DROP TABLE IF EXISTS `tourism_venue`;
CREATE TABLE `tourism_venue`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '场馆ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '场馆名称',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '场馆类别（博物馆、图书馆、文化馆、剧院等）',
  `cover_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '封面图片URL',
  `ticket_price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '门票价格（0表示免费）',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '场馆地址',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '所在城市',
  `district` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '所在区县',
  `opening_hours` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '开放时间',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '联系电话',
  `website` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '官方网站',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '场馆介绍',
  `longitude` decimal(10, 7) NULL DEFAULT NULL COMMENT '经度',
  `latitude` decimal(10, 7) NULL DEFAULT NULL COMMENT '纬度',
  `capacity` int NULL DEFAULT 0 COMMENT '容纳人数',
  `booking_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否需要预约（0不需要 1需要）',
  `collection_count` int NULL DEFAULT 0 COMMENT '收藏次数',
  `view_count` int NULL DEFAULT 0 COMMENT '浏览次数',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_name`(`name` ASC) USING BTREE,
  INDEX `idx_category`(`category` ASC) USING BTREE,
  INDEX `idx_city`(`city` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '场馆信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tourism_venue
-- ----------------------------
INSERT INTO `tourism_venue` VALUES (1, '重庆中国三峡博物馆', '博物馆', '/images/sanxia_museum_cover.jpg', 0.00, '重庆市渝中区人民路236号', '重庆市', '渝中区', '09:00-17:00（周一闭馆）', '023-63679066', 'http://www.3gmuseum.cn', '重庆中国三峡博物馆是首批国家一级博物馆，展示了三峡历史文化和重庆地方历史文化。', 106.5584200, 29.5562700, 2000, '0', 0, 0, '0', 'admin', '2025-11-02 12:19:13', 'admin', '2025-11-18 16:07:39', '国家一级博物馆', '2');
INSERT INTO `tourism_venue` VALUES (2, '重庆图书馆', '图书馆', '/images/cq_library_cover.jpg', 0.00, '重庆市沙坪坝区凤天大道106号', '重庆市', '沙坪坝区', '09:00-21:00', '023-65210070', 'http://www.cqlib.cn', '重庆图书馆是重庆市综合性研究型公共图书馆，为市民提供文献借阅、信息咨询、文化活动等服务。', 106.4321000, 29.5412000, 3000, '1', 0, 0, '0', 'admin', '2025-11-02 12:19:13', '', NULL, '市级综合图书馆', '2');
INSERT INTO `tourism_venue` VALUES (3, '重庆科技馆', '科技馆', '', 20.00, '重庆市渝北区黄山大道中段', '', '', '', '12345432213', 'http://www.cqstm.org.cn', '重庆科技馆是重庆市重要的科普教育基地', NULL, NULL, 0, '0', 0, 0, '0', 'liyuan', '2025-11-11 19:07:46', '', NULL, NULL, '2');
INSERT INTO `tourism_venue` VALUES (4, '场馆名称', '场馆类别', '封面图片URL', 20.00, '详细地址', '', '', '', '13345667788', '官方网站', '场馆描述', 106.1234560, 29.1234560, 0, '0', 0, 0, '1', 'liyuan', '2025-11-11 19:55:34', '', NULL, NULL, '2');
INSERT INTO `tourism_venue` VALUES (5, '重庆科技馆1', '科技馆', 'http://example.com/images/venue1.jpg', 0.00, '重庆市渝北区黄山大道中段', '', '', '', '12345678890', 'http://www.cqstm.org.cn', '重庆科技馆是重庆市重要的科普教育基地', 106.1234560, 29.1234560, 0, '0', 0, 0, '1', 'liyuan', '2025-11-11 19:56:37', 'liyuan', '2025-11-12 10:57:47', NULL, '2');
INSERT INTO `tourism_venue` VALUES (6, '重庆科技馆2', '科技馆', 'http://example.com/images/venue1.jpg', 0.00, '重庆市渝北区黄山大道中段', '', '', '', '12345678890', 'http://www.cqstm.org.cn', '重庆科技馆是重庆市重要的科普教育基地', 106.1234560, 29.1234560, 0, '0', 0, 0, '1', 'liyuan', '2025-11-12 10:58:09', '', NULL, NULL, '2');
INSERT INTO `tourism_venue` VALUES (7, '科技馆', '文旅', '/profile/upload/2025/11/18/未标题-1_20251118181611A005.png', 4.00, '重庆市', '重庆市', '重庆市', '下午', '18983432250', '', '解放碑科技', 6.0000000, -6.0000000, 0, '0', 0, 0, '0', 'admin', '2025-11-18 16:28:46', 'admin', '2025-11-18 18:16:19', NULL, '2');
INSERT INTO `tourism_venue` VALUES (8, '就订啊', '酒店', '', 0.00, '重庆市', '重庆市', '重庆市', '', '', '', NULL, 6.0000000, -6.0000000, 0, '0', 0, 0, '0', 'admin', '2025-11-18 16:32:27', '', NULL, NULL, '2');
INSERT INTO `tourism_venue` VALUES (9, '是的', '是的', '/profile/upload/2025/11/18/sala4_20251118182804A008.jpg', 0.00, '四川省阿坝藏族羌族自治州九寨沟县', '阿坝州', '九寨沟县', '', '18983432250', '', NULL, 103.9180000, 33.2540000, 2, '0', 0, 0, '0', 'admin', '2025-11-18 18:28:06', 'admin', '2025-11-18 18:30:53', NULL, '2');
INSERT INTO `tourism_venue` VALUES (10, '教学楼', '教学', '/profile/upload/2025/11/18/蓝莓草莓_20251118192135A002.jpg', 0.00, '重庆市两江新区', '重庆市', '重庆市两江新区', '早上8:00-晚上22:00', '', '', '教学', 2.0000000, 3.0000000, 0, '0', 0, 0, '0', 'admin', '2025-11-18 19:21:37', '', NULL, NULL, '0');

-- ----------------------------
-- Table structure for tourism_venue_facilities
-- ----------------------------
DROP TABLE IF EXISTS `tourism_venue_facilities`;
CREATE TABLE `tourism_venue_facilities`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '关联记录主键',
  `venue_id` bigint NOT NULL COMMENT '关联的场馆ID（外键）',
  `facilities_id` int NOT NULL COMMENT '关联的设备ID（外键）',
  `sort` int NULL DEFAULT 0 COMMENT '设备排序序号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_venue_facilities`(`venue_id` ASC, `facilities_id` ASC) USING BTREE,
  INDEX `facilities_id`(`facilities_id` ASC) USING BTREE,
  CONSTRAINT `tourism_venue_facilities_ibfk_1` FOREIGN KEY (`venue_id`) REFERENCES `tourism_venue` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tourism_venue_facilities_ibfk_2` FOREIGN KEY (`facilities_id`) REFERENCES `tourism_facilities` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '场馆设备-关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tourism_venue_facilities
-- ----------------------------

-- ----------------------------
-- Table structure for tourism_venue_image
-- ----------------------------
DROP TABLE IF EXISTS `tourism_venue_image`;
CREATE TABLE `tourism_venue_image`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '关联记录主键',
  `venue_id` bigint NOT NULL COMMENT '关联的旅游场馆ID（外键）',
  `image_id` int NOT NULL COMMENT '关联的图片ID（外键）',
  `sort` int NULL DEFAULT 0 COMMENT '图片排序序号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_venue_image`(`venue_id` ASC, `image_id` ASC) USING BTREE,
  INDEX `image_id`(`image_id` ASC) USING BTREE,
  CONSTRAINT `tourism_venue_image_ibfk_1` FOREIGN KEY (`venue_id`) REFERENCES `tourism_venue` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tourism_venue_image_ibfk_2` FOREIGN KEY (`image_id`) REFERENCES `tourism_image` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '旅游场馆-图片关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tourism_venue_image
-- ----------------------------

-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
