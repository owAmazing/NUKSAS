-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2026-06-21 15:05:21
-- 伺服器版本： 10.4.32-MariaDB
-- PHP 版本： 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `scholarship_system`
--

-- --------------------------------------------------------

--
-- 資料表結構 `aboriginal_student`
--

CREATE TABLE `aboriginal_student` (
  `id` varchar(50) NOT NULL,
  `aboriginal_certify` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `admin_memo`
--

CREATE TABLE `admin_memo` (
  `id` varchar(50) NOT NULL COMMENT '備忘錄ID（MEMO+時間戳記）',
  `admin_id` varchar(50) NOT NULL COMMENT '管理員ID',
  `title` varchar(255) NOT NULL COMMENT '標題',
  `content` text DEFAULT NULL COMMENT '內容',
  `priority` varchar(20) NOT NULL DEFAULT '重要' COMMENT '優先級：緊急/重要/沒那麼重要',
  `status` varchar(20) NOT NULL DEFAULT '代辦' COMMENT '狀態：代辦/完成',
  `reminder_date` date DEFAULT NULL COMMENT '提醒日期',
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '建立時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理員備忘錄';

--
-- 傾印資料表的資料 `admin_memo`
--

INSERT INTO `admin_memo` (`id`, `admin_id`, `title`, `content`, `priority`, `status`, `reminder_date`, `created_time`) VALUES
('MEMO1782014804495', 'ADMIN001', '有問題', NULL, '緊急', '代辦', '2009-11-11', '2026-06-21 04:06:44');

-- --------------------------------------------------------

--
-- 資料表結構 `announcement`
--

CREATE TABLE `announcement` (
  `announce_id` varchar(50) NOT NULL,
  `type` enum('Apply','Result') NOT NULL DEFAULT 'Apply',
  `admin_id` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` text DEFAULT NULL,
  `publish_date` timestamp NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `announcement`
--

INSERT INTO `announcement` (`announce_id`, `type`, `admin_id`, `title`, `content`, `publish_date`, `created_at`) VALUES
('ANN001', 'Apply', 'ADMIN001', '', NULL, '2026-01-07 02:09:39', '2026-01-05 12:02:04'),
('ANN1767751997691', 'Apply', 'ADMIN001', 'good 獎學金現在正發放中', '只要是優良好學生就可以申請', '2026-01-07 02:13:17', '2026-01-07 02:13:17'),
('ANN1767835675098', 'Apply', 'ADMIN001', 'nice 獎學金現正發送中', 'nice', '2026-01-08 01:27:55', '2026-01-08 01:27:55'),
('ANN1767920272594', 'Apply', 'ADMIN001', 'hello', '1234567yu8iouiuytyrewrjk', '2026-01-09 00:57:52', '2026-01-09 00:57:52'),
('ANN1767938849110', 'Apply', 'ADMIN001', '我在2026/01/09下午2.公告喔!!', 'abdwhbqodbwobwqobdwoqbd', '2026-01-09 06:07:29', '2026-01-09 06:07:29'),
('ANN1768208040508', 'Apply', 'ADMIN001', 'best獎學金現正發送', 'best 講學金20000', '2026-01-12 08:54:00', '2026-01-12 08:54:00'),
('ANN1782046825082', 'Apply', 'ADMIN002', 'test1', 'test1', '2026-06-21 13:00:25', '2026-06-21 13:00:25');

-- --------------------------------------------------------

--
-- 資料表結構 `application`
--

CREATE TABLE `application` (
  `id` varchar(50) NOT NULL,
  `student_id` varchar(50) NOT NULL,
  `scholarship_name` varchar(100) NOT NULL,
  `apply_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `apply_way` varchar(50) DEFAULT NULL,
  `apply_state` enum('Pending','Approved','Rejected','Under Review') NOT NULL DEFAULT 'Pending',
  `rank` int(11) DEFAULT NULL,
  `score` decimal(5,2) DEFAULT NULL,
  `family_income` decimal(12,2) DEFAULT NULL,
  `gpa` decimal(3,2) DEFAULT NULL,
  `recommendation_id` varchar(50) DEFAULT NULL,
  `requires_recommendation` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否需要導師推薦',
  `reject_reason` text DEFAULT NULL COMMENT '退件原因',
  `result_notified` tinyint(1) NOT NULL DEFAULT 0 COMMENT '截止結果是否已寄通知'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `application`
--

INSERT INTO `application` (`id`, `student_id`, `scholarship_name`, `apply_date`, `apply_way`, `apply_state`, `rank`, `score`, `family_income`, `gpa`, `recommendation_id`, `requires_recommendation`, `reject_reason`, `result_notified`) VALUES
('', 'S001', 'good', '2026-01-07 03:02:52', NULL, '', NULL, 85.50, NULL, 3.80, NULL, 0, NULL, 0),
('APP001', 'S001', '優秀學生獎學金', '2026-01-05 12:02:04', '線上申請', 'Rejected', NULL, 85.50, NULL, 3.80, 'REC001', 0, NULL, 0),
('APP1767755222667', 'S001', 'good', '2026-01-07 03:07:02', NULL, 'Rejected', NULL, 85.00, NULL, 3.50, NULL, 0, NULL, 0),
('APP1767755353734', 'S001', '優秀學生獎學金', '2026-01-07 03:09:13', NULL, 'Approved', NULL, 90.00, NULL, 4.00, 'REC1767938102', 0, NULL, 0),
('APP1767757399832', 'S001', 'good', '2026-01-07 03:43:19', NULL, 'Approved', NULL, 91.00, NULL, 3.60, NULL, 0, NULL, 0),
('APP1767835906983', 'S001', 'nice', '2026-01-08 01:31:46', NULL, 'Approved', NULL, 98.00, NULL, 4.00, NULL, 0, NULL, 0),
('APP1767838012308', 'S001', 'good', '2026-01-08 02:06:52', NULL, 'Approved', NULL, 85.50, NULL, 3.80, 'REC1767838097', 0, NULL, 0),
('APP1767843074110', 'S001', 'good', '2026-01-08 03:31:14', NULL, 'Rejected', NULL, 50.00, NULL, 3.80, NULL, 0, NULL, 0),
('APP1767861628217', 'S001', 'balance', '2026-01-08 08:40:28', NULL, 'Approved', NULL, 90.00, NULL, 4.00, NULL, 0, NULL, 0),
('APP1767874113721', 'S003', 'nice', '2026-01-08 12:08:33', NULL, 'Approved', NULL, 90.00, NULL, 4.00, 'REC1767874635', 0, NULL, 0),
('APP1767919875701', 'S001', 'balance', '2026-01-09 00:51:15', NULL, 'Approved', NULL, 100.00, NULL, 4.00, 'REC1767919922', 0, NULL, 0),
('APP1767940155316', 'S001', 'good', '2026-01-09 06:29:15', NULL, 'Approved', NULL, 89.00, NULL, 3.50, 'REC1767940384', 0, NULL, 0),
('APP1767959388786', 'S001', 'aboriginal', '2026-01-09 11:49:48', NULL, 'Pending', NULL, 60.00, NULL, 4.00, 'REC1780559602', 0, NULL, 0),
('APP1768125216606', 'S003', 'good', '2026-01-11 09:53:36', NULL, 'Pending', NULL, 90.00, NULL, 4.00, NULL, 0, NULL, 0),
('APP1768196346020', 'S004', 'good', '2026-01-12 05:39:06', NULL, 'Approved', NULL, 70.00, NULL, 4.00, 'REC1768196401', 0, NULL, 0),
('APP1768207774630', 'S001', 'good', '2026-01-12 08:49:34', NULL, 'Approved', NULL, 95.00, NULL, 4.00, 'REC1768207820', 0, NULL, 0),
('APP1780557290704', 'S001', 'aboriginal', '2026-06-04 07:14:50', NULL, 'Pending', NULL, 90.00, NULL, 4.00, NULL, 0, NULL, 0),
('APP1782044953137', 'S002', 'good', '2026-06-21 12:29:13', NULL, '', NULL, 90.00, NULL, 4.00, NULL, 1, NULL, 0);

-- --------------------------------------------------------

--
-- 資料表結構 `apply_announcement`
--

CREATE TABLE `apply_announcement` (
  `announce_id` varchar(50) NOT NULL,
  `apply_date` date NOT NULL,
  `apply_deadline` date NOT NULL,
  `apply_condition` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `apply_announcement`
--

INSERT INTO `apply_announcement` (`announce_id`, `apply_date`, `apply_deadline`, `apply_condition`) VALUES
('ANN001', '2026-01-01', '2026-01-31', '1. GPA >= 3.5\n2. 無記過紀錄');

-- --------------------------------------------------------

--
-- 資料表結構 `disabled_student`
--

CREATE TABLE `disabled_student` (
  `id` varchar(50) NOT NULL,
  `disabled_certify` varchar(100) DEFAULT NULL,
  `disabled_level` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `identity_proof`
--

CREATE TABLE `identity_proof` (
  `id` varchar(50) NOT NULL,
  `student_id` varchar(50) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_size` int(11) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `file_category` varchar(50) NOT NULL DEFAULT 'identity_proof' COMMENT '檔案類別：identity_proof(身份證明) / transcript(成績單) / award_certificate(參賽得獎)',
  `file_mime` varchar(100) DEFAULT NULL COMMENT '檔案 MIME 類型，例：image/jpeg、application/pdf'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `identity_proof`
--

INSERT INTO `identity_proof` (`id`, `student_id`, `file_path`, `file_name`, `file_size`, `uploaded_at`, `file_category`, `file_mime`) VALUES
('PROOF1780557492895', 'S001', '/scholarship/uploads/identity-proofs/PROOF1780557492895.pdf', '近年商標經典案例摘要（中文版）.pdf', 727128, '2026-06-04 07:18:12', 'identity_proof', NULL),
('PROOF1782044972139', 'S002', '/scholarship/uploads/identity-proofs/PROOF1782044972139.png', '螢幕擷取畫面 2026-02-21 230538.png', 443343, '2026-06-21 12:29:32', 'identity_proof', 'image/png');

-- --------------------------------------------------------

--
-- 資料表結構 `low_income_student`
--

CREATE TABLE `low_income_student` (
  `id` varchar(50) NOT NULL,
  `low_income_certify` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `message`
--

CREATE TABLE `message` (
  `id` varchar(50) NOT NULL,
  `user_id` varchar(50) NOT NULL COMMENT '發起留言者ID',
  `title` varchar(255) NOT NULL COMMENT '標題',
  `content` text NOT NULL COMMENT '留言內容',
  `visibility` varchar(10) NOT NULL DEFAULT 'Public' COMMENT '可見度: Public 或 Private',
  `target_user_id` varchar(50) DEFAULT NULL COMMENT '指定查看者ID（visibility=Private 時使用）',
  `reply_content` text DEFAULT NULL COMMENT '回覆內容',
  `reply_user_id` varchar(50) DEFAULT NULL COMMENT '回覆者ID',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '留言建立時間',
  `replied_at` timestamp NULL DEFAULT NULL COMMENT '回覆時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='師生留言板';

--
-- 傾印資料表的資料 `message`
--

INSERT INTO `message` (`id`, `user_id`, `title`, `content`, `visibility`, `target_user_id`, `reply_content`, `reply_user_id`, `created_at`, `replied_at`) VALUES
('MSG1782046033769', 'S002', 'e', 'e', 'Public', NULL, NULL, NULL, '2026-06-21 12:47:13', NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `normal_student`
--

CREATE TABLE `normal_student` (
  `id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `normal_student`
--

INSERT INTO `normal_student` (`id`) VALUES
('S001');

-- --------------------------------------------------------

--
-- 資料表結構 `notification`
--

CREATE TABLE `notification` (
  `id` int(11) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `target_url` varchar(255) NOT NULL DEFAULT '',
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `notification`
--

INSERT INTO `notification` (`id`, `user_id`, `title`, `content`, `target_url`, `is_read`, `created_at`) VALUES
(1, 'S001', '📢 新獎學金開放申請：new_test2', '符合資格的同學請盡快至系統申請', '/scholarship/pages/student_dashboard.html', 0, '2026-06-21 13:03:07'),
(2, 'S002', '📢 新獎學金開放申請：new_test2', '符合資格的同學請盡快至系統申請', '/scholarship/pages/student_dashboard.html', 1, '2026-06-21 13:03:07'),
(3, 'S003', '📢 新獎學金開放申請：new_test2', '符合資格的同學請盡快至系統申請', '/scholarship/pages/student_dashboard.html', 0, '2026-06-21 13:03:07'),
(4, 'S004', '📢 新獎學金開放申請：new_test2', '符合資格的同學請盡快至系統申請', '/scholarship/pages/student_dashboard.html', 0, '2026-06-21 13:03:07');

-- --------------------------------------------------------

--
-- 資料表結構 `organization`
--

CREATE TABLE `organization` (
  `id` varchar(50) NOT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `receiving_way` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `organization`
--

INSERT INTO `organization` (`id`, `contact_person`, `receiving_way`) VALUES
('ORG001', '陳經理', '銀行轉帳');

-- --------------------------------------------------------

--
-- 資料表結構 `overseas_student`
--

CREATE TABLE `overseas_student` (
  `id` varchar(50) NOT NULL,
  `overseas_id` varchar(50) DEFAULT NULL,
  `chinese_certify` varchar(100) DEFAULT NULL,
  `immigrate_date` date DEFAULT NULL,
  `passport_number` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `overseas_student`
--

INSERT INTO `overseas_student` (`id`, `overseas_id`, `chinese_certify`, `immigrate_date`, `passport_number`) VALUES
('S001', 'a111', 'good', '2000-11-11', 'a22323');

-- --------------------------------------------------------

--
-- 資料表結構 `pass_result`
--

CREATE TABLE `pass_result` (
  `organization_id` varchar(50) NOT NULL,
  `application_id` varchar(50) NOT NULL,
  `result` enum('Pass','Fail','Waiting') NOT NULL,
  `result_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `recommendation`
--

CREATE TABLE `recommendation` (
  `id` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `update_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `teacher_id` varchar(50) NOT NULL,
  `file_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `recommendation`
--

INSERT INTO `recommendation` (`id`, `content`, `update_date`, `teacher_id`, `file_path`) VALUES
('REC001', '該生品學兼優，值得推薦。', '2026-01-05 12:02:04', 'T001', NULL),
('REC1767838097', 'good', '2026-01-08 02:08:17', 'T001', NULL),
('REC1767874635', '恭喜發財', '2026-01-08 12:17:15', 'T001', NULL),
('REC1767919922', 'hello', '2026-01-09 00:52:02', 'T001', NULL),
('REC1767938102', '2026/01/09發給你喔!!!', '2026-01-09 05:55:02', 'T001', NULL),
('REC1767940384', '你表現得很好雖然差我一點', '2026-01-09 06:33:04', 'T001', NULL),
('REC1767959466', '普通', '2026-01-09 11:51:06', 'T001', NULL),
('REC1768196401', 'good', '2026-01-12 05:40:01', 'T001', NULL),
('REC1768207820', 'good', '2026-01-12 08:50:20', 'T001', NULL),
('REC1780559602', '普通', '2026-06-04 07:53:22', 'T001', NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `result_announcement`
--

CREATE TABLE `result_announcement` (
  `announce_id` varchar(50) NOT NULL,
  `result` text DEFAULT NULL,
  `announce_date` date NOT NULL,
  `remark` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `scholarship`
--

CREATE TABLE `scholarship` (
  `name` varchar(100) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_published` tinyint(1) DEFAULT 0 COMMENT '是否已發放',
  `published_by` varchar(50) DEFAULT NULL COMMENT '發放機構ID',
  `published_at` timestamp NULL DEFAULT NULL COMMENT '發放時間',
  `identity_restriction` varchar(20) DEFAULT NULL COMMENT '身份限制',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `required_documents` varchar(255) DEFAULT NULL COMMENT '申請必備檔案類別，逗號分隔'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `scholarship`
--

INSERT INTO `scholarship` (`name`, `amount`, `description`, `created_at`, `is_published`, `published_by`, `published_at`, `identity_restriction`, `start_date`, `end_date`, `required_documents`) VALUES
('aboriginal', 25000.00, 'Test update', '2026-01-08 08:38:26', 1, 'ADMIN001', '2026-01-08 08:38:32', NULL, '2026-01-15', '2026-02-28', NULL),
('abroad', 2000.00, '僑生', '2026-01-08 08:37:00', 1, 'ADMIN001', '2026-01-08 08:38:30', '僑生', NULL, NULL, NULL),
('balance', 1000.00, '無', '2026-01-08 08:10:54', 1, 'ADMIN001', '2026-01-08 08:10:58', '清寒', NULL, NULL, NULL),
('best', 20000.00, '清寒', '2026-01-12 08:52:41', 1, 'ADMIN001', '2026-01-12 08:52:55', '清寒', '2026-01-12', '2026-01-13', NULL),
('difficult', 1000.00, '身心障礙', '2026-01-08 08:37:43', 1, 'ADMIN001', '2026-01-08 08:38:34', '身心障礙', NULL, NULL, NULL),
('good', 12000.00, '', '2026-01-06 15:33:13', 1, 'ADMIN001', '2026-01-09 00:54:48', NULL, '2026-01-09', '2026-01-10', NULL),
('greatest', 1000.00, '快閃獎學金', '2026-01-09 02:05:55', 1, 'ADMIN001', '2026-01-09 02:09:27', NULL, NULL, NULL, NULL),
('new_test2', 1000.00, '', '2026-06-21 13:03:01', 1, 'ADMIN002', '2026-06-21 13:03:07', NULL, '2026-06-21', '2026-06-22', NULL),
('nice', 20000.00, '', '2026-01-06 15:44:33', 1, 'ADMIN001', '2026-01-08 01:27:24', NULL, NULL, NULL, NULL),
('normal', 1500.00, 'normal', '2026-01-08 08:42:45', 1, 'ADMIN001', '2026-01-08 08:43:08', NULL, NULL, NULL, NULL),
('testttsssssss', 99999999.99, 'helohleohleohleolol', '2026-01-09 00:59:08', 1, 'ADMIN001', '2026-01-09 00:59:16', '清寒', NULL, NULL, NULL),
('優秀學生獎學金', 10000.00, '獎勵學業成績優異學生', '2026-01-05 12:02:04', 0, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `scholarship_organization`
--

CREATE TABLE `scholarship_organization` (
  `scholarship_name` varchar(100) NOT NULL,
  `organization_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `scholarship_organization`
--

INSERT INTO `scholarship_organization` (`scholarship_name`, `organization_id`) VALUES
('best', 'ORG001'),
('good', 'ORG001'),
('優秀學生獎學金', 'ORG001');

-- --------------------------------------------------------

--
-- 資料表結構 `student`
--

CREATE TABLE `student` (
  `id` varchar(50) NOT NULL,
  `identity` varchar(50) NOT NULL,
  `major` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `student`
--

INSERT INTO `student` (`id`, `identity`, `major`) VALUES
('S001', '低收入戶', '資訊管理學系'),
('S002', '', NULL),
('S003', '', NULL),
('S004', '', NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `system_administrator`
--

CREATE TABLE `system_administrator` (
  `id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `system_administrator`
--

INSERT INTO `system_administrator` (`id`) VALUES
('ADMIN001'),
('ADMIN002');

-- --------------------------------------------------------

--
-- 資料表結構 `teacher`
--

CREATE TABLE `teacher` (
  `id` varchar(50) NOT NULL,
  `faculty` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `teacher`
--

INSERT INTO `teacher` (`id`, `faculty`) VALUES
('T001', '資訊工程學系');

-- --------------------------------------------------------

--
-- 資料表結構 `user`
--

CREATE TABLE `user` (
  `id` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `type` enum('Student','Teacher','Organization','SystemAdministrator') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `department` varchar(100) DEFAULT NULL COMMENT '所屬科系（Student/Teacher 必填）',
  `password` varchar(255) DEFAULT NULL COMMENT 'bcrypt 加鹽雜湊密碼',
  `email_verified` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Email 驗證狀態',
  `verification_code` varchar(6) DEFAULT NULL COMMENT '6位數 Email OTP 驗證碼'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `type`, `created_at`, `updated_at`, `department`, `password`, `email_verified`, `verification_code`) VALUES
('ADMIN001', '管理員一', 'admin1@example.com', 'SystemAdministrator', '2026-01-05 12:02:04', '2026-06-21 09:12:06', NULL, NULL, 1, NULL),
('ADMIN002', '模擬管理員', 'mockadmin@nuk.edu.tw', 'SystemAdministrator', '2026-06-21 10:53:29', '2026-06-21 12:12:34', NULL, '$2y$10$8TUpROT2oLa15cSvBxyzruA9gt79NfHQ7mpYvlGGJLzRRYKtd6iQu', 1, NULL),
('ORG001', 'XX基金會', 'contact@xxfoundation.org', 'Organization', '2026-01-05 12:02:04', '2026-06-21 09:12:06', NULL, NULL, 1, NULL),
('S001', '王小明', '123456@example.com', 'Student', '2026-01-05 12:02:04', '2026-06-21 09:12:06', NULL, NULL, 1, NULL),
('S002', '陳阿明', 'sans73978@gmail.com', 'Student', '2026-06-21 10:57:52', '2026-06-21 10:57:52', '資訊工程學系', '$2y$10$dJDB5aTDeddkn//nCvKWkeb4hubNDx55URrPY9RAOu7CHF72hUP2u', 0, '822448'),
('S003', '劉德華', 'student2@example.com', 'Student', '2026-01-08 10:37:49', '2026-06-21 09:12:06', NULL, NULL, 1, NULL),
('S004', '洗得', 'student4@example.com', 'Student', '2026-01-12 05:38:46', '2026-06-21 09:12:06', NULL, NULL, 1, NULL),
('T001', '張教授', 'prof.chang@example.com', 'Teacher', '2026-01-05 12:02:04', '2026-06-21 09:12:06', NULL, NULL, 1, NULL),
('T002', '尤教授', 'coolercat1769@gmail.com', 'Teacher', '2026-06-21 10:58:48', '2026-06-21 11:10:25', '資訊工程學系', '$2y$10$Wz7o1e8fQrW.6KG5/bQ86urkzAXlhjJuGg78yu35XyghbfWiqCIFa', 0, '822127');

-- --------------------------------------------------------

--
-- 資料表結構 `user_phone`
--

CREATE TABLE `user_phone` (
  `user_id` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `user_phone`
--

INSERT INTO `user_phone` (`user_id`, `phone`) VALUES
('S001', '02-1234-5621'),
('T001', '0923-456-789');

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `v_application_detail`
-- (請參考以下實際畫面)
--
CREATE TABLE `v_application_detail` (
`application_id` varchar(50)
,`apply_date` timestamp
,`student_name` varchar(100)
,`major` varchar(100)
,`scholarship_name` varchar(100)
,`amount` decimal(10,2)
,`apply_state` enum('Pending','Approved','Rejected','Under Review')
,`score` decimal(5,2)
,`gpa` decimal(3,2)
,`recommendation_content` text
,`teacher_name` varchar(100)
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `v_scholarship_organization`
-- (請參考以下實際畫面)
--
CREATE TABLE `v_scholarship_organization` (
`scholarship_name` varchar(100)
,`amount` decimal(10,2)
,`organization_name` varchar(100)
,`contact_person` varchar(100)
,`organization_email` varchar(100)
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `v_student_info`
-- (請參考以下實際畫面)
--
CREATE TABLE `v_student_info` (
`id` varchar(50)
,`name` varchar(100)
,`email` varchar(100)
,`identity` varchar(50)
,`major` varchar(100)
,`phones` mediumtext
);

-- --------------------------------------------------------

--
-- 檢視表結構 `v_application_detail`
--
DROP TABLE IF EXISTS `v_application_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_application_detail`  AS SELECT `a`.`id` AS `application_id`, `a`.`apply_date` AS `apply_date`, `u`.`name` AS `student_name`, `st`.`major` AS `major`, `sch`.`name` AS `scholarship_name`, `sch`.`amount` AS `amount`, `a`.`apply_state` AS `apply_state`, `a`.`score` AS `score`, `a`.`gpa` AS `gpa`, `r`.`content` AS `recommendation_content`, `t`.`name` AS `teacher_name` FROM ((((((`application` `a` join `student` `st` on(`a`.`student_id` = `st`.`id`)) join `user` `u` on(`st`.`id` = `u`.`id`)) join `scholarship` `sch` on(`a`.`scholarship_name` = `sch`.`name`)) left join `recommendation` `r` on(`a`.`recommendation_id` = `r`.`id`)) left join `teacher` `te` on(`r`.`teacher_id` = `te`.`id`)) left join `user` `t` on(`te`.`id` = `t`.`id`)) ;

-- --------------------------------------------------------

--
-- 檢視表結構 `v_scholarship_organization`
--
DROP TABLE IF EXISTS `v_scholarship_organization`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_scholarship_organization`  AS SELECT `sch`.`name` AS `scholarship_name`, `sch`.`amount` AS `amount`, `u`.`name` AS `organization_name`, `o`.`contact_person` AS `contact_person`, `u`.`email` AS `organization_email` FROM (((`scholarship` `sch` join `scholarship_organization` `so` on(`sch`.`name` = `so`.`scholarship_name`)) join `organization` `o` on(`so`.`organization_id` = `o`.`id`)) join `user` `u` on(`o`.`id` = `u`.`id`)) ;

-- --------------------------------------------------------

--
-- 檢視表結構 `v_student_info`
--
DROP TABLE IF EXISTS `v_student_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_student_info`  AS SELECT `u`.`id` AS `id`, `u`.`name` AS `name`, `u`.`email` AS `email`, `s`.`identity` AS `identity`, `s`.`major` AS `major`, group_concat(`up`.`phone` separator ', ') AS `phones` FROM ((`user` `u` join `student` `s` on(`u`.`id` = `s`.`id`)) left join `user_phone` `up` on(`u`.`id` = `up`.`user_id`)) GROUP BY `u`.`id`, `u`.`name`, `u`.`email`, `s`.`identity`, `s`.`major` ;

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `aboriginal_student`
--
ALTER TABLE `aboriginal_student`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `admin_memo`
--
ALTER TABLE `admin_memo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_admin_memo_admin` (`admin_id`);

--
-- 資料表索引 `announcement`
--
ALTER TABLE `announcement`
  ADD PRIMARY KEY (`announce_id`),
  ADD KEY `idx_announcement_type` (`type`),
  ADD KEY `idx_announcement_admin` (`admin_id`);

--
-- 資料表索引 `application`
--
ALTER TABLE `application`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recommendation_id` (`recommendation_id`),
  ADD KEY `idx_application_student` (`student_id`),
  ADD KEY `idx_application_scholarship` (`scholarship_name`),
  ADD KEY `idx_application_state` (`apply_state`);

--
-- 資料表索引 `apply_announcement`
--
ALTER TABLE `apply_announcement`
  ADD PRIMARY KEY (`announce_id`);

--
-- 資料表索引 `disabled_student`
--
ALTER TABLE `disabled_student`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `identity_proof`
--
ALTER TABLE `identity_proof`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- 資料表索引 `low_income_student`
--
ALTER TABLE `low_income_student`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_message_user` (`user_id`),
  ADD KEY `fk_message_target` (`target_user_id`),
  ADD KEY `fk_message_reply_user` (`reply_user_id`);

--
-- 資料表索引 `normal_student`
--
ALTER TABLE `normal_student`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_read` (`user_id`,`is_read`);

--
-- 資料表索引 `organization`
--
ALTER TABLE `organization`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `overseas_student`
--
ALTER TABLE `overseas_student`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `pass_result`
--
ALTER TABLE `pass_result`
  ADD PRIMARY KEY (`organization_id`,`application_id`),
  ADD KEY `application_id` (`application_id`);

--
-- 資料表索引 `recommendation`
--
ALTER TABLE `recommendation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_recommendation_teacher` (`teacher_id`);

--
-- 資料表索引 `result_announcement`
--
ALTER TABLE `result_announcement`
  ADD PRIMARY KEY (`announce_id`);

--
-- 資料表索引 `scholarship`
--
ALTER TABLE `scholarship`
  ADD PRIMARY KEY (`name`);

--
-- 資料表索引 `scholarship_organization`
--
ALTER TABLE `scholarship_organization`
  ADD PRIMARY KEY (`scholarship_name`,`organization_id`),
  ADD KEY `organization_id` (`organization_id`);

--
-- 資料表索引 `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_student_major` (`major`);

--
-- 資料表索引 `system_administrator`
--
ALTER TABLE `system_administrator`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_email` (`email`),
  ADD KEY `idx_user_type` (`type`);

--
-- 資料表索引 `user_phone`
--
ALTER TABLE `user_phone`
  ADD PRIMARY KEY (`user_id`,`phone`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `notification`
--
ALTER TABLE `notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 已傾印資料表的限制式
--

--
-- 資料表的限制式 `aboriginal_student`
--
ALTER TABLE `aboriginal_student`
  ADD CONSTRAINT `aboriginal_student_ibfk_1` FOREIGN KEY (`id`) REFERENCES `student` (`id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `admin_memo`
--
ALTER TABLE `admin_memo`
  ADD CONSTRAINT `fk_admin_memo_admin` FOREIGN KEY (`admin_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `announcement`
--
ALTER TABLE `announcement`
  ADD CONSTRAINT `announcement_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `system_administrator` (`id`);

--
-- 資料表的限制式 `application`
--
ALTER TABLE `application`
  ADD CONSTRAINT `application_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`),
  ADD CONSTRAINT `application_ibfk_2` FOREIGN KEY (`scholarship_name`) REFERENCES `scholarship` (`name`),
  ADD CONSTRAINT `application_ibfk_3` FOREIGN KEY (`recommendation_id`) REFERENCES `recommendation` (`id`);

--
-- 資料表的限制式 `apply_announcement`
--
ALTER TABLE `apply_announcement`
  ADD CONSTRAINT `apply_announcement_ibfk_1` FOREIGN KEY (`announce_id`) REFERENCES `announcement` (`announce_id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `disabled_student`
--
ALTER TABLE `disabled_student`
  ADD CONSTRAINT `disabled_student_ibfk_1` FOREIGN KEY (`id`) REFERENCES `student` (`id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `identity_proof`
--
ALTER TABLE `identity_proof`
  ADD CONSTRAINT `identity_proof_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `low_income_student`
--
ALTER TABLE `low_income_student`
  ADD CONSTRAINT `low_income_student_ibfk_1` FOREIGN KEY (`id`) REFERENCES `student` (`id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `fk_message_reply_user` FOREIGN KEY (`reply_user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_message_target` FOREIGN KEY (`target_user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_message_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `normal_student`
--
ALTER TABLE `normal_student`
  ADD CONSTRAINT `normal_student_ibfk_1` FOREIGN KEY (`id`) REFERENCES `student` (`id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `organization`
--
ALTER TABLE `organization`
  ADD CONSTRAINT `organization_ibfk_1` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `overseas_student`
--
ALTER TABLE `overseas_student`
  ADD CONSTRAINT `overseas_student_ibfk_1` FOREIGN KEY (`id`) REFERENCES `student` (`id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `pass_result`
--
ALTER TABLE `pass_result`
  ADD CONSTRAINT `pass_result_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`),
  ADD CONSTRAINT `pass_result_ibfk_2` FOREIGN KEY (`application_id`) REFERENCES `application` (`id`);

--
-- 資料表的限制式 `recommendation`
--
ALTER TABLE `recommendation`
  ADD CONSTRAINT `recommendation_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`);

--
-- 資料表的限制式 `result_announcement`
--
ALTER TABLE `result_announcement`
  ADD CONSTRAINT `result_announcement_ibfk_1` FOREIGN KEY (`announce_id`) REFERENCES `announcement` (`announce_id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `scholarship_organization`
--
ALTER TABLE `scholarship_organization`
  ADD CONSTRAINT `scholarship_organization_ibfk_1` FOREIGN KEY (`scholarship_name`) REFERENCES `scholarship` (`name`) ON DELETE CASCADE,
  ADD CONSTRAINT `scholarship_organization_ibfk_2` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `system_administrator`
--
ALTER TABLE `system_administrator`
  ADD CONSTRAINT `system_administrator_ibfk_1` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `teacher`
--
ALTER TABLE `teacher`
  ADD CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `user_phone`
--
ALTER TABLE `user_phone`
  ADD CONSTRAINT `user_phone_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;