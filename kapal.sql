-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 14, 2026 at 02:52 PM
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
  `id_klaim_detail` int DEFAULT NULL,
  `id_doc_cargo` int DEFAULT NULL,
  `nama_file` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `file_upload`
--

INSERT INTO `file_upload` (`id`, `id_kontrak`, `id_cable`, `id_klaim_detail`, `id_doc_cargo`, `nama_file`, `created_at`, `updated_at`) VALUES
(28, NULL, NULL, NULL, 1, 'uploads/doc_cargo/final osl.txt', '2026-04-11 14:53:31', '2026-04-11 14:53:31'),
(29, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/vessel_export_20260412.csv', '2026-04-11 23:41:14', '2026-04-11 23:41:14'),
(30, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/cable_export_20260412.csv', '2026-04-11 23:41:14', '2026-04-11 23:41:14'),
(31, 16, NULL, NULL, NULL, 'uploads/kontrak/vessel_export_20260412.csv', '2026-04-11 23:42:27', '2026-04-11 23:42:27'),
(40, NULL, 14, NULL, NULL, 'uploads/cable/SURAT PERNYATAAN TERKAIT TATA RUANG.pdf', '2026-04-13 01:04:19', '2026-04-13 01:04:19');

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
(1, 'TES', '50', 3, '2026-04-11 03:12:20', '2026-04-12 00:18:45'),
(2, 'PERTAMA', '1000', 3, '2026-04-11 23:36:44', '2026-04-11 23:36:44');

-- --------------------------------------------------------

--
-- Table structure for table `m_kontrak`
--

CREATE TABLE `m_kontrak` (
  `id` int NOT NULL,
  `id_vessel` int NOT NULL,
  `no_kontrak` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tgl_awal_kontrak` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tgl_akhir_kontrak` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `charter_rate` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `speed` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `me_ballast` varchar(100) DEFAULT NULL,
  `me_laden` varchar(100) DEFAULT NULL,
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

INSERT INTO `m_kontrak` (`id`, `id_vessel`, `no_kontrak`, `tgl_awal_kontrak`, `tgl_akhir_kontrak`, `charter_rate`, `speed`, `me_ballast`, `me_laden`, `pumping_rate`, `discharge`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(16, 34, '004/TCP/1/2024', '2024-01-04T00:00', '2025-01-04T00:00:00', '55000', '4', '1.8', '1.8', '150', '0.02', 'ACTIVE', 3, '2026-04-03 09:02:34', '2026-04-12 00:42:20');

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
(34, 'AL2F8', 'ALBATROSS 2/FLAMINGO 8', 'TB/OB', 'ACTIVE', 3, '2026-04-03 06:40:40', '2026-04-12 00:17:11');

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
(45, 'App\\Models\\User', 2, 'api-token', '5698bc8755b57f5b8888270c8f43135e14e807a64c077cb6561e1eb5f154806b', '[\"*\"]', '2026-04-13 01:12:09', NULL, '2026-04-13 00:56:18', '2026-04-13 01:12:09'),
(47, 'App\\Models\\User', 3, 'api-token', '3562f18b260f588b9c7c9e190a25676ca1f380eed092d18334488bc4fcc514e3', '[\"*\"]', '2026-04-13 07:59:42', NULL, '2026-04-13 07:09:50', '2026-04-13 07:59:42'),
(48, 'App\\Models\\User', 1, 'api-token', '93f8a0097bf106be92baab11cc3e3091b20d5da2083b77627f9fbe4891e68ec2', '[\"*\"]', '2026-04-14 07:48:53', NULL, '2026-04-14 05:04:24', '2026-04-14 07:48:53');

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
(2, 'variable est_claim_transport', '0.07', 'ACTIVE', NULL, NULL);

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
(2, 14, 2, '26001/L', 'PERTAMA', '1000', '6164.489', '1', '0.000162', '3.209', '0.000521', '1', '0.000162', '1', '0.000162', '523.04', '0', '0.191667', '0.191667', '0', '0', '428305.23', 'OPEN', 3, '2026-04-12 00:36:39', '2026-04-12 00:42:45');

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
(7, 2, '26001/L', '01', '2026-03-07T09:24', '2026-03-07T10:00', '0.025', 3, '2026-04-12 00:42:45', '2026-04-12 00:42:45'),
(8, 2, '26001/L', '02', '2026-03-07T11:30', '2026-03-07T15:30', '0.166667', 3, '2026-04-12 00:42:45', '2026-04-12 00:42:45');

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `t_klaim`
--

INSERT INTO `t_klaim` (`id`, `id_vessel`, `no_klaim_awal`, `tgl_klaim_awal`, `jenis_klaim`, `no_klaim_akhir`, `tgl_klaim_akhir`, `user_id`, `created_at`, `updated_at`) VALUES
(40, 34, '1', '2025-01-01', 'SSOB', NULL, NULL, 3, '2026-04-12 01:12:38', '2026-04-12 01:12:38');

-- --------------------------------------------------------

--
-- Table structure for table `t_klaim_detail`
--

CREATE TABLE `t_klaim_detail` (
  `id` int NOT NULL,
  `id_klaim` int NOT NULL,
  `id_cable` int DEFAULT NULL,
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

INSERT INTO `t_klaim_detail` (`id`, `id_klaim`, `id_cable`, `no_urut`, `no_voyage_gab`, `no_kontrak`, `keterangan`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(45, 40, 14, '01', '26001/L', '004/TCP/1/2024', NULL, 'OPEN', 3, '2026-04-12 01:12:39', '2026-04-12 01:12:39');

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
(1, 35, 'SS', NULL, NULL, '8918.403998', NULL, NULL, NULL, NULL, NULL, 'OPEN', 3, '2026-04-11 13:27:13', '2026-04-11 13:27:13'),
(2, 35, 'OB', NULL, NULL, '8918.403998', NULL, NULL, NULL, NULL, NULL, 'OPEN', 3, '2026-04-11 13:27:13', '2026-04-11 13:27:13'),
(3, 36, 'SS', 'USD', '16500', '8918.403998', '15000', '15000', '247500000', NULL, NULL, 'OPEN', 3, '2026-04-11 13:28:18', '2026-04-11 13:49:23'),
(4, 36, 'OB', 'IDR', '1', '101229628.5', '180500000', '180500000', '180500000', NULL, NULL, 'OPEN', 3, '2026-04-11 13:28:18', '2026-04-11 13:49:23'),
(5, 37, 'SP', NULL, NULL, '5453.020832', NULL, NULL, NULL, NULL, NULL, 'OPEN', 3, '2026-04-11 14:37:38', '2026-04-11 14:37:38'),
(6, 37, 'OB', NULL, NULL, '101229628.5', NULL, NULL, NULL, NULL, NULL, 'OPEN', 3, '2026-04-11 14:37:38', '2026-04-11 14:37:38'),
(9, 39, 'SS', NULL, NULL, '8918.403998', NULL, NULL, NULL, NULL, NULL, 'OPEN', 3, '2026-04-11 14:41:46', '2026-04-11 14:41:46'),
(10, 39, 'OB', NULL, NULL, '101229628.5', NULL, NULL, NULL, NULL, NULL, 'OPEN', 3, '2026-04-11 14:41:46', '2026-04-11 14:41:46'),
(11, 40, 'TL', NULL, NULL, '9361236.03', NULL, NULL, NULL, NULL, NULL, 'OPEN', 3, '2026-04-11 14:54:17', '2026-04-11 14:54:17'),
(14, 42, 'SP', 'USD', '16900', '5453.020832', '10', NULL, '0', NULL, NULL, 'OPEN', 3, '2026-04-11 23:40:10', '2026-04-11 23:41:14'),
(15, 42, 'OB', 'IDR', '1', '340104.909375', '10', NULL, '0', NULL, NULL, 'OPEN', 3, '2026-04-11 23:40:10', '2026-04-11 23:41:14'),
(16, 43, 'TL', NULL, NULL, '2654.5145', NULL, NULL, NULL, NULL, NULL, 'OPEN', 3, '2026-04-11 23:56:22', '2026-04-11 23:56:22'),
(19, 45, 'SS', NULL, NULL, '2654.5145', NULL, NULL, NULL, NULL, NULL, 'OPEN', 3, '2026-04-12 01:12:39', '2026-04-12 01:12:39'),
(20, 45, 'OB', NULL, NULL, '-16216066282.878', NULL, NULL, NULL, NULL, NULL, 'OPEN', 3, '2026-04-12 01:12:39', '2026-04-12 01:12:39');

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
  `captain` varchar(100) DEFAULT NULL,
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
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `t_master_cable`
--

INSERT INTO `t_master_cable` (`id`, `id_vessel`, `no_voyage_gab`, `no_voyage`, `jenis_voyage`, `captain`, `atd_port`, `atd_time`, `atd_rob`, `ata_port`, `ata_time`, `ata_rob`, `distance`, `speed`, `est_sail_day`, `act_sail_day`, `charter_rate_day`, `est_claim_speed`, `std_bunker_cons`, `act_bunker_cons`, `excess_bunker`, `bunker_price`, `est_claim_bunker`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(14, 34, '26001/L', '26001', 'L', 'STEEN', 'JAMBI', '2025-06-01 13:50:45', '2', 'JAKARTA', '2025-06-02 20:15:50', '2', '5', '4', '0.052083', '1.267419', '1833.333333', '2228.116', '1.8', '0', '-1.8', '10636275.93', '-16216066282.878', 'OPEN', 1, '2026-04-11 23:53:22', '2026-04-13 03:02:51');

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
  ADD PRIMARY KEY (`id`);

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
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `m_kontrak`
--
ALTER TABLE `m_kontrak`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `m_vessel`
--
ALTER TABLE `m_vessel`
  ADD PRIMARY KEY (`id`);

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
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_doc_cargo_detail`
--
ALTER TABLE `t_doc_cargo_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_klaim`
--
ALTER TABLE `t_klaim`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_klaim_detail`
--
ALTER TABLE `t_klaim_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_klaim_detail_nilai`
--
ALTER TABLE `t_klaim_detail_nilai`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_master_cable`
--
ALTER TABLE `t_master_cable`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `m_kontrak`
--
ALTER TABLE `m_kontrak`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `m_vessel`
--
ALTER TABLE `m_vessel`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `t_doc_cargo`
--
ALTER TABLE `t_doc_cargo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `t_doc_cargo_detail`
--
ALTER TABLE `t_doc_cargo_detail`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `t_klaim`
--
ALTER TABLE `t_klaim`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `t_klaim_detail`
--
ALTER TABLE `t_klaim_detail`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `t_klaim_detail_nilai`
--
ALTER TABLE `t_klaim_detail_nilai`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `t_master_cable`
--
ALTER TABLE `t_master_cable`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

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
