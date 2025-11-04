-- =============================================
-- 文旅网站业务表创建脚本（包含外键约束）
-- 基于若依框架设计规范
-- 创建时间：2024年
-- =============================================

-- 设置字符集
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =============================================
-- 1. 通知公告表
-- =============================================
DROP TABLE IF EXISTS `tourism_notice`;
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='通知公告表';

-- =============================================
-- 2. A级景区信息表
-- =============================================
DROP TABLE IF EXISTS `tourism_scenic_spot`;
CREATE TABLE `tourism_scenic_spot` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '景区ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '景区名称',
  `level` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'A' COMMENT '景区等级（A、AA、AAA、AAAA、AAAAA）',
  `cover_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '封面图片URL',
  `image_urls` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '景区图片URLs，JSON格式存储',
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='A级景区信息表';

-- =============================================
-- 3. 场馆信息表
-- =============================================
DROP TABLE IF EXISTS `tourism_venue`;
CREATE TABLE `tourism_venue` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '场馆ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '场馆名称',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '场馆类别（博物馆、图书馆、文化馆、剧院等）',
  `cover_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '封面图片URL',
  `image_urls` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '场馆图片URLs，JSON格式存储',
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
  `facilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '设施信息，JSON格式存储',
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='场馆信息表';

-- =============================================
-- 4. 特色活动信息表
-- =============================================
DROP TABLE IF EXISTS `tourism_activity`;
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
  `collection_count` int DEFAULT '0' COMMENT '收藏次数',
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='特色活动信息表';

-- =============================================
-- 5. 特色活动报名表
-- =============================================
DROP TABLE IF EXISTS `tourism_activity_application`;
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='特色活动报名表';

-- =============================================
-- 6. 用户收藏信息表
-- =============================================
DROP TABLE IF EXISTS `tourism_user_collection`;
CREATE TABLE `tourism_user_collection` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `target_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收藏目标类型（scenic_spot、venue、activity）',
  `target_id` bigint NOT NULL COMMENT '收藏目标ID',
  `target_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '收藏目标名称',
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户收藏信息表';

-- =============================================
-- 7. 活动评论表
-- =============================================
DROP TABLE IF EXISTS `tourism_activity_comment`;
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='活动评论表';

-- =============================================
-- 初始化数据
-- =============================================

-- 插入通知公告示例数据
INSERT INTO `tourism_notice` VALUES 
(1, '重庆文旅网站正式上线', '欢迎使用重庆文化旅游服务平台！本平台为您提供A级景区信息、文化场馆介绍、特色活动报名等服务。', '2', '1', 0, '0', 'admin', NOW(), '', NULL, '系统通知', '0'),
(2, '春节期间活动安排通知', '春节期间，各大景区和文化场馆将举办丰富多彩的文化活动，欢迎广大市民和游客参与。', '1', '0', 0, '0', 'admin', NOW(), '', NULL, '节日通知', '0');

-- 插入A级景区示例数据
INSERT INTO `tourism_scenic_spot` VALUES 
(1, '洪崖洞民俗风貌区', 'AAAA', '/images/hongyadong_cover.jpg', '["\/images\/hongyadong_1.jpg","\/images\/hongyadong_2.jpg"]', 0.00, '重庆市渝中区嘉陵江滨江路88号', '重庆市', '渝中区', '全天开放', '023-63039995', 'http://www.hongyadong.com', '洪崖洞是重庆市核心商圈解放碑的延伸，位于重庆市渝中区嘉陵江滨江路88号，是兼具观光旅游、休闲度假等功能的旅游区。', 106.584970, 29.564270, 0, 0, '0', 'admin', NOW(), '', NULL, '重庆地标性景区', '0'),
(2, '磁器口古镇', 'AAAA', '/images/ciqikou_cover.jpg', '["\/images\/ciqikou_1.jpg","\/images\/ciqikou_2.jpg"]', 0.00, '重庆市沙坪坝区磁器口古镇', '重庆市', '沙坪坝区', '09:00-18:00', '023-65312003', '', '磁器口古镇位于重庆市沙坪坝区嘉陵江畔，始建于宋代，拥有"一江两溪三山四街"的独特地貌。', 106.463420, 29.590650, 0, 0, '0', 'admin', NOW(), '', NULL, '千年古镇', '0');

-- 插入场馆示例数据
INSERT INTO `tourism_venue` VALUES 
(1, '重庆中国三峡博物馆', '博物馆', '/images/sanxia_museum_cover.jpg', '["\/images\/sanxia_museum_1.jpg","\/images\/sanxia_museum_2.jpg"]', 0.00, '重庆市渝中区人民路236号', '重庆市', '渝中区', '09:00-17:00（周一闭馆）', '023-63679066', 'http://www.3gmuseum.cn', '重庆中国三峡博物馆是首批国家一级博物馆，展示了三峡历史文化和重庆地方历史文化。', 106.558420, 29.556270, 2000, '["无障碍设施","免费WiFi","语音导览","文创商店"]', '0', 0, 0, '0', 'admin', NOW(), '', NULL, '国家一级博物馆', '0'),
(2, '重庆图书馆', '图书馆', '/images/cq_library_cover.jpg', '["\/images\/cq_library_1.jpg","\/images\/cq_library_2.jpg"]', 0.00, '重庆市沙坪坝区凤天大道106号', '重庆市', '沙坪坝区', '09:00-21:00', '023-65210070', 'http://www.cqlib.cn', '重庆图书馆是重庆市综合性研究型公共图书馆，为市民提供文献借阅、信息咨询、文化活动等服务。', 106.432100, 29.541200, 3000, '["自习室","电子阅览室","多媒体室","咖啡厅"]', '1', 0, 0, '0', 'admin', NOW(), '', NULL, '市级综合图书馆', '0');

-- 恢复外键检查
SET FOREIGN_KEY_CHECKS = 1;

-- =============================================
-- 脚本执行完成
-- =============================================