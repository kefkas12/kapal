-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 28, 2026 at 03:02 PM
-- Server version: 8.0.45-0ubuntu0.24.04.1
-- PHP Version: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kapal`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `file_upload`
--

CREATE TABLE `file_upload` (
  `id` int NOT NULL,
  `id_kontrak` int DEFAULT NULL,
  `id_cable` int DEFAULT NULL,
  `id_klaim_awal` int DEFAULT NULL,
  `id_klaim_akhir` int DEFAULT NULL,
  `id_doc_cargo` int DEFAULT NULL,
  `id_off_hire` int DEFAULT NULL,
  `id_on_hire` int DEFAULT NULL,
  `id_redelivery` int DEFAULT NULL,
  `id_delivery` int DEFAULT NULL,
  `nama_file` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `file_upload`
--

INSERT INTO `file_upload` (`id`, `id_kontrak`, `id_cable`, `id_klaim_awal`, `id_klaim_akhir`, `id_doc_cargo`, `id_off_hire`, `id_on_hire`, `id_redelivery`, `id_delivery`, `nama_file`, `created_at`, `updated_at`) VALUES
(28, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/final osl.txt', '2026-04-11 14:53:31', '2026-04-11 14:53:31'),
(29, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/vessel_export_20260412.csv', '2026-04-11 23:41:14', '2026-04-11 23:41:14'),
(30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/cable_export_20260412.csv', '2026-04-11 23:41:14', '2026-04-11 23:41:14'),
(31, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/vessel_export_20260412.csv', '2026-04-11 23:42:27', '2026-04-11 23:42:27'),
(41, NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/PbeM9KY2ZQIHwi362x7RSRiwgsaXnpFLKLGnbUAk.pdf', '2026-04-14 08:45:27', '2026-04-14 08:45:27'),
(42, 23, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/ChatGPT Image Apr 12, 2026, 01_22_06 AM.png', '2026-04-14 10:29:22', '2026-04-14 10:29:22'),
(53, NULL, NULL, 46, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/AKSFOOD ID (1).pdf', '2026-04-14 21:54:33', '2026-04-14 21:54:33'),
(55, NULL, NULL, NULL, 46, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/DPP+Onsite+2026 (1).pdf', '2026-04-14 22:21:13', '2026-04-14 22:21:13'),
(57, 24, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB.pdf', '2026-04-20 18:35:54', '2026-04-20 18:35:54'),
(58, NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/Invoice Nasi Bakar Nony - up Ibu Tari.pdf', '2026-04-20 19:07:07', '2026-04-20 19:07:07'),
(69, 25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_1.pdf', '2026-04-26 02:06:31', '2026-04-26 02:06:31'),
(70, NULL, 19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB.pdf', '2026-04-26 02:26:07', '2026-04-26 02:26:07'),
(71, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB.pdf', '2026-04-26 02:41:03', '2026-04-26 02:41:03'),
(72, NULL, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_1.pdf', '2026-04-26 02:59:19', '2026-04-26 02:59:19'),
(73, NULL, NULL, 60, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB.pdf', '2026-04-26 03:01:18', '2026-04-26 03:01:18'),
(75, NULL, NULL, 59, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_1.pdf', '2026-04-26 03:25:36', '2026-04-26 03:25:36'),
(76, NULL, NULL, NULL, 59, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_2.pdf', '2026-04-26 03:34:01', '2026-04-26 03:34:01'),
(77, NULL, NULL, NULL, 60, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_3.pdf', '2026-04-26 03:35:14', '2026-04-26 03:35:14'),
(78, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, 'uploads/off_hire/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_1.pdf', '2026-04-26 03:47:54', '2026-04-26 03:47:54'),
(79, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, 'uploads/on_hire/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_1.pdf', '2026-04-26 03:47:54', '2026-04-26 03:47:54'),
(80, 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_2.pdf', '2026-04-26 04:10:59', '2026-04-26 04:10:59'),
(83, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, 'uploads/off_hire/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB.pdf', '2026-04-27 10:13:55', '2026-04-27 10:13:55'),
(84, NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, 'uploads/on_hire/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB.pdf', '2026-04-27 10:13:55', '2026-04-27 10:13:55'),
(85, 27, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_3.pdf', '2026-04-27 11:29:59', '2026-04-27 11:29:59'),
(86, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, 'uploads/redelivery/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB.pdf', '2026-04-27 12:03:51', '2026-04-27 12:03:51'),
(87, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'uploads/delivery/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB.pdf', '2026-04-27 12:03:51', '2026-04-27 12:03:51'),
(88, NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, 'uploads/off_hire/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_2.pdf', '2026-04-27 12:25:45', '2026-04-27 12:25:45'),
(89, NULL, NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, 'uploads/on_hire/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_2.pdf', '2026-04-27 12:25:45', '2026-04-27 12:25:45'),
(90, NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, 'uploads/off_hire/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_3.pdf', '2026-04-27 12:51:57', '2026-04-27 12:51:57'),
(91, NULL, NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, 'uploads/on_hire/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_3.pdf', '2026-04-27 12:51:57', '2026-04-27 12:51:57'),
(92, NULL, NULL, NULL, NULL, NULL, 7, NULL, NULL, NULL, 'uploads/off_hire/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_4.pdf', '2026-04-27 12:52:48', '2026-04-27 12:52:48'),
(93, NULL, NULL, NULL, NULL, NULL, NULL, 7, NULL, NULL, 'uploads/on_hire/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_4.pdf', '2026-04-27 12:52:48', '2026-04-27 12:52:48'),
(94, NULL, NULL, 70, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_4.pdf', '2026-04-28 07:38:34', '2026-04-28 07:38:34'),
(95, NULL, NULL, 68, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_5.pdf', '2026-04-28 07:39:13', '2026-04-28 07:39:13');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_03_21_114519_create_personal_access_tokens_table', 1),
(5, '2026_03_21_121228_create_oauth_auth_codes_table', 1),
(6, '2026_03_21_121229_create_oauth_access_tokens_table', 1),
(7, '2026_03_21_121230_create_oauth_refresh_tokens_table', 1),
(8, '2026_03_21_121231_create_oauth_clients_table', 1),
(9, '2026_03_21_121232_create_oauth_device_codes_table', 1),
(10, '2026_04_03_202048_create_permission_tables', 2);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(2, 'App\\Models\\User', 1),
(1, 'App\\Models\\User', 2),
(3, 'App\\Models\\User', 3),
(2, 'App\\Models\\User', 4);

-- --------------------------------------------------------

--
-- Table structure for table `m_grade`
--

CREATE TABLE `m_grade` (
  `id` int NOT NULL,
  `grade` varchar(100) DEFAULT NULL,
  `price_bbl` varchar(100) DEFAULT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `m_grade`
--

INSERT INTO `m_grade` (`id`, `grade`, `price_bbl`, `user_id`, `created_at`, `updated_at`) VALUES
(2, 'PERTALITE', '81.602', 3, '2026-04-11 23:36:44', '2026-04-14 11:17:01'),
(3, 'PERTAMAX', '120', 2, '2026-04-20 19:24:58', '2026-04-20 19:25:05');

-- --------------------------------------------------------

--
-- Table structure for table `m_kontrak`
--

CREATE TABLE `m_kontrak` (
  `id` int NOT NULL,
  `id_vessel` int NOT NULL,
  `no_surat_pemenang` varchar(100) DEFAULT NULL,
  `no_kontrak` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tgl_awal_kontrak` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tgl_akhir_kontrak` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `charter_rate` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `speed` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `me_ballast` varchar(100) DEFAULT NULL,
  `me_laden` varchar(100) DEFAULT NULL,
  `toleransi_transport_loss` varchar(100) DEFAULT NULL,
  `pumping_rate` varchar(100) DEFAULT NULL,
  `discharge` varchar(100) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `m_kontrak`
--

INSERT INTO `m_kontrak` (`id`, `id_vessel`, `no_surat_pemenang`, `no_kontrak`, `tgl_awal_kontrak`, `tgl_akhir_kontrak`, `charter_rate`, `speed`, `me_ballast`, `me_laden`, `toleransi_transport_loss`, `pumping_rate`, `discharge`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(16, 34, '004/TCP/1/2024', '004/TCP/1/2024', '2024-01-04 00:00:00', '2025-01-04 00:00:00', '55000', '4', '10.2', '1.8', NULL, '150', '0.02', 'NON ACTIVE', 2, '2026-04-03 09:02:34', '2026-04-26 04:10:59'),
(23, 36, '1', '050/TCP/VI/2025', '2025-06-27 00:00:00', '2027-06-27 00:00:00', '5200.00', '10', '5.52', '5.64', '0.06', '200', '2.28', 'NON ACTIVE', 3, '2026-04-14 10:29:22', '2026-04-27 11:29:59'),
(24, 34, '004/TCP/1/2026', '004/TCP/1/2026', '2026-01-04 00:00:00', '2027-01-04 00:00:00', '55000', '4', '10.2', '1.8', NULL, '150', '0.02', 'NON ACTIVE', 2, '2026-04-20 18:35:54', '2026-04-26 04:10:59'),
(25, 40, '1', '1', '2026-04-25 16:03:00', '2027-04-25 16:03:00', '10', '100', '10', '10', '0.07', '10', '10', 'ACTIVE', 3, '2026-04-26 02:06:31', '2026-04-26 02:06:31'),
(26, 34, '004/TCP/1/2026', '004/TCP/1/2027', '2028-01-01 00:08:00', '2029-01-01 00:08:00', '55000', '4', '10.2', '1.8', '0.07', '150', '0.02', 'ACTIVE', 2, '2026-04-26 04:10:59', '2026-04-26 04:10:59'),
(27, 36, '1', '321321', '2027-06-27 00:01:00', '2028-06-27 00:01:00', '5200.00', '10', '5.52', '5.64', '0.07', '200', '2.28', 'ACTIVE', 2, '2026-04-27 11:29:59', '2026-04-27 11:29:59');

-- --------------------------------------------------------

--
-- Table structure for table `m_vessel`
--

CREATE TABLE `m_vessel` (
  `id` int NOT NULL,
  `kode_vessel` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `nama_vessel` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `jenis_vessel` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `m_vessel`
--

INSERT INTO `m_vessel` (`id`, `kode_vessel`, `nama_vessel`, `jenis_vessel`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(34, 'AL2F8', 'ALBATROSS 2/FLAMINGO 8', 'SATGAS', 'ACTIVE', 3, '2026-04-03 06:40:40', '2026-04-12 00:17:11'),
(36, 'F19', 'FALCON 19', 'SMALL I', 'ACTIVE', 3, '2026-04-14 10:27:30', '2026-04-14 10:27:30'),
(40, 'F20', 'FALCON20', 'SATGAS', 'ACTIVE', 3, '2026-04-26 01:40:09', '2026-04-26 01:40:09');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` char(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` char(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect_uris` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `grant_types` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_device_codes`
--

CREATE TABLE `oauth_device_codes` (
  `id` char(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_code` char(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `user_approved_at` datetime DEFAULT NULL,
  `last_polled_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` char(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` char(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(62, 'App\\Models\\User', 1, 'api-token', '5774ee2c94ed2dd920e5950c97308e08a7591bbe178022d7fb4ebd461dd24af7', '[\"*\"]', '2026-04-26 02:51:27', NULL, '2026-04-26 02:28:00', '2026-04-26 02:51:27'),
(64, 'App\\Models\\User', 3, 'api-token', '54774e7f04aed2ac0f93ea4be60bf29e2717106ac3e2b1390272695c612595e6', '[\"*\"]', '2026-04-27 09:52:26', NULL, '2026-04-27 09:04:07', '2026-04-27 09:52:26'),
(68, 'App\\Models\\User', 2, 'api-token', '9fad20212e84fa1d1861cce38bef7149f85c3f291fa8462401e2788e0f7d13ed', '[\"*\"]', '2026-04-28 07:55:10', NULL, '2026-04-28 07:10:40', '2026-04-28 07:55:10');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'approval', 'web', '2026-04-11 13:19:54', '2026-04-11 13:19:54'),
(2, 'admin', 'web', '2026-04-11 13:19:54', '2026-04-11 13:19:54'),
(3, 'superadmin', 'web', '2026-04-11 13:19:54', '2026-04-11 13:19:54');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('AXBO8lAjGXEbIny1E6IPIZGras4ywXnZAQHKI4sS', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJvZWxxRktRMU9ScUlDUXRsbDdSM2VFM1JTMW5Sc2YwSmV2NGllTmZqIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1774379012),
('B3CpnxukvbVK2Qwe3J5QG7PKB3TZfHmIQuaJbN39', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJESW1iS2Z6OUtsRWxqQXRBZ0RsUUIxWk9YOEljSnN4MjlKS0dPVXdVIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1775232104);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int NOT NULL,
  `nama` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `value` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `nama`, `value`, `status`, `created_at`, `updated_at`) VALUES
(1, 'variable est_claim_bunker', '0.847', 'ACTIVE', NULL, NULL),
(2, 'variable est_claim_transport', '-0.07', 'ACTIVE', NULL, NULL),
(3, 'variable toleransi_transport_loss', '0.07', 'ACTIVE', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `t_doc_cargo`
--

CREATE TABLE `t_doc_cargo` (
  `id` int NOT NULL,
  `id_cable` int NOT NULL,
  `id_grade` int NOT NULL,
  `no_voyage_gab` varchar(100) DEFAULT NULL,
  `grade` varchar(100) DEFAULT NULL,
  `price_bbl` varchar(100) DEFAULT NULL,
  `bill_of_lading` varchar(100) DEFAULT NULL,
  `r1` varchar(100) DEFAULT NULL,
  `ratio_r1` varchar(100) DEFAULT NULL,
  `r2` varchar(100) DEFAULT NULL,
  `ratio_r2` varchar(100) DEFAULT NULL,
  `r3` varchar(100) DEFAULT NULL,
  `ratio_r3` varchar(100) DEFAULT NULL,
  `r4` varchar(100) DEFAULT NULL,
  `ratio_r4` varchar(100) DEFAULT NULL,
  `act_receipt` varchar(100) DEFAULT NULL,
  `est_discharge` varchar(100) DEFAULT NULL,
  `act_discharge` varchar(100) DEFAULT NULL,
  `overdue_discharge` varchar(100) DEFAULT NULL,
  `est_claim_pumping` varchar(100) DEFAULT NULL,
  `est_claim_bunker` varchar(100) DEFAULT NULL,
  `est_claim_transport` varchar(100) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `t_doc_cargo`
--

INSERT INTO `t_doc_cargo` (`id`, `id_cable`, `id_grade`, `no_voyage_gab`, `grade`, `price_bbl`, `bill_of_lading`, `r1`, `ratio_r1`, `r2`, `ratio_r2`, `r3`, `ratio_r3`, `r4`, `ratio_r4`, `act_receipt`, `est_discharge`, `act_discharge`, `overdue_discharge`, `est_claim_pumping`, `est_claim_bunker`, `est_claim_transport`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(4, 18, 2, 'AL2F8/26001/L', 'PERTALITE', '80605', '1000', '10', '10', '-20', '10', '10', '10', '-10', '-10', '1000', '0.277778', '3.000694', '2.722916', '4992.013073', '553.51441', '0', 'APPROVE', 2, '2026-04-26 02:41:03', '2026-04-26 02:52:33');

-- --------------------------------------------------------

--
-- Table structure for table `t_doc_cargo_detail`
--

CREATE TABLE `t_doc_cargo_detail` (
  `id` int NOT NULL,
  `id_doc_cargo` int NOT NULL,
  `no_voyage_gab` varchar(100) DEFAULT NULL,
  `no_urut` varchar(100) DEFAULT NULL,
  `start_time` varchar(100) DEFAULT NULL,
  `stop_time` varchar(100) DEFAULT NULL,
  `discharge_time` varchar(100) DEFAULT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `t_doc_cargo_detail`
--

INSERT INTO `t_doc_cargo_detail` (`id`, `id_doc_cargo`, `no_voyage_gab`, `no_urut`, `start_time`, `stop_time`, `discharge_time`, `user_id`, `created_at`, `updated_at`) VALUES
(24, 4, 'AL2F8/26001/L', '01', '2026-04-26 16:45:00', '2026-04-28 16:46:00', '2.000694', 1, '2026-04-26 02:49:09', '2026-04-26 02:49:09'),
(25, 4, 'AL2F8/26001/L', '02', '2026-04-28 16:46:00', '2026-04-29 16:46:00', '1', 1, '2026-04-26 02:49:09', '2026-04-26 02:49:09');

-- --------------------------------------------------------

--
-- Table structure for table `t_klaim`
--

CREATE TABLE `t_klaim` (
  `id` int NOT NULL,
  `id_vessel` int NOT NULL,
  `no_klaim_awal` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tgl_klaim_awal` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `jenis_klaim` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `no_klaim_akhir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tgl_klaim_akhir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_id` int NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `t_klaim`
--

INSERT INTO `t_klaim` (`id`, `id_vessel`, `no_klaim_awal`, `tgl_klaim_awal`, `jenis_klaim`, `no_klaim_akhir`, `tgl_klaim_akhir`, `user_id`, `status`, `created_at`, `updated_at`) VALUES
(61, 34, '10', '2026-04-28 03:10:00', 'OHBOH', 2, 'OPEN', '2026-04-27 13:11:05', '2026-04-27 13:11:05'),
(62, 34, '126', '2026-04-29 03:11:00', 'SSOB', 2, 'OPEN', '2026-04-27 13:11:30', '2026-04-27 13:11:30');

-- --------------------------------------------------------

--
-- Table structure for table `t_klaim_detail`
--

CREATE TABLE `t_klaim_detail` (
  `id` int NOT NULL,
  `id_klaim` int NOT NULL,
  `id_cable` int DEFAULT NULL,
  `id_off_hire` int DEFAULT NULL,
  `id_redelivery_delivery` int DEFAULT NULL,
  `no_urut` varchar(100) DEFAULT NULL,
  `no_voyage_gab` varchar(100) DEFAULT NULL,
  `no_kontrak` varchar(100) DEFAULT NULL,
  `keterangan` text,
  `status` varchar(20) NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `t_klaim_detail`
--

INSERT INTO `t_klaim_detail` (`id`, `id_klaim`, `id_cable`, `id_off_hire`, `id_redelivery_delivery`, `no_urut`, `no_voyage_gab`, `no_kontrak`, `keterangan`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(68, 61, NULL, 6, NULL, '01', '123', '004/TCP/1/2027', 'tes', 'OPEN', 2, '2026-04-27 13:11:06', '2026-04-28 07:48:02'),
(69, 61, NULL, 7, NULL, '02', '124', '004/TCP/1/2027', NULL, 'OPEN', 2, '2026-04-27 13:11:06', '2026-04-27 13:11:06'),
(70, 62, 18, '01', 'AL2F8/26001/L', '004/TCP/1/2027', NULL, 'OPEN', 2, '2026-04-27 13:11:30', '2026-04-27 13:11:30');

-- --------------------------------------------------------

--
-- Table structure for table `t_klaim_detail_nilai`
--

CREATE TABLE `t_klaim_detail_nilai` (
  `id` int NOT NULL,
  `id_klaim_detail` int NOT NULL,
  `sub_jenis` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `currency` varchar(100) DEFAULT NULL,
  `kurs` varchar(100) DEFAULT NULL,
  `val_potensi` varchar(100) DEFAULT NULL,
  `val_klaim_awal` varchar(100) DEFAULT NULL,
  `val_klaim_akhir` varchar(100) DEFAULT NULL,
  `val_klaim_akhir_idr` varchar(100) DEFAULT NULL,
  `no_tagihan_klaim` varchar(100) DEFAULT NULL,
  `no_tagihan_dipotong` varchar(100) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `t_klaim_detail_nilai`
--

INSERT INTO `t_klaim_detail_nilai` (`id`, `id_klaim_detail`, `sub_jenis`, `currency`, `kurs`, `val_potensi`, `val_klaim_awal`, `val_klaim_akhir`, `val_klaim_akhir_idr`, `no_tagihan_klaim`, `no_tagihan_dipotong`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(54, 68, 'OH', 'USD', '16900', '110000', '120000', '', '', 'OPEN', 2, '2026-04-27 13:11:06', '2026-04-28 07:47:53'),
(55, 68, 'BOH', 'IDR', '1', '208362', '250000', '', '', 'OPEN', 2, '2026-04-27 13:11:06', '2026-04-28 07:47:53'),
(56, 69, 'OH', 'USD', NULL, '110000', NULL, '', '', 'OPEN', 2, '2026-04-27 13:11:06', '2026-04-27 13:11:06'),
(57, 69, 'BOH', 'IDR', '1', '105028', NULL, '', '', 'OPEN', 2, '2026-04-27 13:11:06', '2026-04-27 13:11:06'),
(58, 70, 'SS', 'USD', NULL, '10980.902165', NULL, '', '', 'OPEN', 2, '2026-04-27 13:11:30', '2026-04-27 13:11:30'),
(59, 70, 'OB', 'IDR', '1', '-113836.8', NULL, '', '', 'OPEN', 2, '2026-04-27 13:11:30', '2026-04-27 13:11:30');

-- --------------------------------------------------------

--
-- Table structure for table `t_master_cable`
--

CREATE TABLE `t_master_cable` (
  `id` int NOT NULL,
  `id_vessel` int NOT NULL,
  `no_voyage_gab` varchar(100) NOT NULL,
  `no_voyage` varchar(10) NOT NULL,
  `jenis_voyage` varchar(30) NOT NULL,
  `master` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `atd_port` varchar(100) DEFAULT NULL,
  `atd_time` varchar(100) DEFAULT NULL,
  `atd_rob` varchar(100) DEFAULT NULL,
  `ata_port` varchar(100) DEFAULT NULL,
  `ata_time` varchar(100) DEFAULT NULL,
  `ata_rob` varchar(100) DEFAULT NULL,
  `distance` varchar(100) DEFAULT NULL,
  `speed` varchar(100) DEFAULT NULL,
  `est_sail_day` varchar(100) DEFAULT NULL,
  `act_sail_day` varchar(100) DEFAULT NULL,
  `charter_rate_day` varchar(100) DEFAULT NULL,
  `est_claim_speed` varchar(100) DEFAULT NULL,
  `std_bunker_cons` varchar(100) DEFAULT NULL,
  `act_bunker_cons` varchar(100) DEFAULT NULL,
  `excess_bunker` varchar(100) DEFAULT NULL,
  `bunker_price` varchar(100) DEFAULT NULL,
  `est_claim_bunker` varchar(100) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `keterangan` text,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `t_master_cable`
--

INSERT INTO `t_master_cable` (`id`, `id_vessel`, `no_voyage_gab`, `no_voyage`, `jenis_voyage`, `master`, `atd_port`, `atd_time`, `atd_rob`, `ata_port`, `ata_time`, `ata_rob`, `distance`, `speed`, `est_sail_day`, `act_sail_day`, `charter_rate_day`, `est_claim_speed`, `std_bunker_cons`, `act_bunker_cons`, `excess_bunker`, `bunker_price`, `est_claim_bunker`, `status`, `keterangan`, `user_id`, `created_at`, `updated_at`) VALUES
(18, 34, 'AL2F8/26001/L', '26001', 'L', 'STEVEN', 'PANJANG', '2026-04-22 09:06:00', '12', 'JAMBI', '2026-04-28 09:06:00', '13', '1', '4', '0.010417', '6', '1833.333333', '10980.902165', '10.2', '-1', '-11.2', '12', '-113836.8', 'APPROVE', NULL, 2, '2026-04-20 19:07:07', '2026-04-20 19:16:36'),
(19, 40, 'F20/26001/L', '26001', 'L', 'TES', 'JAKARTA', '2026-04-19 16:21:00', '10', 'PALEMBANG', '2026-04-22 16:21:00', '-1', '100', '100', '0.041667', '3', '0.333333', '0.98611', '10', '11', '1', '1000', '847000', 'CLOSE', 'tes', 2, '2026-04-26 02:26:07', '2026-04-26 03:39:50'),
(20, 40, 'F20/26001/D1', '26001', 'D1', 'TES', 'PALEMBANG', '2026-04-26 16:58:00', '300', 'PALEMBANG', '2026-04-27 16:58:00', '200', '100', '100', '0.041667', '1', '0.333333', '0.319444', '10', '100', '90', '500', '38115000', 'CLOSE', 'tes', 2, '2026-04-26 02:59:19', '2026-04-26 03:39:50');

-- --------------------------------------------------------

--
-- Table structure for table `t_off_hire`
--

CREATE TABLE `t_off_hire` (
  `id` int NOT NULL,
  `id_vessel` int NOT NULL,
  `no_sertifikat` varchar(100) DEFAULT NULL,
  `no_kontrak` varchar(100) DEFAULT NULL,
  `bunker_price` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `est_oh` varchar(100) DEFAULT NULL,
  `est_boh` varchar(100) DEFAULT NULL,
  `date_time_off_hire` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tempat_off_hire` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `bunker_off_hire` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `date_time_on_hire` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tempat_on_hire` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `bunker_on_hire` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `t_off_hire`
--

INSERT INTO `t_off_hire` (`id`, `id_vessel`, `no_sertifikat`, `no_kontrak`, `bunker_price`, `est_oh`, `est_boh`, `date_time_off_hire`, `tempat_off_hire`, `bunker_off_hire`, `date_time_on_hire`, `tempat_on_hire`, `bunker_on_hire`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(6, 34, '123', '004/TCP/1/2027', '123', '110000', '208362', '2026-04-28 02:51:00', 'TES', '123', '2026-04-30 02:51:00', 'SET', '125', 'APPROVE', 2, '2026-04-27 12:51:57', '2026-04-27 12:51:59'),
(7, 34, '124', '004/TCP/1/2027', '124', '110000', '105028', '2026-04-28 02:52:00', 'TES1', '124', '2026-04-30 02:52:00', 'SET1', '125', 'APPROVE', 2, '2026-04-27 12:52:48', '2026-04-27 12:52:51');

-- --------------------------------------------------------

--
-- Table structure for table `t_redelivery_delivery`
--

CREATE TABLE `t_redelivery_delivery` (
  `id` int NOT NULL,
  `id_kontrak_redelivery` int NOT NULL,
  `id_kontrak_delivery` int NOT NULL,
  `id_vessel` int NOT NULL,
  `no_sertifikat` varchar(100) DEFAULT NULL,
  `no_kontrak_redelivery` varchar(100) DEFAULT NULL,
  `no_kontrak_delivery` varchar(100) DEFAULT NULL,
  `bunker_price` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `est_bod` varchar(100) DEFAULT NULL,
  `date_time_redelivery` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tempat_redelivery` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `bunker_redelivery` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `date_time_delivery` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tempat_delivery` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `bunker_delivery` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'steven', 'work.stevensantoso@gmail.com', NULL, '$2y$12$wOlAWPsdCj1RgS.7ObDT3O6LaLljs3fWJkuC1nEni2tx7mqIyarl2', NULL, '2026-03-21 05:20:52', '2026-03-21 05:20:52'),
(2, 'approve steven', 'approve.stevensantoso@gmail.com', NULL, '$2y$12$AyaRWK408pOGLnYNES.NN./kLiL37yNo09/LC/pWSFGVnKi2h2.Xq', NULL, '2026-04-03 13:18:28', '2026-04-03 13:18:28'),
(3, 'superadmin', 'superadmin@gmail.com', NULL, '$2y$12$ITQlOCdxko8yVoRHXd/Rr.E9DUiXvWkoK1/YVfOCfrlpdfFPJ7fXK', NULL, '2026-04-11 13:21:38', '2026-04-11 23:34:41'),
(4, 'tes', 'tes@gmail.com', NULL, '$2y$12$JUrGA6No6dHs.BU2QcLhEOLyCIR8OzqW3IBIYxwEhROVsEPyn8VBG', NULL, '2026-04-11 23:33:52', '2026-04-11 23:33:52');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `file_upload`
--
ALTER TABLE `file_upload`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_kontrak` (`id_kontrak`),
  ADD KEY `id_cable` (`id_cable`),
  ADD KEY `id_doc_cargo` (`id_doc_cargo`),
  ADD KEY `id_klaim_awal` (`id_klaim_awal`),
  ADD KEY `id_klaim_akhir` (`id_klaim_akhir`),
  ADD KEY `id_off_hire` (`id_off_hire`),
  ADD KEY `id_on_hire` (`id_on_hire`),
  ADD KEY `id_redelivery` (`id_redelivery`),
  ADD KEY `id_delivery` (`id_delivery`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `m_grade`
--
ALTER TABLE `m_grade`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `m_kontrak`
--
ALTER TABLE `m_kontrak`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_vessel` (`id_vessel`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `m_vessel`
--
ALTER TABLE `m_vessel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_owner_type_owner_id_index` (`owner_type`,`owner_id`);

--
-- Indexes for table `oauth_device_codes`
--
ALTER TABLE `oauth_device_codes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `oauth_device_codes_user_code_unique` (`user_code`),
  ADD KEY `oauth_device_codes_user_id_index` (`user_id`),
  ADD KEY `oauth_device_codes_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_doc_cargo`
--
ALTER TABLE `t_doc_cargo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cable` (`id_cable`),
  ADD KEY `id_grade` (`id_grade`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `t_doc_cargo_detail`
--
ALTER TABLE `t_doc_cargo_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_doc_cargo` (`id_doc_cargo`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `t_klaim`
--
ALTER TABLE `t_klaim`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_vessel` (`id_vessel`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `t_klaim_detail`
--
ALTER TABLE `t_klaim_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_klaim` (`id_klaim`),
  ADD KEY `id_cable` (`id_cable`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `id_off_hire` (`id_off_hire`) USING BTREE,
  ADD KEY `id_redelivery_delivery` (`id_redelivery_delivery`);

--
-- Indexes for table `t_klaim_detail_nilai`
--
ALTER TABLE `t_klaim_detail_nilai`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_klaim_detail` (`id_klaim_detail`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `sub_jenis` (`sub_jenis`);

--
-- Indexes for table `t_master_cable`
--
ALTER TABLE `t_master_cable`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_vessel` (`id_vessel`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `t_off_hire`
--
ALTER TABLE `t_off_hire`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cable` (`id_vessel`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `t_redelivery_delivery`
--
ALTER TABLE `t_redelivery_delivery`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `id_kontrak_redelivery` (`id_kontrak_redelivery`) USING BTREE,
  ADD KEY `id_kontrak_delivery` (`id_kontrak_delivery`) USING BTREE,
  ADD KEY `id_vessel` (`id_vessel`) USING BTREE;

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `file_upload`
--
ALTER TABLE `file_upload`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `m_grade`
--
ALTER TABLE `m_grade`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `m_kontrak`
--
ALTER TABLE `m_kontrak`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `m_vessel`
--
ALTER TABLE `m_vessel`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `t_doc_cargo`
--
ALTER TABLE `t_doc_cargo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `t_doc_cargo_detail`
--
ALTER TABLE `t_doc_cargo_detail`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `t_klaim`
--
ALTER TABLE `t_klaim`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `t_klaim_detail`
--
ALTER TABLE `t_klaim_detail`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `t_klaim_detail_nilai`
--
ALTER TABLE `t_klaim_detail_nilai`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `t_master_cable`
--
ALTER TABLE `t_master_cable`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `t_off_hire`
--
ALTER TABLE `t_off_hire`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `t_redelivery_delivery`
--
ALTER TABLE `t_redelivery_delivery`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
