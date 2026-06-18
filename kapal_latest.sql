-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 07, 2026 at 01:08 PM
-- Server version: 10.11.18-MariaDB
-- PHP Version: 8.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `oslclaimtracker_kapal`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `file_upload`
--

CREATE TABLE `file_upload` (
  `id` int(11) NOT NULL,
  `id_kontrak` int(11) DEFAULT NULL,
  `id_cable` int(11) DEFAULT NULL,
  `id_klaim_awal` int(11) DEFAULT NULL,
  `id_klaim_akhir` int(11) DEFAULT NULL,
  `id_doc_cargo` int(11) DEFAULT NULL,
  `id_off_hire` int(11) DEFAULT NULL,
  `id_on_hire` int(11) DEFAULT NULL,
  `id_redelivery` int(11) DEFAULT NULL,
  `id_delivery` int(11) DEFAULT NULL,
  `nama_file` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(43, NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/Invoice Nasi Bakar Nony 11 Maret 2026 - Wisma76.pdf', '2026-04-14 10:51:19', '2026-04-14 10:51:19'),
(45, NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/AKSFOOD ID (1).pdf', '2026-04-14 10:58:32', '2026-04-14 10:58:32'),
(46, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Invoice Nasi Bakar Nony - up Ibu Tari.pdf', '2026-04-14 11:43:31', '2026-04-14 11:43:31'),
(47, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/DPP+Onsite+2026.pdf', '2026-04-14 11:45:10', '2026-04-14 11:45:10'),
(53, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/AKSFOOD ID (1).pdf', '2026-04-14 21:54:33', '2026-04-14 21:54:33'),
(55, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/DPP+Onsite+2026 (1).pdf', '2026-04-14 22:21:13', '2026-04-14 22:21:13'),
(57, NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/Akad Ijaroh.pdf', '2026-04-15 13:38:49', '2026-04-15 13:38:49'),
(58, 24, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/900.TXT', '2026-04-15 13:42:07', '2026-04-15 13:42:07'),
(59, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/Akad Ijaroh.pdf', '2026-04-15 15:00:19', '2026-04-15 15:00:19'),
(60, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Akad Ijaroh.pdf', '2026-04-16 00:40:40', '2026-04-16 00:40:40'),
(61, 25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/CV_2026012113454096 (1).pdf', '2026-04-16 03:48:48', '2026-04-16 03:48:48'),
(62, 25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/CV_2026012113454096 (2).pdf', '2026-04-16 03:48:48', '2026-04-16 03:48:48'),
(63, 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/CV_2026012113454096.pdf', '2026-04-16 04:07:38', '2026-04-16 04:07:38'),
(64, 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/CV_2026012113454096 (1)_1.pdf', '2026-04-16 04:08:14', '2026-04-16 04:08:14'),
(65, NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/ikrar_f818c297-2720-4610-b5cb-942a73866a91.pdf', '2026-04-16 04:25:52', '2026-04-16 04:25:52'),
(66, NULL, 19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/Invoice Nasi Bakar Nony - up Ibu Tari.pdf', '2026-04-16 04:40:46', '2026-04-16 04:40:46'),
(67, NULL, 19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/CV_2026012113454096 (1).pdf', '2026-04-16 04:40:46', '2026-04-16 04:40:46'),
(68, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Invoice Nasi Bakar Nony - up Ibu Tari_1.pdf', '2026-04-16 04:59:30', '2026-04-16 04:59:30'),
(69, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB.pdf', '2026-04-16 06:37:26', '2026-04-16 06:37:26'),
(70, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB_1.pdf', '2026-04-16 06:39:51', '2026-04-16 06:39:51'),
(71, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/Invoice Nasi Bakar Nony - up Ibu Tari.pdf', '2026-04-16 06:40:18', '2026-04-16 06:40:18'),
(74, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, 'uploads/off_hire/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB.pdf', '2026-04-26 06:06:27', '2026-04-26 06:06:27'),
(75, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, 'uploads/on_hire/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB.pdf', '2026-04-26 06:06:27', '2026-04-26 06:06:27'),
(76, NULL, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/M_01-DOC002_Ebupot_2126_BPA1_2507ZR3EB.pdf', '2026-04-26 06:56:12', '2026-04-26 06:56:12'),
(79, 27, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604.pdf', '2026-04-29 07:30:30', '2026-04-29 07:30:30'),
(80, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_1.pdf', '2026-04-29 07:31:49', '2026-04-29 07:31:49'),
(81, NULL, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604.pdf', '2026-04-29 07:33:20', '2026-04-29 07:33:20'),
(84, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/list_pemotongan_invoice_202604.pdf', '2026-04-29 07:58:35', '2026-04-29 07:58:35'),
(85, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/list_pemotongan_invoice_202604_1.pdf', '2026-04-29 07:59:53', '2026-04-29 07:59:53'),
(88, 29, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_2.pdf', '2026-04-29 08:03:40', '2026-04-29 08:03:40'),
(93, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/list_pemotongan_invoice_202604_2.pdf', '2026-04-29 08:07:58', '2026-04-29 08:07:58'),
(94, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/list_pemotongan_invoice_202604_3.pdf', '2026-04-29 08:08:48', '2026-04-29 08:08:48'),
(98, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, 'uploads/redelivery/list_pemotongan_invoice_202604 (1).pdf', '2026-05-07 03:52:27', '2026-05-07 03:52:27'),
(99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 'uploads/delivery/list_pemotongan_invoice_202604 (1).pdf', '2026-05-07 03:52:27', '2026-05-07 03:52:27'),
(100, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/Inspection_PSA_1149-PIS0410-PN-2026-S0.pdf', '2026-05-07 07:26:32', '2026-05-07 07:26:32'),
(102, NULL, 24, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/PSA Albatross 2 Flamingo 8.pdf', '2026-05-07 08:00:44', '2026-05-07 08:00:44'),
(103, NULL, 25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/PSA Albatross 2 Flamingo 8_1.pdf', '2026-05-07 08:10:19', '2026-05-07 08:10:19'),
(104, NULL, 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/PSA Albatross 2 Flamingo 8_2.pdf', '2026-05-07 08:28:32', '2026-05-07 08:28:32'),
(105, NULL, 27, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/Inspection_PSA_1149-PIS0410-PN-2026-S0.pdf', '2026-05-07 08:42:03', '2026-05-07 08:42:03'),
(106, NULL, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/PSA Albatross 2 Flamingo 8_3.pdf', '2026-05-07 08:43:41', '2026-05-07 08:43:41'),
(107, NULL, 29, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/PSA Albatross 2 Flamingo 8_4.pdf', '2026-05-07 09:04:10', '2026-05-07 09:04:10'),
(108, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/PSA Albatross 2 Flamingo 8_5.pdf', '2026-05-07 09:05:10', '2026-05-07 09:05:10'),
(109, NULL, 31, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/PSA Albatross 2 Flamingo 8_6.pdf', '2026-05-07 10:04:02', '2026-05-07 10:04:02'),
(110, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/Inspection_PSA_1150-PIS0410-PN-2026-S0.pdf', '2026-05-07 10:21:03', '2026-05-07 10:21:03'),
(111, NULL, 33, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/Inspection_PSA_1149-PIS0410-PN-2026-S0_1.pdf', '2026-05-07 10:23:15', '2026-05-07 10:23:15'),
(113, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/Notulen Weekly Meeting 12 Mei 2026.pdf', '2026-05-13 03:30:06', '2026-05-13 03:30:06'),
(114, 31, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/Notulen Weekly Meeting 12 Mei 2026.pdf', '2026-05-13 07:44:55', '2026-05-13 07:44:55'),
(118, NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, 'uploads/off_hire/OFFCERT_7697_20250526111510138.pdf', '2026-05-15 03:46:58', '2026-05-15 03:46:58'),
(119, NULL, NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, 'uploads/on_hire/ONCERT_7698_20250605132422641.pdf', '2026-05-15 03:46:58', '2026-05-15 03:46:58'),
(120, NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, 'uploads/off_hire/OFFCERT_7949_20250725153052598.pdf', '2026-05-15 03:55:00', '2026-05-15 03:55:00'),
(121, NULL, NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, 'uploads/on_hire/ONCERT_7950_20250806225227604.pdf', '2026-05-15 03:55:00', '2026-05-15 03:55:00'),
(130, NULL, NULL, 58, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/Surat_Keluar_5752_PIS2330_2025-S6.pdf', '2026-05-20 09:21:40', '2026-05-20 09:21:40'),
(131, NULL, NULL, NULL, 58, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/Surat_Keluar_5752_PIS2330_2025-S6_1.pdf', '2026-05-20 09:22:11', '2026-05-20 09:22:11'),
(132, NULL, NULL, NULL, NULL, 12, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Voy.25006.L.SG351.II.24 (3).pdf', '2026-05-22 09:36:03', '2026-05-22 09:36:03'),
(133, NULL, NULL, NULL, NULL, 13, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Voy.25005.D.SG351.II.25 (1).pdf', '2026-05-22 10:03:34', '2026-05-22 10:03:34'),
(134, NULL, NULL, NULL, NULL, 14, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Voy.25005.D.SG351.II.25 (1)_1.pdf', '2026-05-22 10:10:20', '2026-05-22 10:10:20'),
(135, NULL, NULL, NULL, NULL, 15, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Voy.25005.L.SG351.II.25.pdf', '2026-05-22 10:28:14', '2026-05-22 10:28:14'),
(136, NULL, NULL, NULL, NULL, 16, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Voy.25004.L.SG351.II.25.pdf', '2026-05-22 10:38:49', '2026-05-22 10:38:49'),
(137, NULL, NULL, NULL, NULL, 17, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Voy.25004.D.SG351.II.25.pdf', '2026-05-22 13:10:42', '2026-05-22 13:10:42'),
(138, NULL, NULL, NULL, NULL, 18, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Voy.25003.L.SG 351.I.25.pdf', '2026-05-22 13:13:37', '2026-05-22 13:13:37'),
(139, NULL, NULL, NULL, NULL, 19, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Voy.25003.L.SG 351.I.25_1.pdf', '2026-05-22 13:14:47', '2026-05-22 13:14:47'),
(140, NULL, NULL, NULL, NULL, 20, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Documen Cargo SPOB SEAGULL 351 (1).pdf', '2026-05-22 13:26:21', '2026-05-22 13:26:21'),
(141, NULL, NULL, NULL, NULL, 21, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Voy.25005.L.SG351.II.25_1.pdf', '2026-05-22 13:43:57', '2026-05-22 13:43:57'),
(142, NULL, NULL, NULL, NULL, 22, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Documen Cargo SPOB SEAGULL 351 (2).pdf', '2026-05-22 13:50:35', '2026-05-22 13:50:35'),
(143, NULL, NULL, NULL, NULL, 23, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Voy.25002.L.SG 351.I.25.pdf', '2026-05-22 14:00:14', '2026-05-22 14:00:14'),
(144, NULL, NULL, NULL, NULL, 24, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Voy.25002.D.SG351.I.25.pdf', '2026-05-22 14:10:08', '2026-05-22 14:10:08'),
(145, NULL, NULL, NULL, NULL, 25, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Voy.25006.L.SG351.II.24 (4).pdf', '2026-05-24 11:39:05', '2026-05-24 11:39:05'),
(146, NULL, NULL, NULL, NULL, 26, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Voy.25002.D.SG351.I.25 (2).pdf', '2026-05-24 11:50:38', '2026-05-24 11:50:38'),
(147, NULL, NULL, NULL, NULL, 27, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Voy.25002.L.SG 351.I.25 (1).pdf', '2026-05-24 11:55:02', '2026-05-24 11:55:02'),
(148, NULL, NULL, NULL, NULL, 28, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Voy.25001.D.SG351.I.25 (1).pdf', '2026-05-24 12:19:10', '2026-05-24 12:19:10'),
(149, NULL, NULL, 62, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/Surat_Keluar_1289_PIS2330_2025-S6.pdf', '2026-05-24 12:37:36', '2026-05-24 12:37:36'),
(150, NULL, NULL, 63, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/Surat_Keluar_2658 Klaim SSOB SPOB Seagull 351 Periode 21-24 Januari 2025.pdf', '2026-05-24 12:50:32', '2026-05-24 12:50:32'),
(151, NULL, NULL, 64, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/Surat_Keluar_3225_PIS2330_2025-S6.pdf', '2026-05-24 12:56:00', '2026-05-24 12:56:00'),
(152, NULL, NULL, 64, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/SlowSpeed-155866 SPOB SEAGULL 351.pdf', '2026-05-24 12:59:43', '2026-05-24 12:59:43'),
(153, NULL, NULL, 64, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/SlowSpeed-155865 SPOB SEAGULL 351.pdf', '2026-05-24 12:59:43', '2026-05-24 12:59:43'),
(154, NULL, NULL, 64, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/SlowSpeed-153694 SPOB SEAGULL 351.pdf', '2026-05-24 13:00:20', '2026-05-24 13:00:20'),
(155, NULL, NULL, 63, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/SlowSpeed-153695 SPOB SEAGULL 351.pdf', '2026-05-24 13:01:39', '2026-05-24 13:01:39'),
(156, NULL, NULL, 65, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/Surat_Keluar_3816_PIS2330_2025-S6.pdf', '2026-05-24 13:51:11', '2026-05-24 13:51:11'),
(157, NULL, NULL, 65, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/SlowSpeed-131594.pdf', '2026-05-24 13:56:39', '2026-05-24 13:56:39'),
(158, NULL, NULL, 65, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/SlowSpeed-131593.pdf', '2026-05-24 13:56:39', '2026-05-24 13:56:39'),
(159, NULL, NULL, 66, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/Surat_Keluar_5647 SPOB Seagull 351 Periode 27 September 2023 s.d 26 Agustus 2025.pdf', '2026-05-24 14:01:07', '2026-05-24 14:01:07'),
(160, NULL, NULL, 66, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/SlowSpeed-161760.pdf', '2026-05-24 14:02:00', '2026-05-24 14:02:00'),
(161, NULL, NULL, 66, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/SlowSpeed-161759.pdf', '2026-05-24 14:03:58', '2026-05-24 14:03:58'),
(162, NULL, NULL, 66, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/SlowSpeed-164296.pdf', '2026-05-24 14:06:49', '2026-05-24 14:06:49'),
(163, NULL, NULL, NULL, 64, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/Surat_Keluar_3225_PIS2330_2025-S6_1.pdf', '2026-05-24 14:32:37', '2026-05-24 14:32:37'),
(164, NULL, NULL, NULL, NULL, 29, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Voy.25001.L.SG 351.I.25.pdf', '2026-05-25 03:47:36', '2026-05-25 03:47:36'),
(165, NULL, NULL, NULL, NULL, 30, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/Voy.25001.L.SG 351.I.25_1.pdf', '2026-05-25 03:53:33', '2026-05-25 03:53:33'),
(166, NULL, NULL, 67, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/Odyssey Compro.pdf', '2026-05-25 07:04:31', '2026-05-25 07:04:31'),
(167, NULL, NULL, NULL, 67, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/Odyssey Compro_1.pdf', '2026-05-25 07:05:12', '2026-05-25 07:05:12'),
(173, NULL, NULL, 70, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/INVOICE - BSB2605001 - PT FERMENTECH INDONESIA - PO2026040089 (3)_1.pdf', '2026-05-26 20:22:15', '2026-05-26 20:22:15'),
(175, NULL, NULL, NULL, NULL, 35, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/PSA 202 - 25 May 2026.pdf', '2026-05-27 02:12:56', '2026-05-27 02:12:56'),
(176, NULL, NULL, 71, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/PSA 202 - 25 May 2026.pdf', '2026-05-27 02:14:05', '2026-05-27 02:14:05'),
(177, NULL, NULL, NULL, NULL, 36, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/PSA 202 - 25 May 2026_1.pdf', '2026-05-27 02:17:00', '2026-05-27 02:17:00'),
(178, NULL, NULL, 72, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/PSA 202 - 25 May 2026_1.pdf', '2026-05-27 02:18:27', '2026-05-27 02:18:27'),
(179, NULL, NULL, NULL, 72, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim/WhatsApp Image 2026-05-25 at 4.26.51 PM (1).jpeg', '2026-05-27 02:24:39', '2026-05-27 02:24:39'),
(180, NULL, NULL, NULL, 72, NULL, NULL, NULL, NULL, NULL, 'uploads/klaim_detail/Cecklish DICSH VOG 20.pdf', '2026-05-27 02:25:41', '2026-05-27 02:25:41'),
(183, NULL, NULL, NULL, NULL, 39, NULL, NULL, NULL, NULL, 'uploads/doc_cargo/[Fully Signed] 0000827387_9134640942_einvoice.pdf', '2026-05-28 02:43:31', '2026-05-28 02:43:31'),
(187, 33, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_2.pdf', '2026-06-01 22:02:42', '2026-06-01 22:02:42'),
(188, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_3.pdf', '2026-06-01 22:03:49', '2026-06-01 22:03:49'),
(189, 35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_4.pdf', '2026-06-01 22:05:45', '2026-06-01 22:05:45'),
(190, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_5.pdf', '2026-06-01 22:06:40', '2026-06-01 22:06:40'),
(191, 37, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_6.pdf', '2026-06-01 22:09:06', '2026-06-01 22:09:06'),
(192, 38, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_7.pdf', '2026-06-01 22:10:07', '2026-06-01 22:10:07'),
(193, 39, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_8.pdf', '2026-06-01 22:11:49', '2026-06-01 22:11:49'),
(194, 40, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_9.pdf', '2026-06-01 22:13:26', '2026-06-01 22:13:26'),
(195, 41, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_10.pdf', '2026-06-01 22:17:32', '2026-06-01 22:17:32'),
(196, 42, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_11.pdf', '2026-06-01 22:18:53', '2026-06-01 22:18:53'),
(197, 43, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_12.pdf', '2026-06-01 22:20:22', '2026-06-01 22:20:22'),
(198, 44, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_13.pdf', '2026-06-01 22:21:22', '2026-06-01 22:21:22'),
(199, 45, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_14.pdf', '2026-06-01 22:23:06', '2026-06-01 22:23:06'),
(200, 46, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_15.pdf', '2026-06-01 22:24:00', '2026-06-01 22:24:00'),
(201, 47, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_16.pdf', '2026-06-01 22:26:44', '2026-06-01 22:26:44'),
(202, 48, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_17.pdf', '2026-06-01 22:27:53', '2026-06-01 22:27:53'),
(203, 49, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/kontrak/list_pemotongan_invoice_202604_18.pdf', '2026-06-01 22:43:35', '2026-06-01 22:43:35'),
(204, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_2.pdf', '2026-06-02 07:33:14', '2026-06-02 07:33:14'),
(205, NULL, 37, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_3.pdf', '2026-06-02 07:35:15', '2026-06-02 07:35:15'),
(206, NULL, 38, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_4.pdf', '2026-06-02 07:37:06', '2026-06-02 07:37:06'),
(207, NULL, 39, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_5.pdf', '2026-06-02 07:38:11', '2026-06-02 07:38:11'),
(208, NULL, 40, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_6.pdf', '2026-06-02 07:41:27', '2026-06-02 07:41:27'),
(209, NULL, 41, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_7.pdf', '2026-06-02 07:43:31', '2026-06-02 07:43:31'),
(210, NULL, 42, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_8.pdf', '2026-06-02 07:44:26', '2026-06-02 07:44:26'),
(211, NULL, 43, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_9.pdf', '2026-06-02 07:48:08', '2026-06-02 07:48:08'),
(212, NULL, 44, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_10.pdf', '2026-06-02 07:49:09', '2026-06-02 07:49:09'),
(213, NULL, 45, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_11.pdf', '2026-06-02 07:50:15', '2026-06-02 07:50:15'),
(214, NULL, 46, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_12.pdf', '2026-06-02 07:51:15', '2026-06-02 07:51:15'),
(215, NULL, 47, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_13.pdf', '2026-06-02 07:52:08', '2026-06-02 07:52:08'),
(216, NULL, 48, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_14.pdf', '2026-06-02 07:54:35', '2026-06-02 07:54:35'),
(217, NULL, 49, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_15.pdf', '2026-06-02 07:55:22', '2026-06-02 07:55:22'),
(218, NULL, 50, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_16.pdf', '2026-06-02 07:56:06', '2026-06-02 07:56:06'),
(219, NULL, 51, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_17.pdf', '2026-06-02 07:57:16', '2026-06-02 07:57:16'),
(220, NULL, 52, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_18.pdf', '2026-06-02 08:02:50', '2026-06-02 08:02:50'),
(221, NULL, 53, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_19.pdf', '2026-06-02 08:05:30', '2026-06-02 08:05:30'),
(222, NULL, 54, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_20.pdf', '2026-06-02 08:06:28', '2026-06-02 08:06:28'),
(223, NULL, 55, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_21.pdf', '2026-06-02 08:07:13', '2026-06-02 08:07:13'),
(224, NULL, 56, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_22.pdf', '2026-06-02 08:07:59', '2026-06-02 08:07:59'),
(225, NULL, 57, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_23.pdf', '2026-06-02 08:08:55', '2026-06-02 08:08:55'),
(226, NULL, 58, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_24.pdf', '2026-06-02 08:09:42', '2026-06-02 08:09:42'),
(227, NULL, 59, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_25.pdf', '2026-06-02 08:10:27', '2026-06-02 08:10:27'),
(228, NULL, 60, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_26.pdf', '2026-06-02 08:11:28', '2026-06-02 08:11:28'),
(229, NULL, 61, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_27.pdf', '2026-06-02 08:12:08', '2026-06-02 08:12:08'),
(230, NULL, 62, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_28.pdf', '2026-06-02 08:13:02', '2026-06-02 08:13:02'),
(231, NULL, 63, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_29.pdf', '2026-06-02 08:13:46', '2026-06-02 08:13:46'),
(232, NULL, 64, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_30.pdf', '2026-06-02 08:14:31', '2026-06-02 08:14:31'),
(233, NULL, 65, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_31.pdf', '2026-06-02 08:15:10', '2026-06-02 08:15:10'),
(234, NULL, 66, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_32.pdf', '2026-06-02 08:15:59', '2026-06-02 08:15:59'),
(235, NULL, 67, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_33.pdf', '2026-06-02 08:16:59', '2026-06-02 08:16:59'),
(236, NULL, 68, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_34.pdf', '2026-06-02 08:18:09', '2026-06-02 08:18:09'),
(237, NULL, 69, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_35.pdf', '2026-06-02 08:22:15', '2026-06-02 08:22:15'),
(238, NULL, 70, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_36.pdf', '2026-06-02 08:23:29', '2026-06-02 08:23:29'),
(239, NULL, 71, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_37.pdf', '2026-06-02 08:24:43', '2026-06-02 08:24:43'),
(240, NULL, 72, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_38.pdf', '2026-06-02 08:25:37', '2026-06-02 08:25:37'),
(241, NULL, 73, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_39.pdf', '2026-06-02 08:27:15', '2026-06-02 08:27:15'),
(242, NULL, 74, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_40.pdf', '2026-06-02 08:28:03', '2026-06-02 08:28:03'),
(243, NULL, 75, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_41.pdf', '2026-06-02 08:28:40', '2026-06-02 08:28:40'),
(244, NULL, 76, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_42.pdf', '2026-06-02 08:37:26', '2026-06-02 08:37:26'),
(245, NULL, 77, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_43.pdf', '2026-06-02 09:02:26', '2026-06-02 09:02:26'),
(246, NULL, 78, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_44.pdf', '2026-06-02 09:04:13', '2026-06-02 09:04:13'),
(247, NULL, 79, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_45.pdf', '2026-06-02 09:16:23', '2026-06-02 09:16:23'),
(248, NULL, 80, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_46.pdf', '2026-06-02 09:37:36', '2026-06-02 09:37:36'),
(249, NULL, 81, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_47.pdf', '2026-06-02 09:59:49', '2026-06-02 09:59:49'),
(250, NULL, 82, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_48.pdf', '2026-06-02 10:00:24', '2026-06-02 10:00:24'),
(251, NULL, 83, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_49.pdf', '2026-06-02 10:01:09', '2026-06-02 10:01:09'),
(252, NULL, 84, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_50.pdf', '2026-06-02 10:02:28', '2026-06-02 10:02:28'),
(253, NULL, 85, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_51.pdf', '2026-06-02 10:06:39', '2026-06-02 10:06:39'),
(254, NULL, 86, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_52.pdf', '2026-06-02 10:07:18', '2026-06-02 10:07:18'),
(255, NULL, 87, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_53.pdf', '2026-06-02 10:07:56', '2026-06-02 10:07:56'),
(256, NULL, 88, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_54.pdf', '2026-06-02 10:08:43', '2026-06-02 10:08:43'),
(257, NULL, 89, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_55.pdf', '2026-06-02 10:09:43', '2026-06-02 10:09:43'),
(258, NULL, 90, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_56.pdf', '2026-06-02 10:10:35', '2026-06-02 10:10:35'),
(259, NULL, 91, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_57.pdf', '2026-06-02 10:12:14', '2026-06-02 10:12:14'),
(260, NULL, 92, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_58.pdf', '2026-06-02 10:15:03', '2026-06-02 10:15:03'),
(261, NULL, 93, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_59.pdf', '2026-06-02 10:16:05', '2026-06-02 10:16:05'),
(262, NULL, 94, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_60.pdf', '2026-06-02 10:16:51', '2026-06-02 10:16:51'),
(263, NULL, 95, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_61.pdf', '2026-06-02 10:18:39', '2026-06-02 10:18:39'),
(264, NULL, 96, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_62.pdf', '2026-06-02 10:22:31', '2026-06-02 10:22:31'),
(265, NULL, 97, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_63.pdf', '2026-06-02 10:23:15', '2026-06-02 10:23:15'),
(266, NULL, 98, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_64.pdf', '2026-06-02 10:25:42', '2026-06-02 10:25:42'),
(267, NULL, 99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_65.pdf', '2026-06-02 10:26:30', '2026-06-02 10:26:30'),
(268, NULL, 100, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_66.pdf', '2026-06-02 10:27:17', '2026-06-02 10:27:17'),
(269, NULL, 101, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_67.pdf', '2026-06-02 10:31:02', '2026-06-02 10:31:02'),
(270, NULL, 102, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_68.pdf', '2026-06-02 10:32:02', '2026-06-02 10:32:02'),
(271, NULL, 103, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_69.pdf', '2026-06-02 10:32:47', '2026-06-02 10:32:47'),
(272, NULL, 104, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_70.pdf', '2026-06-02 10:33:31', '2026-06-02 10:33:31'),
(273, NULL, 105, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_71.pdf', '2026-06-02 10:34:15', '2026-06-02 10:34:15'),
(274, NULL, 106, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_72.pdf', '2026-06-02 10:34:51', '2026-06-02 10:34:51'),
(275, NULL, 107, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_73.pdf', '2026-06-02 10:35:33', '2026-06-02 10:35:33'),
(276, NULL, 108, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_74.pdf', '2026-06-02 10:36:14', '2026-06-02 10:36:14'),
(277, NULL, 109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_75.pdf', '2026-06-02 11:11:36', '2026-06-02 11:11:36'),
(278, NULL, 110, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_76.pdf', '2026-06-02 11:12:10', '2026-06-02 11:12:10'),
(279, NULL, 111, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_77.pdf', '2026-06-02 11:13:15', '2026-06-02 11:13:15'),
(280, NULL, 112, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_78.pdf', '2026-06-02 11:14:01', '2026-06-02 11:14:01'),
(281, NULL, 113, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_79.pdf', '2026-06-02 11:14:39', '2026-06-02 11:14:39'),
(282, NULL, 114, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_80.pdf', '2026-06-02 11:15:14', '2026-06-02 11:15:14'),
(283, NULL, 115, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_81.pdf', '2026-06-02 11:15:48', '2026-06-02 11:15:48'),
(284, NULL, 116, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_82.pdf', '2026-06-02 11:19:14', '2026-06-02 11:19:14'),
(285, NULL, 117, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_83.pdf', '2026-06-02 12:30:43', '2026-06-02 12:30:43'),
(286, NULL, 118, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_84.pdf', '2026-06-02 12:31:33', '2026-06-02 12:31:33'),
(287, NULL, 119, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_85.pdf', '2026-06-02 12:35:10', '2026-06-02 12:35:10'),
(288, NULL, 120, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_86.pdf', '2026-06-02 12:36:49', '2026-06-02 12:36:49'),
(289, NULL, 121, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_87.pdf', '2026-06-02 12:37:54', '2026-06-02 12:37:54'),
(290, NULL, 122, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_88.pdf', '2026-06-02 12:38:54', '2026-06-02 12:38:54'),
(291, NULL, 123, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_89.pdf', '2026-06-02 12:39:45', '2026-06-02 12:39:45'),
(292, NULL, 124, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_90.pdf', '2026-06-02 12:41:31', '2026-06-02 12:41:31'),
(293, NULL, 125, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_91.pdf', '2026-06-02 12:43:04', '2026-06-02 12:43:04'),
(294, NULL, 126, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_92.pdf', '2026-06-02 12:55:44', '2026-06-02 12:55:44'),
(295, NULL, 127, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_93.pdf', '2026-06-02 12:57:16', '2026-06-02 12:57:16'),
(296, NULL, 128, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_94.pdf', '2026-06-02 12:58:15', '2026-06-02 12:58:15'),
(297, NULL, 129, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_95.pdf', '2026-06-02 12:59:16', '2026-06-02 12:59:16'),
(298, NULL, 130, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_96.pdf', '2026-06-02 13:00:23', '2026-06-02 13:00:23'),
(299, NULL, 131, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_97.pdf', '2026-06-02 13:03:45', '2026-06-02 13:03:45'),
(300, NULL, 132, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_98.pdf', '2026-06-02 13:04:39', '2026-06-02 13:04:39'),
(301, NULL, 133, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_99.pdf', '2026-06-02 13:06:04', '2026-06-02 13:06:04'),
(302, NULL, 134, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_100.pdf', '2026-06-02 13:08:46', '2026-06-02 13:08:46'),
(303, NULL, 135, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_101.pdf', '2026-06-02 13:09:34', '2026-06-02 13:09:34'),
(304, NULL, 136, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_102.pdf', '2026-06-02 13:10:37', '2026-06-02 13:10:37'),
(305, NULL, 137, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_103.pdf', '2026-06-02 13:11:42', '2026-06-02 13:11:42'),
(306, NULL, 138, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_104.pdf', '2026-06-02 13:15:03', '2026-06-02 13:15:03'),
(307, NULL, 139, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_105.pdf', '2026-06-02 13:17:52', '2026-06-02 13:17:52'),
(308, NULL, 140, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_106.pdf', '2026-06-02 13:18:38', '2026-06-02 13:18:38'),
(309, NULL, 141, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_107.pdf', '2026-06-02 13:23:23', '2026-06-02 13:23:23'),
(310, NULL, 142, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_108.pdf', '2026-06-02 13:24:12', '2026-06-02 13:24:12'),
(311, NULL, 143, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_109.pdf', '2026-06-02 13:24:54', '2026-06-02 13:24:54'),
(312, NULL, 144, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_110.pdf', '2026-06-02 13:30:57', '2026-06-02 13:30:57'),
(313, NULL, 145, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_111.pdf', '2026-06-02 13:31:41', '2026-06-02 13:31:41'),
(314, NULL, 146, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_112.pdf', '2026-06-02 13:34:31', '2026-06-02 13:34:31'),
(315, NULL, 147, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_113.pdf', '2026-06-02 13:35:21', '2026-06-02 13:35:21'),
(316, NULL, 148, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_114.pdf', '2026-06-02 13:37:29', '2026-06-02 13:37:29'),
(317, NULL, 149, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_115.pdf', '2026-06-02 13:38:40', '2026-06-02 13:38:40'),
(318, NULL, 150, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_116.pdf', '2026-06-02 13:39:41', '2026-06-02 13:39:41'),
(319, NULL, 151, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_117.pdf', '2026-06-02 13:40:27', '2026-06-02 13:40:27'),
(320, NULL, 152, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_118.pdf', '2026-06-02 13:41:12', '2026-06-02 13:41:12'),
(321, NULL, 153, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_119.pdf', '2026-06-02 13:41:53', '2026-06-02 13:41:53'),
(322, NULL, 154, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_120.pdf', '2026-06-02 13:42:42', '2026-06-02 13:42:42'),
(323, NULL, 155, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_121.pdf', '2026-06-02 13:43:29', '2026-06-02 13:43:29'),
(324, NULL, 156, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_122.pdf', '2026-06-02 13:44:29', '2026-06-02 13:44:29'),
(325, NULL, 157, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_123.pdf', '2026-06-02 13:45:15', '2026-06-02 13:45:15'),
(326, NULL, 158, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_124.pdf', '2026-06-02 13:46:08', '2026-06-02 13:46:08'),
(327, NULL, 159, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_125.pdf', '2026-06-02 13:47:15', '2026-06-02 13:47:15'),
(328, NULL, 160, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_126.pdf', '2026-06-02 13:48:15', '2026-06-02 13:48:15'),
(329, NULL, 161, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_127.pdf', '2026-06-02 13:49:09', '2026-06-02 13:49:09'),
(330, NULL, 162, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_128.pdf', '2026-06-02 13:49:57', '2026-06-02 13:49:57'),
(331, NULL, 163, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_129.pdf', '2026-06-02 13:51:15', '2026-06-02 13:51:15'),
(332, NULL, 164, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_130.pdf', '2026-06-02 13:52:13', '2026-06-02 13:52:13'),
(333, NULL, 165, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_131.pdf', '2026-06-02 13:53:15', '2026-06-02 13:53:15'),
(334, NULL, 166, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_132.pdf', '2026-06-02 13:54:02', '2026-06-02 13:54:02'),
(335, NULL, 167, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_133.pdf', '2026-06-02 13:56:57', '2026-06-02 13:56:57'),
(336, NULL, 168, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_134.pdf', '2026-06-02 13:58:41', '2026-06-02 13:58:41'),
(337, NULL, 169, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_135.pdf', '2026-06-02 14:01:18', '2026-06-02 14:01:18'),
(338, NULL, 170, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_136.pdf', '2026-06-02 14:02:55', '2026-06-02 14:02:55'),
(339, NULL, 171, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_137.pdf', '2026-06-02 14:03:42', '2026-06-02 14:03:42'),
(340, NULL, 172, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_138.pdf', '2026-06-02 14:04:39', '2026-06-02 14:04:39'),
(341, NULL, 173, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_139.pdf', '2026-06-02 14:05:26', '2026-06-02 14:05:26'),
(342, NULL, 174, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_140.pdf', '2026-06-02 14:06:29', '2026-06-02 14:06:29'),
(343, NULL, 175, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_141.pdf', '2026-06-02 14:07:22', '2026-06-02 14:07:22'),
(344, NULL, 176, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_142.pdf', '2026-06-02 14:08:13', '2026-06-02 14:08:13'),
(345, NULL, 177, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_143.pdf', '2026-06-02 14:08:58', '2026-06-02 14:08:58'),
(346, NULL, 178, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_144.pdf', '2026-06-02 14:09:44', '2026-06-02 14:09:44'),
(347, NULL, 179, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_145.pdf', '2026-06-02 14:10:38', '2026-06-02 14:10:38'),
(348, NULL, 180, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_146.pdf', '2026-06-02 14:11:31', '2026-06-02 14:11:31'),
(349, NULL, 181, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_147.pdf', '2026-06-02 14:12:16', '2026-06-02 14:12:16'),
(350, NULL, 182, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_148.pdf', '2026-06-02 14:13:05', '2026-06-02 14:13:05'),
(351, NULL, 183, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_149.pdf', '2026-06-02 14:13:54', '2026-06-02 14:13:54'),
(352, NULL, 184, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_150.pdf', '2026-06-02 14:15:08', '2026-06-02 14:15:08'),
(353, NULL, 185, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_151.pdf', '2026-06-02 14:16:01', '2026-06-02 14:16:01'),
(354, NULL, 186, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_152.pdf', '2026-06-02 14:16:45', '2026-06-02 14:16:45'),
(355, NULL, 187, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_153.pdf', '2026-06-02 14:21:19', '2026-06-02 14:21:19'),
(356, NULL, 188, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_154.pdf', '2026-06-02 14:23:52', '2026-06-02 14:23:52'),
(357, NULL, 189, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_155.pdf', '2026-06-02 14:24:40', '2026-06-02 14:24:40'),
(358, NULL, 190, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_156.pdf', '2026-06-02 14:25:47', '2026-06-02 14:25:47'),
(359, NULL, 191, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_157.pdf', '2026-06-02 14:26:35', '2026-06-02 14:26:35'),
(360, NULL, 192, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_158.pdf', '2026-06-02 14:27:37', '2026-06-02 14:27:37'),
(361, NULL, 193, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_159.pdf', '2026-06-02 14:28:21', '2026-06-02 14:28:21'),
(362, NULL, 194, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_160.pdf', '2026-06-02 14:29:05', '2026-06-02 14:29:05'),
(363, NULL, 195, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_161.pdf', '2026-06-02 14:29:42', '2026-06-02 14:29:42'),
(364, NULL, 196, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_162.pdf', '2026-06-02 14:31:00', '2026-06-02 14:31:00'),
(365, NULL, 197, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_163.pdf', '2026-06-02 15:32:06', '2026-06-02 15:32:06'),
(366, NULL, 198, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_164.pdf', '2026-06-02 15:33:00', '2026-06-02 15:33:00'),
(367, NULL, 199, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_165.pdf', '2026-06-02 15:33:57', '2026-06-02 15:33:57'),
(368, NULL, 200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_166.pdf', '2026-06-02 15:35:21', '2026-06-02 15:35:21'),
(369, NULL, 201, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_167.pdf', '2026-06-02 15:36:05', '2026-06-02 15:36:05'),
(370, NULL, 202, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_168.pdf', '2026-06-02 15:36:51', '2026-06-02 15:36:51'),
(371, NULL, 203, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_169.pdf', '2026-06-02 15:37:52', '2026-06-02 15:37:52'),
(372, NULL, 204, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_170.pdf', '2026-06-02 15:38:38', '2026-06-02 15:38:38'),
(373, NULL, 205, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_171.pdf', '2026-06-02 15:39:29', '2026-06-02 15:39:29'),
(374, NULL, 206, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_172.pdf', '2026-06-02 15:42:21', '2026-06-02 15:42:21'),
(375, NULL, 207, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_173.pdf', '2026-06-02 15:43:29', '2026-06-02 15:43:29'),
(376, NULL, 208, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_174.pdf', '2026-06-02 15:44:27', '2026-06-02 15:44:27'),
(377, NULL, 209, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_175.pdf', '2026-06-02 15:45:11', '2026-06-02 15:45:11'),
(378, NULL, 210, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_176.pdf', '2026-06-02 15:46:15', '2026-06-02 15:46:15'),
(379, NULL, 211, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_177.pdf', '2026-06-02 15:47:01', '2026-06-02 15:47:01'),
(380, NULL, 212, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_178.pdf', '2026-06-02 15:47:40', '2026-06-02 15:47:40'),
(382, NULL, 213, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_180.pdf', '2026-06-02 15:49:15', '2026-06-02 15:49:15'),
(383, NULL, 214, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_181.pdf', '2026-06-02 15:49:53', '2026-06-02 15:49:53'),
(384, NULL, 215, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_182.pdf', '2026-06-02 15:50:40', '2026-06-02 15:50:40'),
(385, NULL, 216, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_183.pdf', '2026-06-02 15:51:30', '2026-06-02 15:51:30'),
(386, NULL, 217, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_184.pdf', '2026-06-02 15:52:11', '2026-06-02 15:52:11'),
(387, NULL, 218, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_185.pdf', '2026-06-02 15:52:58', '2026-06-02 15:52:58'),
(388, NULL, 219, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_186.pdf', '2026-06-02 15:53:57', '2026-06-02 15:53:57'),
(389, NULL, 220, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_187.pdf', '2026-06-02 15:54:38', '2026-06-02 15:54:38'),
(390, NULL, 221, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_188.pdf', '2026-06-02 15:55:50', '2026-06-02 15:55:50'),
(391, NULL, 222, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_189.pdf', '2026-06-02 15:58:22', '2026-06-02 15:58:22'),
(392, NULL, 223, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_190.pdf', '2026-06-02 16:04:35', '2026-06-02 16:04:35'),
(393, NULL, 224, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_191.pdf', '2026-06-02 16:05:24', '2026-06-02 16:05:24'),
(394, NULL, 225, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_192.pdf', '2026-06-02 16:06:04', '2026-06-02 16:06:04'),
(395, NULL, 226, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_193.pdf', '2026-06-02 16:06:47', '2026-06-02 16:06:47'),
(396, NULL, 227, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_194.pdf', '2026-06-02 16:07:30', '2026-06-02 16:07:30'),
(397, NULL, 228, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_195.pdf', '2026-06-02 16:08:08', '2026-06-02 16:08:08'),
(398, NULL, 229, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_196.pdf', '2026-06-02 16:08:47', '2026-06-02 16:08:47');
INSERT INTO `file_upload` (`id`, `id_kontrak`, `id_cable`, `id_klaim_awal`, `id_klaim_akhir`, `id_doc_cargo`, `id_off_hire`, `id_on_hire`, `id_redelivery`, `id_delivery`, `nama_file`, `created_at`, `updated_at`) VALUES
(399, NULL, 230, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_197.pdf', '2026-06-02 16:09:25', '2026-06-02 16:09:25'),
(400, NULL, 231, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_198.pdf', '2026-06-02 16:10:24', '2026-06-02 16:10:24'),
(401, NULL, 232, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_199.pdf', '2026-06-02 16:12:37', '2026-06-02 16:12:37'),
(402, NULL, 233, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_200.pdf', '2026-06-02 16:13:13', '2026-06-02 16:13:13'),
(403, NULL, 234, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_201.pdf', '2026-06-02 16:13:59', '2026-06-02 16:13:59'),
(404, NULL, 235, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_202.pdf', '2026-06-02 16:14:50', '2026-06-02 16:14:50'),
(405, NULL, 236, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_203.pdf', '2026-06-02 16:17:11', '2026-06-02 16:17:11'),
(406, NULL, 237, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_204.pdf', '2026-06-02 16:18:08', '2026-06-02 16:18:08'),
(407, NULL, 238, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_205.pdf', '2026-06-02 16:20:09', '2026-06-02 16:20:09'),
(408, NULL, 239, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_206.pdf', '2026-06-02 16:20:47', '2026-06-02 16:20:47'),
(409, NULL, 240, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_207.pdf', '2026-06-02 16:21:23', '2026-06-02 16:21:23'),
(410, NULL, 241, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_208.pdf', '2026-06-02 16:22:01', '2026-06-02 16:22:01'),
(411, NULL, 242, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_209.pdf', '2026-06-02 16:22:49', '2026-06-02 16:22:49'),
(412, NULL, 243, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_210.pdf', '2026-06-02 17:32:42', '2026-06-02 17:32:42'),
(413, NULL, 244, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_211.pdf', '2026-06-02 17:33:37', '2026-06-02 17:33:37'),
(414, NULL, 245, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_212.pdf', '2026-06-02 17:34:30', '2026-06-02 17:34:30'),
(415, NULL, 246, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_213.pdf', '2026-06-02 17:35:29', '2026-06-02 17:35:29'),
(416, NULL, 247, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_214.pdf', '2026-06-02 17:36:39', '2026-06-02 17:36:39'),
(417, NULL, 248, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_215.pdf', '2026-06-02 17:37:46', '2026-06-02 17:37:46'),
(418, NULL, 249, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_216.pdf', '2026-06-02 17:38:37', '2026-06-02 17:38:37'),
(419, NULL, 250, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_217.pdf', '2026-06-02 17:39:23', '2026-06-02 17:39:23'),
(420, NULL, 251, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_218.pdf', '2026-06-02 17:40:11', '2026-06-02 17:40:11'),
(421, NULL, 252, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_219.pdf', '2026-06-02 17:41:02', '2026-06-02 17:41:02'),
(422, NULL, 253, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_220.pdf', '2026-06-02 17:41:53', '2026-06-02 17:41:53'),
(423, NULL, 254, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_221.pdf', '2026-06-02 23:33:34', '2026-06-02 23:33:34'),
(424, NULL, 255, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_222.pdf', '2026-06-02 23:34:34', '2026-06-02 23:34:34'),
(426, NULL, 257, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_223.pdf', '2026-06-02 23:38:16', '2026-06-02 23:38:16'),
(427, NULL, 258, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_224.pdf', '2026-06-02 23:39:22', '2026-06-02 23:39:22'),
(428, NULL, 259, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_225.pdf', '2026-06-03 00:13:08', '2026-06-03 00:13:08'),
(429, NULL, 260, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_226.pdf', '2026-06-03 00:13:49', '2026-06-03 00:13:49'),
(430, NULL, 261, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_227.pdf', '2026-06-03 00:14:35', '2026-06-03 00:14:35'),
(431, NULL, 262, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_228.pdf', '2026-06-03 00:15:21', '2026-06-03 00:15:21'),
(432, NULL, 263, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_229.pdf', '2026-06-03 00:16:13', '2026-06-03 00:16:13'),
(433, NULL, 264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_230.pdf', '2026-06-03 00:34:53', '2026-06-03 00:34:53'),
(434, NULL, 265, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_231.pdf', '2026-06-03 00:36:44', '2026-06-03 00:36:44'),
(435, NULL, 266, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_232.pdf', '2026-06-03 00:38:23', '2026-06-03 00:38:23'),
(436, NULL, 267, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_233.pdf', '2026-06-03 00:39:10', '2026-06-03 00:39:10'),
(437, NULL, 268, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_234.pdf', '2026-06-03 00:40:26', '2026-06-03 00:40:26'),
(438, NULL, 269, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_235.pdf', '2026-06-03 00:41:15', '2026-06-03 00:41:15'),
(439, NULL, 270, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_236.pdf', '2026-06-03 00:42:27', '2026-06-03 00:42:27'),
(440, NULL, 271, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_237.pdf', '2026-06-03 00:49:29', '2026-06-03 00:49:29'),
(441, NULL, 272, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_238.pdf', '2026-06-03 00:50:17', '2026-06-03 00:50:17'),
(442, NULL, 273, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_239.pdf', '2026-06-03 00:51:57', '2026-06-03 00:51:57'),
(443, NULL, 274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_240.pdf', '2026-06-03 00:53:32', '2026-06-03 00:53:32'),
(444, NULL, 275, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_241.pdf', '2026-06-03 00:55:38', '2026-06-03 00:55:38'),
(445, NULL, 276, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_242.pdf', '2026-06-03 00:56:57', '2026-06-03 00:56:57'),
(446, NULL, 277, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_243.pdf', '2026-06-03 01:03:14', '2026-06-03 01:03:14'),
(447, NULL, 278, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_244.pdf', '2026-06-03 01:09:11', '2026-06-03 01:09:11'),
(448, NULL, 279, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_245.pdf', '2026-06-03 01:10:09', '2026-06-03 01:10:09'),
(449, NULL, 280, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_246.pdf', '2026-06-03 02:36:41', '2026-06-03 02:36:41'),
(450, NULL, 281, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_247.pdf', '2026-06-03 02:37:28', '2026-06-03 02:37:28'),
(451, NULL, 282, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_248.pdf', '2026-06-03 02:38:24', '2026-06-03 02:38:24'),
(452, NULL, 283, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_249.pdf', '2026-06-03 02:39:31', '2026-06-03 02:39:31'),
(454, NULL, 285, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_250.pdf', '2026-06-03 02:45:15', '2026-06-03 02:45:15'),
(455, NULL, 286, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_251.pdf', '2026-06-03 02:46:15', '2026-06-03 02:46:15'),
(456, NULL, 287, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_252.pdf', '2026-06-03 02:50:10', '2026-06-03 02:50:10'),
(457, NULL, 288, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_253.pdf', '2026-06-03 02:50:58', '2026-06-03 02:50:58'),
(458, NULL, 289, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_254.pdf', '2026-06-03 02:51:46', '2026-06-03 02:51:46'),
(459, NULL, 290, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_255.pdf', '2026-06-03 02:52:42', '2026-06-03 02:52:42'),
(460, NULL, 291, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_256.pdf', '2026-06-03 02:56:36', '2026-06-03 02:56:36'),
(461, NULL, 292, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_257.pdf', '2026-06-03 02:57:36', '2026-06-03 02:57:36'),
(462, NULL, 293, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_258.pdf', '2026-06-03 03:08:17', '2026-06-03 03:08:17'),
(463, NULL, 294, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_259.pdf', '2026-06-03 03:09:54', '2026-06-03 03:09:54'),
(464, NULL, 295, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_260.pdf', '2026-06-03 03:12:22', '2026-06-03 03:12:22'),
(465, NULL, 296, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_261.pdf', '2026-06-03 03:15:05', '2026-06-03 03:15:05'),
(466, NULL, 297, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_262.pdf', '2026-06-03 03:16:37', '2026-06-03 03:16:37'),
(467, NULL, 298, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_263.pdf', '2026-06-03 03:34:48', '2026-06-03 03:34:48'),
(468, NULL, 299, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_264.pdf', '2026-06-03 03:35:51', '2026-06-03 03:35:51'),
(469, NULL, 300, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_265.pdf', '2026-06-03 03:38:04', '2026-06-03 03:38:04'),
(470, NULL, 301, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_266.pdf', '2026-06-03 03:38:52', '2026-06-03 03:38:52'),
(471, NULL, 302, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_267.pdf', '2026-06-03 03:43:02', '2026-06-03 03:43:02'),
(472, NULL, 303, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_268.pdf', '2026-06-03 03:47:02', '2026-06-03 03:47:02'),
(473, NULL, 304, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_269.pdf', '2026-06-03 03:55:34', '2026-06-03 03:55:34'),
(474, NULL, 305, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_270.pdf', '2026-06-03 03:56:13', '2026-06-03 03:56:13'),
(475, NULL, 306, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_271.pdf', '2026-06-03 04:28:29', '2026-06-03 04:28:29'),
(476, NULL, 307, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_272.pdf', '2026-06-03 04:29:33', '2026-06-03 04:29:33'),
(477, NULL, 308, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_273.pdf', '2026-06-03 04:32:30', '2026-06-03 04:32:30'),
(478, NULL, 309, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_274.pdf', '2026-06-03 04:33:20', '2026-06-03 04:33:20'),
(479, NULL, 310, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_275.pdf', '2026-06-03 04:34:13', '2026-06-03 04:34:13'),
(480, NULL, 311, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_276.pdf', '2026-06-03 04:39:00', '2026-06-03 04:39:00'),
(481, NULL, 312, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_277.pdf', '2026-06-03 04:39:46', '2026-06-03 04:39:46'),
(482, NULL, 313, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_278.pdf', '2026-06-03 04:40:34', '2026-06-03 04:40:34'),
(483, NULL, 314, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_279.pdf', '2026-06-03 04:41:28', '2026-06-03 04:41:28'),
(484, NULL, 315, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_280.pdf', '2026-06-03 04:42:22', '2026-06-03 04:42:22'),
(485, NULL, 316, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_281.pdf', '2026-06-03 04:43:21', '2026-06-03 04:43:21'),
(486, NULL, 317, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_282.pdf', '2026-06-03 04:44:15', '2026-06-03 04:44:15'),
(487, NULL, 318, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_283.pdf', '2026-06-03 04:45:02', '2026-06-03 04:45:02'),
(488, NULL, 319, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_284.pdf', '2026-06-03 04:45:48', '2026-06-03 04:45:48'),
(489, NULL, 320, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_285.pdf', '2026-06-03 04:46:28', '2026-06-03 04:46:28'),
(490, NULL, 321, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_286.pdf', '2026-06-03 04:47:09', '2026-06-03 04:47:09'),
(491, NULL, 322, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_287.pdf', '2026-06-03 04:47:59', '2026-06-03 04:47:59'),
(492, NULL, 323, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_288.pdf', '2026-06-03 04:56:38', '2026-06-03 04:56:38'),
(493, NULL, 324, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_289.pdf', '2026-06-03 04:58:57', '2026-06-03 04:58:57'),
(494, NULL, 325, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_290.pdf', '2026-06-03 05:05:08', '2026-06-03 05:05:08'),
(495, NULL, 326, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_291.pdf', '2026-06-03 05:05:39', '2026-06-03 05:05:39'),
(496, NULL, 327, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_292.pdf', '2026-06-03 05:07:27', '2026-06-03 05:07:27'),
(497, NULL, 328, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_293.pdf', '2026-06-03 05:08:52', '2026-06-03 05:08:52'),
(498, NULL, 329, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_294.pdf', '2026-06-03 05:09:58', '2026-06-03 05:09:58'),
(499, NULL, 330, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_295.pdf', '2026-06-03 05:11:12', '2026-06-03 05:11:12'),
(500, NULL, 331, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_296.pdf', '2026-06-03 05:12:10', '2026-06-03 05:12:10'),
(501, NULL, 332, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_297.pdf', '2026-06-03 05:13:48', '2026-06-03 05:13:48'),
(502, NULL, 333, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_298.pdf', '2026-06-03 05:27:06', '2026-06-03 05:27:06'),
(503, NULL, 334, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_299.pdf', '2026-06-03 05:29:48', '2026-06-03 05:29:48'),
(504, NULL, 335, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_300.pdf', '2026-06-03 05:31:05', '2026-06-03 05:31:05'),
(505, NULL, 336, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_301.pdf', '2026-06-03 05:31:58', '2026-06-03 05:31:58'),
(506, NULL, 337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_302.pdf', '2026-06-03 05:32:58', '2026-06-03 05:32:58'),
(508, NULL, 339, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_179.pdf', '2026-06-03 05:46:10', '2026-06-03 05:46:10'),
(509, NULL, 340, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_303.pdf', '2026-06-03 05:47:06', '2026-06-03 05:47:06'),
(510, NULL, 341, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_304.pdf', '2026-06-03 05:48:00', '2026-06-03 05:48:00'),
(511, NULL, 342, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_305.pdf', '2026-06-03 05:49:15', '2026-06-03 05:49:15'),
(512, NULL, 343, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_306.pdf', '2026-06-03 05:51:17', '2026-06-03 05:51:17'),
(513, NULL, 344, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_307.pdf', '2026-06-03 05:52:24', '2026-06-03 05:52:24'),
(514, NULL, 345, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_308.pdf', '2026-06-03 05:56:08', '2026-06-03 05:56:08'),
(515, NULL, 346, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_309.pdf', '2026-06-03 05:56:49', '2026-06-03 05:56:49'),
(516, NULL, 347, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_310.pdf', '2026-06-03 05:57:35', '2026-06-03 05:57:35'),
(517, NULL, 348, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_311.pdf', '2026-06-03 05:58:26', '2026-06-03 05:58:26'),
(518, NULL, 349, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_312.pdf', '2026-06-03 06:00:37', '2026-06-03 06:00:37'),
(519, NULL, 350, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_313.pdf', '2026-06-03 06:01:23', '2026-06-03 06:01:23'),
(520, NULL, 351, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_314.pdf', '2026-06-03 06:02:14', '2026-06-03 06:02:14'),
(521, NULL, 352, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_315.pdf', '2026-06-03 06:03:20', '2026-06-03 06:03:20'),
(522, NULL, 353, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_316.pdf', '2026-06-03 06:04:28', '2026-06-03 06:04:28'),
(523, NULL, 354, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_317.pdf', '2026-06-03 06:05:13', '2026-06-03 06:05:13'),
(526, NULL, 357, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_318.pdf', '2026-06-03 06:16:45', '2026-06-03 06:16:45'),
(527, NULL, 358, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_319.pdf', '2026-06-03 06:17:53', '2026-06-03 06:17:53'),
(528, NULL, 359, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_320.pdf', '2026-06-03 06:19:51', '2026-06-03 06:19:51'),
(529, NULL, 360, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_321.pdf', '2026-06-03 06:21:40', '2026-06-03 06:21:40'),
(531, NULL, 362, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_322.pdf', '2026-06-03 06:27:26', '2026-06-03 06:27:26'),
(532, NULL, 363, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_323.pdf', '2026-06-03 06:28:49', '2026-06-03 06:28:49'),
(533, NULL, 364, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_324.pdf', '2026-06-03 06:29:40', '2026-06-03 06:29:40'),
(534, NULL, 365, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_325.pdf', '2026-06-03 06:30:56', '2026-06-03 06:30:56'),
(535, NULL, 366, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_326.pdf', '2026-06-03 06:35:12', '2026-06-03 06:35:12'),
(536, NULL, 367, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_327.pdf', '2026-06-03 06:36:16', '2026-06-03 06:36:16'),
(537, NULL, 368, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_328.pdf', '2026-06-03 06:37:16', '2026-06-03 06:37:16'),
(538, NULL, 369, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_329.pdf', '2026-06-03 06:38:04', '2026-06-03 06:38:04'),
(539, NULL, 370, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_330.pdf', '2026-06-03 06:39:18', '2026-06-03 06:39:18'),
(540, NULL, 371, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_331.pdf', '2026-06-03 06:40:04', '2026-06-03 06:40:04'),
(541, NULL, 372, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_332.pdf', '2026-06-03 06:40:47', '2026-06-03 06:40:47'),
(542, NULL, 373, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_333.pdf', '2026-06-03 06:41:31', '2026-06-03 06:41:31'),
(543, NULL, 374, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_334.pdf', '2026-06-03 06:42:10', '2026-06-03 06:42:10'),
(544, NULL, 375, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_335.pdf', '2026-06-03 06:43:45', '2026-06-03 06:43:45'),
(545, NULL, 376, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_336.pdf', '2026-06-03 06:45:14', '2026-06-03 06:45:14'),
(546, NULL, 377, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_337.pdf', '2026-06-03 06:46:08', '2026-06-03 06:46:08'),
(547, NULL, 378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_338.pdf', '2026-06-03 07:05:55', '2026-06-03 07:05:55'),
(548, NULL, 379, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_339.pdf', '2026-06-03 07:09:12', '2026-06-03 07:09:12'),
(549, NULL, 380, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_340.pdf', '2026-06-03 07:10:22', '2026-06-03 07:10:22'),
(550, NULL, 381, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_341.pdf', '2026-06-03 07:11:06', '2026-06-03 07:11:06'),
(551, NULL, 382, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_342.pdf', '2026-06-03 07:11:53', '2026-06-03 07:11:53'),
(552, NULL, 383, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_343.pdf', '2026-06-03 07:12:42', '2026-06-03 07:12:42'),
(553, NULL, 384, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_344.pdf', '2026-06-03 07:13:30', '2026-06-03 07:13:30'),
(554, NULL, 385, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_345.pdf', '2026-06-03 07:16:32', '2026-06-03 07:16:32'),
(555, NULL, 386, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_346.pdf', '2026-06-03 07:17:29', '2026-06-03 07:17:29'),
(556, NULL, 387, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_347.pdf', '2026-06-03 07:18:32', '2026-06-03 07:18:32'),
(557, NULL, 388, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_348.pdf', '2026-06-03 07:19:19', '2026-06-03 07:19:19'),
(558, NULL, 389, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_349.pdf', '2026-06-03 07:20:00', '2026-06-03 07:20:00'),
(559, NULL, 390, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_350.pdf', '2026-06-03 07:20:52', '2026-06-03 07:20:52'),
(560, NULL, 391, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_351.pdf', '2026-06-03 07:21:36', '2026-06-03 07:21:36'),
(561, NULL, 392, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_352.pdf', '2026-06-03 07:22:46', '2026-06-03 07:22:46'),
(562, NULL, 393, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_353.pdf', '2026-06-03 07:23:33', '2026-06-03 07:23:33'),
(563, NULL, 394, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_354.pdf', '2026-06-03 07:24:23', '2026-06-03 07:24:23'),
(564, NULL, 395, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_355.pdf', '2026-06-03 07:25:01', '2026-06-03 07:25:01'),
(565, NULL, 396, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_356.pdf', '2026-06-03 07:25:54', '2026-06-03 07:25:54'),
(566, NULL, 397, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_357.pdf', '2026-06-03 07:26:46', '2026-06-03 07:26:46'),
(567, NULL, 398, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_358.pdf', '2026-06-03 07:46:56', '2026-06-03 07:46:56'),
(568, NULL, 399, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_359.pdf', '2026-06-03 07:47:54', '2026-06-03 07:47:54'),
(569, NULL, 400, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_360.pdf', '2026-06-03 07:50:44', '2026-06-03 07:50:44'),
(570, NULL, 401, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_361.pdf', '2026-06-03 07:53:06', '2026-06-03 07:53:06'),
(571, NULL, 402, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_362.pdf', '2026-06-03 07:53:54', '2026-06-03 07:53:54'),
(572, NULL, 403, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_363.pdf', '2026-06-03 07:55:22', '2026-06-03 07:55:22'),
(573, NULL, 404, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_364.pdf', '2026-06-03 07:56:04', '2026-06-03 07:56:04'),
(574, NULL, 405, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_365.pdf', '2026-06-03 07:56:58', '2026-06-03 07:56:58'),
(575, NULL, 406, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_366.pdf', '2026-06-03 07:57:39', '2026-06-03 07:57:39'),
(576, NULL, 407, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_367.pdf', '2026-06-03 07:59:20', '2026-06-03 07:59:20'),
(577, NULL, 408, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_368.pdf', '2026-06-03 08:00:24', '2026-06-03 08:00:24'),
(578, NULL, 409, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_369.pdf', '2026-06-03 08:01:05', '2026-06-03 08:01:05'),
(579, NULL, 410, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_370.pdf', '2026-06-03 08:02:08', '2026-06-03 08:02:08'),
(580, NULL, 411, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_371.pdf', '2026-06-03 08:03:03', '2026-06-03 08:03:03'),
(581, NULL, 412, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_372.pdf', '2026-06-03 08:03:46', '2026-06-03 08:03:46'),
(582, NULL, 413, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_373.pdf', '2026-06-03 08:04:22', '2026-06-03 08:04:22'),
(583, NULL, 414, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_374.pdf', '2026-06-03 08:06:02', '2026-06-03 08:06:02'),
(584, NULL, 415, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_375.pdf', '2026-06-03 08:06:46', '2026-06-03 08:06:46'),
(585, NULL, 416, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_376.pdf', '2026-06-03 08:08:47', '2026-06-03 08:08:47'),
(586, NULL, 417, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_377.pdf', '2026-06-03 08:09:35', '2026-06-03 08:09:35'),
(587, NULL, 418, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_378.pdf', '2026-06-03 08:10:17', '2026-06-03 08:10:17'),
(588, NULL, 419, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_379.pdf', '2026-06-03 08:10:51', '2026-06-03 08:10:51'),
(589, NULL, 420, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_380.pdf', '2026-06-03 08:11:58', '2026-06-03 08:11:58'),
(590, NULL, 421, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_381.pdf', '2026-06-03 08:12:32', '2026-06-03 08:12:32'),
(591, NULL, 422, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_382.pdf', '2026-06-03 08:13:11', '2026-06-03 08:13:11'),
(592, NULL, 423, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_383.pdf', '2026-06-03 08:13:56', '2026-06-03 08:13:56'),
(593, NULL, 424, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_384.pdf', '2026-06-03 08:14:44', '2026-06-03 08:14:44'),
(594, NULL, 425, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_385.pdf', '2026-06-03 08:15:24', '2026-06-03 08:15:24'),
(595, NULL, 426, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_386.pdf', '2026-06-03 08:16:04', '2026-06-03 08:16:04'),
(596, NULL, 427, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_387.pdf', '2026-06-03 08:16:56', '2026-06-03 08:16:56'),
(597, NULL, 428, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_388.pdf', '2026-06-03 08:18:12', '2026-06-03 08:18:12'),
(598, NULL, 429, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_389.pdf', '2026-06-03 08:18:51', '2026-06-03 08:18:51'),
(599, NULL, 430, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_390.pdf', '2026-06-03 08:19:41', '2026-06-03 08:19:41'),
(600, NULL, 431, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_391.pdf', '2026-06-03 08:22:12', '2026-06-03 08:22:12'),
(601, NULL, 432, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_392.pdf', '2026-06-03 08:22:59', '2026-06-03 08:22:59'),
(602, NULL, 433, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_393.pdf', '2026-06-03 08:45:45', '2026-06-03 08:45:45'),
(603, NULL, 434, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_394.pdf', '2026-06-03 08:47:38', '2026-06-03 08:47:38'),
(604, NULL, 435, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_395.pdf', '2026-06-03 08:48:13', '2026-06-03 08:48:13'),
(605, NULL, 436, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_396.pdf', '2026-06-03 08:48:54', '2026-06-03 08:48:54'),
(606, NULL, 437, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_397.pdf', '2026-06-03 08:49:47', '2026-06-03 08:49:47'),
(607, NULL, 438, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_398.pdf', '2026-06-03 08:50:47', '2026-06-03 08:50:47'),
(608, NULL, 439, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_399.pdf', '2026-06-03 08:51:45', '2026-06-03 08:51:45'),
(609, NULL, 440, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_400.pdf', '2026-06-03 08:54:49', '2026-06-03 08:54:49'),
(610, NULL, 441, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_401.pdf', '2026-06-03 08:55:48', '2026-06-03 08:55:48'),
(611, NULL, 442, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_402.pdf', '2026-06-03 08:57:16', '2026-06-03 08:57:16'),
(612, NULL, 443, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_403.pdf', '2026-06-03 09:01:00', '2026-06-03 09:01:00'),
(613, NULL, 444, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_404.pdf', '2026-06-03 09:01:51', '2026-06-03 09:01:51'),
(614, NULL, 445, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_405.pdf', '2026-06-03 09:02:45', '2026-06-03 09:02:45'),
(615, NULL, 446, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_406.pdf', '2026-06-03 09:03:34', '2026-06-03 09:03:34'),
(616, NULL, 447, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_407.pdf', '2026-06-03 09:04:20', '2026-06-03 09:04:20'),
(617, NULL, 448, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_408.pdf', '2026-06-03 09:05:53', '2026-06-03 09:05:53'),
(618, NULL, 449, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_409.pdf', '2026-06-03 09:06:40', '2026-06-03 09:06:40'),
(619, NULL, 450, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_410.pdf', '2026-06-03 09:07:51', '2026-06-03 09:07:51'),
(620, NULL, 451, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_411.pdf', '2026-06-03 09:09:38', '2026-06-03 09:09:38'),
(621, NULL, 452, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_412.pdf', '2026-06-03 09:12:15', '2026-06-03 09:12:15'),
(622, NULL, 453, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_413.pdf', '2026-06-03 09:12:54', '2026-06-03 09:12:54'),
(623, NULL, 454, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_414.pdf', '2026-06-03 09:15:32', '2026-06-03 09:15:32'),
(624, NULL, 455, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_415.pdf', '2026-06-03 09:17:21', '2026-06-03 09:17:21'),
(625, NULL, 456, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_416.pdf', '2026-06-03 09:18:06', '2026-06-03 09:18:06'),
(626, NULL, 457, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_417.pdf', '2026-06-03 09:19:18', '2026-06-03 09:19:18'),
(627, NULL, 458, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_418.pdf', '2026-06-03 09:20:12', '2026-06-03 09:20:12'),
(628, NULL, 459, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_419.pdf', '2026-06-03 09:21:20', '2026-06-03 09:21:20'),
(629, NULL, 460, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_420.pdf', '2026-06-03 09:22:20', '2026-06-03 09:22:20'),
(630, NULL, 461, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_421.pdf', '2026-06-03 09:22:55', '2026-06-03 09:22:55'),
(631, NULL, 462, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_422.pdf', '2026-06-03 09:23:42', '2026-06-03 09:23:42'),
(632, NULL, 463, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_423.pdf', '2026-06-03 09:24:49', '2026-06-03 09:24:49'),
(633, NULL, 464, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_424.pdf', '2026-06-03 09:25:26', '2026-06-03 09:25:26'),
(634, NULL, 465, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_425.pdf', '2026-06-03 09:26:04', '2026-06-03 09:26:04'),
(635, NULL, 466, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_426.pdf', '2026-06-03 09:26:55', '2026-06-03 09:26:55'),
(636, NULL, 467, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_427.pdf', '2026-06-03 09:27:39', '2026-06-03 09:27:39'),
(637, NULL, 468, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_428.pdf', '2026-06-03 09:28:37', '2026-06-03 09:28:37'),
(638, NULL, 469, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_429.pdf', '2026-06-03 09:29:13', '2026-06-03 09:29:13'),
(639, NULL, 470, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_430.pdf', '2026-06-03 09:30:22', '2026-06-03 09:30:22'),
(640, NULL, 471, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_431.pdf', '2026-06-03 09:31:30', '2026-06-03 09:31:30'),
(641, NULL, 472, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_432.pdf', '2026-06-03 09:32:32', '2026-06-03 09:32:32'),
(642, NULL, 473, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_433.pdf', '2026-06-03 09:35:30', '2026-06-03 09:35:30'),
(644, NULL, 475, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_434.pdf', '2026-06-03 09:38:21', '2026-06-03 09:38:21'),
(645, NULL, 476, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_435.pdf', '2026-06-03 09:39:07', '2026-06-03 09:39:07'),
(646, NULL, 477, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_436.pdf', '2026-06-03 09:39:46', '2026-06-03 09:39:46'),
(647, NULL, 478, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_437.pdf', '2026-06-03 09:40:26', '2026-06-03 09:40:26'),
(648, NULL, 479, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_438.pdf', '2026-06-03 09:43:40', '2026-06-03 09:43:40'),
(649, NULL, 480, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_439.pdf', '2026-06-03 09:44:24', '2026-06-03 09:44:24'),
(650, NULL, 481, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_440.pdf', '2026-06-03 09:45:40', '2026-06-03 09:45:40'),
(651, NULL, 482, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_441.pdf', '2026-06-03 09:47:43', '2026-06-03 09:47:43'),
(652, NULL, 483, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_442.pdf', '2026-06-03 09:48:26', '2026-06-03 09:48:26'),
(653, NULL, 484, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_443.pdf', '2026-06-03 09:53:35', '2026-06-03 09:53:35'),
(654, NULL, 485, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_444.pdf', '2026-06-03 09:57:25', '2026-06-03 09:57:25'),
(655, NULL, 486, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_445.pdf', '2026-06-03 09:58:37', '2026-06-03 09:58:37'),
(656, NULL, 487, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_446.pdf', '2026-06-03 10:02:45', '2026-06-03 10:02:45'),
(657, NULL, 488, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_447.pdf', '2026-06-03 10:03:48', '2026-06-03 10:03:48'),
(658, NULL, 489, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_448.pdf', '2026-06-03 10:04:53', '2026-06-03 10:04:53'),
(659, NULL, 490, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_449.pdf', '2026-06-03 10:08:53', '2026-06-03 10:08:53'),
(660, NULL, 491, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_450.pdf', '2026-06-03 10:09:37', '2026-06-03 10:09:37'),
(661, NULL, 492, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_451.pdf', '2026-06-03 10:10:26', '2026-06-03 10:10:26'),
(662, NULL, 493, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_452.pdf', '2026-06-03 10:12:13', '2026-06-03 10:12:13'),
(663, NULL, 494, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_453.pdf', '2026-06-03 10:12:52', '2026-06-03 10:12:52'),
(664, NULL, 495, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_454.pdf', '2026-06-03 10:13:39', '2026-06-03 10:13:39'),
(665, NULL, 496, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_455.pdf', '2026-06-03 10:15:37', '2026-06-03 10:15:37'),
(666, NULL, 497, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_456.pdf', '2026-06-03 10:16:18', '2026-06-03 10:16:18'),
(667, NULL, 498, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_457.pdf', '2026-06-03 10:55:36', '2026-06-03 10:55:36'),
(668, NULL, 499, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_458.pdf', '2026-06-03 10:56:21', '2026-06-03 10:56:21'),
(669, NULL, 500, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_459.pdf', '2026-06-03 10:57:16', '2026-06-03 10:57:16'),
(670, NULL, 501, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_460.pdf', '2026-06-03 10:58:38', '2026-06-03 10:58:38'),
(671, NULL, 502, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_461.pdf', '2026-06-03 11:01:05', '2026-06-03 11:01:05'),
(672, NULL, 503, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_462.pdf', '2026-06-03 11:02:53', '2026-06-03 11:02:53'),
(673, NULL, 504, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_463.pdf', '2026-06-03 11:03:48', '2026-06-03 11:03:48'),
(674, NULL, 505, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_464.pdf', '2026-06-03 11:05:20', '2026-06-03 11:05:20'),
(675, NULL, 506, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_465.pdf', '2026-06-03 11:22:36', '2026-06-03 11:22:36'),
(676, NULL, 507, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_466.pdf', '2026-06-03 11:24:06', '2026-06-03 11:24:06'),
(677, NULL, 508, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_467.pdf', '2026-06-03 11:24:49', '2026-06-03 11:24:49'),
(678, NULL, 509, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_468.pdf', '2026-06-03 11:25:23', '2026-06-03 11:25:23'),
(679, NULL, 510, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_469.pdf', '2026-06-03 11:26:02', '2026-06-03 11:26:02'),
(680, NULL, 511, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_470.pdf', '2026-06-03 11:26:52', '2026-06-03 11:26:52'),
(681, NULL, 512, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_471.pdf', '2026-06-03 11:27:44', '2026-06-03 11:27:44'),
(682, NULL, 513, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_472.pdf', '2026-06-03 11:28:28', '2026-06-03 11:28:28'),
(683, NULL, 514, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_473.pdf', '2026-06-03 11:29:14', '2026-06-03 11:29:14'),
(684, NULL, 515, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_474.pdf', '2026-06-03 11:30:00', '2026-06-03 11:30:00'),
(685, NULL, 516, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_475.pdf', '2026-06-03 11:30:52', '2026-06-03 11:30:52'),
(686, NULL, 517, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_476.pdf', '2026-06-03 11:32:12', '2026-06-03 11:32:12'),
(687, NULL, 518, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_477.pdf', '2026-06-03 11:33:14', '2026-06-03 11:33:14'),
(688, NULL, 519, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_478.pdf', '2026-06-03 11:34:15', '2026-06-03 11:34:15'),
(689, NULL, 520, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_479.pdf', '2026-06-03 11:35:12', '2026-06-03 11:35:12'),
(690, NULL, 521, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_480.pdf', '2026-06-03 11:35:58', '2026-06-03 11:35:58'),
(691, NULL, 522, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_481.pdf', '2026-06-03 11:36:46', '2026-06-03 11:36:46'),
(692, NULL, 523, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_482.pdf', '2026-06-03 11:37:25', '2026-06-03 11:37:25'),
(693, NULL, 524, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_483.pdf', '2026-06-03 11:38:16', '2026-06-03 11:38:16'),
(694, NULL, 525, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_484.pdf', '2026-06-03 11:38:56', '2026-06-03 11:38:56'),
(695, NULL, 526, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_485.pdf', '2026-06-03 11:39:42', '2026-06-03 11:39:42'),
(696, NULL, 527, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_486.pdf', '2026-06-03 11:40:42', '2026-06-03 11:40:42'),
(697, NULL, 528, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_487.pdf', '2026-06-03 11:41:26', '2026-06-03 11:41:26'),
(698, NULL, 529, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_488.pdf', '2026-06-03 11:42:12', '2026-06-03 11:42:12'),
(699, NULL, 530, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_489.pdf', '2026-06-03 11:43:21', '2026-06-03 11:43:21'),
(700, NULL, 531, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_490.pdf', '2026-06-03 11:46:21', '2026-06-03 11:46:21'),
(701, NULL, 532, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_491.pdf', '2026-06-03 11:48:08', '2026-06-03 11:48:08'),
(702, NULL, 533, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_492.pdf', '2026-06-03 11:48:59', '2026-06-03 11:48:59'),
(703, NULL, 534, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_493.pdf', '2026-06-03 11:49:55', '2026-06-03 11:49:55'),
(704, NULL, 535, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_494.pdf', '2026-06-03 11:54:05', '2026-06-03 11:54:05'),
(705, NULL, 536, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_495.pdf', '2026-06-03 11:55:00', '2026-06-03 11:55:00'),
(706, NULL, 537, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_496.pdf', '2026-06-03 11:56:06', '2026-06-03 11:56:06'),
(707, NULL, 538, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_497.pdf', '2026-06-03 11:59:23', '2026-06-03 11:59:23'),
(708, NULL, 539, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_498.pdf', '2026-06-03 12:01:52', '2026-06-03 12:01:52'),
(709, NULL, 540, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_499.pdf', '2026-06-03 12:02:56', '2026-06-03 12:02:56'),
(711, NULL, 542, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_500.pdf', '2026-06-03 12:05:56', '2026-06-03 12:05:56'),
(712, NULL, 543, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_501.pdf', '2026-06-03 12:06:38', '2026-06-03 12:06:38'),
(713, NULL, 544, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_502.pdf', '2026-06-03 12:07:22', '2026-06-03 12:07:22'),
(714, NULL, 545, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_503.pdf', '2026-06-03 12:08:01', '2026-06-03 12:08:01'),
(715, NULL, 546, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_504.pdf', '2026-06-03 12:10:04', '2026-06-03 12:10:04'),
(716, NULL, 547, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_505.pdf', '2026-06-03 12:10:57', '2026-06-03 12:10:57'),
(717, NULL, 548, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_506.pdf', '2026-06-03 12:11:48', '2026-06-03 12:11:48');
INSERT INTO `file_upload` (`id`, `id_kontrak`, `id_cable`, `id_klaim_awal`, `id_klaim_akhir`, `id_doc_cargo`, `id_off_hire`, `id_on_hire`, `id_redelivery`, `id_delivery`, `nama_file`, `created_at`, `updated_at`) VALUES
(718, NULL, 549, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_507.pdf', '2026-06-03 12:40:55', '2026-06-03 12:40:55'),
(719, NULL, 550, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_508.pdf', '2026-06-03 12:42:30', '2026-06-03 12:42:30'),
(720, NULL, 551, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_509.pdf', '2026-06-03 12:44:37', '2026-06-03 12:44:37'),
(721, NULL, 552, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_510.pdf', '2026-06-03 12:48:05', '2026-06-03 12:48:05'),
(722, NULL, 553, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_511.pdf', '2026-06-03 12:48:55', '2026-06-03 12:48:55'),
(723, NULL, 554, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_512.pdf', '2026-06-03 12:49:35', '2026-06-03 12:49:35'),
(724, NULL, 555, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_513.pdf', '2026-06-03 12:51:35', '2026-06-03 12:51:35'),
(725, NULL, 556, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_514.pdf', '2026-06-03 12:52:25', '2026-06-03 12:52:25'),
(726, NULL, 557, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_515.pdf', '2026-06-03 12:53:07', '2026-06-03 12:53:07'),
(727, NULL, 558, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_516.pdf', '2026-06-03 12:53:57', '2026-06-03 12:53:57'),
(728, NULL, 559, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_517.pdf', '2026-06-03 12:54:40', '2026-06-03 12:54:40'),
(729, NULL, 560, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_518.pdf', '2026-06-03 12:55:21', '2026-06-03 12:55:21'),
(730, NULL, 561, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_519.pdf', '2026-06-03 12:57:12', '2026-06-03 12:57:12'),
(731, NULL, 562, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_520.pdf', '2026-06-03 12:58:08', '2026-06-03 12:58:08'),
(732, NULL, 563, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_521.pdf', '2026-06-03 12:58:53', '2026-06-03 12:58:53'),
(733, NULL, 564, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_522.pdf', '2026-06-03 13:00:06', '2026-06-03 13:00:06'),
(734, NULL, 565, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_523.pdf', '2026-06-03 13:00:56', '2026-06-03 13:00:56'),
(735, NULL, 566, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_524.pdf', '2026-06-03 13:01:42', '2026-06-03 13:01:42'),
(736, NULL, 567, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_525.pdf', '2026-06-03 13:02:52', '2026-06-03 13:02:52'),
(737, NULL, 568, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_526.pdf', '2026-06-03 13:03:31', '2026-06-03 13:03:31'),
(738, NULL, 569, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_527.pdf', '2026-06-03 13:04:16', '2026-06-03 13:04:16'),
(739, NULL, 570, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_528.pdf', '2026-06-03 13:05:13', '2026-06-03 13:05:13'),
(740, NULL, 571, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_529.pdf', '2026-06-03 13:06:57', '2026-06-03 13:06:57'),
(741, NULL, 572, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_530.pdf', '2026-06-03 13:08:25', '2026-06-03 13:08:25'),
(742, NULL, 573, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_531.pdf', '2026-06-03 13:09:45', '2026-06-03 13:09:45'),
(743, NULL, 574, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_532.pdf', '2026-06-03 13:10:29', '2026-06-03 13:10:29'),
(744, NULL, 575, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_533.pdf', '2026-06-03 13:11:09', '2026-06-03 13:11:09'),
(745, NULL, 576, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_534.pdf', '2026-06-03 13:11:49', '2026-06-03 13:11:49'),
(746, NULL, 577, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_535.pdf', '2026-06-03 13:12:53', '2026-06-03 13:12:53'),
(747, NULL, 578, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_536.pdf', '2026-06-03 13:13:26', '2026-06-03 13:13:26'),
(748, NULL, 579, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_537.pdf', '2026-06-03 13:14:02', '2026-06-03 13:14:02'),
(749, NULL, 580, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_538.pdf', '2026-06-03 13:14:36', '2026-06-03 13:14:36'),
(750, NULL, 581, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_539.pdf', '2026-06-03 13:15:07', '2026-06-03 13:15:07'),
(751, NULL, 582, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_540.pdf', '2026-06-03 13:15:38', '2026-06-03 13:15:38'),
(752, NULL, 583, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_541.pdf', '2026-06-03 13:16:11', '2026-06-03 13:16:11'),
(753, NULL, 584, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_542.pdf', '2026-06-03 13:16:40', '2026-06-03 13:16:40'),
(754, NULL, 585, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_543.pdf', '2026-06-03 13:17:13', '2026-06-03 13:17:13'),
(755, NULL, 586, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_544.pdf', '2026-06-03 13:17:52', '2026-06-03 13:17:52'),
(756, NULL, 587, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_545.pdf', '2026-06-03 13:18:24', '2026-06-03 13:18:24'),
(757, NULL, 588, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_546.pdf', '2026-06-03 13:19:02', '2026-06-03 13:19:02'),
(758, NULL, 589, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_547.pdf', '2026-06-03 13:20:14', '2026-06-03 13:20:14'),
(759, NULL, 590, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_548.pdf', '2026-06-03 13:22:00', '2026-06-03 13:22:00'),
(760, NULL, 591, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_549.pdf', '2026-06-03 13:23:06', '2026-06-03 13:23:06'),
(761, NULL, 592, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_550.pdf', '2026-06-03 13:23:52', '2026-06-03 13:23:52'),
(762, NULL, 593, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_551.pdf', '2026-06-03 13:24:35', '2026-06-03 13:24:35'),
(763, NULL, 594, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_552.pdf', '2026-06-03 13:25:51', '2026-06-03 13:25:51'),
(764, NULL, 595, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_553.pdf', '2026-06-03 13:26:49', '2026-06-03 13:26:49'),
(765, NULL, 596, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_554.pdf', '2026-06-03 13:27:19', '2026-06-03 13:27:19'),
(766, NULL, 597, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_555.pdf', '2026-06-03 13:28:11', '2026-06-03 13:28:11'),
(767, NULL, 598, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_556.pdf', '2026-06-03 13:29:04', '2026-06-03 13:29:04'),
(768, NULL, 599, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_557.pdf', '2026-06-03 13:29:35', '2026-06-03 13:29:35'),
(769, NULL, 600, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_558.pdf', '2026-06-03 13:30:08', '2026-06-03 13:30:08'),
(770, NULL, 601, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_559.pdf', '2026-06-03 13:31:08', '2026-06-03 13:31:08'),
(771, NULL, 602, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_560.pdf', '2026-06-03 13:31:54', '2026-06-03 13:31:54'),
(772, NULL, 603, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_561.pdf', '2026-06-03 13:33:10', '2026-06-03 13:33:10'),
(773, NULL, 604, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_562.pdf', '2026-06-03 13:33:39', '2026-06-03 13:33:39'),
(774, NULL, 605, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_563.pdf', '2026-06-03 13:38:38', '2026-06-03 13:38:38'),
(775, NULL, 606, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_564.pdf', '2026-06-03 13:39:22', '2026-06-03 13:39:22'),
(776, NULL, 607, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_565.pdf', '2026-06-03 13:40:55', '2026-06-03 13:40:55'),
(777, NULL, 608, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_566.pdf', '2026-06-03 13:41:34', '2026-06-03 13:41:34'),
(778, NULL, 609, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_567.pdf', '2026-06-03 13:42:05', '2026-06-03 13:42:05'),
(779, NULL, 610, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_568.pdf', '2026-06-03 13:42:35', '2026-06-03 13:42:35'),
(780, NULL, 611, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_569.pdf', '2026-06-03 13:44:32', '2026-06-03 13:44:32'),
(781, NULL, 612, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_570.pdf', '2026-06-03 13:45:12', '2026-06-03 13:45:12'),
(782, NULL, 613, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_571.pdf', '2026-06-03 13:45:54', '2026-06-03 13:45:54'),
(783, NULL, 614, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_572.pdf', '2026-06-03 13:46:31', '2026-06-03 13:46:31'),
(784, NULL, 615, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_573.pdf', '2026-06-03 13:47:34', '2026-06-03 13:47:34'),
(785, NULL, 616, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_574.pdf', '2026-06-03 13:48:10', '2026-06-03 13:48:10'),
(786, NULL, 617, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_575.pdf', '2026-06-03 13:48:50', '2026-06-03 13:48:50'),
(787, NULL, 618, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_576.pdf', '2026-06-03 13:52:17', '2026-06-03 13:52:17'),
(788, NULL, 619, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_577.pdf', '2026-06-03 13:54:15', '2026-06-03 13:54:15'),
(789, NULL, 620, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_578.pdf', '2026-06-03 13:54:56', '2026-06-03 13:54:56'),
(790, NULL, 621, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_579.pdf', '2026-06-03 13:55:46', '2026-06-03 13:55:46'),
(791, NULL, 622, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_580.pdf', '2026-06-03 13:56:27', '2026-06-03 13:56:27'),
(792, NULL, 623, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_581.pdf', '2026-06-03 13:57:31', '2026-06-03 13:57:31'),
(793, NULL, 624, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_582.pdf', '2026-06-03 13:58:36', '2026-06-03 13:58:36'),
(794, NULL, 625, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_583.pdf', '2026-06-03 13:59:24', '2026-06-03 13:59:24'),
(795, NULL, 626, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_584.pdf', '2026-06-03 14:00:05', '2026-06-03 14:00:05'),
(796, NULL, 627, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_585.pdf', '2026-06-03 14:00:52', '2026-06-03 14:00:52'),
(797, NULL, 628, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_586.pdf', '2026-06-03 14:01:36', '2026-06-03 14:01:36'),
(798, NULL, 629, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_587.pdf', '2026-06-03 14:02:48', '2026-06-03 14:02:48'),
(799, NULL, 630, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_588.pdf', '2026-06-03 14:03:29', '2026-06-03 14:03:29'),
(800, NULL, 631, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_589.pdf', '2026-06-03 14:04:02', '2026-06-03 14:04:02'),
(801, NULL, 632, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_590.pdf', '2026-06-03 14:04:35', '2026-06-03 14:04:35'),
(802, NULL, 633, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_591.pdf', '2026-06-03 14:05:10', '2026-06-03 14:05:10'),
(803, NULL, 634, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_592.pdf', '2026-06-03 14:05:46', '2026-06-03 14:05:46'),
(804, NULL, 635, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_593.pdf', '2026-06-03 14:28:53', '2026-06-03 14:28:53'),
(805, NULL, 636, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_594.pdf', '2026-06-03 14:29:27', '2026-06-03 14:29:27'),
(806, NULL, 637, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_595.pdf', '2026-06-03 14:30:13', '2026-06-03 14:30:13'),
(807, NULL, 638, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_596.pdf', '2026-06-03 14:30:44', '2026-06-03 14:30:44'),
(808, NULL, 639, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_597.pdf', '2026-06-03 14:31:14', '2026-06-03 14:31:14'),
(809, NULL, 640, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_598.pdf', '2026-06-03 14:31:43', '2026-06-03 14:31:43'),
(810, NULL, 641, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_599.pdf', '2026-06-03 14:32:17', '2026-06-03 14:32:17'),
(811, NULL, 642, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_600.pdf', '2026-06-03 14:33:11', '2026-06-03 14:33:11'),
(812, NULL, 643, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_601.pdf', '2026-06-03 14:33:51', '2026-06-03 14:33:51'),
(813, NULL, 644, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_602.pdf', '2026-06-03 14:34:38', '2026-06-03 14:34:38'),
(814, NULL, 645, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_603.pdf', '2026-06-03 14:35:22', '2026-06-03 14:35:22'),
(815, NULL, 646, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_604.pdf', '2026-06-03 14:35:59', '2026-06-03 14:35:59'),
(816, NULL, 647, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_605.pdf', '2026-06-03 14:36:35', '2026-06-03 14:36:35'),
(817, NULL, 648, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_606.pdf', '2026-06-03 14:37:18', '2026-06-03 14:37:18'),
(818, NULL, 649, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_607.pdf', '2026-06-03 14:37:54', '2026-06-03 14:37:54'),
(819, NULL, 650, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_608.pdf', '2026-06-03 14:38:32', '2026-06-03 14:38:32'),
(820, NULL, 651, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_609.pdf', '2026-06-03 14:39:32', '2026-06-03 14:39:32'),
(821, NULL, 652, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_610.pdf', '2026-06-03 14:40:09', '2026-06-03 14:40:09'),
(822, NULL, 653, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_611.pdf', '2026-06-03 14:40:48', '2026-06-03 14:40:48'),
(823, NULL, 654, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_612.pdf', '2026-06-03 14:41:38', '2026-06-03 14:41:38'),
(824, NULL, 655, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_613.pdf', '2026-06-03 14:42:15', '2026-06-03 14:42:15'),
(825, NULL, 656, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_614.pdf', '2026-06-03 14:42:51', '2026-06-03 14:42:51'),
(826, NULL, 657, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_615.pdf', '2026-06-03 14:43:33', '2026-06-03 14:43:33'),
(827, NULL, 658, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_616.pdf', '2026-06-03 14:45:59', '2026-06-03 14:45:59'),
(828, NULL, 659, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_617.pdf', '2026-06-03 14:46:54', '2026-06-03 14:46:54'),
(829, NULL, 660, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_618.pdf', '2026-06-03 14:47:28', '2026-06-03 14:47:28'),
(830, NULL, 661, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_619.pdf', '2026-06-03 14:48:03', '2026-06-03 14:48:03'),
(831, NULL, 662, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_620.pdf', '2026-06-03 14:48:40', '2026-06-03 14:48:40'),
(832, NULL, 663, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_621.pdf', '2026-06-03 14:49:46', '2026-06-03 14:49:46'),
(833, NULL, 664, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_622.pdf', '2026-06-03 14:50:17', '2026-06-03 14:50:17'),
(834, NULL, 665, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_623.pdf', '2026-06-03 14:50:56', '2026-06-03 14:50:56'),
(835, NULL, 666, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_624.pdf', '2026-06-03 14:51:38', '2026-06-03 14:51:38'),
(836, NULL, 667, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_625.pdf', '2026-06-03 14:52:07', '2026-06-03 14:52:07'),
(837, NULL, 668, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_626.pdf', '2026-06-03 14:52:44', '2026-06-03 14:52:44'),
(838, NULL, 669, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_627.pdf', '2026-06-03 14:53:20', '2026-06-03 14:53:20'),
(839, NULL, 670, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_628.pdf', '2026-06-03 14:54:22', '2026-06-03 14:54:22'),
(840, NULL, 671, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_629.pdf', '2026-06-03 14:55:03', '2026-06-03 14:55:03'),
(841, NULL, 672, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_630.pdf', '2026-06-03 14:55:33', '2026-06-03 14:55:33'),
(842, NULL, 673, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_631.pdf', '2026-06-03 14:56:22', '2026-06-03 14:56:22'),
(843, NULL, 674, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_632.pdf', '2026-06-03 14:57:16', '2026-06-03 14:57:16'),
(844, NULL, 675, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_633.pdf', '2026-06-03 14:57:52', '2026-06-03 14:57:52'),
(845, NULL, 676, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_634.pdf', '2026-06-03 14:58:25', '2026-06-03 14:58:25'),
(846, NULL, 677, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_635.pdf', '2026-06-03 14:59:03', '2026-06-03 14:59:03'),
(847, NULL, 678, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_636.pdf', '2026-06-03 14:59:44', '2026-06-03 14:59:44'),
(848, NULL, 679, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_637.pdf', '2026-06-03 15:01:06', '2026-06-03 15:01:06'),
(849, NULL, 680, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_638.pdf', '2026-06-03 15:01:57', '2026-06-03 15:01:57'),
(850, NULL, 681, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_639.pdf', '2026-06-03 15:02:34', '2026-06-03 15:02:34'),
(851, NULL, 682, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_640.pdf', '2026-06-03 15:05:36', '2026-06-03 15:05:36'),
(852, NULL, 683, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_641.pdf', '2026-06-03 15:06:16', '2026-06-03 15:06:16'),
(853, NULL, 684, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_642.pdf', '2026-06-03 15:06:58', '2026-06-03 15:06:58'),
(854, NULL, 685, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_643.pdf', '2026-06-03 15:07:30', '2026-06-03 15:07:30'),
(855, NULL, 686, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_644.pdf', '2026-06-03 15:08:14', '2026-06-03 15:08:14'),
(856, NULL, 687, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_645.pdf', '2026-06-03 15:09:27', '2026-06-03 15:09:27'),
(857, NULL, 688, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_646.pdf', '2026-06-03 15:10:37', '2026-06-03 15:10:37'),
(858, NULL, 689, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_647.pdf', '2026-06-03 15:11:38', '2026-06-03 15:11:38'),
(859, NULL, 690, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_648.pdf', '2026-06-03 15:12:08', '2026-06-03 15:12:08'),
(860, NULL, 691, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_649.pdf', '2026-06-03 15:12:43', '2026-06-03 15:12:43'),
(861, NULL, 692, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_650.pdf', '2026-06-03 15:13:16', '2026-06-03 15:13:16'),
(862, NULL, 693, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_651.pdf', '2026-06-03 15:14:01', '2026-06-03 15:14:01'),
(863, NULL, 694, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_652.pdf', '2026-06-03 15:14:53', '2026-06-03 15:14:53'),
(864, NULL, 695, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_653.pdf', '2026-06-03 15:15:38', '2026-06-03 15:15:38'),
(865, NULL, 696, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_654.pdf', '2026-06-03 15:16:14', '2026-06-03 15:16:14'),
(866, NULL, 697, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_655.pdf', '2026-06-03 15:16:51', '2026-06-03 15:16:51'),
(867, NULL, 698, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_656.pdf', '2026-06-03 15:17:30', '2026-06-03 15:17:30'),
(868, NULL, 699, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_657.pdf', '2026-06-03 21:38:13', '2026-06-03 21:38:13'),
(869, NULL, 700, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_658.pdf', '2026-06-03 21:39:58', '2026-06-03 21:39:58'),
(870, NULL, 701, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_659.pdf', '2026-06-03 21:41:34', '2026-06-03 21:41:34'),
(871, NULL, 702, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_660.pdf', '2026-06-03 21:42:35', '2026-06-03 21:42:35'),
(872, NULL, 703, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_661.pdf', '2026-06-03 21:45:05', '2026-06-03 21:45:05'),
(873, NULL, 704, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_662.pdf', '2026-06-03 21:46:23', '2026-06-03 21:46:23'),
(874, NULL, 705, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_663.pdf', '2026-06-03 21:50:30', '2026-06-03 21:50:30'),
(875, NULL, 706, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_664.pdf', '2026-06-03 21:53:51', '2026-06-03 21:53:51'),
(876, NULL, 707, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_665.pdf', '2026-06-03 22:47:31', '2026-06-03 22:47:31'),
(877, NULL, 708, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_666.pdf', '2026-06-03 22:54:30', '2026-06-03 22:54:30'),
(878, NULL, 709, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_667.pdf', '2026-06-03 22:55:28', '2026-06-03 22:55:28'),
(879, NULL, 710, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_668.pdf', '2026-06-04 18:29:55', '2026-06-04 18:29:55'),
(880, NULL, 711, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_669.pdf', '2026-06-04 18:31:48', '2026-06-04 18:31:48'),
(881, NULL, 712, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_670.pdf', '2026-06-04 18:33:59', '2026-06-04 18:33:59'),
(882, NULL, 713, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_671.pdf', '2026-06-04 18:38:51', '2026-06-04 18:38:51'),
(883, NULL, 714, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_672.pdf', '2026-06-04 18:41:20', '2026-06-04 18:41:20'),
(884, NULL, 715, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_673.pdf', '2026-06-04 18:42:52', '2026-06-04 18:42:52'),
(885, NULL, 716, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_674.pdf', '2026-06-04 18:53:19', '2026-06-04 18:53:19'),
(886, NULL, 717, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_675.pdf', '2026-06-04 18:55:14', '2026-06-04 18:55:14'),
(887, NULL, 718, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_676.pdf', '2026-06-04 18:57:04', '2026-06-04 18:57:04'),
(888, NULL, 719, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_677.pdf', '2026-06-04 18:58:33', '2026-06-04 18:58:33'),
(889, NULL, 720, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_678.pdf', '2026-06-04 19:02:21', '2026-06-04 19:02:21'),
(890, NULL, 721, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_679.pdf', '2026-06-04 19:03:31', '2026-06-04 19:03:31'),
(891, NULL, 722, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_680.pdf', '2026-06-04 19:05:20', '2026-06-04 19:05:20'),
(892, NULL, 723, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_681.pdf', '2026-06-04 19:08:59', '2026-06-04 19:08:59'),
(893, NULL, 724, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_682.pdf', '2026-06-04 19:10:34', '2026-06-04 19:10:34'),
(894, NULL, 725, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_683.pdf', '2026-06-04 19:11:30', '2026-06-04 19:11:30'),
(895, NULL, 726, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_684.pdf', '2026-06-04 19:12:55', '2026-06-04 19:12:55'),
(896, NULL, 727, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_685.pdf', '2026-06-04 19:13:55', '2026-06-04 19:13:55'),
(897, NULL, 728, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_686.pdf', '2026-06-04 19:16:19', '2026-06-04 19:16:19'),
(898, NULL, 729, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_687.pdf', '2026-06-04 19:17:09', '2026-06-04 19:17:09'),
(899, NULL, 730, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_688.pdf', '2026-06-04 19:18:19', '2026-06-04 19:18:19'),
(900, NULL, 731, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_689.pdf', '2026-06-04 19:19:18', '2026-06-04 19:19:18'),
(901, NULL, 732, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_690.pdf', '2026-06-04 19:20:19', '2026-06-04 19:20:19'),
(902, NULL, 733, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_691.pdf', '2026-06-04 19:21:35', '2026-06-04 19:21:35'),
(903, NULL, 734, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_692.pdf', '2026-06-04 19:22:25', '2026-06-04 19:22:25'),
(904, NULL, 735, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_693.pdf', '2026-06-04 19:25:21', '2026-06-04 19:25:21'),
(905, NULL, 736, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_694.pdf', '2026-06-04 19:26:53', '2026-06-04 19:26:53'),
(906, NULL, 737, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_695.pdf', '2026-06-04 19:27:38', '2026-06-04 19:27:38'),
(907, NULL, 738, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_696.pdf', '2026-06-04 19:28:40', '2026-06-04 19:28:40'),
(908, NULL, 739, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_697.pdf', '2026-06-04 19:29:59', '2026-06-04 19:29:59'),
(909, NULL, 740, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_698.pdf', '2026-06-04 19:30:57', '2026-06-04 19:30:57'),
(910, NULL, 741, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_699.pdf', '2026-06-04 19:31:35', '2026-06-04 19:31:35'),
(911, NULL, 742, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_700.pdf', '2026-06-04 19:32:41', '2026-06-04 19:32:41'),
(912, NULL, 743, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_701.pdf', '2026-06-04 19:33:14', '2026-06-04 19:33:14'),
(913, NULL, 744, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_702.pdf', '2026-06-04 19:34:20', '2026-06-04 19:34:20'),
(914, NULL, 745, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_703.pdf', '2026-06-04 19:35:05', '2026-06-04 19:35:05'),
(915, NULL, 746, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_704.pdf', '2026-06-04 19:36:22', '2026-06-04 19:36:22'),
(916, NULL, 747, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_705.pdf', '2026-06-04 19:37:00', '2026-06-04 19:37:00'),
(917, NULL, 748, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_706.pdf', '2026-06-04 19:38:56', '2026-06-04 19:38:56'),
(918, NULL, 749, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_707.pdf', '2026-06-04 19:39:45', '2026-06-04 19:39:45'),
(919, NULL, 750, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_708.pdf', '2026-06-04 19:40:42', '2026-06-04 19:40:42'),
(920, NULL, 751, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_709.pdf', '2026-06-04 19:41:29', '2026-06-04 19:41:29'),
(921, NULL, 752, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_710.pdf', '2026-06-04 19:42:24', '2026-06-04 19:42:24'),
(922, NULL, 753, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_711.pdf', '2026-06-04 19:43:12', '2026-06-04 19:43:12'),
(923, NULL, 754, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_712.pdf', '2026-06-04 19:44:08', '2026-06-04 19:44:08'),
(924, NULL, 755, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_713.pdf', '2026-06-04 19:44:48', '2026-06-04 19:44:48'),
(925, NULL, 756, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_714.pdf', '2026-06-04 19:45:39', '2026-06-04 19:45:39'),
(926, NULL, 757, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_715.pdf', '2026-06-04 19:46:30', '2026-06-04 19:46:30'),
(927, NULL, 758, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_716.pdf', '2026-06-04 19:51:12', '2026-06-04 19:51:12'),
(928, NULL, 759, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_717.pdf', '2026-06-04 19:52:19', '2026-06-04 19:52:19'),
(929, NULL, 760, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_718.pdf', '2026-06-04 19:53:09', '2026-06-04 19:53:09'),
(930, NULL, 761, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_719.pdf', '2026-06-04 19:55:08', '2026-06-04 19:55:08'),
(931, NULL, 762, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_720.pdf', '2026-06-04 19:56:04', '2026-06-04 19:56:04'),
(932, NULL, 763, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_721.pdf', '2026-06-04 19:56:43', '2026-06-04 19:56:43'),
(933, NULL, 764, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_722.pdf', '2026-06-04 19:57:26', '2026-06-04 19:57:26'),
(934, NULL, 765, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_723.pdf', '2026-06-04 19:58:11', '2026-06-04 19:58:11'),
(935, NULL, 766, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_724.pdf', '2026-06-04 19:59:24', '2026-06-04 19:59:24'),
(936, NULL, 767, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_725.pdf', '2026-06-04 20:00:03', '2026-06-04 20:00:03'),
(937, NULL, 768, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_726.pdf', '2026-06-04 20:00:47', '2026-06-04 20:00:47'),
(938, NULL, 769, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_727.pdf', '2026-06-04 20:01:42', '2026-06-04 20:01:42'),
(939, NULL, 770, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_728.pdf', '2026-06-04 20:02:26', '2026-06-04 20:02:26'),
(940, NULL, 771, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_729.pdf', '2026-06-04 20:03:06', '2026-06-04 20:03:06'),
(941, NULL, 772, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_730.pdf', '2026-06-04 20:03:53', '2026-06-04 20:03:53'),
(942, NULL, 773, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_731.pdf', '2026-06-04 20:04:38', '2026-06-04 20:04:38'),
(943, NULL, 774, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_732.pdf', '2026-06-04 20:05:23', '2026-06-04 20:05:23'),
(944, NULL, 775, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_733.pdf', '2026-06-04 20:06:04', '2026-06-04 20:06:04'),
(945, NULL, 776, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_734.pdf', '2026-06-04 20:06:39', '2026-06-04 20:06:39'),
(946, NULL, 777, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_735.pdf', '2026-06-04 20:07:22', '2026-06-04 20:07:22'),
(947, NULL, 778, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_736.pdf', '2026-06-04 20:08:00', '2026-06-04 20:08:00'),
(948, NULL, 779, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_737.pdf', '2026-06-04 20:08:50', '2026-06-04 20:08:50'),
(949, NULL, 780, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_738.pdf', '2026-06-04 20:09:26', '2026-06-04 20:09:26'),
(950, NULL, 781, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_739.pdf', '2026-06-04 20:10:02', '2026-06-04 20:10:02'),
(951, NULL, 782, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_740.pdf', '2026-06-04 20:10:33', '2026-06-04 20:10:33'),
(952, NULL, 783, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_741.pdf', '2026-06-04 20:11:08', '2026-06-04 20:11:08'),
(953, NULL, 784, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_742.pdf', '2026-06-04 20:11:47', '2026-06-04 20:11:47'),
(954, NULL, 785, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads/cable/list_pemotongan_invoice_202604_743.pdf', '2026-06-04 20:12:31', '2026-06-04 20:12:31');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
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
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 2),
(1, 'App\\Models\\User', 7),
(1, 'App\\Models\\User', 12),
(2, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 4),
(2, 'App\\Models\\User', 6),
(2, 'App\\Models\\User', 9),
(2, 'App\\Models\\User', 10),
(3, 'App\\Models\\User', 3),
(3, 'App\\Models\\User', 5),
(3, 'App\\Models\\User', 8),
(3, 'App\\Models\\User', 11);

-- --------------------------------------------------------

--
-- Table structure for table `m_grade`
--

CREATE TABLE `m_grade` (
  `id` int(11) NOT NULL,
  `grade` varchar(100) DEFAULT NULL,
  `price_bbl` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `m_grade`
--

INSERT INTO `m_grade` (`id`, `grade`, `price_bbl`, `user_id`, `created_at`, `updated_at`) VALUES
(2, 'PERTALITE', '81.602', 3, '2026-04-11 23:36:44', '2026-04-14 11:17:01'),
(3, 'PERTAMAX', '100', 3, '2026-04-15 13:32:52', '2026-04-15 13:32:52'),
(6, 'B40', '90', 3, '2026-05-20 07:33:37', '2026-05-20 07:33:37'),
(7, 'AVTUR', '100.21', 12, '2026-05-26 06:53:21', '2026-05-26 06:53:21');

-- --------------------------------------------------------

--
-- Table structure for table `m_kontrak`
--

CREATE TABLE `m_kontrak` (
  `id` int(11) NOT NULL,
  `id_vessel` int(11) NOT NULL,
  `no_surat_pemenang` varchar(100) DEFAULT NULL,
  `no_kontrak` varchar(100) DEFAULT NULL,
  `tgl_awal_kontrak` varchar(100) DEFAULT NULL,
  `tgl_akhir_kontrak` varchar(100) DEFAULT NULL,
  `charter_rate` varchar(100) DEFAULT NULL,
  `period` varchar(20) DEFAULT NULL,
  `speed` varchar(100) DEFAULT NULL,
  `me_ballast` varchar(100) DEFAULT NULL,
  `me_laden` varchar(100) DEFAULT NULL,
  `toleransi_transport_loss` varchar(100) DEFAULT NULL,
  `pumping_rate` varchar(100) DEFAULT NULL,
  `discharge` varchar(100) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `m_kontrak`
--

INSERT INTO `m_kontrak` (`id`, `id_vessel`, `no_surat_pemenang`, `no_kontrak`, `tgl_awal_kontrak`, `tgl_akhir_kontrak`, `charter_rate`, `period`, `speed`, `me_ballast`, `me_laden`, `toleransi_transport_loss`, `pumping_rate`, `discharge`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(33, 34, '045/TCP/IV/2023', '045/TCP/IV/2023', '2023-04-05 00:00:00', '2025-04-05 00:00:00', '47350', 'MONTH', '4', '2.530', '2.530', '0.07', '200', '0.840', 'NON ACTIVE', 3, '2026-06-01 22:02:42', '2026-06-01 22:03:49'),
(34, 34, '038/TCP/V/2025', '038/TCP/V/2025', '2025-05-05 00:00:00', '2026-05-05 00:00:00', '55000', 'MONTH', '4', '2.530', '2.530', '0.07', '200', '0.840', 'ACTIVE', 3, '2026-06-01 22:03:49', '2026-06-01 22:03:49'),
(35, 45, '004/TCP/1/2024', '004/TCP/1/2024', '2024-01-04 00:00:00', '2026-01-04 00:00:00', '50000', 'MONTH', '4', '2.040', '2.040', '0.07', '200', '0.960', 'NON ACTIVE', 3, '2026-06-01 22:05:45', '2026-06-01 22:06:40'),
(36, 45, '001/TCP/I/2026', '001/TCP/I/2026', '2026-01-16 00:00:00', '2028-01-16 00:00:00', '55000', 'MONTH', '4', '2.040', '2.040', '0.07', '200', '0.960', 'ACTIVE', 3, '2026-06-01 22:06:40', '2026-06-01 22:06:40'),
(37, 36, '0464/Q25076/2020-S0', '0464/Q25076/2020-S0', '2020-06-23 00:00:00', '2025-06-23 00:00:00', '4100', 'MONTH', '10', '6.220', '6.340', '0.07', '200', '2.8', 'NON ACTIVE', 3, '2026-06-01 22:09:06', '2026-06-01 22:10:07'),
(38, 36, '050/TCP/VI/2025', '050/TCP/VI/2025', '2025-06-27 00:00:00', '2027-06-27 00:00:00', '5200', 'MONTH', '10', '6.220', '6.340', '0.07', '200', '2.8', 'ACTIVE', 3, '2026-06-01 22:10:07', '2026-06-01 22:10:07'),
(39, 46, '031/TCP/III/2024', '031/TCP/III/2024', '2024-03-27 00:00:00', '2026-03-27 00:00:00', '5750', 'MONTH', '10', '7.385', '7.520', '0.07', '200', '2', 'NON ACTIVE', 3, '2026-06-01 22:11:49', '2026-06-01 22:13:26'),
(40, 46, '033/TCP/III/2026', '033/TCP/III/2026', '2026-03-28 00:00:00', '2028-03-28 00:00:00', '5750', 'MONTH', '10', '7.360', '7.495', '0.07', '200', '2', 'ACTIVE', 3, '2026-06-01 22:13:26', '2026-06-01 22:13:26'),
(41, 47, '171/TCP/XI/2023', '171/TCP/XI/2023', '2023-11-16 00:00:00', '2025-11-16 00:00:00', '5750', 'MONTH', '10', '7.385', '7.520', '0.07', '200', '2.35', 'NON ACTIVE', 3, '2026-06-01 22:17:32', '2026-06-01 22:18:53'),
(42, 47, '132/TCP/XI/2025', '132/TCP/XI/2025', '2025-12-10 00:00:00', '2027-12-10 00:00:00', '5750', 'MONTH', '10', '7.360', '7.495', '0.07', '200', '2.35', 'ACTIVE', 3, '2026-06-01 22:18:53', '2026-06-01 22:18:53'),
(43, 44, '138/TCP/IX/2023', '138/TCP/IX/2023', '2023-09-17 00:00:00', '2025-09-17 00:00:00', '2600', 'MONTH', '7', '3.995', '4.042', '0.07', '150', '1.008', 'NON ACTIVE', 3, '2026-06-01 22:20:22', '2026-06-01 22:21:22'),
(44, 44, '106/TCP/X/2025', '106/TCP/X/2025', '2025-10-18 00:00:00', '2026-10-18 00:00:00', '2600', 'MONTH', '7', '3.995', '4.042', '0.07', '150', '1.008', 'ACTIVE', 3, '2026-06-01 22:21:22', '2026-06-01 22:21:22'),
(45, 43, '069/TCP/VI/2024', '069/TCP/VI/2024', '2024-06-18 00:00:00', '2025-06-18 00:00:00', '2650', 'MONTH', '7', '3.290', '3.340', '0.07', '150', '1.008', 'NON ACTIVE', 3, '2026-06-01 22:23:06', '2026-06-01 22:24:00'),
(46, 43, '045/TCP/VI/2025', '045/TCP/VI/2025', '2025-06-22 00:00:00', '2026-06-22 00:00:00', '2650', 'MONTH', '7', '3.290', '3.340', '0.07', '150', '1.008', 'ACTIVE', 3, '2026-06-01 22:24:00', '2026-06-01 22:24:00'),
(47, 41, '146/TCP/X/2023', '146/TCP/X/2023', '2023-10-01 00:00:00', '2025-10-01 00:00:00', '3300', 'MONTH', '7', '5.088', '5.218', '0.07', '200', '2.016', 'NON ACTIVE', 3, '2026-06-01 22:26:44', '2026-06-01 22:27:53'),
(48, 41, '112/TCP/X/2025', '112/TCP/X/2025', '2025-10-23 00:00:00', '2026-10-23 00:00:00', '3350', 'MONTH', '7', '5.088', '5.218', '0.07', '200', '2.016', 'ACTIVE', 3, '2026-06-01 22:27:53', '2026-06-01 22:27:53'),
(49, 42, '073/TCP/VI/2024', '073/TCP/VI/2024', '2024-06-26 00:00:00', '2025-06-23 00:00:00', '2900', 'MONTH', '10', '6.652', '6.820', '0.07', '200', '2.3', 'ACTIVE', 3, '2026-06-01 22:43:35', '2026-06-01 22:43:35');

-- --------------------------------------------------------

--
-- Table structure for table `m_vessel`
--

CREATE TABLE `m_vessel` (
  `id` int(11) NOT NULL,
  `kode_vessel` varchar(100) DEFAULT NULL,
  `nama_vessel` varchar(100) DEFAULT NULL,
  `jenis_vessel` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `m_vessel`
--

INSERT INTO `m_vessel` (`id`, `kode_vessel`, `nama_vessel`, `jenis_vessel`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(34, 'AB2F8', 'ALBATROSS 2/FLAMINGO 8', 'SATGAS', 'ACTIVE', 3, '2026-04-03 06:40:40', '2026-06-01 14:02:51'),
(36, 'F19', 'FALCON 19', 'SMALL I', 'ACTIVE', 3, '2026-04-14 10:27:30', '2026-04-14 10:27:30'),
(41, 'SG351', 'SEAGULL 351', 'SPOB', 'ACTIVE', 11, '2026-05-07 02:48:15', '2026-05-07 02:48:15'),
(42, 'F18', 'FALCON 18', 'SMALL I', 'ACTIVE', 3, '2026-06-01 13:53:21', '2026-06-01 14:02:02'),
(43, 'SG202', 'SEAGULL 202', 'SPOB', 'ACTIVE', 3, '2026-06-01 13:55:01', '2026-06-01 13:55:01'),
(44, 'SG201', 'SEAGULL 201', 'SPOB', 'ACTIVE', 3, '2026-06-01 14:00:27', '2026-06-01 22:32:46'),
(45, 'AB5FL9', 'ALBATROSS 5/ FLAMINGO 9', 'SATGAS', 'ACTIVE', 3, '2026-06-01 14:01:40', '2026-06-01 22:33:51'),
(46, 'MMXII', 'MPMT XII', 'SATGAS', 'ACTIVE', 3, '2026-06-01 14:03:48', '2026-06-01 14:03:48'),
(47, 'MMXV', 'MPMT XV', 'SATGAS', 'ACTIVE', 3, '2026-06-01 14:04:36', '2026-06-01 14:04:36');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` char(80) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` char(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `scopes` text DEFAULT NULL,
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
  `id` char(80) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` char(36) NOT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` char(36) NOT NULL,
  `owner_type` varchar(255) DEFAULT NULL,
  `owner_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `secret` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `redirect_uris` text NOT NULL,
  `grant_types` text NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_device_codes`
--

CREATE TABLE `oauth_device_codes` (
  `id` char(80) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` char(36) NOT NULL,
  `user_code` char(8) NOT NULL,
  `scopes` text NOT NULL,
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
  `id` char(80) NOT NULL,
  `access_token_id` char(80) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(57, 'App\\Models\\User', 1, 'api-token', 'c2c240dc7a3f6d40ee9f3c26c81d01da8ba550dc367af552e82fc8047cc52e9c', '[\"*\"]', '2026-04-15 16:40:56', NULL, '2026-04-15 16:39:51', '2026-04-15 16:40:56'),
(61, 'App\\Models\\User', 5, 'api-token', '00032118078c5f75bc670706e189406c1a07e742307d2f6e369a73e02ab7c8a5', '[\"*\"]', '2026-04-16 00:52:53', NULL, '2026-04-16 00:31:55', '2026-04-16 00:52:53'),
(75, 'App\\Models\\User', 6, 'api-token', 'd44ba57fe697a640248d69a2e947c283c27bd0015c64e4d4cac73bca1f219d15', '[\"*\"]', '2026-04-21 03:27:21', NULL, '2026-04-16 07:04:32', '2026-04-21 03:27:21'),
(90, 'App\\Models\\User', 8, 'api-token', 'f1a294f1e4e9e0e8b614e3ae7750a528e4834d9d5457222c02e6d0799ad11e36', '[\"*\"]', '2026-04-29 07:47:14', NULL, '2026-04-22 09:59:33', '2026-04-29 07:47:14'),
(103, 'App\\Models\\User', 9, 'api-token', 'f1ba264c97e91d8fca52ff3ef3aac17f01440fc832e289d99a584d63fbcaa338', '[\"*\"]', '2026-05-05 03:31:06', NULL, '2026-04-29 08:12:23', '2026-05-05 03:31:06'),
(169, 'App\\Models\\User', 7, 'api-token', 'b851e7eeb46103819565e4ee88c1a07335b36dfca8299cd222fa048e17b53f75', '[\"*\"]', '2026-05-29 06:22:53', NULL, '2026-05-25 20:15:03', '2026-05-29 06:22:53'),
(176, 'App\\Models\\User', 2, 'api-token', 'ca4f6d85e55b5fdc33207fb2995355d329e0d2a908154431b4b4e50b6177ea8a', '[\"*\"]', '2026-06-06 08:22:09', NULL, '2026-06-01 20:18:48', '2026-06-06 08:22:09'),
(191, 'App\\Models\\User', 12, 'api-token', '6e79157ab346e87d114a1c288740b9e57f7c9081e9e64cdd1681dc16c38e65c3', '[\"*\"]', '2026-06-01 23:41:13', NULL, '2026-06-01 23:40:33', '2026-06-01 23:41:13'),
(202, 'App\\Models\\User', 11, 'api-token', '436308f2eb3e87305a55f2738f8f97a44b268efd52c5aeb876c760acb11b8bc7', '[\"*\"]', '2026-06-03 23:13:02', NULL, '2026-06-03 19:17:43', '2026-06-03 23:13:02'),
(203, 'App\\Models\\User', 10, 'api-token', 'ef6bee4dda84db28f798647e3399ace833051b95c06da46958aaed052c6136c3', '[\"*\"]', '2026-06-07 19:01:52', NULL, '2026-06-03 21:59:50', '2026-06-07 19:01:52'),
(204, 'App\\Models\\User', 3, 'api-token', 'f727e95b7a0fecf1ca8fc4055f6cdeece8b6d628c16c5fc128ea31f20fc1bade', '[\"*\"]', '2026-06-04 20:12:32', NULL, '2026-06-04 02:20:01', '2026-06-04 20:12:32');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
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
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('AXBO8lAjGXEbIny1E6IPIZGras4ywXnZAQHKI4sS', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJvZWxxRktRMU9ScUlDUXRsbDdSM2VFM1JTMW5Sc2YwSmV2NGllTmZqIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1774379012),
('B3CpnxukvbVK2Qwe3J5QG7PKB3TZfHmIQuaJbN39', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJESW1iS2Z6OUtsRWxqQXRBZ0RsUUIxWk9YOEljSnN4MjlKS0dPVXdVIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1775232104),
('I2Wtafl4TqT0R5IFfiWumtFelz68tCEcCuHmlC5K', NULL, '114.10.72.171', 'PostmanRuntime/7.51.1', 'eyJfdG9rZW4iOiJXUWhhSG5RYmNSRnpCaGM1QnFlWG9rMFE5ZlBmUlBLWlB5am1uVElZIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHBzOlwvXC9vc2wuZ2xvYmFscGVyZGFuYXJhY2tpbmcuY29tXC9iZSIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1776256101);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `value` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `id` int(11) NOT NULL,
  `id_cable` int(11) NOT NULL,
  `id_grade` int(11) NOT NULL,
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
  `flow_rate_pump` varchar(100) DEFAULT NULL,
  `nomor_pompa` varchar(100) DEFAULT NULL,
  `pressure_pompa` varchar(100) DEFAULT NULL,
  `rpm` varchar(100) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `t_doc_cargo`
--

INSERT INTO `t_doc_cargo` (`id`, `id_cable`, `id_grade`, `no_voyage_gab`, `grade`, `price_bbl`, `bill_of_lading`, `r1`, `ratio_r1`, `r2`, `ratio_r2`, `r3`, `ratio_r3`, `r4`, `ratio_r4`, `act_receipt`, `est_discharge`, `act_discharge`, `overdue_discharge`, `est_claim_pumping`, `est_claim_bunker`, `est_claim_transport`, `flow_rate_pump`, `nomor_pompa`, `pressure_pompa`, `rpm`, `remarks`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(12, 34, 2, 'SG351/25006/L', 'PERTALITE', '81.602', '9928.844', '30.106', '0.303218', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', '0', '0', '0', NULL, '0', '0', '0', '0', 'APPROVE', 12, '2026-05-22 09:36:03', '2026-05-22 09:36:07'),
(13, 33, 2, 'SG351/25005/D1', 'PERTALITE', '81.602', '8672.578', '-98', '-1.129998', '1.89', '0.021793', '45.504', '0.524688', '-50.269', '-0.579632', '1369.925', '0.285401', '0.5375', '0.252099', '831.926563', '6521652.019575', '0', '106.195736', '0', '0', '0', '0', 'OPEN', 12, '2026-05-22 10:03:34', '2026-05-22 10:12:20'),
(14, 33, 3, 'SG351/25005/D1', 'PERTAMAX', '100', '7422.163', '17.998', '0.24249', '-2.725', '-0.036714', '24.310', '0.327533', '3.587', '0.048328', '1179.815', '0.245795', '0.558333', '0.312538', '1031.376088', '8085179.927147', '0', '88.045948', '0', '0', '0', '0', 'APPROVE', 12, '2026-05-22 10:10:20', '2026-05-22 10:10:22'),
(15, 32, 2, 'SG351/25005/L', 'PERTALITE', '81.602', '8672.578', '-97.663', '-1.126113', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', '0', '0', '0', NULL, '0', '0', '0', '0', 'APPROVE', 12, '2026-05-22 10:28:14', '2026-05-22 10:28:24'),
(16, 30, 2, 'SG351/25004/L', 'PERTALITE', '81.602', '16080.559', '58.329', '0.36273', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', '0', '0', '0', NULL, '0', '0', '0', '0', 'APPROVE', 12, '2026-05-22 10:38:49', '2026-05-22 10:38:53'),
(17, 31, 2, 'SG351/25004/D1', 'PERTALITE', '81.602', '16080.559', '58.329', '0.36273', '-2.434', '-0.015136', '-11.093', '-0.068984', '49.670', '0.308882', '2545.249', '0.53026', '0.85', '0.31974', '1055.141312', '8271480.659211', '0', '124.767108', '0', '0', '0', '0', 'APPROVE', 12, '2026-05-22 13:10:42', '2026-05-22 13:10:59'),
(18, 28, 2, 'SG351/25003/L', 'PERTALITE', '81.602', '9917.9', '25.803', '0.260166', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', '0', '0', '0', NULL, '0', '0', '0', '0', 'APPROVE', 12, '2026-05-22 13:13:37', '2026-05-22 13:13:40'),
(19, 28, 3, 'SG351/25003/L', 'PERTAMAX', '100', '6207.605', '70.959', '1.143098', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', '0', '0', '0', NULL, '0', '0', '0', '0', 'APPROVE', 12, '2026-05-22 13:14:47', '2026-05-22 13:14:50'),
(20, 29, 2, 'SG351/25003/D1', 'PERTALITE', '81.602', '9917.900', '25.803', '0.260166', '-6.315', '-0.063673', '9.654', '0.097339', '41.773', '0.421188', '1575.770', '0.328285', '365.266667', '364.938382', '1204296.659225', '9503056766.078108', '0', '0.179751', '0', '0', '0', '0', 'APPROVE', 12, '2026-05-22 13:26:20', '2026-05-22 13:26:23'),
(21, 32, 3, 'SG351/25005/L', 'PERTAMAX', '100', '7422.163', '17.998', '0.24249', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', '0', '0', '0', NULL, '0', '0', '0', '0', 'APPROVE', 12, '2026-05-22 13:43:57', '2026-05-22 13:44:11'),
(22, 29, 3, 'SG351/25003/D1', 'PERTAMAX', '100', '6207.605', '70.959', '1.143098', '1.574', '0.025356', '4.836', '0.077904', '64.548', '1.039821', '990.455', '0.206345', '0.55', '0.343655', '1134.062188', '8948839.359075', '0', '75.03447', '0', '0', '0', '0', 'APPROVE', 12, '2026-05-22 13:50:35', '2026-05-22 13:50:38'),
(23, 26, 2, 'SG351/25002/L', 'PERTALITE', '81.602', '9926.755', '55.353', '0.557614', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', '0', '0', '0', NULL, '0', '0', '0', '0', 'APPROVE', 12, '2026-05-22 14:00:14', '2026-05-22 14:00:17'),
(24, 27, 2, 'SG351/25002/D1', 'PERTALITE', '81.602', '9926.755', '55.353', '0.557614', '-2.014', '-0.020289', '-12.244', '-0.123343', '41.637', '0.419442', '1593.456', '0.33197', '1.6', '1.26803', '4184.499', '33019714.22904', '0', '41.49625', '0', '0', '0', '0', 'APPROVE', 12, '2026-05-22 14:10:08', '2026-05-22 14:10:12'),
(25, 34, 3, 'SG351/25006/L', 'PERTAMAX', '100', '6208.005', '51.076', '0.822744', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', '0', '0', '0', NULL, '0', '0', '0', '0', 'APPROVE', 12, '2026-05-24 11:39:05', '2026-05-27 02:46:33'),
(26, 27, 3, 'SG351/25002/D1', 'PERTAMAX', '100', '3104.368', '49.240', '1.586152', '-0.254', '-0.008182', '-1.041', '-0.033533', '51.920', '1.672482', '492.431', '0.10259', '0.208333', '0.105743', '348.952587', '2753570.909859', '0', '98.486358', '0', '0', '0', '0', 'APPROVE', 12, '2026-05-24 11:50:38', '2026-05-24 11:56:09'),
(27, 26, 3, 'SG351/25002/L', 'PERTAMAX', '100', '3104.368', '49.240', '1.586152', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', '0', '0', '0', NULL, '0', '0', '0', '0', 'APPROVE', 12, '2026-05-24 11:55:02', '2026-05-24 12:23:01'),
(28, 25, 2, 'SG351/25001/D1', 'PERTALITE', '81.602', '9968.224', '-97.618', '-0.979292', '-1.53', '-0.015349', '-275.123', '-2.76', '-371.221', '-3.724044', '1627.866', '0.339139', '0.000694', '-0.338445', '-1116.867675', '-8813158.148718', '0.000000', '97734.510086', '0', '0', '0', '0', 'APPROVE', 2, '2026-05-24 12:19:10', '2026-05-26 20:21:46'),
(29, 24, 2, 'SG351/25001/L', 'PERTALITE', '81.602', '9968.224', '97.156', '0.974657', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', '0', '0', '0', NULL, '0', '0', '0', '0', 'APPROVE', 2, '2026-05-25 03:47:36', '2026-05-26 20:20:09'),
(30, 24, 6, 'SG351/25001/L', 'B40', '90', '6190.715', '-49.366', '-0.79742', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', '0', '0', '0', NULL, '0', '0', '0', '0', 'APPROVE', 12, '2026-05-25 03:53:33', '2026-05-25 03:53:53'),
(35, 33, 7, 'SG351/25005/D1', 'AVTUR', '100.21', '1367.98', '17.998', '1.315663', '-9.658', '-0.706004', '0', '0', '0', '0', '0', '0', '1', '1', '3300', '25869412.8', '871.867837', NULL, NULL, NULL, NULL, NULL, 'APPROVE', 12, '2026-05-27 02:12:56', '2026-05-28 02:41:26'),
(36, 31, 7, 'SG351/25004/D1', 'AVTUR', '91.07', '25885.84', '58.329', '0.225332', '-23.521', '-0.090864', '0', '0', '0', '0', '0', '0', '0.041667', '0.041667', '137.5011', '1077900.823138', '491.852828', NULL, '0', '0', '0', '0', 'APPROVE', 12, '2026-05-27 02:17:00', '2026-05-27 02:17:14'),
(39, 31, 3, 'SG351/25004/D1', 'PERTAMAX', '81.6', '4958.41', '10', '0.201678', '-9.602', '-0.193651', '10', '0.201678', '10', '0.201678', '10', '0.002083', '1', '0.997917', '3293.125', '25815518.19', '500.299682', '0.416667', NULL, NULL, NULL, NULL, 'APPROVE', 12, '2026-05-28 02:43:31', '2026-05-28 02:43:38');

-- --------------------------------------------------------

--
-- Table structure for table `t_doc_cargo_detail`
--

CREATE TABLE `t_doc_cargo_detail` (
  `id` int(11) NOT NULL,
  `id_doc_cargo` int(11) NOT NULL,
  `no_voyage_gab` varchar(100) DEFAULT NULL,
  `no_urut` varchar(100) DEFAULT NULL,
  `start_time` varchar(100) DEFAULT NULL,
  `stop_time` varchar(100) DEFAULT NULL,
  `discharge_time` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `t_doc_cargo_detail`
--

INSERT INTO `t_doc_cargo_detail` (`id`, `id_doc_cargo`, `no_voyage_gab`, `no_urut`, `start_time`, `stop_time`, `discharge_time`, `user_id`, `created_at`, `updated_at`) VALUES
(47, 12, 'SG351/25006/L', '01', '', '', '0', 12, '2026-05-22 09:36:03', '2026-05-22 09:36:03'),
(50, 14, 'SG351/25005/D1', '01', '2025-02-22 20:06:00', '2025-02-23 09:30:00', '0.558333', 12, '2026-05-22 10:10:20', '2026-05-22 10:10:20'),
(51, 13, 'SG351/25005/D1', '01', '2025-02-22 16:00:00', '2025-02-22 19:36:00', '0.15', 12, '2026-05-22 10:12:18', '2026-05-22 10:12:18'),
(52, 13, 'SG351/25005/D1', '02', '2025-02-23 09:36:00', '2025-02-23 18:54:00', '0.3875', 12, '2026-05-22 10:12:18', '2026-05-22 10:12:18'),
(53, 15, 'SG351/25005/L', '01', '', '', '0', 12, '2026-05-22 10:28:14', '2026-05-22 10:28:14'),
(54, 16, 'SG351/25004/L', '01', '', '', '0', 12, '2026-05-22 10:38:49', '2026-05-22 10:38:49'),
(55, 17, 'SG351/25004/D1', '01', '2025-02-11 20:42:00', '2025-02-12 17:06:00', '0.85', 12, '2026-05-22 13:10:42', '2026-05-22 13:10:42'),
(56, 18, 'SG351/25003/L', '01', '', '', '0', 12, '2026-05-22 13:13:37', '2026-05-22 13:13:37'),
(57, 19, 'SG351/25003/L', '01', '', '', '0', 12, '2026-05-22 13:14:47', '2026-05-22 13:14:47'),
(58, 20, 'SG351/25003/D1', '01', '2025-02-01 13:00:00', '2026-02-01 16:54:00', '365.1625', 12, '2026-05-22 13:26:20', '2026-05-22 13:26:20'),
(59, 20, 'SG351/25003/D1', '02', '2025-02-02 07:00:00', '2025-02-02 09:30:00', '0.104167', 12, '2026-05-22 13:26:20', '2026-05-22 13:26:20'),
(60, 21, 'SG351/25005/L', '01', '', '', '0', 12, '2026-05-22 13:43:57', '2026-05-22 13:43:57'),
(61, 22, 'SG351/25003/D1', '01', '2025-02-01 17:24:00', '2025-02-02 06:36:00', '0.55', 12, '2026-05-22 13:50:35', '2026-05-22 13:50:35'),
(62, 23, 'SG351/25002/L', '01', '', '', '0', 12, '2026-05-22 14:00:14', '2026-05-22 14:00:14'),
(63, 24, 'SG351/25002/D1', '01', '2025-01-20 13:36:00', '2025-01-21 17:54:00', '1.179167', 12, '2026-05-22 14:10:08', '2026-05-22 14:10:08'),
(64, 24, 'SG351/25002/D1', '02', '2025-01-20 23:24:00', '2025-01-21 09:30:00', '0.420833', 12, '2026-05-22 14:10:08', '2026-05-22 14:10:08'),
(68, 26, 'SG351/25002/D1', '01', '2025-01-20 18:12:00', '2025-01-20 23:12:00', '0.208333', 12, '2026-05-24 11:56:04', '2026-05-24 11:56:04'),
(72, 27, 'SG351/25002/L', '01', '', '', '0', 12, '2026-05-24 12:22:59', '2026-05-24 12:22:59'),
(73, 29, 'SG351/25001/L', '01', '', '', '0', 12, '2026-05-25 03:47:36', '2026-05-25 03:47:36'),
(74, 30, 'SG351/25001/L', '01', '', '', '0', 12, '2026-05-25 03:53:33', '2026-05-25 03:53:33'),
(75, 25, 'SG351/25006/L', '01', '', '', '0', 7, '2026-05-25 20:16:31', '2026-05-25 20:16:31'),
(82, 28, 'SG351/25001/D1', '01', '2025-01-07 12:36:00', '2025-01-07 12:37:00', '0.000694', 2, '2026-05-26 20:21:43', '2026-05-26 20:21:43'),
(85, 36, 'SG351/25004/D1', '01', '2026-05-28 09:14:00', '2026-05-28 10:14:00', '0.041667', 12, '2026-05-27 02:17:00', '2026-05-27 02:17:00'),
(88, 35, 'SG351/25005/D1', '01', '2026-05-27 09:11:00', '2026-05-28 09:11:00', '1', 12, '2026-05-28 02:41:20', '2026-05-28 02:41:20'),
(89, 39, 'SG351/25004/D1', '01', '2026-05-28 09:41:00', '2026-05-29 09:41:00', '1', 12, '2026-05-28 02:43:31', '2026-05-28 02:43:31');

-- --------------------------------------------------------

--
-- Table structure for table `t_klaim`
--

CREATE TABLE `t_klaim` (
  `id` int(11) NOT NULL,
  `id_vessel` int(11) NOT NULL,
  `no_klaim_awal` varchar(100) DEFAULT NULL,
  `tgl_klaim_awal` varchar(100) DEFAULT NULL,
  `jenis_klaim` varchar(100) DEFAULT NULL,
  `no_klaim_akhir` varchar(100) DEFAULT NULL,
  `tgl_klaim_akhir` varchar(100) DEFAULT NULL,
  `periode_klaim` text DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `t_klaim`
--

INSERT INTO `t_klaim` (`id`, `id_vessel`, `no_klaim_awal`, `tgl_klaim_awal`, `jenis_klaim`, `no_klaim_akhir`, `tgl_klaim_akhir`, `periode_klaim`, `user_id`, `status`, `created_at`, `updated_at`) VALUES
(58, 41, '5752/PIS2330/2025-S6', '2025-10-16 00:00:00', 'OHBOH', '5752/PIS2330/2025-S6', '2026-05-16 04:36:00', NULL, 7, 'APPROVE', '2026-05-15 07:32:42', '2026-05-21 07:30:36'),
(62, 41, '1289/PIS2330/2025-S6', '2025-02-24 00:00:00', 'SSOB', NULL, NULL, NULL, 12, 'OPEN', '2026-05-24 12:37:36', '2026-05-24 12:37:36'),
(63, 41, '2658/PIS2330/2025-S6', '2025-05-22 00:00:00', 'SSOB', NULL, NULL, NULL, 12, 'OPEN', '2026-05-24 12:50:32', '2026-05-24 12:50:32'),
(64, 41, '3225/PIS2330/2025-S6', '2025-05-21 00:00:00', 'SSOB', '3225/PIS2330/2025-S6', '2026-04-15 00:00:00', NULL, 12, 'APPROVE', '2026-05-24 12:56:00', '2026-05-24 14:35:22'),
(65, 41, '3816/PIS2330/2025-S6', '2025-06-25 00:00:00', 'SSOB', NULL, NULL, NULL, 12, 'OPEN', '2026-05-24 13:51:11', '2026-05-24 13:51:11'),
(66, 41, '5647/PIS2330/2025-S6', '2025-10-08 00:00:00', 'SSOB', NULL, NULL, NULL, 12, 'OPEN', '2026-05-24 14:01:07', '2026-05-24 14:01:07');

-- --------------------------------------------------------

--
-- Table structure for table `t_klaim_detail`
--

CREATE TABLE `t_klaim_detail` (
  `id` int(11) NOT NULL,
  `id_klaim` int(11) NOT NULL,
  `id_cable` int(11) DEFAULT NULL,
  `id_off_hire` int(11) DEFAULT NULL,
  `id_redelivery_delivery` int(11) DEFAULT NULL,
  `no_urut` varchar(100) DEFAULT NULL,
  `no_voyage_gab` varchar(100) DEFAULT NULL,
  `no_kontrak` varchar(100) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `t_klaim_detail`
--

INSERT INTO `t_klaim_detail` (`id`, `id_klaim`, `id_cable`, `id_off_hire`, `id_redelivery_delivery`, `no_urut`, `no_voyage_gab`, `no_kontrak`, `keterangan`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(65, 58, NULL, 6, NULL, '01', '0727/OFFHIRE/Q22076/2025', '146/TCP/X/2023', NULL, 'APPROVE', 11, '2026-05-15 07:32:42', '2026-05-21 07:31:46'),
(69, 62, 27, NULL, NULL, '01', 'SG351/25002/D1', '146/TCP/X/2023', NULL, 'OPEN', 12, '2026-05-24 12:37:37', '2026-05-24 12:37:37'),
(70, 63, 28, NULL, NULL, '01', 'SG351/25003/L', '146/TCP/X/2023', NULL, 'OPEN', 12, '2026-05-24 12:50:32', '2026-05-24 12:50:32'),
(71, 64, 29, NULL, NULL, '01', 'SG351/25003/D1', '146/TCP/X/2023', 'Unclaim Bad Weather BMKG', 'APPROVE', 12, '2026-05-24 12:56:00', '2026-05-24 14:35:22'),
(72, 64, 31, NULL, NULL, '02', 'SG351/25004/D1', '146/TCP/X/2023', 'Unclaim Bad Weather BMKG', 'APPROVE', 12, '2026-05-24 12:59:44', '2026-05-24 14:35:22'),
(73, 64, 30, NULL, NULL, '03', 'SG351/25004/L', '146/TCP/X/2023', 'Unclaim Bad Weather BMKG', 'APPROVE', 12, '2026-05-24 13:35:37', '2026-05-24 14:35:22'),
(74, 65, 25, NULL, NULL, '01', 'SG351/25001/D1', '146/TCP/X/2023', NULL, 'OPEN', 12, '2026-05-24 13:51:11', '2026-05-24 13:51:11'),
(75, 65, 24, NULL, NULL, '02', 'SG351/26001/L', '146/TCP/X/2023', NULL, 'OPEN', 12, '2026-05-24 13:56:39', '2026-05-24 13:56:39'),
(76, 66, 32, NULL, NULL, '02', 'SG351/25005/L', '146/TCP/X/2023', NULL, 'OPEN', 12, '2026-05-24 14:01:08', '2026-05-24 14:02:49'),
(77, 66, 33, NULL, NULL, '01', 'SG351/25005/D1', '146/TCP/X/2023', NULL, 'OPEN', 12, '2026-05-24 14:02:49', '2026-05-24 14:02:49'),
(78, 66, 34, NULL, NULL, '03', 'SG351/25006/L', '146/TCP/X/2023', NULL, 'OPEN', 12, '2026-05-24 14:04:47', '2026-05-24 14:04:47'),
(83, 70, 25, NULL, NULL, '01', 'SG351/25001/D1', '146/TCP/X/2023', NULL, 'OPEN', 2, '2026-05-26 20:22:16', '2026-05-26 20:22:16'),
(84, 71, 33, NULL, NULL, '01', 'SG351/25005/D1', '146/TCP/X/2023', NULL, 'OPEN', 12, '2026-05-27 02:14:06', '2026-05-27 02:14:06'),
(85, 72, 31, NULL, NULL, '01', 'SG351/25004/D1', '146/TCP/X/2023', NULL, 'OPEN', 12, '2026-05-27 02:18:27', '2026-05-27 02:18:27');

-- --------------------------------------------------------

--
-- Table structure for table `t_klaim_detail_nilai`
--

CREATE TABLE `t_klaim_detail_nilai` (
  `id` int(11) NOT NULL,
  `id_klaim_detail` int(11) NOT NULL,
  `sub_jenis` varchar(10) NOT NULL,
  `currency` varchar(100) DEFAULT NULL,
  `kurs` varchar(100) DEFAULT NULL,
  `val_potensi` varchar(100) DEFAULT NULL,
  `val_klaim_awal` varchar(100) DEFAULT NULL,
  `val_klaim_akhir` varchar(100) DEFAULT NULL,
  `val_klaim_akhir_idr` varchar(100) DEFAULT NULL,
  `no_tagihan_klaim` varchar(100) DEFAULT NULL,
  `no_tagihan_dipotong` varchar(100) DEFAULT NULL,
  `tanggal_tagihan_klaim` varchar(100) DEFAULT NULL,
  `tanggal_tagihan_dipotong` varchar(100) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `t_klaim_detail_nilai`
--

INSERT INTO `t_klaim_detail_nilai` (`id`, `id_klaim_detail`, `sub_jenis`, `currency`, `kurs`, `val_potensi`, `val_klaim_awal`, `val_klaim_akhir`, `val_klaim_akhir_idr`, `no_tagihan_klaim`, `no_tagihan_dipotong`, `tanggal_tagihan_klaim`, `tanggal_tagihan_dipotong`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(46, 62, 'OH', 'USD', NULL, '47350', NULL, NULL, NULL, '', '', NULL, NULL, 'OPEN', 7, '2026-05-07 04:12:30', '2026-05-07 04:12:30'),
(47, 62, 'BOH', 'IDR', '1', '84700000', NULL, NULL, NULL, '', '', NULL, NULL, 'OPEN', 7, '2026-05-07 04:12:30', '2026-05-07 04:12:30'),
(52, 65, 'OH', 'USD', NULL, '58025', '58025', '58025', '0', '912345', '100', '2026-05-01 14:31:00', '2026-06-01 14:31:00', 'CLOSE', 11, '2026-05-15 07:32:42', '2026-05-21 07:32:46'),
(53, 65, 'BOH', 'IDR', '1', '37508.9', '34648885.195', '58025', '0', '912346', '101', '2026-05-01 14:31:00', '2026-07-01 14:31:00', 'CLOSE', 11, '2026-05-15 07:32:42', '2026-05-21 07:32:46'),
(58, 69, 'SS', 'USD', NULL, '2903.2146', '3191.964', NULL, NULL, '', '', NULL, NULL, 'OPEN', 12, '2026-05-24 12:37:37', '2026-05-24 12:38:58'),
(59, 69, 'OB', 'IDR', '1', '24735576.25', '21330257.982', NULL, NULL, '', '', NULL, NULL, 'OPEN', 12, '2026-05-24 12:37:37', '2026-05-24 12:38:58'),
(60, 70, 'SS', 'USD', NULL, '1775.3868', '1763.929', NULL, NULL, '', '', NULL, NULL, 'OPEN', 12, '2026-05-24 12:50:32', '2026-05-24 12:51:15'),
(61, 70, 'OB', 'IDR', '1', '4428572.32125', '9772553.818', NULL, NULL, '', '', NULL, NULL, 'OPEN', 12, '2026-05-24 12:50:32', '2026-05-24 12:51:15'),
(62, 71, 'SS', 'USD', NULL, '9887.8857', '13877.679', '0', '0', '', '', NULL, NULL, 'APPROVE', 12, '2026-05-24 12:56:00', '2026-05-24 14:35:22'),
(63, 71, 'OB', 'IDR', '1', '130898318.6665', '121813624.585', '0', '0', '', '', NULL, NULL, 'APPROVE', 12, '2026-05-24 12:56:00', '2026-05-24 14:35:22'),
(64, 72, 'SS', 'USD', NULL, '6364.2843', '6666.786', '0', '0', '', '', NULL, NULL, 'APPROVE', 12, '2026-05-24 12:59:44', '2026-05-24 14:35:22'),
(65, 72, 'OB', 'IDR', '1', '79391867.6859', '91168099.166', '0', '0', '', '', NULL, NULL, 'APPROVE', 12, '2026-05-24 12:59:44', '2026-05-24 14:35:22'),
(66, 73, 'SS', 'USD', NULL, '4835.7441', '4838.036', '0', '0', '', '', NULL, NULL, 'APPROVE', 12, '2026-05-24 13:35:37', '2026-05-24 14:35:22'),
(67, 73, 'OB', 'IDR', '1', '54733725.31935', '63787626.004', '0', '0', '', '', NULL, NULL, 'APPROVE', 12, '2026-05-24 13:35:37', '2026-05-24 14:35:22'),
(68, 74, 'SS', 'USD', NULL, '3964.257', '2033.214', NULL, NULL, '', '', NULL, NULL, 'OPEN', 12, '2026-05-24 13:51:12', '2026-05-24 13:52:26'),
(69, 74, 'OB', 'IDR', '1', '43077361.25', '15848930.958', NULL, NULL, '', '', NULL, NULL, 'OPEN', 12, '2026-05-24 13:51:12', '2026-05-24 13:52:26'),
(70, 75, 'SS', 'USD', NULL, '65.264952', '4360.714', NULL, NULL, '', '', NULL, NULL, 'OPEN', 12, '2026-05-24 13:56:39', '2026-05-24 13:57:29'),
(71, 75, 'OB', 'IDR', '1', '12418538.03575', '43003814.109', NULL, NULL, '', '', NULL, NULL, 'OPEN', 12, '2026-05-24 13:56:39', '2026-05-24 13:57:29'),
(72, 76, 'SS', 'USD', NULL, '5126.7843', '5126.786', NULL, NULL, '', '', NULL, NULL, 'OPEN', 12, '2026-05-24 14:01:08', '2026-05-24 14:02:35'),
(73, 76, 'OB', 'IDR', '1', '59392394.71935', '68649196.301', NULL, NULL, '', '', NULL, NULL, 'OPEN', 12, '2026-05-24 14:01:08', '2026-05-24 14:02:35'),
(74, 77, 'SS', 'USD', NULL, '6710.3256', '6708.036', NULL, NULL, '', '', NULL, NULL, 'OPEN', 12, '2026-05-24 14:02:49', '2026-05-24 14:03:29'),
(75, 77, 'OB', 'IDR', '1', '80533920.1359', '92383491.740', NULL, NULL, '', '', NULL, NULL, 'OPEN', 12, '2026-05-24 14:02:49', '2026-05-24 14:03:29'),
(76, 78, 'SS', 'USD', NULL, '2926.7832', '5058.036', NULL, NULL, '', '', NULL, NULL, 'OPEN', 12, '2026-05-24 14:04:47', '2026-05-24 14:06:25'),
(77, 78, 'OB', 'IDR', '1', '23735419.38075', '40361996.616', NULL, NULL, '', '', NULL, NULL, 'OPEN', 12, '2026-05-24 14:04:47', '2026-05-24 14:06:25'),
(78, 79, 'BOD', 'IDR', '1', '-847', '900', '900', '900', '', '', NULL, NULL, 'APPROVE', 11, '2026-05-25 07:04:31', '2026-05-25 07:06:02'),
(85, 83, 'SP', 'USD', NULL, '-1116.867675', '0', NULL, NULL, '', '', NULL, NULL, 'OPEN', 2, '2026-05-26 20:22:16', '2026-05-26 20:26:36'),
(86, 83, 'OB', 'IDR', '1', '-8813158.148718', '0', NULL, NULL, '', '', NULL, NULL, 'OPEN', 2, '2026-05-26 20:22:16', '2026-05-26 20:26:36'),
(87, 84, 'TL', 'USD', NULL, '871.867837', NULL, NULL, NULL, '', '', NULL, NULL, 'OPEN', 12, '2026-05-27 02:14:06', '2026-05-27 02:14:06'),
(88, 85, 'TL', 'USD', NULL, '491.852828', NULL, '0', '0', '', '', NULL, NULL, 'OPEN', 12, '2026-05-27 02:18:27', '2026-05-27 02:25:41');

-- --------------------------------------------------------

--
-- Table structure for table `t_master_cable`
--

CREATE TABLE `t_master_cable` (
  `id` int(11) NOT NULL,
  `id_vessel` int(11) NOT NULL,
  `id_kontrak` int(11) DEFAULT NULL,
  `no_voyage_gab` varchar(100) NOT NULL,
  `no_voyage` varchar(10) NOT NULL,
  `jenis_voyage` varchar(30) NOT NULL,
  `master` varchar(100) DEFAULT NULL,
  `atd_port` varchar(100) DEFAULT NULL,
  `atd_time` varchar(100) DEFAULT NULL,
  `atd_rob` varchar(100) DEFAULT NULL,
  `ata_port` varchar(100) DEFAULT NULL,
  `ata_time` varchar(100) DEFAULT NULL,
  `ata_rob` varchar(100) DEFAULT NULL,
  `distance` varchar(100) DEFAULT NULL,
  `speed` varchar(100) DEFAULT NULL,
  `act_speed` varchar(100) DEFAULT NULL,
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
  `keterangan` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `t_master_cable`
--

INSERT INTO `t_master_cable` (`id`, `id_vessel`, `id_kontrak`, `no_voyage_gab`, `no_voyage`, `jenis_voyage`, `master`, `atd_port`, `atd_time`, `atd_rob`, `ata_port`, `ata_time`, `ata_rob`, `distance`, `speed`, `act_speed`, `est_sail_day`, `act_sail_day`, `charter_rate_day`, `est_claim_speed`, `std_bunker_cons`, `act_bunker_cons`, `excess_bunker`, `bunker_price`, `est_claim_bunker`, `status`, `keterangan`, `user_id`, `created_at`, `updated_at`) VALUES
(36, 34, 34, 'AB2F8/25001/L', '25001', 'L', 'IMAM FAHRUDI', 'PANGKALAN BALAM', '2025-01-05 13:59:00', '30.365', 'TG. UBAN', '2025-01-08 13:00:00', '15.683', '288', '4', '4.055386', '3', '2.959028', '1774.193548', '-72.692258', '7.59', '14.682', '7.092', '14950.00', '89803513.8', 'OPEN', NULL, 3, '2026-06-02 07:33:14', '2026-06-02 11:27:05'),
(37, 34, 34, 'AB2F8/25001/D1', '25001', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-01-11 19:30:00', '0.052', 'OB. JAMBI', '2025-01-13 07:00:00', '48.802', '145', '4', '4.084506', '1.510417', '1.479167', '1774.193548', '-55.443548', '3.821355', '-48.75', '-52.571355', '15250.00', '-679051049.69625', 'OPEN', NULL, 3, '2026-06-02 07:35:15', '2026-06-02 11:34:20'),
(38, 34, 34, 'AB2F8/25002/L', '25002', 'L', 'IMAM FAHRUDI', 'OB. JAMBI', '2025-01-18 21:00:00', '37.762', 'TG. UBAN', '2025-01-20 09:00:00', '34.482', '145', '4', '4.027778', '1.510417', '1.5', '1774.193548', '-18.481774', '3.821355', '3.28', '-0.541355', '14950.00', '-6854988.89075', 'OPEN', NULL, 3, '2026-06-02 07:37:06', '2026-06-02 11:36:10'),
(39, 34, 34, 'AB2F8/25002/D1', '25002', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-01-28 20:45:00', '28.517', 'OB. JAMBI', '2025-01-30 07:59:00', '25.415', '145', '4', '4.11542', '1.510417', '1.468056', '1774.193548', '-75.156613', '3.821355', '3.102', '-0.719355', '15250.00', '-9291728.69625', 'OPEN', NULL, 3, '2026-06-02 07:38:11', '2026-06-02 12:00:56'),
(40, 34, 34, 'AB2F8/25003/L', '25003', 'L', 'IMAM FAHRUDI', 'OB. JAMBI', '2025-02-04 21:30:00', '14.533', 'TG. UBAN', '2025-02-06 12:00:00', '11.169', '145', '4', '3.766233', '1.510417', '1.604167', '1964.285714', '184.151786', '3.821355', '3.364', '-0.457355', '15150.00', '-5868802.22775', 'OPEN', NULL, 3, '2026-06-02 07:41:27', '2026-06-02 12:01:32'),
(41, 34, 34, 'AB2F8/25003/D1', '25003', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-02-13 09:30:00', '54.725', 'OB. JAMBI', '2025-02-14 19:59:00', '51.640', '145', '4', '4.204929', '1.510417', '1.436806', '1964.285714', '-144.593036', '3.821355', '3.085', '-0.736355', '15450.00', '-9636051.98325', 'OPEN', NULL, 3, '2026-06-02 07:43:31', '2026-06-02 12:02:03'),
(42, 34, 34, 'AB2F8/25004/L', '25004', 'L', 'IMAM FAHRUDI', 'OB. JAMBI', '2025-02-19 07:30:00', '42.32', 'TG. UBAN', '2025-02-20 19:30:00', '39.093', '145', '4', '4.027778', '1.510417', '1.5', '1964.285714', '-20.461964', '3.821355', '3.227', '-0.594355', '15150.00', '-7626793.07775', 'OPEN', NULL, 3, '2026-06-02 07:44:26', '2026-06-02 12:02:37'),
(43, 34, 34, 'AB2F8/25004/D1', '25004', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-02-22 08:29:00', '35.494', 'OB. JAMBI', '2025-02-23 19:00:00', '32.435', '145', '4', '4.20087', '1.510417', '1.438194', '1964.285714', '-141.866607', '3.821355', '3.059', '-0.762355', '15450.00', '-9976291.88325', 'OPEN', NULL, 3, '2026-06-02 07:48:08', '2026-06-02 12:04:00'),
(44, 34, 34, 'AB2F8/25005/L', '25005', 'L', 'IMAM FAHRUDI', 'OB. JAMBI', '2025-02-28 18:30:00', '22.489', 'PANJANG', '2025-03-05 14:00:00', '12.16', '480', '4', '4.155844', '5', '4.8125', '1774.193548', '-332.66129', '12.65', '10.329', '-2.321', '15150.00', '-29783188.05', 'OPEN', NULL, 3, '2026-06-02 07:49:09', '2026-06-02 12:03:13'),
(45, 34, 34, 'AB2F8/25005/D1', '25005', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2025-03-09 10:30:00', '58.729', 'OB. JAMBI', '2025-03-14 10:30:00', '47.637', '480', '4', '4', '5', '5', '1774.193548', '0', '12.65', '11.092', '-1.558', '15150.00', '-19992333.9', 'OPEN', NULL, 3, '2026-06-02 07:50:15', '2026-06-02 12:04:33'),
(46, 34, 34, 'AB2F8/25006/L', '25006', 'L', 'IMAM FAHRUDI', 'OB. JAMBI', '2025-03-21 19:00:00', '33.317', 'TG. UBAN', '2025-03-23 07:00:00', '30.032', '145', '4', '4.027778', '1.510417', '1.5', '1774.193548', '-18.481774', '3.821355', '3.285', '-0.536355', '15150.00', '-6882534.17775', 'OPEN', NULL, 3, '2026-06-02 07:51:15', '2026-06-02 12:06:28'),
(47, 34, 34, 'AB2F8/25006/D1', '25006', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-03-26 00:30:00', '25.753', 'OB. JAMBI', '2025-03-27 10:00:00', '22.772', '145', '4', '4.328359', '1.510417', '1.395833', '1774.193548', '-203.294194', '3.821355', '2.981', '-0.840355', '15450.00', '-10997011.58325', 'OPEN', NULL, 3, '2026-06-02 07:52:08', '2026-06-02 12:06:54'),
(48, 34, 34, 'AB2F8/25007/L', '25007', 'L', 'IMAM FAHRUDI', 'OB. JAMBI', '2025-04-03 16:00:00', '10.838', 'TG. UBAN', '2025-04-05 02:00:00', '7.735', '145', '4', '4.264705', '1.510417', '1.416667', '1833.333333', '-171.875', '3.821355', '3.103', '-0.718355', '14500.00', '-8822476.9325', 'OPEN', NULL, 3, '2026-06-02 07:54:35', '2026-06-02 12:07:30'),
(49, 34, 34, 'AB2F8/25007/D1', '25007', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-04-06 08:00:00', '54.795', 'OB. JAMBI', '2025-04-07 19:00:00', '51.580', '145', '4', '4.142858', '1.510417', '1.458333', '1833.333333', '-95.487333', '3.821355', '3.215', '-0.606355', '14200.00', '-7292874.127', 'OPEN', NULL, 3, '2026-06-02 07:55:22', '2026-06-02 12:08:48'),
(50, 34, 34, 'AB2F8/25008/L', '25008', 'L', 'IMAM FAHRUDI', 'OB. JAMBI', '2025-04-13 00:30:00', '41.194', 'PANJANG', '2025-04-17 21:30:00', '30.580', '480', '4', '4.102564', '5', '4.875', '1833.333333', '-229.166667', '12.65', '10.614', '-2.036', '14500.00', '-25005134', 'OPEN', NULL, 3, '2026-06-02 07:56:06', '2026-06-02 12:09:26'),
(51, 34, 34, 'AB2F8/25008/D1', '25008', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2025-04-20 21:00:00', '26.635', 'OB. JAMBI', '2025-04-25 20:00:00', '15.866', '480', '4', '4.033614', '5', '4.958333', '1833.333333', '-76.3895', '12.65', '10.769', '-1.881', '14200.00', '-22623539.4', 'OPEN', NULL, 3, '2026-06-02 07:57:16', '2026-06-02 12:09:59'),
(52, 34, 34, 'AB2F8/25009/L', '25009', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-05-03 21:30:00', '5.606', 'TG. UBAN', '2025-05-05 02:00:00', '2.911', '145', '4', '5.087719', '1.510417', '1.1875', '1774.193548', '-572.917258', '3.821355', '2.695', '-1.126355', '14350.00', '-13690225.52975', 'OPEN', NULL, 3, '2026-06-02 08:02:50', '2026-06-02 12:12:52'),
(53, 34, 34, 'AB2F8/25009/D1', '25009', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-05-06 12:00:00', '51.848', 'JAMBI', '2025-05-07 23:00:00', '48.670', '145', '4', '4.142858', '1.510417', '1.458333', '1774.193548', '-92.407097', '3.821355', '3.178', '-0.643355', '14050.00', '-7656149.67425', 'OPEN', NULL, 3, '2026-06-02 08:05:30', '2026-06-02 12:13:24'),
(54, 34, 34, 'AB2F8/25010/L', '25010', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-05-15 10:00:00', '36.968', 'PANJANG', '2025-05-20 07:00:00', '26.342', '480', '4', '4.102564', '5', '4.875', '1774.193548', '-221.774193', '12.65', '10.626', '-2.024', '14050.00', '-24086308.4', 'OPEN', NULL, 3, '2026-06-02 08:06:28', '2026-06-02 12:13:56'),
(55, 34, 34, 'AB2F8/25010/D1', '25010', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2025-05-23 15:00:00', '51.731', 'JAMBI', '2025-05-28 21:00:00', '40.273', '480', '4', '3.809524', '5', '5.25', '1774.193548', '443.548387', '12.65', '11.458', '-1.192', '14050.00', '-14185217.2', 'OPEN', NULL, 3, '2026-06-02 08:07:13', '2026-06-02 12:16:13'),
(56, 34, 34, 'AB2F8/25011/L', '25011', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-06-03 09:00:00', '28.807', 'PANJANG', '2025-06-08 07:30:00', '18.154', '480', '4', '4.050633', '5', '4.9375', '1833.333333', '-114.583333', '12.65', '10.653', '-1.997', '13500.00', '-22834696.5', 'OPEN', NULL, 3, '2026-06-02 08:07:59', '2026-06-02 12:16:40'),
(57, 34, 34, 'AB2F8/25011/D1', '25011', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2025-06-10 20:00:00', '56.832', 'JAMBI', '2025-06-15 19:30:00', '45.849', '480', '4', '4.016736', '5', '4.979167', '1833.333333', '-38.193833', '12.65', '10.983', '-1.667', '13500.00', '-19061311.5', 'OPEN', NULL, 3, '2026-06-02 08:08:55', '2026-06-02 12:17:19'),
(58, 34, 34, 'AB2F8/25012/L', '25012', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-06-26 16:30:00', '32.381', 'TG. UBAN', '2025-06-28 04:00:00', '29.055', '145', '4', '4.084506', '1.510417', '1.479167', '1833.333333', '-57.291667', '3.821355', '3.326', '-0.495355', '13800.00', '-5790006.453', 'OPEN', NULL, 3, '2026-06-02 08:09:42', '2026-06-02 12:17:48'),
(59, 34, 34, 'AB2F8/25012/D1', '25012', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-06-29 08:30:00', '59.282', 'JAMBI', '2025-06-30 20:30:00', '56.036', '145', '4', '4.027778', '1.510417', '1.5', '1833.333333', '-19.097833', '3.821355', '3.246', '-0.575355', '13500.00', '-6578896.7475', 'OPEN', NULL, 3, '2026-06-02 08:10:27', '2026-06-02 12:18:18'),
(60, 34, 34, 'AB2F8/25013/L', '25013', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-07-06 12:00:00', '45.486', 'PANJANG', '2025-07-11 09:00:00', '34.859', '480', '4', '4.102564', '5', '4.875', '1774.193548', '-221.774193', '12.65', '10.627', '-2.023', '14350.00', '-24588452.35', 'OPEN', NULL, 3, '2026-06-02 08:11:28', '2026-06-02 12:19:06'),
(61, 34, 34, 'AB2F8/25013/D1', '25013', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2025-07-13 02:30:00', '3.147', 'JAMBI', '2025-07-18 02:00:00', '20.627', '480', '4', '4.016736', '5', '4.979167', '1774.193548', '-36.961774', '12.65', '-17.48', '-30.13', '13950.00', '-356005534.5', 'OPEN', NULL, 3, '2026-06-02 08:12:08', '2026-06-02 12:19:47'),
(62, 34, 34, 'AB2F8/25014/L', '25014', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-07-24 10:30:00', '9.359', 'TG. UBAN', '2025-07-25 22:00:00', '6.135', '145', '4', '4.084506', '1.510417', '1.479167', '1774.193548', '-55.443548', '3.821355', '3.224', '-0.597355', '14250.00', '-7209925.51125', 'OPEN', NULL, 3, '2026-06-02 08:13:02', '2026-06-02 12:20:14'),
(63, 34, 34, 'AB2F8/25014/D1', '25014', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-07-28 20:00:00', '52.54', 'JAMBI', '2025-07-30 08:00:00', '49.194', '145', '4', '4.027778', '1.510417', '1.5', '1774.193548', '-18.481774', '3.821355', '3.346', '-0.475355', '13950.00', '-5616628.30575', 'OPEN', NULL, 3, '2026-06-02 08:13:46', '2026-06-02 12:21:42'),
(64, 34, 34, 'AB2F8/25015/L', '25015', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-08-04 14:00:00', '38.731', 'PANJANG', '2025-08-09 10:30:00', '28.219', '480', '4', '4.120171', '5', '4.854167', '1774.193548', '-258.735968', '12.65', '10.512', '-2.138', '14450.00', '-26167302.7', 'OPEN', NULL, 3, '2026-06-02 08:14:31', '2026-06-02 12:23:10'),
(65, 34, 34, 'AB2F8/25015/D1', '25015', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2025-08-14 19:00:00', '53.035', 'JAMBI', '2025-08-19 18:30:00', '42.133', '480', '4', '4.016736', '5', '4.979167', '1774.193548', '-36.961774', '12.65', '10.902', '-1.748', '14450.00', '-21394034.2', 'OPEN', NULL, 3, '2026-06-02 08:15:10', '2026-06-02 12:23:47'),
(66, 34, 34, 'AB2F8/25016/L', '25016', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-08-25 07:30:00', '31.151', 'TG. UBAN', '2025-08-26 19:00:00', '27.912', '145', '4', '4.084506', '1.510417', '1.479167', '1774.193548', '-55.443548', '3.821355', '3.239', '-0.582355', '14750.00', '-7275506.60375', 'OPEN', NULL, 3, '2026-06-02 08:15:59', '2026-06-02 12:25:14'),
(67, 34, 34, 'AB2F8/25016/D1', '25016', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-08-29 10:00:00', '24.019', 'JAMBI', '2025-08-30 22:00:00', '20.768', '145', '4', '4.027778', '1.510417', '1.5', '1774.193548', '-18.481774', '3.821355', '3.251', '-0.570355', '14450.00', '-6980660.39825', 'OPEN', NULL, 3, '2026-06-02 08:16:59', '2026-06-02 11:44:22'),
(68, 34, 34, 'AB2F8/25017/L', '25017', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-09-06 07:12:00', '11.942', 'PANJANG', '2025-09-10 17:00:00', '2.257', '480', '4', '4.536862', '5', '4.408333', '1833.333333', '-1084.722833', '12.65', '9.685', '-2.965', '14350.00', '-36037944.25', 'OPEN', NULL, 3, '2026-06-02 08:18:09', '2026-06-02 11:44:49'),
(69, 34, 34, 'AB2F8/25017/D1', '25017', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2025-09-13 13:00:00', '49.084', 'JAMBI', '2025-09-18 12:00:00', '38.153', '480', '4', '4.033614', '5', '4.958333', '1833.333333', '-76.3895', '12.65', '10.931', '-1.719', '14150.00', '-20602300.95', 'OPEN', NULL, 3, '2026-06-02 08:22:15', '2026-06-02 11:45:14'),
(70, 34, 34, 'AB2F8/25018/L', '25018', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-09-26 06:30:00', '26.203', 'TG. UBAN', '2025-09-27 17:00:00', '23.035', '145', '4', '4.202899', '1.510417', '1.4375', '1833.333333', '-133.681167', '3.821355', '3.168', '-0.653355', '14450.00', '-7996509.84825', 'OPEN', NULL, 3, '2026-06-02 08:23:29', '2026-06-02 11:45:38'),
(71, 34, 34, 'AB2F8/25018/D1', '25018', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-09-30 03:36:00', '55.958', 'JAMBI', '2025-10-01 15:36:00', '52.896', '145', '4', '4.027778', '1.510417', '1.5', '1774.193548', '-18.481774', '3.821355', '3.062', '-0.759355', '14300.00', '-9197383.6955', 'OPEN', NULL, 3, '2026-06-02 08:24:43', '2026-06-02 11:46:17'),
(72, 34, 34, 'AB2F8/25019/L', '25019', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-10-06 20:24:00', '41.812', 'PANJANG', '2025-10-11 17:02:00', '31.413', '480', '4', '4.115462', '5', '4.859722', '1774.193548', '-248.880323', '12.65', '10.399', '-2.251', '14300.00', '-27264337.1', 'OPEN', NULL, 3, '2026-06-02 08:25:37', '2026-06-02 11:46:52'),
(73, 34, 34, 'AB2F8/25019/D1', '25019', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2025-10-15 17:31:00', '61.765', 'JAMBI', '2025-10-20 17:02:00', '51.037', '480', '4', '4.016176', '5', '4.979861', '1774.193548', '-35.730484', '12.65', '10.728', '-1.922', '14300.00', '-23279456.2', 'OPEN', NULL, 3, '2026-06-02 08:27:15', '2026-06-02 11:47:19'),
(74, 34, 34, 'AB2F8/25020/L', '25020', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-10-26 07:55:00', '39.793', 'TG. UBAN', '2025-10-28 18:00:00', '35.712', '145', '4', '2.496413', '1.510417', '2.420139', '1774.193548', '1614.022903', '3.821355', '4.081', '0.259645', '14300.00', '3144846.2045', 'OPEN', NULL, 3, '2026-06-02 08:28:03', '2026-06-02 11:48:18'),
(75, 34, 34, 'AB2F8/25020/D1', '25020', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-10-31 09:30:00', '31.725', 'JAMBI', '2025-11-01 21:30:00', '28.489', '145', '4', '4.027778', '1.510417', '1.5', '1833.333333', '-19.097833', '3.821355', '3.236', '-0.585355', '14300.00', '-7089878.2955', 'OPEN', NULL, 3, '2026-06-02 08:28:40', '2026-06-02 11:48:48'),
(76, 34, 34, 'AB2F8/25021/L', '25021', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-11-07 08:42:00', '17.630', 'PANJANG', '2025-11-12 07:00:00', '7.010', '480', '4', '4.057481', '5', '4.929167', '1833.333333', '-129.8605', '12.65', '10.62', '-2.03', '14300.00', '-24587563', 'OPEN', NULL, 3, '2026-06-02 08:37:26', '2026-06-02 11:49:14'),
(77, 34, 34, 'AB2F8/25021/D41', '25021', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2025-11-14 12:00:00', '69.927', 'JAMBI', '2025-11-19 18:00:00', '58.333', '480', '4', '3.809524', '5', '5.25', '1833.333333', '458.333333', '12.65', '11.594', '-1.056', '14300.00', '-12790377.6', 'OPEN', NULL, 3, '2026-06-02 09:02:26', '2026-06-02 11:49:38'),
(78, 34, 34, 'AB2F8/25022/L', '25022', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-11-25 14:00:00', '47.843', 'TG. UBAN', '2025-11-27 02:00:00', '44.496', '145', '4', '4.027778', '1.510417', '1.5', '1833.333333', '-19.097833', '3.821355', '3.347', '-0.474355', '14300.00', '-5745435.1955', 'OPEN', NULL, 3, '2026-06-02 09:04:13', '2026-06-02 11:50:10'),
(79, 34, 34, 'AB2F8/25022/D1', '25022', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-12-01 10:00:00', '39.810', 'JAMBI', '2025-12-02 22:00:00', '36.645', '145', '4', '4.027778', '1.510417', '1.5', '1774.193548', '-18.481774', '3.821355', '3.165', '-0.656355', '15300.00', '-8505770.0805', 'OPEN', NULL, 3, '2026-06-02 09:16:23', '2026-06-02 11:50:50'),
(80, 34, 34, 'AB2F8/25023/L', '25023', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-12-07 23:00:00', '25.735', 'TG. UBAN', '2025-12-09 23:00:00', '22.387', '145', '4', '3.020833', '1.510417', '2', '1774.193548', '868.615', '3.821355', '3.348', '-0.473355', '15300.00', '-6134254.7805', 'OPEN', NULL, 3, '2026-06-02 09:37:36', '2026-06-02 11:51:20'),
(81, 34, 34, 'AB2F8/25023/D1', '25023', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-12-14 11:30:00', '62.318', 'JAMBI', '2025-12-15 23:00:00', '59.089', '145', '4', '4.084506', '1.510417', '1.479167', '1774.193548', '-55.443548', '3.821355', '3.229', '-0.592355', '15300.00', '-7676387.6805', 'OPEN', NULL, 3, '2026-06-02 09:59:49', '2026-06-02 11:51:56'),
(82, 34, 34, 'AB2F8/25024/L', '25024', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-12-20 15:00:00', '49.137', 'TG. UBAN', '2025-12-22 09:00:00', '45.329', '145', '4', '3.452381', '1.510417', '1.75', '1774.193548', '425.066613', '3.821355', '3.808', '-0.013355', '15300.00', '-173068.7805', 'OPEN', NULL, 3, '2026-06-02 10:00:24', '2026-06-02 11:52:47'),
(83, 34, 34, 'AB2F8/25024/D1', '25024', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-12-24 15:30:00', '41.530', 'BELINYU', '2025-12-27 05:00:00', '36.069', '250', '4', '4.065041', '2.604167', '2.5625', '1774.193548', '-73.925323', '6.588543', '5.461', '-1.127543', '15300.00', '-14611942.4913', 'OPEN', NULL, 3, '2026-06-02 10:01:09', '2026-06-02 11:53:32'),
(84, 34, 34, 'AB2F8/25001/L', '25001', 'L', 'IMAM FAHRUDI', 'BELINYU', '2025-12-28 18:00:00', '32.643', 'PANJANG', '2026-01-02 02:00:00', '23.323', '497.2', '4', '4.78077', '5.179167', '4.333333', '1774.193548', '-1500.673225', '13.103293', '9.32', '-3.783293', '20750.00', '-66492320.29825', 'OPEN', NULL, 3, '2026-06-02 10:02:28', '2026-06-02 11:54:03'),
(85, 34, 34, 'AB2F8/26001/D1', '26001', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2026-01-04 17:30:00', '62.019', 'BELINYU', '2026-01-10 12:00:00', '49.363', '425', '4', '3.068592', '4.427083', '5.770833', '1774.193548', '2384.07258', '11.20052', '12.656', '1.45548', '20750.00', '25580424.87', 'OPEN', NULL, 3, '2026-06-02 10:06:39', '2026-06-02 11:54:33'),
(86, 34, 34, 'AB2F8/26002/L', '26002', 'L', 'IMAM FAHRUDI', 'BELINYU', '2026-01-13 23:30:00', '44.989', 'PANJANG', '2026-01-18 07:30:00', '35.475', '425', '4', '4.086539', '4.427083', '4.333333', '1774.193548', '-166.330645', '11.20052', '9.514', '-1.68652', '20750.00', '-29641010.63', 'OPEN', NULL, 3, '2026-06-02 10:07:18', '2026-06-02 11:55:03'),
(87, 34, 34, 'AB2F8/26002/D1', '26002', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2026-01-23 19:30:00', '64.249', 'JAMBI', '2026-01-31 06:00:00', '47.974', '480', '4', '2.689076', '5', '7.4375', '1774.193548', '4324.596773', '12.65', '16.275', '3.625', '20750.00', '63710281.25', 'OPEN', NULL, 3, '2026-06-02 10:07:56', '2026-06-02 11:55:30'),
(88, 34, 34, 'AB2F8/26003/L', '26003', 'L', 'IMAM FAHRUDI', 'JAMBI', '2026-02-06 08:00:00', '37.300', 'TG. UBAN', '2026-02-07 18:30:00', '34.082', '145', '4', '4.202899', '1.510417', '1.4375', '1964.285714', '-143.229821', '3.821355', '3.218', '-0.603355', '21200.00', '-10834083.722', 'OPEN', NULL, 3, '2026-06-02 10:08:43', '2026-06-02 12:00:00'),
(89, 34, 34, 'AB2F8/26003/D1', '26003', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-02-12 10:30:00', '29.347', 'BELINYU', '2026-02-15 00:00:00', '23.678', '250', '4', '4.065041', '2.604167', '2.5625', '1964.285714', '-81.845893', '6.588543', '5.669', '-0.919543', '21200.00', '-16511681.9252', 'OPEN', NULL, 3, '2026-06-02 10:09:43', '2026-06-02 11:59:03'),
(90, 34, 34, 'AB2F8/26004/L', '26004', 'L', 'IMAM FAHRUDI', 'BELINYU', '2026-02-16 20:30:00', '20.108', 'TG. UBAN', '2026-02-19 11:00:00', '14.334', '250', '4', '3.999999', '2.604167', '2.604167', '1964.285714', '0', '6.588543', '5.774', '-0.814543', '21200.00', '-14626259.9252', 'OPEN', NULL, 3, '2026-06-02 10:10:35', '2026-06-02 11:57:07'),
(91, 34, 34, 'AB2F8/26004/D1', '26004', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-02-21 15:30:00', '68.405', 'JAMBI', '2026-02-23 03:00:00', '65.196', '145', '4', '4.084506', '1.510417', '1.479167', '1964.285714', '-61.383929', '3.821355', '3.209', '-0.612355', '21200.00', '-10995691.322', 'OPEN', NULL, 3, '2026-06-02 10:12:14', '2026-06-02 11:56:41'),
(92, 34, 34, 'AB2F8/26005/L', '26005', 'L', 'IMAM FAHRUDI', 'JAMBI', '2026-02-28 12:00:00', '54.466', 'TG. UBAN', '2026-03-02 00:00:00', '51.229', '145', '4', '4.027778', '1.510417', '1.5', '1774.193548', '-18.481774', '3.821355', '3.237', '-0.584355', '23050.00', '-11408567.18925', 'OPEN', NULL, 3, '2026-06-02 10:15:03', '2026-06-02 11:56:10'),
(93, 34, 34, 'AB2F8/26005/D1', '26005', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-03-06 03:30:00', '46.746', 'JAMBI', '2026-03-07 15:00:00', '43.522', '145', '4', '4.084506', '1.510417', '1.479167', '1774.193548', '-55.443548', '3.821355', '3.224', '-0.597355', '23050.00', '-11662370.73925', 'OPEN', NULL, 3, '2026-06-02 10:16:05', '2026-06-02 11:52:22'),
(94, 34, 34, 'AB2F8/26006/L', '26006', 'L', 'IMAM FAHRUDI', 'JAMBI', '2026-03-13 05:30:00', '32.396', 'TG. UBAN', '2026-03-14 21:00:00', '28.855', '145', '4', '3.670887', '1.510417', '1.645833', '1774.193548', '240.254193', '3.821355', '3.541', '-0.280355', '23050.00', '-5473468.78925', 'OPEN', NULL, 3, '2026-06-02 10:16:51', '2026-06-02 11:43:56'),
(95, 34, 34, 'AB2F8/26006/D1', '26006', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-03-16 13:30:00', '66.810', 'JAMBI', '2026-03-18 01:00:00', '63.565', '145', '4', '4.084506', '1.510417', '1.479167', '1774.193548', '-55.443548', '3.821355', '3.245', '-0.576355', '23050.00', '-11252380.38925', 'OPEN', NULL, 3, '2026-06-02 10:18:39', '2026-06-02 11:43:00'),
(96, 34, 34, 'AB2F8/26007/L', '26007', 'L', 'IMAM FAHRUDI', 'JAMBI', '2026-03-24 08:30:00', '52.121', 'PANJANG', '2026-03-29 07:00:00', '41.466', '480', '4', '4.050633', '5', '4.9375', '1774.193548', '-110.887097', '12.65', '10.655', '-1.995', '23050.00', '-38949083.25', 'OPEN', NULL, 3, '2026-06-02 10:22:31', '2026-06-02 11:42:32'),
(97, 34, 34, 'AB2F8/26007/D1', '26007', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2026-04-03 02:30:00', '39.877', 'JAMBI', '2026-04-08 02:00:00', '29.814', '480', '4', '4.016736', '5', '4.979167', '1833.333333', '-38.193833', '12.65', '10.063', '-2.587', '28150.00', '-61681970.35', 'OPEN', NULL, 3, '2026-06-02 10:23:15', '2026-06-02 11:42:05'),
(98, 34, 34, 'AB2F8/26008/L', '26008', 'L', 'IMAM FAHRUDI', 'JAMBI', '2026-04-13 10:00:00', '21.984', 'PANJANG', '2026-04-18 09:00:00', '11.752', '480', '4', '4.033614', '5', '4.958333', '1833.333333', '-76.3895', '12.65', '10.232', '-2.418', '30550.00', '-62567805.3', 'OPEN', NULL, 3, '2026-06-02 10:25:42', '2026-06-02 11:41:41'),
(99, 34, 34, 'AB2F8/26008/D1', '26008', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2026-04-29 13:00:00', '54.661', 'JAMBI', '2026-05-04 21:30:00', '43.590', '480', '4', '3.735408', '5', '5.354167', '1774.193548', '628.360806', '12.65', '11.071', '-1.579', '30550.00', '-40857967.15', 'OPEN', NULL, 3, '2026-06-02 10:26:30', '2026-06-02 11:41:17'),
(100, 34, 34, 'AB2F8/26009/L', '26009', 'L', 'IMAM FAHRUDI', 'JAMBI', '2026-05-10 22:30:00', '34.534', 'TG. UBAN', '2026-05-12 09:00:00', '31.489', '145', '4', '4.202899', '1.510417', '1.4375', '1774.193548', '-129.368871', '3.821355', '3.045', '-0.776355', '30550.00', '-20088845.52675', 'OPEN', NULL, 3, '2026-06-02 10:27:17', '2026-06-02 11:40:49'),
(101, 45, 36, 'AB5FL9/25001/L', '25001', 'L', 'IMAM FAHRUDI', 'OB. JAMBI', '2025-01-11 17:18:00', '19.504', 'TG. UBAN', '2025-01-13 07:48:00', '15.377', '145', '4', '3.766233', '1.510417', '1.604167', '1774.193548', '166.330645', '3.081251', '4.127', '1.045749', '14950.00', '13241953.57485', 'OPEN', NULL, 3, '2026-06-02 10:31:02', '2026-06-02 11:38:47'),
(102, 45, 36, 'AB5FL9/25001/D1', '25001', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-01-23 08:29:00', '52.919', 'OB. JAMBI', '2025-01-24 20:29:00', '49.561', '145', '4', '4.027778', '1.510417', '1.5', '1774.193548', '-18.481774', '3.081251', '3.358', '0.276749', '15250.00', '3574697.64575', 'OPEN', NULL, 3, '2026-06-02 10:32:02', '2026-06-02 11:38:22'),
(103, 45, 36, 'AB5FL9/25002/L', '25002', 'L', 'IMAM FAHRUDI', 'OB. JAMBI', '2025-02-05 01:00:00', '35.135', 'TG. UBAN', '2025-02-06 12:00:00', '31.071', '145', '4', '4.142858', '1.510417', '1.458333', '1964.285714', '-102.307857', '3.081251', '4.064', '0.982749', '15150.00', '12610684.30545', 'OPEN', NULL, 3, '2026-06-02 10:32:47', '2026-06-02 11:37:15'),
(104, 45, 36, 'AB5FL9/25002/D1', '25002', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-02-14 11:35:00', '26.697', 'OB. JAMBI', '2025-02-15 23:35:00', '23.339', '145', '4', '4.027778', '1.510417', '1.5', '1964.285714', '-20.461964', '3.081251', '3.358', '0.276749', '15450.00', '3621578.92635', 'OPEN', NULL, 3, '2026-06-02 10:33:31', '2026-06-02 11:36:44'),
(105, 45, 36, 'AB5FL9/25003/L', '25003', 'L', 'IMAM FAHRUDI', 'OB. JAMBI', '2025-02-25 21:00:00', '11.475', 'TG. UBAN', '2025-02-27 08:18:00', '7.512', '145', '4', '4.10765', '1.510417', '1.470833', '1964.285714', '-77.754286', '3.081251', '3.963', '0.881749', '15150.00', '11314647.25545', 'OPEN', NULL, 3, '2026-06-02 10:34:15', '2026-06-02 11:33:02'),
(106, 45, 36, 'AB5FL9/25003/D1', '25003', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-03-01 06:12:00', '60.101', 'OB. JAMBI', '2025-03-02 18:12:00', '56.767', '145', '4', '4.027778', '1.510417', '1.5', '1774.193548', '-18.481774', '3.081251', '3.334', '0.252749', '15450.00', '3307511.32635', 'OPEN', NULL, 3, '2026-06-02 10:34:51', '2026-06-02 11:32:23'),
(107, 45, 36, 'AB5FL9/25004/L', '25004', 'L', 'IMAM FAHRUDI', 'OB. JAMBI', '2025-03-12 10:42:00', '41.274', 'TG. UBAN', '2025-03-13 20:30:00', '37.812', '145', '4', '4.289942', '1.510417', '1.408333', '1774.193548', '-181.116774', '3.081251', '3.462', '0.380749', '15150.00', '4885790.20545', 'OPEN', NULL, 3, '2026-06-02 10:35:33', '2026-06-02 11:31:27'),
(108, 45, 36, 'AB5FL9/25004/D1', '25004', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-03-16 08:30:00', '35.813', 'OB. JAMBI', '2025-03-17 20:30:00', '32.478', '145', '4', '4.027778', '1.510417', '1.5', '1774.193548', '-18.481774', '3.081251', '3.335', '0.253749', '15450.00', '3320597.47635', 'OPEN', NULL, 3, '2026-06-02 10:36:14', '2026-06-02 11:31:04'),
(109, 45, 36, 'AB5FL9/25005/L', '25005', 'L', 'IMAM FAHRUDI', 'OB. JAMBI', '2025-03-25 07:42:00', '17.819', 'TG. UBAN', '2025-03-26 18:00:00', '11.722', '145', '4', '4.227404', '1.510417', '1.429167', '1774.193548', '-144.153226', '3.081251', '6.097', '3.015749', '15150.00', '38698241.95545', 'OPEN', NULL, 3, '2026-06-02 11:11:36', '2026-06-02 11:30:42'),
(110, 45, 36, 'AB5FL9/25005/D1', '25005', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-03-28 10:30:00', '60.147', 'OB. JAMBI', '2025-03-29 22:30:00', '56.821', '145', '4', '4.027778', '1.510417', '1.5', '1774.193548', '-18.481774', '3.081251', '3.326', '0.244749', '15450.00', '3202822.12635', 'OPEN', NULL, 3, '2026-06-02 11:12:10', '2026-06-02 11:30:15'),
(111, 45, 36, 'AB5FL9/25006/L', '25006', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-04-05 08:30:00', '45.548', 'TG. UBAN', '2025-04-06 18:30:00', '42.457', '145', '4', '4.264705', '1.510417', '1.416667', '1833.333333', '-171.875', '3.081251', '3.091', '0.009749', '14500.00', '119732.3435', 'OPEN', NULL, 3, '2026-06-02 11:13:15', '2026-06-02 11:29:21'),
(112, 45, 36, 'AB5FL9/25006/D1', '25006', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-04-08 22:18:00', '40.145', 'JAMBI', '2025-04-10 10:18:00', '36.819', '145', '4', '4.027778', '1.510417', '1.5', '1833.333333', '-19.097833', '3.081251', '3.326', '0.244749', '14200.00', '2943694.1226', 'OPEN', NULL, 3, '2026-06-02 11:14:01', '2026-06-02 11:24:52'),
(113, 45, 36, 'AB5FL9/25007/L', '25007', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-04-16 02:06:00', '26.187', 'TG. UBAN', '2025-04-17 12:00:00', '21.976', '145', '4', '4.277286', '1.510417', '1.4125', '1833.333333', '-179.5145', '3.081251', '4.211', '1.129749', '14500.00', '13875012.3435', 'OPEN', NULL, 3, '2026-06-02 11:14:39', '2026-06-02 11:23:56'),
(114, 45, 36, 'AB5FL9/25007/D1', '25007', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-04-19 13:30:00', '47.827', 'JAMBI', '2025-04-21 01:30:00', '44.505', '145', '4', '4.027778', '1.510417', '1.5', '1833.333333', '-19.097833', '3.081251', '3.322', '0.240749', '14200.00', '2895584.5226', 'OPEN', NULL, 3, '2026-06-02 11:15:14', '2026-06-02 11:22:32'),
(115, 45, 36, 'AB5FL9/25008/L', '25008', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-04-27 01:00:00', '33.315', 'TG. UBAN', '2025-04-28 11:18:00', '30.737', '145', '4', '4.227404', '1.510417', '1.429167', '1833.333333', '-148.958333', '3.081251', '2.578', '-0.503251', '14500.00', '-6180677.1565', 'OPEN', NULL, 3, '2026-06-02 11:15:48', '2026-06-02 11:22:08'),
(116, 45, 36, 'AB5FL9/25008/D1', '25008', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-04-30 19:00:00', '28.678', 'JAMBI', '2025-05-02 07:00:00', '25.053', '145', '4', '4.027778', '1.510417', '1.5', '1774.193548', '-18.481774', '3.081251', '3.625', '0.543749', '14050', '6470803.41215', 'OPEN', NULL, 3, '2026-06-02 11:19:14', '2026-06-02 11:21:10'),
(117, 45, 36, 'AB5FL9/25009/L', '25009', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-05-09 04:30:00', '10.267', 'TG. UBAN', '2025-05-10 13:42:00', '9.364', '145', '4', '4.367471', '1.510417', '1.383333', '1774.193548', '-225.471613', '3.081251', '0.903', '-2.178251', '14350.00', '-26475442.86695', 'OPEN', NULL, 3, '2026-06-02 12:30:43', '2026-06-02 12:30:43'),
(118, 45, 36, 'AB5FL9/25009/D1', '25009', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-05-11 16:48:00', '49.478', 'JAMBI', '2025-05-13 04:48:00', '46.150', '145', '4', '4.027778', '1.510417', '1.5', '1774.193548', '-18.481774', '3.081251', '3.328', '0.246749', '14050.00', '2936399.46215', 'OPEN', NULL, 3, '2026-06-02 12:31:33', '2026-06-02 12:31:33'),
(119, 45, 36, 'AB5FL9/25010/L', '25010', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-05-21 07:00:00', '34.125', 'SAMBU', '2025-05-23 16:30:00', '29.427', '235', '4', '4.086957', '2.447917', '2.395833', '1774.193548', '-92.407097', '4.993751', '4.698', '-0.295751', '14350.00', '-3594690.74195', 'OPEN', NULL, 3, '2026-06-02 12:35:10', '2026-06-02 12:35:10'),
(120, 45, 36, 'AB5FL9/25010/D1', '25010', 'D1', 'IMAM FAHRUDI', 'SAMBU', '2025-05-31 21:00:00', '26.397', 'KABIL', '2025-06-01 08:30:00', '25.43', '40', '4', '3.478258', '0.416667', '0.479167', '1833.333333', '114.583333', '0.850001', '0.967', '0.116999', '13800.00', '1367554.5114', 'OPEN', NULL, 3, '2026-06-02 12:36:49', '2026-06-02 12:36:49'),
(121, 45, 36, 'AB5FL9/25011/L', '25011', 'L', 'IMAM FAHRUDI', 'KABIL', '2025-06-08 20:42:00', '21.197', 'TG. UBAN', '2025-06-08 22:24:00', '21.063', '6', '4', '3.529428', '0.0625', '0.070833', '1833.333333', '15.277167', '0.1275', '0.134', '0.0065', '13800.00', '75975.9', 'OPEN', NULL, 3, '2026-06-02 12:37:54', '2026-06-02 12:37:54'),
(122, 45, 36, 'AB5FL9/25011/D1', '25011', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-06-11 08:42:00', '53.71', 'P. BALAM', '2025-06-15 00:00:00', '44.631', '288', '4', '3.298969', '3', '3.6375', '1833.333333', '1168.75', '6.12', '9.079', '2.959', '13500.00', '33834685.5', 'OPEN', NULL, 3, '2026-06-02 12:38:54', '2026-06-02 12:38:54'),
(123, 45, 36, 'AB5FL9/25012/L', '25012', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2025-08-27 23:30:00', '18.948', 'TG. UBAN', '2025-08-30 22:00:00', '13.31', '288', '4', '4.085106', '3', '2.9375', '1774.193548', '-110.887097', '6.12', '5.638', '-0.482', '14750.00', '-6021746.5', 'OPEN', NULL, 3, '2026-06-02 12:39:45', '2026-06-02 12:39:45'),
(124, 45, 36, 'AB5FL9/25012/D1', '25012', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-09-04 11:30:00', '43.04', 'BELINYU', '2025-09-07 03:00:00', '36.924', '248', '4', '3.905512', '2.583333', '2.645833', '1833.333333', '114.583333', '5.269999', '6.116', '0.846001', '14150.00', '10139364.28505', 'OPEN', NULL, 3, '2026-06-02 12:41:31', '2026-06-02 12:41:31'),
(125, 45, 36, 'AB5FL9/25013/L', '25013', 'L', 'IMAM FAHRUDI', 'BELINYU', '2025-09-10 02:00:00', '33.576', 'TG. UBAN', '2025-09-12 15:00:00', '28.46', '248', '4', '4.065573', '2.583333', '2.541667', '1833.333333', '-76.387667', '5.269999', '5.116', '-0.153999', '14450.00', '-1884816.86085', 'OPEN', NULL, 3, '2026-06-02 12:43:04', '2026-06-02 12:43:04'),
(126, 45, 36, 'AB5FL9/25013/D1', '25013', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-09-16 01:00:00', '25.311', 'JAMBI', '2025-09-17 13:00:00', '22.258', '145', '4', '4.027778', '1.510417', '1.5', '1833.333333', '-19.097833', '3.081251', '3.053', '-0.028251', '14150.00', '-338589.64755', 'OPEN', NULL, 3, '2026-06-02 12:55:44', '2026-06-02 12:55:44'),
(127, 45, 36, 'AB5FL9/25014/L', '25014', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-09-23 17:30:00', '10.126', 'TG. UBAN', '2025-09-25 07:30:00', '6.157', '145', '4', '3.81579', '1.510417', '1.583333', '1833.333333', '133.679333', '3.081251', '3.969', '0.887749', '14450.00', '10865293.17335', 'OPEN', NULL, 3, '2026-06-02 12:57:16', '2026-06-02 12:57:16'),
(128, 45, 36, 'AB5FL9/25014/D1', '25014', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-09-28 00:06:00', '45.143', 'BELINYU', '2025-09-30 17:00:00', '39.679', '248', '4', '3.821263', '2.583333', '2.704167', '1833.333333', '221.529', '5.269999', '5.464', '0.194001', '14150.00', '2325111.68505', 'OPEN', NULL, 3, '2026-06-02 12:58:15', '2026-06-02 12:58:15'),
(129, 45, 36, 'AB5FL9/25015/L', '25015', 'L', 'IMAM FAHRUDI', 'BELINYU', '2025-10-02 23:02:00', '35.096', 'PANJANG', '2025-10-07 10:33:00', '26.255', '430', '4', '3.99938', '4.479167', '4.479861', '1774.193548', '1.23129', '9.137501', '8.841', '-0.296501', '14300.00', '-3591249.7621', 'OPEN', NULL, 3, '2026-06-02 12:59:16', '2026-06-02 12:59:16'),
(130, 45, 36, 'AB5FL9/25015/D1', '25015', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2025-10-10 12:00:00', '48.2', 'BELINYU', '2025-10-15 10:04:00', '38.203', '430', '4', '3.64201', '4.479167', '4.919444', '1774.193548', '781.136613', '9.137501', '9.997', '0.859499', '14300.00', '10410337.8379', 'OPEN', NULL, 3, '2026-06-02 13:00:23', '2026-06-02 13:00:23'),
(131, 45, 36, 'AB5FL9/25015/D2', '25015', 'D2', 'IMAM FAHRUDI', 'BELINYU', '2025-10-16 12:57:00', '34.973', 'JAMBI', '2025-10-17 23:02:00', '31.735', '130', '4', '3.814181', '1.354167', '1.420139', '1774.193548', '117.047097', '2.762501', '3.238', '0.475499', '14300.00', '5759291.4379', 'OPEN', NULL, 3, '2026-06-02 13:03:45', '2026-06-02 13:03:45'),
(132, 45, 36, 'AB5FL9/25016/L', '25016', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-10-23 12:57:00', '20.321', 'TG. UBAN', '2025-10-25 01:26:00', '16.988', '145', '4', '3.974417', '1.510417', '1.520139', '1774.193548', '17.24871', '3.081251', '3.333', '0.251749', '14300.00', '3049209.0629', 'OPEN', NULL, 3, '2026-06-02 13:04:39', '2026-06-02 13:04:39'),
(133, 45, 36, 'AB5FL9/25016/D1', '25016', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-10-26 06:00:00', '57.017', 'JAMBI', '2025-10-27 18:00:00', '53.986', '145', '4', '4.027778', '1.510417', '1.5', '1774.193548', '-18.481774', '3.081251', '3.031', '-0.050251', '14300.00', '-608645.1371', 'OPEN', NULL, 3, '2026-06-02 13:06:04', '2026-06-02 13:06:04'),
(134, 45, 36, 'AB5FL9/25017/L', '25017', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-11-02 10:00:00', '42.109', 'TG. UBAN', '2025-11-03 22:00:00', '38.652', '145', '4', '4.027778', '1.510417', '1.5', '1833.333333', '-19.097833', '3.081251', '3.457', '0.375749', '14300.00', '4551109.4629', 'OPEN', NULL, 3, '2026-06-02 13:08:46', '2026-06-02 13:08:46'),
(135, 45, 36, 'AB5FL9/25017/D1', '25017', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-11-06 15:00:00', '36.254', 'JAMBI', '2025-11-08 03:00:00', '32.223', '145', '4', '4.027778', '1.510417', '1.5', '1833.333333', '-19.097833', '3.081251', '4.031', '0.949749', '14300.00', '11503454.8629', 'OPEN', NULL, 3, '2026-06-02 13:09:34', '2026-06-02 13:09:34'),
(136, 45, 36, 'AB5FL9/25018/L', '25018', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-11-13 19:00:00', '23.514', 'TG. UBAN', '2025-11-15 07:30:00', '19.735', '145', '4', '3.972604', '1.510417', '1.520833', '1833.333333', '19.096', '3.081251', '3.779', '0.697749', '14300.00', '8451205.6629', 'OPEN', NULL, 3, '2026-06-02 13:10:37', '2026-06-02 13:10:37'),
(137, 45, 36, 'AB5FL9/25018/D1', '25018', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-11-18 07:00:00', '58.644', 'JAMBI', '2025-11-19 19:00:00', '55.649', '145', '4', '4.027778', '1.510417', '1.5', '1833.333333', '-19.097833', '3.081251', '2.995', '-0.086251', '14300.00', '-1044680.7371', 'OPEN', NULL, 3, '2026-06-02 13:11:42', '2026-06-02 13:11:42'),
(138, 45, 36, 'AB5FL9/25019/L', '25019', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-11-26 11:00:00', '45.316', 'TG. UBAN', '2025-11-27 22:00:00', '42.333', '145', '4', '4.142858', '1.510417', '1.458333', '1833.333333', '-95.487333', '3.081251', '2.983', '-0.098251', '14300.00', '-1190025.9371', 'OPEN', NULL, 3, '2026-06-02 13:15:03', '2026-06-02 13:15:03'),
(139, 45, 36, 'AB5FL9/25019/D1', '25019', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-12-08 07:00:00', '36.178', 'JAMBI', '2025-12-09 22:00:00', '33.243', '145', '4', '3.717949', '1.510417', '1.625', '1774.193548', '203.292419', '3.081251', '2.935', '-0.146251', '15300.00', '-1895281.3341', 'OPEN', NULL, 3, '2026-06-02 13:17:52', '2026-06-02 13:17:52'),
(140, 45, 36, 'AB5FL9/25020/L', '25020', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-12-14 18:30:00', '23.577', 'TG. UBAN', '2025-12-16 07:00:00', '20.503', '145', '4', '3.972604', '1.510417', '1.520833', '1774.193548', '18.48', '3.081251', '3.074', '-0.007251', '15300.00', '-93966.4341', 'OPEN', NULL, 3, '2026-06-02 13:18:38', '2026-06-02 13:18:38'),
(141, 45, 36, 'AB5FL9/25020/D1', '25020', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-12-21 06:30:00', '58.664', 'JAMBI', '2025-12-24 10:30:00', '52.453', '272', '4', '3.578947', '2.833333', '3.166667', '1774.193548', '591.399032', '5.779999', '6.211', '0.431001', '15300.00', '5585385.0591', 'OPEN', NULL, 3, '2026-06-02 13:23:23', '2026-06-02 13:23:23'),
(142, 45, 36, 'AB5FL9/25021/L', '25021', 'L', 'IMAM FAHRUDI', 'JAMBI', '2025-12-30 06:30:00', '40.508', 'TG. UBAN', '2026-01-01 01:00:00', '36.917', '145', '4', '3.411765', '1.510417', '1.770833', '1774.193548', '462.028387', '3.081251', '3.591', '0.509749', '20750.00', '8958966.11225', 'OPEN', NULL, 3, '2026-06-02 13:24:12', '2026-06-02 13:24:12'),
(143, 45, 36, 'AB5FL9/26021/D1', '26021', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-01-06 11:00:00', '33.675', 'JAMBI', '2026-01-08 02:30:00', '30.396', '145', '4', '3.670887', '1.510417', '1.645833', '1774.193548', '240.254193', '3.081251', '3.279', '0.197749', '20750.00', '3475488.11225', 'OPEN', NULL, 3, '2026-06-02 13:24:54', '2026-06-02 13:24:54'),
(144, 45, 36, 'AB5FL9/26001/L', '26001', 'L', 'IMAM FAHRUDI', 'JAMBI', '2026-01-14 07:00:00', '19.614', 'TG. UBAN', '2026-01-15 22:30:00', '16.326', '145', '4', '3.670887', '1.510417', '1.645833', '1774.193548', '240.254193', '3.081251', '3.288', '0.206749', '20750.00', '3633665.36225', 'OPEN', NULL, 3, '2026-06-02 13:30:57', '2026-06-02 13:30:57'),
(145, 45, 36, 'AB5FL9/26001/D1', '26001', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-01-18 18:30:00', '54.741', 'JAMBI', '2026-01-20 07:00:00', '51.609', '145', '4', '3.972604', '1.510417', '1.520833', '1774.193548', '18.48', '3.081251', '3.132', '0.050749', '20750.00', '891926.36225', 'OPEN', NULL, 3, '2026-06-02 13:31:41', '2026-06-02 13:31:41'),
(146, 45, 36, 'AB5FL9/26002/L', '26002', 'L', 'IMAM FAHRUDI', 'JAMBI', '2026-01-25 08:30:00', '42.108', 'TG. UBAN', '2026-01-27 03:00:00', '38.496', '145', '4', '3.411765', '1.510417', '1.770833', '1774.193548', '462.028387', '3.081251', '3.612', '0.530749', '20750.00', '9328046.36225', 'OPEN', NULL, 3, '2026-06-02 13:34:31', '2026-06-02 13:34:31'),
(147, 45, 36, 'AB5FL9/26002/D1', '26002', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-01-29 07:30:00', '36.335', 'JAMBI', '2026-01-30 23:00:00', '33.045', '145', '4', '3.670887', '1.510417', '1.645833', '1774.193548', '240.254193', '3.081251', '3.29', '0.208749', '20750.00', '3668815.86225', 'OPEN', NULL, 3, '2026-06-02 13:35:21', '2026-06-02 13:35:21'),
(148, 45, 36, 'AB5FL9/26003/L', '26003', 'L', 'IMAM FAHRUDI', 'JAMBI', '2026-02-07 09:30:00', '22.607', 'TG. UBAN', '2026-02-08 23:30:00', '19.28', '145', '4', '3.81579', '1.510417', '1.583333', '1964.285714', '143.227857', '3.081251', '3.327', '0.245749', '21200.00', '4412767.3436', 'OPEN', NULL, 3, '2026-06-02 13:37:29', '2026-06-02 13:37:29'),
(149, 45, 36, 'AB5FL9/26003/D1', '26003', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-02-14 08:00:00', '57.248', 'JAMBI', '2026-02-16 00:00:00', '53.909', '145', '4', '3.624999', '1.510417', '1.666667', '1964.285714', '306.919643', '3.081251', '3.339', '0.257749', '21200.00', '4628244.1436', 'OPEN', NULL, 3, '2026-06-02 13:38:40', '2026-06-02 13:38:40'),
(150, 45, 36, 'AB5FL9/26004/L', '26004', 'L', 'IMAM FAHRUDI', 'JAMBI', '2026-02-20 20:30:00', '44.386', 'MUSI', '2026-02-22 03:00:00', '41.842', '130', '4', '4.262296', '1.354167', '1.270833', '1964.285714', '-163.691786', '2.762501', '2.544', '-0.218501', '21200.00', '-3923491.3564', 'OPEN', NULL, 3, '2026-06-02 13:39:41', '2026-06-02 13:39:41'),
(151, 45, 36, 'AB5FL9/26004/D1', '26004', 'D1', 'IMAM FAHRUDI', 'MUSI', '2026-02-25 23:30:00', '38.044', 'JAMBI', '2026-02-27 18:00:00', '34.496', '130', '4', '3.058824', '1.354167', '1.770833', '1964.285714', '818.451071', '2.762501', '3.548', '0.785499', '21200.00', '14104734.2436', 'OPEN', NULL, 3, '2026-06-02 13:40:27', '2026-06-02 13:40:27'),
(152, 45, 36, 'AB5FL9/26005/L', '26005', 'L', 'IMAM FAHRUDI', 'JAMBI', '2026-03-05 01:00:00', '23.759', 'TG. UBAN', '2026-03-06 12:30:00', '20.799', '145', '4', '4.084506', '1.510417', '1.479167', '1774.193548', '-55.443548', '3.081251', '2.96', '-0.121251', '23050.00', '-2367225.71085', 'OPEN', NULL, 3, '2026-06-02 13:41:12', '2026-06-02 13:41:12'),
(153, 45, 36, 'AB5FL9/26005/D1', '26005', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-03-08 16:00:00', '60.162', 'JAMBI', '2026-03-10 04:00:00', '57.165', '145', '4', '4.027778', '1.510417', '1.5', '1774.193548', '-18.481774', '3.081251', '2.997', '-0.084251', '23050.00', '-1644861.76085', 'OPEN', NULL, 3, '2026-06-02 13:41:53', '2026-06-02 13:41:53'),
(154, 45, 36, 'AB5FL9/26006/L', '26006', 'L', 'IMAM FAHRUDI', 'JAMBI', '2026-03-15 10:30:00', '47.045', 'TG. UBAN', '2026-03-17 00:30:00', '43.979', '145', '4', '3.81579', '1.510417', '1.583333', '1774.193548', '129.367097', '3.081251', '3.066', '-0.015251', '23050.00', '-297750.61085', 'OPEN', NULL, 3, '2026-06-02 13:42:42', '2026-06-02 13:42:42'),
(155, 45, 36, 'AB5FL9/26006/D1', '26006', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-03-18 09:24:00', '42.168', 'JAMBI', '2026-03-19 21:24:00', '39.171', '145', '4', '4.027778', '1.510417', '1.5', '1774.193548', '-18.481774', '3.081251', '2.997', '-0.084251', '23050.00', '-1644861.76085', 'OPEN', NULL, 3, '2026-06-02 13:43:29', '2026-06-02 13:43:29'),
(156, 45, 36, 'AB5FL9/26007/L', '26007', 'L', 'IMAM FAHRUDI', 'JAMBI', '2026-03-26 13:00:00', '27.68', 'TG. UBAN', '2026-03-28 03:00:00', '24.516', '145', '4', '3.81579', '1.510417', '1.583333', '1774.193548', '129.367097', '3.081251', '3.164', '0.082749', '23050.00', '1615537.68915', 'OPEN', NULL, 3, '2026-06-02 13:44:29', '2026-06-02 13:44:29'),
(157, 45, 36, 'AB5FL9/26007/D1', '26007', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-03-30 03:00:00', '63.952', 'JAMBI', '2026-03-31 17:00:00', '60.792', '145', '4', '3.81579', '1.510417', '1.583333', '1774.193548', '129.367097', '3.081251', '3.16', '0.078749', '23050.00', '1537444.28915', 'OPEN', NULL, 3, '2026-06-02 13:45:15', '2026-06-02 13:45:15'),
(158, 45, 36, 'AB5FL9/26008/L', '26008', 'L', 'IMAM FAHRUDI', 'JAMBI', '2026-04-06 21:00:00', '50.26', 'TG. UBAN', '2026-04-08 09:00:00', '47.267', '145', '4', '4.027778', '1.510417', '1.5', '1833.333333', '-19.097833', '3.081251', '2.993', '-0.088251', '28150.00', '-2104173.00555', 'OPEN', NULL, 3, '2026-06-02 13:46:08', '2026-06-02 13:46:08'),
(159, 45, 36, 'AB5FL9/26008/D1', '26008', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-04-14 16:30:00', '43.769', 'JAMBI', '2026-04-16 06:00:00', '40.651', '145', '4', '3.866667', '1.510417', '1.5625', '1833.333333', '95.4855', '3.081251', '3.118', '0.036749', '30550.00', '950911.61165', 'OPEN', NULL, 3, '2026-06-02 13:47:15', '2026-06-02 13:47:15'),
(160, 45, 36, 'AB5FL9/26008/D2', '26008', 'D2', 'IMAM FAHRUDI', 'JAMBI', '2026-04-22 07:30:00', '29.147', 'BELINYU', '2026-04-23 17:00:00', '26.320', '135', '4', '4.029852', '1.40625', '1.395833', '1833.333333', '-19.097833', '2.86875', '2.827', '-0.04175', '30550.00', '-1080316.7375', 'OPEN', NULL, 3, '2026-06-02 13:48:15', '2026-06-02 13:48:15'),
(161, 45, 36, 'AB5FL9/26009/L', '26009', 'L', 'IMAM FAHRUDI', 'BELINYU', '2026-04-24 20:00:00', '59.221', 'MUNTOK', '2026-04-25 10:00:00', '57.117', '70', '4', '5.000003', '0.729167', '0.583333', '1833.333333', '-267.362333', '1.487501', '2.104', '0.616499', '30550.00', '15952435.64915', 'OPEN', NULL, 3, '2026-06-02 13:49:09', '2026-06-02 13:49:09'),
(162, 45, 36, 'AB5FL9/26009/D1', '26009', 'D1', 'IMAM FAHRUDI', 'MUNTOK', '2026-04-26 20:30:00', '56.54', 'JAMBI', '2026-04-28 07:30:00', '53.49', '133', '4', '3.800001', '1.385417', '1.458333', '1833.333333', '133.679333', '2.826251', '3.05', '0.223749', '30550.00', '5789695.56165', 'OPEN', NULL, 3, '2026-06-02 13:49:57', '2026-06-02 13:49:57'),
(163, 45, 36, 'AB5FL9/26010/L', '26010', 'L', 'IMAM FAHRUDI', 'JAMBI', '2026-05-04 11:30:00', '41.727', 'TG. UBAN', '2026-05-05 22:30:00', '38.785', '145', '4', '4.142858', '1.510417', '1.458333', '1774.193548', '-92.407097', '3.081251', '2.942', '-0.139251', '30550.00', '-3603237.98835', 'OPEN', NULL, 3, '2026-06-02 13:51:15', '2026-06-02 13:51:15'),
(164, 45, 36, 'AB5FL9/26011/D1', '26010', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-05-08 03:00:00', '36.846', 'JAMBI', '2026-05-09 20:30:00', '33.354', '145', '4', '3.493975', '1.510417', '1.729167', '1774.193548', '388.104839', '3.081251', '3.492', '0.410749', '30550.00', '10628479.51165', 'OPEN', NULL, 3, '2026-06-02 13:52:13', '2026-06-02 13:52:13'),
(165, 45, 36, 'AB5FL9/26011/L', '26011', 'L', 'IMAM FAHRUDI', 'JAMBI', '2026-05-16 09:30:00', '19.232', 'TG. UBAN', '2026-05-17 21:00:00', '17.887', '145', '4', '4.084506', '1.510417', '1.479167', '1774.193548', '-55.443548', '3.081251', '1.345', '-1.736251', '30550.00', '-44926970.43835', 'OPEN', NULL, 3, '2026-06-02 13:53:15', '2026-06-02 13:53:15'),
(166, 45, 36, 'AB5FL9/26011/D1', '26011', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-05-20 14:30:00', '58.358', 'JAMBI', '2026-05-22 02:30:00', '55.141', '145', '4', '4.027778', '1.510417', '1.5', '1774.193548', '-18.481774', '3.081251', '3.217', '0.135749', '30550.00', '3512620.76165', 'OPEN', NULL, 3, '2026-06-02 13:54:02', '2026-06-02 13:54:02'),
(167, 42, 49, 'F18/25021/D4', '25021', 'D4', 'IMAM FAHRUDI', 'FT BIAK', '2025-01-01 04:59:00', '60.989', 'FT SERUI', '2025-01-01 22:59:00', '56.702', '120', '120', '6.666667', '0.041667', '0.75', '93.548387', '66.26341', '0.277169', '4.287', '4.009831', '14950.00', '50775086.51215', 'OPEN', NULL, 3, '2026-06-02 13:56:57', '2026-06-02 13:56:57'),
(168, 42, 49, 'F18/25001/L', '25001', 'L', 'IMAM FAHRUDI', 'FT SERUI', '2025-01-01 09:30:00', '56.127', 'IT WAYAME', '2025-01-07 06:00:00', '23.838', '670', '10', '4.768683', '2.791667', '5.854167', '93.548387', '286.491935', '19.039169', '32.289', '13.249831', '14950.00', '167777972.51215', 'OPEN', NULL, 3, '2026-06-02 13:58:41', '2026-06-02 14:01:37'),
(169, 42, 49, 'F18/25001/D1', '25001', 'D1', 'IMAM FAHRUDI', 'IT WAYAME', '2025-01-17 10:00:00', '112.264', 'FT MANOKWARI', '2025-01-21 09:30:00', '85.146', '550', '10', '5.759162', '2.291667', '3.979167', '93.548387', '157.862903', '15.629169', '27.118', '11.488831', '14950.00', '145479045.86215', 'OPEN', NULL, 3, '2026-06-02 14:01:18', '2026-06-02 14:01:54'),
(170, 42, 49, 'F18/25001/D2', '25001', 'D2', 'IMAM FAHRUDI', 'FT MANOKWARI', '2025-01-22 01:59:00', '84.017', 'FT NABIRE', '2025-01-23 04:00:00', '76.633', '185', '10', '7.110825', '0.770833', '1.084028', '93.548387', '29.298887', '5.257081', '7.384', '2.126919', '14950.00', '26932430.87535', 'OPEN', NULL, 3, '2026-06-02 14:02:55', '2026-06-02 14:02:55'),
(171, 42, 49, 'F18/25001/D3', '25001', 'D3', 'IMAM FAHRUDI', 'FT NABIRE', '2025-01-23 16:30:00', '75.652', 'FT SERUI', '2025-01-24 06:41:00', '71.620', '105', '10', '7.403058', '0.4375', '0.590972', '93.548387', '14.357058', '2.98375', '4.032', '1.04825', '14950.00', '13273622.8625', 'OPEN', NULL, 3, '2026-06-02 14:03:42', '2026-06-02 14:03:42'),
(172, 42, 49, 'F18/25001/D4', '25001', 'D4', 'IMAM FAHRUDI', 'FT SERUI', '2025-01-24 16:00:00', '71.033', 'FT BIAK', '2025-01-25 09:11:00', '66.148', '120', '10', '6.983513', '0.5', '0.715972', '93.548387', '20.203832', '3.41', '4.885', '1.475', '14950.00', '18677408.75', 'OPEN', NULL, 3, '2026-06-02 14:04:39', '2026-06-02 14:04:39'),
(173, 42, 49, 'F18/25002/L', '25002', 'L', 'IMAM FAHRUDI', 'FT BIAK', '2025-01-25 20:29:00', '65.253', 'IT WAYAME', '2025-01-30 08:29:00', '35.223', '645', '10', '5.972222', '2.6875', '4.5', '93.548387', '169.556451', '18.32875', '30.03', '11.70125', '14950.00', '148168833.3125', 'OPEN', NULL, 3, '2026-06-02 14:05:26', '2026-06-02 14:05:26'),
(174, 42, 49, 'F18/25002/D1', '25002', 'D1', 'IMAM FAHRUDI', 'IT WAYAME', '2025-02-01 01:30:00', '126.842', 'FT SERUI', '2025-02-05 10:42:00', '96.963', '670', '4', '6.368822', '6.979167', '4.383333', '103.571429', '-268.854237', '47.597919', '29.879', '-17.718919', '14950.00', '-224368469.67535', 'OPEN', NULL, 3, '2026-06-02 14:06:29', '2026-06-02 14:06:29'),
(175, 42, 49, 'F18/25002/D2', '25002', 'D2', 'IMAM FAHRUDI', 'FT SERUI', '2025-02-05 18:00:00', '96.51', 'FT MANOKWARI', '2025-02-06 17:54:00', '89.722', '155', '10', '6.485358', '0.645833', '0.995833', '103.571429', '36.25', '4.404581', '6.788', '2.383419', '15150.00', '30584151.77895', 'OPEN', NULL, 3, '2026-06-02 14:07:22', '2026-06-02 14:07:22'),
(176, 42, 49, 'F18/25002/D3', '25002', 'D3', 'IMAM FAHRUDI', 'FT MANOKWARI', '2025-02-07 09:30:00', '88.603', 'FT NABIRE', '2025-02-08 13:59:00', '80.448', '185', '10', '6.495024', '0.770833', '1.186806', '103.571429', '43.082918', '5.257081', '8.155', '2.897919', '15150.00', '37186241.50395', 'OPEN', NULL, 3, '2026-06-02 14:08:13', '2026-06-02 14:08:13'),
(177, 42, 49, 'F18/25002/D4', '25002', 'D4', 'IMAM FAHRUDI', 'FT NABIRE', '2025-02-08 23:29:00', '79.827', 'FT BIAK', '2025-02-10 00:30:00', '72.723', '165', '10', '6.595604', '0.6875', '1.042361', '103.571429', '36.753461', '4.68875', '7.104', '2.41525', '15150.00', '30992608.7625', 'OPEN', NULL, 3, '2026-06-02 14:08:58', '2026-06-02 14:08:58');
INSERT INTO `t_master_cable` (`id`, `id_vessel`, `id_kontrak`, `no_voyage_gab`, `no_voyage`, `jenis_voyage`, `master`, `atd_port`, `atd_time`, `atd_rob`, `ata_port`, `ata_time`, `ata_rob`, `distance`, `speed`, `act_speed`, `est_sail_day`, `act_sail_day`, `charter_rate_day`, `est_claim_speed`, `std_bunker_cons`, `act_bunker_cons`, `excess_bunker`, `bunker_price`, `est_claim_bunker`, `status`, `keterangan`, `user_id`, `created_at`, `updated_at`) VALUES
(178, 42, 49, 'F18/25003/L', '25003', 'L', 'IMAM FAHRUDI', 'FT BIAK', '2025-02-10 18:30:00', '71.171', 'IT WAYAME', '2025-02-15 04:00:00', '42.059', '640', '10', '6.066351', '2.666667', '4.395833', '103.571429', '179.092194', '18.186669', '29.112', '10.925331', '15150.00', '140194393.65855', 'OPEN', NULL, 3, '2026-06-02 14:09:44', '2026-06-02 14:09:44'),
(179, 42, 49, 'F18/25003/D1', '25003', 'D1', 'IMAM FAHRUDI', 'IT WAYAME', '2025-02-21 19:30:00', '124.678', 'FT SORONG', '2025-02-24 00:30:00', '109.624', '330', '10', '6.226416', '1.375', '2.208333', '103.571429', '86.30949', '9.3775', '15.054', '5.6765', '15150.00', '72841131.825', 'OPEN', NULL, 3, '2026-06-02 14:10:38', '2026-06-02 14:10:38'),
(180, 42, 49, 'F18/25003/D2', '25003', 'D2', 'IMAM FAHRUDI', 'FT SORONG', '2025-02-24 12:00:00', '108.991', 'FT MANOKWARI', '2025-02-26 03:30:00', '97.772', '330', '10', '8.354432', '1.375', '1.645833', '103.571429', '28.050561', '9.3775', '11.219', '1.8415', '15150.00', '23630220.075', 'OPEN', NULL, 3, '2026-06-02 14:11:31', '2026-06-02 14:11:31'),
(181, 42, 49, 'F18/25003/D3', '25003', 'D3', 'IMAM FAHRUDI', 'FT MANOKWARI', '2025-02-26 19:00:00', '96.916', 'FT NABIRE', '2025-02-27 21:00:00', '89.230', '180', '10', '6.923079', '0.75', '1.083333', '103.571429', '34.523775', '5.115', '7.686', '2.571', '15150.00', '32991200.55', 'OPEN', NULL, 3, '2026-06-02 14:12:16', '2026-06-02 14:12:16'),
(182, 42, 49, 'F18/25003/D4', '25003', 'D4', 'IMAM FAHRUDI', 'FT NABIRE', '2025-02-28 08:12:00', '88.421', 'FT SERUI', '2025-02-28 22:30:00', '84.359', '105', '10', '7.342661', '0.4375', '0.595833', '103.571429', '16.398775', '2.98375', '4.062', '1.07825', '15150.00', '13836157.9125', 'OPEN', NULL, 3, '2026-06-02 14:13:05', '2026-06-02 14:13:05'),
(183, 42, 49, 'F18/25003/D5', '25003', 'D5', 'IMAM FAHRUDI', 'FT SERUI', '2025-03-01 09:00:00', '83.78', 'FT SORONG', '2025-03-03 23:42:00', '66.657', '360', '10', '5.741627', '1.5', '2.6125', '93.548387', '104.072581', '10.23', '17.123', '6.893', '14950.00', '87283646.45', 'OPEN', NULL, 3, '2026-06-02 14:13:54', '2026-06-02 14:13:54'),
(184, 36, 38, 'F19/25001/L', '25001', 'L', 'IMAM FAHRUDI', 'BITUNG', '2025-01-09 02:29:00', '37.536', 'KALBUT', '2025-01-14 13:30:00', '11.968', '1050', '10', '8.014247', '4.375', '5.459028', '167.741935', '181.836954', '27.2125', '25.568', '-1.6445', '14950.00', '-20823727.925', 'OPEN', NULL, 3, '2026-06-02 14:15:08', '2026-06-02 14:15:08'),
(185, 36, 38, 'F19/25001/D1', '25001', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-02-12 20:12:00', '25.698', 'BENOA', '2025-02-13 15:54:00', '22.111', '152', '10', '7.715739', '0.633333', '0.820833', '185.714286', '34.821429', '4.015331', '3.587', '-0.428331', '14800.00', '-5369386.0836', 'OPEN', NULL, 3, '2026-06-02 14:16:01', '2026-06-02 14:16:01'),
(186, 36, 38, 'F19/25001/D2', '25001', 'D2', 'IMAM FAHRUDI', 'BENOA', '2025-02-15 13:59:00', '18.821', 'TUBAN', '2025-02-17 05:12:00', '10.356', '316', '10', '8.057797', '1.316667', '1.634028', '185.714286', '58.938472', '8.347669', '8.465', '0.117331', '14800.00', '1470814.4836', 'OPEN', NULL, 3, '2026-06-02 14:16:45', '2026-06-02 14:16:45'),
(187, 36, 38, 'F19/25002/L', '25002', 'L', 'IMAM FAHRUDI', 'TUBAN', '2025-02-17 02:29:00', '77.634', 'BALONGAN', '2025-02-18 22:30:00', '72.645', '205', '10', '4.657326', '0.854167', '1.834028', '185.714286', '181.974186', '5.312919', '4.989', '-0.323919', '14800.00', '-4060519.0164', 'OPEN', NULL, 10, '2026-06-02 14:21:19', '2026-06-03 01:40:36'),
(188, 36, 38, 'F19/25002/D1', '25002', 'D1', 'IMAM FAHRUDI', 'BALONGAN', '2025-02-21 01:00:00', '70.603', 'PLAJU', '2025-02-22 22:42:00', '62.463', '370', '10', '8.096279', '1.541667', '1.904167', '185.714286', '67.321429', '9.774169', '8.14', '-1.634169', '14950.00', '-20692910.08785', 'OPEN', NULL, 10, '2026-06-02 14:23:52', '2026-06-03 01:52:01'),
(189, 36, 38, 'F19/25003/L', '25003', 'L', 'IMAM FAHRUDI', 'PLAJU', '2025-02-25 10:59:00', '57.429', 'KALBUT', '2025-02-28 22:12:00', '39.386', '720', '10', '8.652113', '3', '3.467361', '185.714286', '86.795614', '18.66', '18.043', '-0.617', '14950', '-7812855.05', 'OPEN', NULL, 10, '2026-06-02 14:24:40', '2026-06-03 01:54:24'),
(190, 36, 38, 'F19/25003/D1', '25003', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-03-10 19:00:00', '31.383', 'AMPENAN', '2025-03-11 11:54:00', '27.685', '136', '10', '8.047333', '0.566667', '0.704167', '167.741935', '23.064516', '3.592669', '3.698', '0.105331', '14600.00', '1302544.2122', 'OPEN', NULL, 10, '2026-06-02 14:25:47', '2026-06-03 01:56:26'),
(191, 36, 38, 'F19/25003/D2', '25003', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2025-03-12 16:00:00', '25.352', 'BENOA', '2025-03-12 19:48:00', '24.424', '49', '10', '12.894764', '0.204167', '0.158333', '167.741935', '-7.688284', '1.294419', '0.928', '-0.366419', '14600.00', '-4531210.6378', 'OPEN', NULL, 10, '2026-06-02 14:26:35', '2026-06-03 01:58:19'),
(192, 36, 38, 'F19/25004/L', '25004', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-03-15 13:30:00', '21.619', 'KALBUT', '2025-03-16 10:00:00', '16.917', '151', '10', '7.365851', '0.629167', '0.854167', '167.741935', '37.741935', '3.913419', '4.702', '0.788581', '14600.00', '9751750.3622', 'OPEN', NULL, 10, '2026-06-02 14:27:37', '2026-06-03 02:06:21'),
(193, 36, 38, 'F19/25004/D1', '25004', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-03-20 08:30:00', '55.534', 'BENOA', '2025-03-21 07:54:00', '50.347', '151', '10', '6.452991', '0.629167', '0.975', '167.741935', '58.010697', '3.988919', '5.187', '1.198081', '14600.00', '14815709.2622', 'OPEN', NULL, 10, '2026-06-02 14:28:21', '2026-06-03 02:07:24'),
(194, 36, 38, 'F19/25005/L', '25005', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-03-22 15:42:00', '48.057', 'KALBUT', '2025-03-23 13:18:00', '43.365', '151', '10', '6.990741', '0.629167', '0.9', '167.741935', '45.430051', '3.913419', '4.692', '0.778581', '14600.00', '9628088.3622', 'OPEN', NULL, 10, '2026-06-02 14:29:05', '2026-06-03 02:08:48'),
(195, 36, 38, 'F19/25005/D1', '25005', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-03-25 16:00:00', '41.279', 'BENOA', '2025-03-26 14:30:00', '36.297', '151', '10', '6.711111', '0.629167', '0.9375', '167.741935', '51.720374', '3.988919', '4.982', '0.993081', '14600.00', '12280638.2622', 'OPEN', NULL, 10, '2026-06-02 14:29:42', '2026-06-03 02:10:10'),
(196, 36, 38, 'F19/25006/L', '25006', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-03-31 14:00:00', '31.07', 'KALBUT', '2025-04-01 07:30:00', '27.252', '151', '10', '8.628567', '0.629167', '0.729167', '173.333333', '17.333333', '3.913419', '3.818', '-0.095419', '13900.00', '-1123396.5127', 'OPEN', NULL, 10, '2026-06-02 14:31:00', '2026-06-03 04:44:26'),
(197, 36, 38, 'F19/25006/D1', '25006', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-04-02 09:00:00', '26.082', 'BENOA', '2025-04-03 07:18:00', '21.149', '151', '10', '6.771298', '0.629167', '0.929167', '173.333333', '52', '3.988919', '4.933', '0.944081', '13900.00', '11114948.8373', 'OPEN', NULL, 10, '2026-06-02 15:32:06', '2026-06-03 04:46:18'),
(198, 36, 38, 'F19/25006/D2', '25006', 'D2', 'IMAM FAHRUDI', 'BENOA', '2025-04-05 19:30:00', '17.596', 'AMPENAN', '2025-04-06 01:30:00', '16.258', '52', '10', '8.666667', '0.216667', '0.25', '173.333333', '5.77772', '1.373669', '1.338', '-0.035669', '13900.00', '-419941.8377', 'OPEN', NULL, 10, '2026-06-02 15:33:00', '2026-06-03 04:47:40'),
(199, 36, 38, 'F19/25007/L', '25007', 'L', 'IMAM FAHRUDI', 'AMPENAN', '2025-04-07 13:00:00', '14.968', 'KALBUT', '2025-04-08 07:00:00', '10.978', '151136', '10', '8396.444444', '629.733333', '0.75', '173.333333', '-109023.77751', '3916.941331', '3.99', '-3912.951331', '13900.00', '-46068349905.2623', 'OPEN', NULL, 10, '2026-06-02 15:33:57', '2026-06-03 04:57:31'),
(200, 36, 38, 'F19/25007/D1', '25007', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-04-11 11:00:00', '93.524', 'BENOA', '2025-04-12 09:00:00', '88.665', '151', '10', '6.863634', '0.629167', '0.916667', '173.333333', '49.833333', '3.988919', '4.859', '0.870081', '13900.00', '10243724.6373', 'OPEN', NULL, 10, '2026-06-02 15:35:21', '2026-06-03 05:00:23'),
(201, 36, 38, 'F19/25008/L', '25008', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-04-13 21:00:00', '86.139', 'KALBUT', '2025-04-15 11:24:00', '78.960', '151', '10', '3.932292', '0.629167', '1.6', '173.333333', '168.27772', '3.913419', '7.179', '3.265581', '13900.00', '38446664.7873', 'OPEN', NULL, 10, '2026-06-02 15:36:05', '2026-06-03 05:21:33'),
(202, 36, 38, 'F19/25008/D1', '25008', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-04-18 09:30:00', '75.257', 'BENOA', '2025-04-19 06:54:00', '70.501', '151', '10', '7.056072', '0.629167', '0.891667', '173.333333', '45.5', '3.988919', '4.756', '0.767081', '13900.00', '9031074.7373', 'OPEN', NULL, 10, '2026-06-02 15:36:51', '2026-06-03 05:22:49'),
(203, 36, 38, 'F19/25009/L', '25009', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-04-21 14:00:00', '67.263', 'KALBUT', '2025-04-22 11:30:00', '62.635', '151', '10', '7.023258', '0.629167', '0.895833', '173.333333', '46.222107', '3.913419', '4.628', '0.714581', '13900.00', '8412976.4873', 'OPEN', NULL, 10, '2026-06-02 15:37:52', '2026-06-03 05:30:49'),
(204, 36, 38, 'F19/25009/D1', '25009', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-04-24 12:00:00', '60.763', 'MAUMERE', '2025-04-27 14:30:00', '44.467', '512', '10', '6.872482', '2.133333', '3.104167', '173.333333', '168.277893', '13.525331', '16.296', '2.770669', '13900.00', '32619917.3377', 'OPEN', NULL, 10, '2026-06-02 15:38:38', '2026-06-03 05:27:08'),
(205, 36, 38, 'F19/25009/D2', '25009', 'D2', 'IMAM FAHRUDI', 'MAUMERE', '2025-04-29 02:00:00', '41.958', 'BENOA', '2025-05-01 12:24:00', '26.389', '348', '10', '5.958905', '1.45', '2.433333', '167.741935', '164.94618', '9.193', '15.569', '6.376', '13750.00', '74256490', 'OPEN', NULL, 10, '2026-06-02 15:39:29', '2026-06-03 05:32:05'),
(206, 36, 38, 'F19/25010/L', '25010', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-05-03 23:00:00', '26.166', 'KALBUT', '2025-05-04 21:00:00', '21.430', '151', '10', '6.863634', '0.629167', '0.916667', '167.741935', '48.225806', '3.913419', '4.736', '0.822581', '13750.00', '9579983.97125', 'OPEN', NULL, 10, '2026-06-02 15:42:21', '2026-06-03 05:33:33'),
(207, 36, 38, 'F19/25010/D1', '25010', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-05-07 13:00:00', '45.06', 'BENOA', '2025-05-08 11:00:00', '40.167', '152', '10', '6.909088', '0.633333', '0.916667', '167.741935', '47.526993', '4.015331', '4.893', '0.877669', '13750.00', '10221552.59125', 'OPEN', NULL, 10, '2026-06-02 15:43:29', '2026-06-03 05:34:31'),
(208, 36, 38, 'F19/25011/L', '25011', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-05-10 16:00:00', '36.293', 'KALBUT', '2025-05-11 14:00:00', '31.578', '151', '10', '6.863634', '0.629167', '0.916667', '167.741935', '48.225806', '3.988919', '4.715', '0.726081', '13750.00', '8456120.84625', 'OPEN', NULL, 10, '2026-06-02 15:44:27', '2026-06-03 05:37:01'),
(209, 36, 38, 'F19/25011/D1', '25011', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-05-12 13:00:00', '30.601', 'BENOA', '2025-05-13 17:00:00', '25.987', '151', '10', '5.392856', '0.629167', '1.166667', '167.741935', '90.16129', '3.988919', '4.614', '0.625081', '13750.00', '7279849.59625', 'OPEN', NULL, 10, '2026-06-02 15:45:11', '2026-06-03 05:40:41'),
(210, 36, 38, 'F19/25012/L', '25012', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-05-15 01:00:00', '23.1', 'KALBUT', '2025-05-15 20:30:00', '18.843', '151', '10', '7.74359', '0.629167', '0.8125', '167.741935', '30.752632', '3.988919', '4.257', '0.268081', '13750.00', '3122138.34625', 'OPEN', NULL, 10, '2026-06-02 15:46:15', '2026-06-03 05:41:47'),
(211, 36, 38, 'F19/25012/D1', '25012', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-05-18 13:00:00', '16.509', 'BENOA', '2025-05-19 11:30:00', '11.507', '151', '10', '6.711111', '0.629167', '0.9375', '167.741935', '51.720374', '3.988919', '5.002', '1.013081', '13750', '11798594.59625', 'OPEN', NULL, 10, '2026-06-02 15:47:01', '2026-06-03 05:42:34'),
(212, 36, 38, 'F19/25013/L', '25013', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-05-21 17:00:00', '50.436', 'KALBUT', '2025-05-22 14:00:00', '45.952', '151', '10', '7.190476', '0.629167', '0.875', '167.741935', '41.236503', '3.988919', '4.484', '0.495081', '13750', '5765837.09625', 'OPEN', NULL, 10, '2026-06-02 15:47:40', '2026-06-03 05:43:34'),
(213, 36, 38, 'F19/25013/D1', '25013', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-05-24 11:30:00', '69.48', 'BENOA', '2025-05-25 09:42:00', '64.682', '151', '10', '6.801802', '0.629167', '0.925', '167.741935', '49.6236', '3.988919', '4.798', '0.809081', '13750', '9422759.59625', 'OPEN', NULL, 10, '2026-06-02 15:48:22', '2026-06-03 05:44:36'),
(214, 36, 38, 'F19/25014/L', '25014', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-05-29 13:30:00', '60.057', 'KALBUT', '2025-05-30 09:30:00', '55.693', '151', '10', '7.550003', '0.629167', '0.833333', '167.741935', '34.2472', '3.988919', '4.364', '0.375081', '13750.00', '4368287.09625', 'OPEN', NULL, 10, '2026-06-02 15:49:53', '2026-06-03 05:46:22'),
(215, 36, 38, 'F19/25014/D1', '25014', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-06-03 12:30:00', '52.463', 'BENOA', '2025-06-04 10:24:00', '47.625', '151', '10', '6.894977', '0.629167', '0.9125', '173.333333', '49.111053', '3.988919', '4.838', '0.849081', '13200', '9493065.2124', 'OPEN', NULL, 10, '2026-06-02 15:50:40', '2026-06-03 05:56:09'),
(216, 36, 38, 'F19/25015/L', '25015', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-06-05 15:54:00', '45.088', 'KALBUT', '2025-06-06 13:24:00', '40.432', '151', '10', '7.023258', '0.629167', '0.895833', '173.333333', '46.222107', '3.988919', '4.656', '0.667081', '13200.00', '7458232.4124', 'OPEN', NULL, 10, '2026-06-02 15:51:30', '2026-06-03 05:59:30'),
(217, 36, 38, 'F19/25015/D1', '25015', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-06-09 10:30:00', '37.874', 'BENOA', '2025-06-10 09:12:00', '32.810', '151', '10', '6.651985', '0.629167', '0.945833', '173.333333', '54.888773', '3.988919', '5.064', '1.075081', '13200.00', '12019835.6124', 'OPEN', NULL, 10, '2026-06-02 15:52:11', '2026-06-03 05:59:10'),
(218, 36, 38, 'F19/25016/L', '25016', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-06-11 13:00:00', '30.557', 'KALBUT', '2025-06-12 12:30:00', '25.495', '151', '10', '6.42553', '0.629167', '0.979167', '173.333333', '60.666667', '3.988919', '5.062', '1.073081', '13200.00', '11997474.8124', 'OPEN', NULL, 10, '2026-06-02 15:52:58', '2026-06-03 05:58:51'),
(219, 36, 38, 'F19/25016/D1', '25016', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-06-14 11:42:00', '23.508', 'BENOA', '2025-06-15 10:30:00', '18.564', '151', '10', '6.622807', '0.629167', '0.95', '173.333333', '55.611053', '3.988919', '4.944', '0.955081', '13200.00', '10678187.6124', 'OPEN', NULL, 10, '2026-06-02 15:53:57', '2026-06-03 06:00:28'),
(220, 36, 38, 'F19/25017/L', '25017', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-06-16 11:42:00', '16.397', 'KALBUT', '2025-06-17 10:30:00', '11.466', '151', '10', '6.622807', '0.629167', '0.95', '173.333333', '55.611053', '3.988919', '4.931', '0.942081', '13200.00', '10532842.4124', 'OPEN', NULL, 10, '2026-06-02 15:54:38', '2026-06-03 06:01:43'),
(221, 36, 38, 'F19/25017/D1', '25017', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-06-19 01:00:00', '57.002', 'BENOA', '2025-06-20 00:06:00', '51.634', '152', '10', '6.580087', '0.633333', '0.9625', '173.333333', '57.055613', '4.015331', '5.368', '1.352669', '13200.00', '15123380.4876', 'OPEN', NULL, 10, '2026-06-02 15:55:50', '2026-06-03 06:02:34'),
(222, 36, 38, 'F19/25018/L', '25018', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-06-23 18:06:00', '47.394', 'BALONGAN', '2025-06-26 21:30:00', '31.048', '518', '10', '6.870026', '2.158333', '3.141667', '173.333333', '170.44456', '13.683831', '16.346', '2.662169', '13200.00', '29764114.2876', 'OPEN', NULL, 10, '2026-06-02 15:58:22', '2026-06-03 06:03:42'),
(223, 36, 38, 'F19/25018/D1', '25018', 'D1', 'IMAM FAHRUDI', 'BALONGAN', '2025-06-28 15:30:00', '29.456', 'TUBAN', '2025-06-29 21:42:00', '22.004', '200', '10', '6.622518', '0.833333', '1.258333', '173.333333', '73.666667', '5.283331', '7.452', '2.168669', '13650.00', '25073175.07695', 'OPEN', NULL, 10, '2026-06-02 16:04:35', '2026-06-03 06:05:05'),
(224, 36, 38, 'F19/25018/D2', '25018', 'D2', 'IMAM FAHRUDI', 'TUBAN', '2025-06-30 10:00:00', '55.196', 'BENOA', '2025-07-02 05:00:00', '45.262', '318', '10', '7.395347', '1.325', '1.791667', '167.741935', '78.279626', '8.4005', '9.934', '1.5335', '13650.00', '17729636.925', 'OPEN', NULL, 10, '2026-06-02 16:05:24', '2026-06-03 06:06:08'),
(225, 36, 38, 'F19/25019/D1', '25019', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-07-06 07:36:00', '36.594', 'BENOA', '2025-07-07 05:00:00', '31.426', '151', '10', '7.056072', '0.629167', '0.891667', '167.741935', '44.032258', '3.988919', '5.168', '1.179081', '13650.00', '13632003.93555', 'OPEN', NULL, 10, '2026-06-02 16:06:04', '2026-06-03 06:07:59'),
(226, 36, 38, 'F19/25020/L', '25020', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-07-08 09:36:00', '28.941', 'KALBUT', '2025-07-09 06:00:00', '24.224', '151', '10', '7.401961', '0.629167', '0.85', '167.741935', '37.042955', '3.988919', '4.717', '0.728081', '13650.00', '8417744.88555', 'OPEN', NULL, 3, '2026-06-02 16:06:47', '2026-06-02 16:06:47'),
(227, 36, 38, 'F19/25020/D1', '25020', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-07-18 10:54:00', '68.452', 'BENOA', '2025-07-19 09:30:00', '63.035', '151', '10', '6.681414', '0.629167', '0.941667', '167.741935', '52.419355', '3.988919', '5.417', '1.428081', '13650.00', '16510829.88555', 'OPEN', NULL, 3, '2026-06-02 16:07:30', '2026-06-02 16:07:30'),
(228, 36, 38, 'F19/25021/L', '25021', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-07-22 11:48:00', '59.203', 'KALBUT', '2025-07-23 12:18:00', '53.554', '151', '10', '6.163267', '0.629167', '1.020833', '167.741935', '65.698813', '3.988919', '5.649', '1.660081', '13650.00', '19193109.48555', 'OPEN', NULL, 3, '2026-06-02 16:08:08', '2026-06-02 16:08:08'),
(229, 36, 38, 'F19/25021/D1', '25021', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-07-27 12:42:00', '75.972', 'BENOA', '2025-07-28 10:54:00', '70.642', '151', '10', '6.801802', '0.629167', '0.925', '167.741935', '49.6236', '3.988919', '5.33', '1.341081', '13650.00', '15504975.03555', 'OPEN', NULL, 3, '2026-06-02 16:08:47', '2026-06-02 16:08:47'),
(230, 36, 38, 'F19/25022/L', '25022', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-07-30 15:24:00', '67.221', 'KALBUT', '2025-07-31 12:48:00', '62.271', '151', '10', '7.056072', '0.629167', '0.891667', '167.741935', '44.032258', '3.988919', '4.95', '0.961081', '13650.00', '11111586.03555', 'OPEN', NULL, 3, '2026-06-02 16:09:25', '2026-06-02 16:09:25'),
(231, 36, 38, 'F19/25022/D1', '25022', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-08-02 14:42:00', '60.291', 'AMPENAN', '2025-08-03 10:00:00', '55.660', '136', '10', '7.046629', '0.566667', '0.804167', '167.741935', '39.83871', '3.592669', '4.631', '1.038331', '14150.00', '12444448.95155', 'OPEN', NULL, 3, '2026-06-02 16:10:24', '2026-06-02 16:10:24'),
(232, 36, 38, 'F19/25023/L', '25023', 'L', 'IMAM FAHRUDI', 'AMPENAN', '2025-08-05 04:00:00', '52.57', 'KALBUT', '2025-08-05 21:00:00', '48.468', '136', '10', '8.000004', '0.566667', '0.708333', '167.741935', '23.763329', '3.592669', '4.102', '0.509331', '14150.00', '6104357.50155', 'OPEN', NULL, 3, '2026-06-02 16:12:37', '2026-06-02 16:12:37'),
(233, 36, 38, 'F19/25023/D1', '25023', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-08-09 16:12:00', '45.31', 'BENOA', '2025-08-10 13:00:00', '40.315', '136', '10', '6.538459', '0.566667', '0.866667', '167.741935', '50.32258', '3.592669', '4.995', '1.402331', '14150.00', '16807007.15155', 'OPEN', NULL, 3, '2026-06-02 16:13:13', '2026-06-02 16:13:13'),
(234, 36, 38, 'F19/25023/D2', '25023', 'D2', 'IMAM FAHRUDI', 'BENOA', '2025-08-12 14:48:00', '114.309', 'KENDARI', '2025-08-16 06:00:00', '93.606', '667', '10', '7.649083', '2.779167', '3.633333', '167.741935', '143.279458', '17.619919', '20.703', '3.083081', '14450.00', '37734290.82115', 'OPEN', NULL, 3, '2026-06-02 16:13:59', '2026-06-02 16:13:59'),
(235, 36, 38, 'F19/25024/L', '25024', 'L', 'IMAM FAHRUDI', 'KENDARI', '2025-08-16 19:18:00', '92.412', 'KALBUT', '2025-08-19 16:48:00', '76.222', '655', '10', '9.424462', '2.729167', '2.895833', '167.741935', '27.956877', '17.302919', '16.19', '-1.112919', '14150.00', '-13338389.86095', 'OPEN', NULL, 3, '2026-06-02 16:14:50', '2026-06-02 16:14:50'),
(236, 36, 38, 'F19/25024/D1', '25024', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-08-22 14:18:00', '73.676', 'BENOA', '2025-08-23 10:48:00', '68.762', '151', '10', '7.365851', '0.629167', '0.854167', '167.741935', '37.741935', '3.988919', '4.914', '0.925081', '14150.00', '11087142.03905', 'OPEN', NULL, 3, '2026-06-02 16:17:11', '2026-06-02 16:17:11'),
(237, 36, 38, 'F19/25025/L', '25025', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-08-24 15:00:00', '66.032', 'KALBUT', '2025-08-25 09:54:00', '61.661', '151', '10', '7.989418', '0.629167', '0.7875', '167.741935', '26.559084', '3.988919', '4.371', '0.382081', '14150.00', '4579259.88905', 'OPEN', NULL, 3, '2026-06-02 16:18:08', '2026-06-02 16:18:08'),
(238, 36, 38, 'F19/25025/D1', '25025', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-08-27 11:30:00', '59.59', 'BENOA', '2025-08-28 10:00:00', '54.208', '151', '10', '6.711111', '0.629167', '0.9375', '167.741935', '51.720374', '3.988919', '5.382', '1.393081', '14150.00', '16696145.43905', 'OPEN', NULL, 3, '2026-06-02 16:20:09', '2026-06-02 16:20:09'),
(239, 36, 38, 'F19/25026/L', '25026', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-08-29 12:00:00', '51.692', 'KALBUT', '2025-08-30 07:48:00', '47.132', '151', '10', '7.626263', '0.629167', '0.825', '167.741935', '32.849406', '3.988919', '4.56', '0.571081', '14150.00', '6844434.33905', 'OPEN', NULL, 3, '2026-06-02 16:20:47', '2026-06-02 16:20:47'),
(240, 36, 38, 'F19/25026/D1', '25026', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-09-02 13:36:00', '44.38', 'BENOA', '2025-09-03 11:54:00', '39.045', '151', '10', '6.771298', '0.629167', '0.929167', '173.333333', '52', '3.988919', '5.335', '1.346081', '13850.00', '15790808.90695', 'OPEN', NULL, 3, '2026-06-02 16:21:23', '2026-06-02 16:21:23'),
(241, 36, 38, 'F19/25027/L', '25027', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-09-04 21:00:00', '104.502', 'KALBUT', '2025-09-05 16:54:00', '99.914', '151', '10', '7.587937', '0.629167', '0.829167', '173.333333', '34.666667', '3.988919', '4.588', '0.599081', '13850.00', '7027789.25695', 'OPEN', NULL, 3, '2026-06-02 16:22:01', '2026-06-02 16:22:01'),
(242, 36, 38, 'F19/25027/D1', '25027', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-09-10 09:48:00', '95.833', 'AMPENAN', '2025-09-11 05:18:00', '91.182', '163', '10', '8.358974', '0.679167', '0.8125', '173.333333', '23.111053', '4.305919', '4.651', '0.345081', '13850.00', '4048127.95695', 'OPEN', NULL, 3, '2026-06-02 16:22:49', '2026-06-02 16:22:49'),
(243, 36, 38, 'F19/25028/L', '25028', 'L', 'IMAM FAHRUDI', 'AMPENAN', '2025-09-12 13:30:00', '88.403', 'KALBUT', '2025-09-13 08:30:00', '84.015', '163', '10', '8.578944', '0.679167', '0.791667', '173.333333', '19.5', '4.305919', '4.388', '0.082081', '13850.00', '962888.10695', 'OPEN', NULL, 3, '2026-06-02 17:32:42', '2026-06-02 17:32:42'),
(244, 36, 38, 'F19/25028/D1', '25028', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-09-14 13:54:00', '82.516', 'BITUNG', '2025-09-20 16:54:00', '47.530', '970', '10', '6.598639', '4.041667', '6.125', '173.333333', '361.111053', '25.624169', '34.986', '9.361831', '14150.00', '112202012.62655', 'OPEN', NULL, 3, '2026-06-02 17:33:37', '2026-06-02 17:33:37'),
(245, 36, 38, 'F19/25028/D2', '25028', 'D2', 'IMAM FAHRUDI', 'BITUNG', '2025-09-23 12:24:00', '113.034', 'KENDARI', '2025-09-25 20:54:00', '99.602', '376', '10', '6.654866', '1.566667', '2.354167', '173.333333', '136.5', '9.932669', '13.432', '3.499331', '14150.00', '41939657.00155', 'OPEN', NULL, 3, '2026-06-02 17:34:30', '2026-06-02 17:34:30'),
(246, 36, 38, 'F19/25029/L', '25029', 'L', 'IMAM FAHRUDI', 'KENDARI', '2025-09-27 04:04:00', '97.486', 'BALONGAN', '2025-10-02 18:28:00', '66.591', '947', '10', '7.046131', '3.945833', '5.6', '167.741935', '277.473173', '25.016581', '30.895', '5.878419', '14000.00', '69706292.502', 'OPEN', NULL, 3, '2026-06-02 17:35:29', '2026-06-02 17:35:29'),
(247, 36, 38, 'F19/25029/D1', '25029', 'D1', 'IMAM FAHRUDI', 'BALONGAN', '2025-10-04 15:36:00', '64.487', 'BANJARMASIN', '2025-10-09 00:43:00', '38.935', '720', '10', '6.849532', '3', '4.379861', '167.741935', '231.460554', '19.02', '25.552', '6.532', '14300.00', '79116237.2', 'OPEN', NULL, 3, '2026-06-02 17:36:39', '2026-06-02 17:36:39'),
(248, 36, 38, 'F19/25029/D2', '25029', 'D2', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-10-11 12:00:00', '102.721', 'PONTIANAK', '2025-10-14 15:21:00', '85.672', '527', '10', '6.994029', '2.195833', '3.139583', '167.741935', '158.306451', '13.921581', '17.049', '3.127419', '14300.00', '37879611.6699', 'OPEN', NULL, 3, '2026-06-02 17:37:46', '2026-06-02 17:37:46'),
(249, 36, 38, 'F19/25030/L', '25030', 'L', 'IMAM FAHRUDI', 'PONTIANAK', '2025-10-16 12:28:00', '83.098', 'KALBUT', '2025-10-19 17:31:00', '65.395', '601', '10', '7.800129', '2.504167', '3.210417', '167.741935', '118.467742', '15.876419', '17.703', '1.826581', '14000.00', '21659597.498', 'OPEN', NULL, 3, '2026-06-02 17:38:37', '2026-06-02 17:38:37'),
(250, 36, 38, 'F19/25030/D1', '25030', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-10-21 07:26:00', '64.092', 'BANJARMASIN', '2025-10-22 19:26:00', '55.282', '253', '10', '7.027778', '1.054167', '1.5', '167.741935', '74.78489', '6.683419', '8.81', '2.126581', '14300.00', '25757361.7301', 'OPEN', NULL, 3, '2026-06-02 17:39:23', '2026-06-02 17:39:23'),
(251, 36, 38, 'F19/25030/D2', '25030', 'D2', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-10-26 14:24:00', '118.735', 'KENDARI', '2025-10-30 17:02:00', '95.237', '900', '10', '9.124705', '3.75', '4.109722', '167.741935', '60.340464', '23.775', '23.498', '-0.277', '14300.00', '-3355051.7', 'OPEN', NULL, 3, '2026-06-02 17:40:11', '2026-06-02 17:40:11'),
(252, 36, 38, 'F19/25030/D3', '25030', 'D3', 'IMAM FAHRUDI', 'KENDARI', '2025-10-31 10:30:00', '93.694', 'LUWUK', '2025-11-01 12:30:00', '87.258', '193', '10', '7.423079', '0.804167', '1.083333', '173.333333', '48.388773', '5.098419', '6.436', '1.337581', '14300.00', '16200914.8301', 'OPEN', NULL, 3, '2026-06-02 17:41:02', '2026-06-02 17:41:02'),
(253, 36, 38, 'F19/25030/D4', '25030', 'D4', 'IMAM FAHRUDI', 'LUWUK', '2025-11-01 21:45:00', '86.773', 'GORONTALO', '2025-11-02 16:30:00', '81.995', '137', '10', '7.306667', '0.570833', '0.78125', '173.333333', '36.47228', '3.619081', '4.778', '1.158919', '14300.00', '14036942.8199', 'OPEN', NULL, 3, '2026-06-02 17:41:53', '2026-06-02 17:41:53'),
(254, 36, 38, 'F19/25031/L', '25031', 'L', 'IMAM FAHRUDI', 'GORONTALO', '2025-11-03 02:36:00', '81.201', 'WAYAME', '2025-11-05 13:06:00', '67.669', '416', '10', '7.111111', '1.733333', '2.4375', '173.333333', '122.055613', '10.781331', '13.532', '2.750669', '14300.00', '33316377.9949', 'OPEN', NULL, 3, '2026-06-02 23:33:34', '2026-06-02 23:33:34'),
(255, 36, 38, 'F19/25031/D1', '25031', 'D1', 'IMAM FAHRUDI', 'WAYAME', '2025-11-07 08:00:00', '65.914', 'BITUNG', '2025-11-09 09:30:00', '54.097', '385', '10', '7.777778', '1.604167', '2.0625', '173.333333', '79.444387', '10.170419', '11.817', '1.646581', '14300.00', '19943553.7301', 'OPEN', NULL, 3, '2026-06-02 23:34:34', '2026-06-02 23:34:34'),
(257, 36, 38, 'F19/25032/L', '25032', 'L', 'IMAM FAHRUDI', 'BITUNG', '2025-11-10 05:06:00', '122.074', 'WAYAME', '2025-11-13 00:54:00', '106.110', '385', '10', '5.678466', '1.604167', '2.825', '173.333333', '211.611053', '9.977919', '15.964', '5.986081', '14300.00', '72504011.6801', 'OPEN', NULL, 3, '2026-06-02 23:38:16', '2026-06-02 23:38:16'),
(258, 36, 38, 'F19/25032/D1', '25032', 'D1', 'IMAM FAHRUDI', 'WAYAME', '2025-11-15 13:00:00', '103.575', 'KENDARI', '2025-11-17 22:00:00', '89.864', '256', '10', '4.491228', '1.066667', '2.375', '173.333333', '226.77772', '6.762669', '13.711', '6.948331', '14300.00', '84158879.9051', 'OPEN', NULL, 3, '2026-06-02 23:39:22', '2026-06-02 23:39:22'),
(259, 36, 38, 'F19/25032/D2', '25032', 'D2', 'IMAM FAHRUDI', 'KENDARI', '2025-11-18 10:30:00', '88.797', 'GORONTALO', '2025-11-20 07:30:00', '77.971', '317', '10', '7.044444', '1.320833', '1.875', '173.333333', '96.055613', '8.374081', '10.826', '2.451919', '14300.00', '29697888.1199', 'OPEN', NULL, 3, '2026-06-03 00:13:08', '2026-06-03 00:13:08'),
(260, 36, 38, 'F19/25032/D3', '25032', 'D3', 'IMAM FAHRUDI', 'GORONTALO', '2025-11-21 03:24:00', '75.965', 'BITUNG', '2025-11-22 03:48:00', '70.666', '170', '10', '6.967211', '0.708333', '1.016667', '173.333333', '53.44456', '4.490831', '5.299', '0.808169', '14300.00', '9788623.7449', 'OPEN', NULL, 3, '2026-06-03 00:13:49', '2026-06-03 00:13:49'),
(261, 36, 38, 'F19/25032/D4', '25032', 'D4', 'IMAM FAHRUDI', 'BITUNG', '2025-11-25 06:48:00', '67.293', 'LUWUK', '2025-11-26 11:48:00', '60.085', '215', '10', '7.413795', '0.895833', '1.208333', '173.333333', '54.166667', '5.679581', '7.208', '1.528419', '14300.00', '18512363.7699', 'OPEN', NULL, 3, '2026-06-03 00:14:35', '2026-06-03 00:14:35'),
(262, 36, 38, 'F19/25032/D5', '25032', 'D5', 'IMAM FAHRUDI', 'LUWUK', '2025-11-27 07:18:00', '58.835', 'KENDARI', '2025-11-28 06:36:00', '53.221', '193', '10', '8.283265', '0.804167', '0.970833', '173.333333', '28.888773', '5.098419', '5.614', '0.515581', '14300.00', '6244768.6301', 'OPEN', NULL, 3, '2026-06-03 00:15:21', '2026-06-03 00:15:21'),
(263, 36, 38, 'F19/25033/L', '25033', 'L', 'IMAM FAHRUDI', 'KENDARI', '2025-11-28 19:00:00', '51.709', 'BALIKPAPAN', '2025-12-02 09:30:00', '31.656', '650', '10', '7.51445', '2.708333', '3.604167', '167.741935', '150.268929', '16.845831', '20.053', '3.207169', '15300.00', '41562023.7879', 'OPEN', NULL, 3, '2026-06-03 00:16:13', '2026-06-03 00:16:13'),
(264, 36, 38, 'F19/25033/D1', '25033', 'D1', 'IMAM FAHRUDI', 'BALIKPAPAN', '2025-12-06 17:00:00', '93.695', 'DONGGALA', '2025-12-07 17:30:00', '87.935', '188', '10', '7.673472', '0.783333', '1.020833', '167.741935', '39.83871', '4.966331', '5.76', '0.793669', '15300.00', '10285235.9379', 'OPEN', NULL, 3, '2026-06-03 00:34:53', '2026-06-03 00:34:53'),
(265, 36, 38, 'F19/25033/D2', '25033', 'D2', 'IMAM FAHRUDI', 'DONGGALA', '2025-12-08 03:24:00', '87.14', 'KENDARI', '2025-12-11 15:48:00', '66.956', '660', '10', '7.819904', '2.75', '3.516667', '167.741935', '128.602206', '17.435', '20.184', '2.749', '15300.00', '35624565.9', 'OPEN', NULL, 3, '2026-06-03 00:36:44', '2026-06-03 00:36:44'),
(266, 36, 38, 'F19/25033/D3', '25033', 'D3', 'IMAM FAHRUDI', 'KENDARI', '2025-12-12 04:36:00', '65.777', 'BITUNG', '2025-12-14 13:06:00', '52.375', '404', '10', '7.150441', '1.683333', '2.354167', '167.741935', '112.526993', '10.672331', '13.402', '2.729669', '15300.00', '35374053.5379', 'OPEN', NULL, 3, '2026-06-03 00:38:23', '2026-06-03 00:38:23'),
(267, 36, 38, 'F19/25033/D4', '25033', 'D4', 'IMAM FAHRUDI', 'BITUNG', '2025-12-16 20:12:00', '49.529', 'GORONTALO', '2025-12-17 17:36:00', '44.401', '170', '10', '7.943922', '0.708333', '0.891667', '167.741935', '30.7528', '4.490831', '5.128', '0.637169', '15300.00', '8257136.7879', 'OPEN', NULL, 3, '2026-06-03 00:39:10', '2026-06-03 00:39:10'),
(268, 36, 38, 'F19/25033/D5', '25033', 'D5', 'IMAM FAHRUDI', 'GORONTALO', '2025-12-18 03:12:00', '43.573', 'LUWUK', '2025-12-18 18:30:00', '39.901', '137', '10', '8.954248', '0.570833', '0.6375', '167.741935', '11.182852', '3.619081', '3.672', '0.052919', '15300.00', '685782.6129', 'OPEN', NULL, 3, '2026-06-03 00:40:26', '2026-06-03 00:40:26'),
(269, 36, 38, 'F19/25034/L', '25034', 'L', 'IMAM FAHRUDI', 'LUWUK', '2025-12-19 01:42:00', '39.185', 'WAYAME', '2025-12-20 23:12:00', '28.687', '384', '10', '8.439562', '1.6', '1.895833', '167.741935', '49.6236', '9.952', '10.498', '0.546', '15300.00', '7075668.6', 'OPEN', NULL, 3, '2026-06-03 00:41:15', '2026-06-03 00:41:15'),
(270, 36, 38, 'F19/25034/D1', '25034', 'D1', 'IMAM FAHRUDI', 'WAYAME', '2025-12-24 14:12:00', '102.932', 'KENDARI', '2025-12-26 08:42:00', '92.936', '336', '10', '7.905884', '1.4', '1.770833', '167.741935', '62.204245', '8.876', '9.996', '1.12', '15300.00', '14514192', 'OPEN', NULL, 3, '2026-06-03 00:42:27', '2026-06-03 00:42:27'),
(271, 36, 38, 'F19/25034/D2', '25034', 'D2', 'IMAM FAHRUDI', 'KENDARI', '2025-12-27 07:18:00', '91.158', 'GORONTALO', '2025-12-29 03:30:00', '80.508', '317', '10', '7.171944', '1.320833', '1.841667', '167.741935', '87.365703', '8.374081', '10.65', '2.275919', '15300.00', '29493861.9129', 'OPEN', NULL, 3, '2026-06-03 00:49:29', '2026-06-03 00:49:29'),
(272, 36, 38, 'F19/25034/D3', '25034', 'D3', 'IMAM FAHRUDI', 'GORONTALO', '2025-12-29 16:00:00', '79.599', 'BITUNG', '2025-12-30 12:12:00', '73.746', '170', '10', '8.415838', '0.708333', '0.841667', '167.741935', '22.365703', '4.490831', '5.853', '1.362169', '15300.00', '17652484.2879', 'OPEN', NULL, 3, '2026-06-03 00:50:17', '2026-06-03 00:50:17'),
(273, 36, 38, 'F19/25034/D4', '25034', 'D4', 'IMAM FAHRUDI', 'BITUNG', '2025-12-31 22:00:00', '71.736', 'LUWUK', '2026-01-02 02:24:00', '64.884', '215', '10', '7.570425', '0.895833', '1.183333', '167.741935', '48.225806', '5.679581', '6.852', '1.172419', '20750.00', '20605557.02975', 'OPEN', NULL, 3, '2026-06-03 00:51:57', '2026-06-03 00:51:57'),
(274, 36, 38, 'F19/26001/L', '26001', 'L', 'IMAM FAHRUDI', 'LUWUK', '2026-01-02 09:06:00', '64.274', 'WAYAME', '2026-01-04 23:12:00', '53.141', '384', '10', '6.183575', '1.6', '2.5875', '167.741935', '165.645161', '9.952', '11.133', '1.181', '20750.00', '20756370.25', 'OPEN', NULL, 3, '2026-06-03 00:53:32', '2026-06-03 00:53:32'),
(275, 36, 38, 'F19/26001/D1', '26001', 'D1', 'IMAM FAHRUDI', 'WAYAME', '2026-01-05 13:42:00', '111.895', 'KENDARI', '2026-01-07 11:00:00', '100.981', '336', '10', '7.417219', '1.4', '1.8875', '167.741935', '81.774193', '8.876', '10.914', '2.038', '20750.00', '35818359.5', 'OPEN', NULL, 3, '2026-06-03 00:55:38', '2026-06-03 00:55:38'),
(276, 36, 38, 'F19/26001/D2', '26001', 'D2', 'IMAM FAHRUDI', 'KENDARI', '2026-01-07 23:42:00', '99.78', 'LUWUK', '2026-01-08 21:48:00', '94.464', '193', '10', '8.733035', '0.804167', '0.920833', '167.741935', '19.569781', '5.098419', '5.316', '0.217581', '20750.00', '3824040.47025', 'OPEN', NULL, 3, '2026-06-03 00:56:57', '2026-06-03 00:56:57'),
(277, 36, 38, 'F19/26001/D3', '26001', 'D3', 'IMAM FAHRUDI', 'LUWUK', '2026-01-09 06:24:00', '93.657', 'GORONTALO', '2026-01-09 23:12:00', '89.595', '137', '10', '8.154762', '0.570833', '0.7', '167.741935', '21.666723', '3.619081', '4.062', '0.442919', '20750.00', '7784412.15475', 'OPEN', NULL, 3, '2026-06-03 01:03:14', '2026-06-03 01:03:14'),
(278, 36, 38, 'F19/26001/D4', '26001', 'D4', 'IMAM FAHRUDI', 'GORONTALO', '2026-01-10 11:00:00', '88.751', 'BITUNG', '2026-01-11 07:00:00', '83.910', '170', '10', '8.500003', '0.708333', '0.833333', '167.741935', '20.967742', '4.490831', '4.841', '0.350169', '20750.00', '6154307.71725', 'OPEN', NULL, 3, '2026-06-03 01:09:11', '2026-06-03 01:09:11'),
(279, 36, 38, 'F19/26002/L', '26002', 'L', 'IMAM FAHRUDI', 'BITUNG', '2026-01-13 02:06:00', '81.388', 'WAYAME', '2026-01-15 04:36:00', '69.655', '384', '10', '7.603959', '1.6', '2.104167', '167.741935', '84.569948', '9.952', '11.733', '1.781', '20750.00', '31301520.25', 'OPEN', NULL, 3, '2026-06-03 01:10:09', '2026-06-03 01:10:09'),
(280, 36, 38, 'F19/26002/D1', '26002', 'D1', 'IMAM FAHRUDI', 'WAYAME', '2026-01-19 18:00:00', '126.198', 'BITUNG', '2026-01-21 22:54:00', '113.446', '385', '10', '7.277882', '1.604167', '2.204167', '167.741935', '100.645161', '10.170419', '12.752', '2.581581', '20750.00', '45371931.47025', 'OPEN', NULL, 3, '2026-06-03 02:36:41', '2026-06-03 02:36:41'),
(281, 36, 38, 'F19/26002/D2', '26002', 'D2', 'IMAM FAHRUDI', 'BITUNG', '2026-01-22 20:36:00', '111.612', 'GORONTALO', '2026-01-23 18:30:00', '106.432', '170', '10', '7.762557', '0.708333', '0.9125', '167.741935', '34.247368', '4.490831', '5.18', '0.689169', '20750.00', '12112317.46725', 'OPEN', NULL, 3, '2026-06-03 02:37:28', '2026-06-03 02:37:28'),
(282, 36, 38, 'F19/26002/D3', '26002', 'D3', 'IMAM FAHRUDI', 'GORONTALO', '2026-01-24 07:30:00', '105.21', 'LUWUK', '2026-01-25 03:00:00', '100.491', '137', '10', '7.025641', '0.570833', '0.8125', '167.741935', '40.53769', '3.619081', '4.719', '1.099919', '20750.00', '19331351.40475', 'OPEN', NULL, 3, '2026-06-03 02:38:24', '2026-06-03 02:38:24'),
(283, 36, 38, 'F19/26002/D4', '26002', 'D4', 'IMAM FAHRUDI', 'LUWUK', '2026-01-25 17:30:00', '99.399', 'KENDARI', '2026-01-26 19:30:00', '93.119', '193', '10', '7.423079', '0.804167', '1.083333', '167.741935', '46.827845', '5.098419', '6.28', '1.181581', '20750.00', '20766581.47025', 'OPEN', NULL, 3, '2026-06-03 02:39:31', '2026-06-03 02:39:31'),
(285, 36, 38, 'F19/26003/L', '26003', 'L', 'IMAM FAHRUDI', 'KENDARI', '2026-01-27 03:54:00', '92.32', 'WAYAME', '2026-01-28 23:18:00', '82.230', '336', '10', '7.741937', '1.4', '1.808333', '167.741935', '68.494568', '8.708', '10.09', '1.382', '20750', '24288995.5', 'OPEN', NULL, 3, '2026-06-03 02:45:15', '2026-06-03 02:45:15'),
(286, 36, 38, 'F19/26003/D1', '26003', 'D1', 'IMAM FAHRUDI', 'WAYAME', '2026-02-04 16:36:00', '110.584', 'BITUNG', '2026-02-06 23:12:00', '97.471', '385', '10', '7.051282', '1.604167', '2.275', '185.714286', '124.583272', '10.170419', '13.113', '2.942581', '21200', '52838161.4684', 'OPEN', NULL, 3, '2026-06-03 02:46:15', '2026-06-03 02:46:15'),
(287, 36, 38, 'F19/26003/D2', '26003', 'D2', 'IMAM FAHRUDI', 'BITUNG', '2026-02-09 00:36:00', '94.891', 'GORONTALO', '2026-02-09 23:42:00', '89.329', '170', '10', '7.359307', '0.708333', '0.9625', '185.714286', '47.202443', '4.490831', '5.562', '1.071169', '21200', '19234339.0316', 'OPEN', NULL, 3, '2026-06-03 02:50:10', '2026-06-03 02:50:10'),
(288, 36, 38, 'F19/26003/D3', '26003', 'D3', 'IMAM FAHRUDI', 'GORONTALO', '2026-02-10 12:12:00', '88.475', 'LUWUK', '2026-02-11 05:54:00', '84.208', '137', '10', '7.740113', '0.570833', '0.7375', '185.714286', '30.952443', '3.619081', '4.267', '0.647919', '21200', '11634292.7316', 'OPEN', NULL, 3, '2026-06-03 02:50:58', '2026-06-03 02:50:58'),
(289, 36, 38, 'F19/26003/D4', '26003', 'D4', 'IMAM FAHRUDI', 'LUWUK', '2026-02-11 14:30:00', '83.419', 'KENDARI', '2026-02-12 16:00:00', '77.292', '193', '10', '7.568627', '0.804167', '1.0625', '185.714286', '47.976129', '5.098419', '6.127', '1.028581', '21200', '18469611.8684', 'OPEN', NULL, 3, '2026-06-03 02:51:46', '2026-06-03 02:51:46'),
(290, 36, 38, 'F19/26004/L', '26004', 'L', 'IMAM FAHRUDI', 'KENDARI', '2026-02-13 20:30:00', '75.525', 'WAYAME', '2026-02-15 16:00:00', '65.462', '336', '10', '7.724138', '1.4', '1.8125', '185.714286', '76.607143', '8.708', '10.063', '1.355', '21200', '24330922', 'OPEN', NULL, 3, '2026-06-03 02:52:42', '2026-06-03 02:52:42'),
(291, 36, 38, 'F19/26004/D1', '26004', 'D1', 'IMAM FAHRUDI', 'WAYAME', '2026-02-18 21:24:00', '105.245', 'BITUNG', '2026-02-21 01:00:00', '92.874', '385', '10', '7.46124', '1.604167', '2.15', '185.714286', '101.368986', '10.170419', '12.371', '2.200581', '21200', '39514512.6684', 'OPEN', NULL, 3, '2026-06-03 02:56:36', '2026-06-03 02:56:36'),
(292, 36, 38, 'F19/26004/D2', '26004', 'D2', 'IMAM FAHRUDI', 'BITUNG', '2026-02-22 13:12:00', '90.354', 'LUWUK', '2026-02-23 20:42:00', '82.786', '215', '10', '6.825397', '0.895833', '1.3125', '185.714286', '77.381014', '5.679581', '7.568', '1.888419', '21200', '33909206.9316', 'OPEN', NULL, 3, '2026-06-03 02:57:36', '2026-06-03 02:57:36'),
(293, 36, 38, 'F19/26004/D3', '26004', 'D3', 'IMAM FAHRUDI', 'LUWUK', '2026-02-24 05:42:00', '82.048', 'KENDARI', '2026-02-25 07:00:00', '75.963', '193', '10', '7.628456', '0.804167', '1.054167', '185.714286', '46.428572', '5.098419', '6.085', '0.986581', '21200', '17715443.0684', 'OPEN', NULL, 3, '2026-06-03 03:08:17', '2026-06-03 03:08:17'),
(294, 36, 38, 'F19/26004/D4', '26004', 'D4', 'IMAM FAHRUDI', 'KENDARI', '2026-02-26 16:06:00', '74.058', 'TERNATE', '2026-03-02 08:06:00', '52.952', '520', '10', '5.90909', '2.166667', '3.666667', '167.741935', '251.612903', '13.736669', '21.106', '7.369331', '23050', '143874028.37885', 'OPEN', NULL, 3, '2026-06-03 03:09:54', '2026-06-03 03:09:54'),
(295, 36, 38, 'F19/26005/L', '26005', 'L', 'IMAM FAHRUDI', 'TERNATE', '2026-03-02 20:00:00', '51.651', 'WAYAME', '2026-03-04 14:00:00', '41.939', '327', '10', '7.785714', '1.3625', '1.75', '167.741935', '65', '8.47475', '9.712', '1.23725', '23050', '24155264.7875', 'OPEN', NULL, 3, '2026-06-03 03:12:22', '2026-06-03 03:12:22'),
(296, 36, 38, 'F19/26005/D1', '26005', 'D1', 'IMAM FAHRUDI', 'WAYAME', '2026-03-05 15:36:00', '100.108', 'BITUNG', '2026-03-08 01:30:00', '86.228', '385', '10', '6.649396', '1.604167', '2.4125', '167.741935', '135.591342', '10.170419', '13.88', '3.709581', '23050', '72423448.21635', 'OPEN', NULL, 3, '2026-06-03 03:15:05', '2026-06-03 03:15:05'),
(297, 36, 38, 'F19/26005/D2', '26005', 'D2', 'IMAM FAHRUDI', 'BITUNG', '2026-03-09 01:18:00', '84.229', 'LUWUK', '2026-03-10 10:00:00', '76.493', '215', '10', '6.574924', '0.895833', '1.3625', '167.741935', '78.279626', '5.679581', '7.736', '2.056419', '23050', '40148187.88365', 'OPEN', NULL, 3, '2026-06-03 03:16:37', '2026-06-03 03:16:37'),
(298, 36, 38, 'F19/26005/D3', '26005', 'D3', 'IMAM FAHRUDI', 'LUWUK', '2026-03-11 01:24:00', '75.526', 'KENDARI', '2026-03-12 05:06:00', '68.91', '193', '10', '6.967507', '0.804167', '1.154167', '167.741935', '58.709677', '5.098419', '6.616', '1.517581', '23050', '29628265.01635', 'OPEN', NULL, 3, '2026-06-03 03:34:48', '2026-06-03 03:34:48'),
(299, 36, 38, 'F19/26005/D4', '26005', 'D4', 'IMAM FAHRUDI', 'KENDARI', '2026-03-12 16:24:00', '67.852', 'TERNATE', '2026-03-15 14:24:00', '51.108', '414', '10', '5.914285', '1.725', '2.916667', '167.741935', '199.892528', '10.9365', '16.744', '5.8075', '23050', '113381855.125', 'OPEN', NULL, 3, '2026-06-03 03:35:51', '2026-06-03 03:35:51'),
(300, 36, 38, 'F19/26006/L', '26006', 'L', 'IMAM FAHRUDI', 'TERNATE', '2026-03-16 08:12:00', '49.764', 'WAYAME', '2026-03-17 20:00:00', '41.505', '303', '10', '8.463685', '1.2625', '1.491667', '167.741935', '38.440916', '7.85275', '8.259', '0.40625', '23050', '7931360.9375', 'OPEN', NULL, 3, '2026-06-03 03:38:04', '2026-06-03 03:38:04'),
(301, 36, 38, 'F19/26006/D1', '26006', 'D1', 'IMAM FAHRUDI', 'WAYAME', '2026-03-19 09:18:00', '109.276', 'MONOKWARI', '2026-03-22 14:00:00', '90.79', '540', '10', '7.040418', '2.25', '3.195833', '167.741935', '158.655858', '14.265', '18.486', '4.221', '23050', '82408060.35', 'OPEN', NULL, 3, '2026-06-03 03:38:52', '2026-06-03 03:38:52'),
(302, 36, 38, 'F19/26006/D2', '26006', 'D2', 'IMAM FAHRUDI', 'MONOKWARI', '2026-03-23 09:24:00', '89.228', 'NABIRE', '2026-03-24 07:54:00', '83.785', '185', '10', '8.222222', '0.770833', '0.9375', '167.741935', '27.957045', '4.887081', '5.443', '0.555919', '23050', '10853401.20865', 'OPEN', NULL, 3, '2026-06-03 03:43:02', '2026-06-03 03:43:02'),
(303, 36, 38, 'F19/26006/D3', '26006', 'D3', 'IMAM FAHRUDI', 'NABIRE', '2026-03-24 20:36:00', '82.731', 'SERUI', '2026-03-25 07:54:00', '79.862', '100', '10', '8.849564', '0.416667', '0.470833', '167.741935', '9.08591', '2.641669', '2.869', '0.227331', '23050', '4438262.67885', 'OPEN', NULL, 3, '2026-06-03 03:47:02', '2026-06-03 03:47:02'),
(304, 36, 38, 'F19/26006/D4', '26006', 'D4', 'IMAM FAHRUDI', 'SERUI', '2026-03-25 17:24:00', '79.161', 'LUWUK', '2026-03-30 21:00:00', '49.391', '882', '10', '7.135922', '3.675', '5.15', '167.741935', '247.419354', '23.2995', '29.77', '6.4705', '23050', '126325836.175', 'OPEN', NULL, 3, '2026-06-03 03:55:34', '2026-06-03 03:55:34'),
(305, 36, 38, 'F19/26006/D5', '26006', 'D5', 'IMAM FAHRUDI', 'LUWUK', '2026-03-31 07:18:00', '48.59', 'GORONTALO', '2026-04-01 00:36:00', '44.399', '137', '10', '7.919079', '0.570833', '0.720833', '173.333333', '26', '3.619081', '4.191', '0.571919', '28150', '13636293.31295', 'OPEN', NULL, 3, '2026-06-03 03:56:13', '2026-06-03 03:56:13'),
(306, 36, 38, 'F19/26007/L', '26007', 'L', 'IMAM FAHRUDI', 'GORONTALO', '2026-04-01 12:30:00', '43.431', 'WAYAME', '2026-04-03 23:12:00', '29.784', '420', '10', '7.155027', '1.75', '2.445833', '173.333333', '120.611053', '10.885', '13.647', '2.762', '28150', '65854504.1', 'OPEN', NULL, 3, '2026-06-03 04:28:29', '2026-06-03 04:28:29'),
(307, 36, 38, 'F19/26012/D1', '26012', 'D1', 'IMAM FAHRUDI', 'WAYAME', '2026-04-05 13:00:00', '114.045', 'BITUNG', '2026-04-07 19:00:00', '100.863', '385', '10', '7.12963', '1.604167', '2.25', '173.333333', '111.944386', '10.170419', '13.182', '3.011581', '28150', '71805276.36205', 'OPEN', NULL, 3, '2026-06-03 04:29:33', '2026-06-03 04:29:33'),
(308, 36, 38, 'F19/26007/D2', '26007', 'D2', 'IMAM FAHRUDI', 'BITUNG', '2026-04-09 14:36:00', '98.059', 'LUWUK', '2026-04-10 23:00:00', '90.248', '215', '10', '6.635802', '0.895833', '1.35', '173.333333', '78.72228', '5.679581', '7.811', '2.131419', '28150', '50819529.78795', 'OPEN', NULL, 3, '2026-06-03 04:32:30', '2026-06-03 04:32:30'),
(309, 36, 38, 'F19/26007/D3', '26007', 'D3', 'IMAM FAHRUDI', 'LUWUK', '2026-04-11 08:16:00', '89.456', 'KENDARI', '2026-04-12 09:18:00', '83.365', '193', '10', '7.709717', '0.804167', '1.043056', '173.333333', '41.407427', '5.098419', '6.091', '0.992581', '28150', '23666158.41205', 'OPEN', NULL, 3, '2026-06-03 04:33:20', '2026-06-03 04:33:20'),
(310, 36, 38, 'F19/26008/L', '26008', 'L', 'IMAM FAHRUDI', 'KENDARI', '2026-04-12 21:42:00', '82.154', 'WAYAME', '2026-04-15 00:42:00', '70.309', '336', '10', '6.588235', '1.4', '2.125', '173.333333', '125.666666', '8.708', '11.845', '3.137', '28150', '74795647.85', 'OPEN', NULL, 3, '2026-06-03 04:34:13', '2026-06-03 04:34:13'),
(311, 36, 38, 'F19/26008/D1', '26008', 'D1', 'IMAM FAHRUDI', 'WAYAME', '2026-04-16 17:12:00', '116.374', 'BITUNG', '2026-04-18 18:30:00', '103.496', '385', '10', '7.809329', '1.604167', '2.054167', '173.333333', '78', '10.170419', '12.878', '2.707581', '30550', '70060959.81885', 'OPEN', NULL, 3, '2026-06-03 04:39:00', '2026-06-03 04:39:00'),
(312, 36, 38, 'F19/26008/D2', '26008', 'D2', 'IMAM FAHRUDI', 'BITUNG', '2026-04-20 02:36:00', '101.23', 'GORONTALO', '2026-04-21 02:00:00', '95.55', '170', '10', '7.264957', '0.708333', '0.975', '173.333333', '46.22228', '4.490831', '5.68', '1.189169', '30550', '30770758.66865', 'OPEN', NULL, 3, '2026-06-03 04:39:46', '2026-06-03 04:39:46'),
(313, 36, 38, 'F19/26008/D3', '26008', 'D3', 'IMAM FAHRUDI', 'GORONTALO', '2026-04-21 14:30:00', '94.411', 'LUWUK', '2026-04-22 08:24:00', '89.478', '137', '10', '7.653635', '0.570833', '0.745833', '173.333333', '30.333333', '3.619081', '4.933', '1.313919', '30550', '33998770.95615', 'OPEN', NULL, 3, '2026-06-03 04:40:34', '2026-06-03 04:40:34'),
(314, 36, 38, 'F19/26008/D4', '26008', 'D4', 'IMAM FAHRUDI', 'LUWUK', '2026-04-22 16:42:00', '88.753', 'KENDARI', '2026-04-23 18:00:00', '82.636', '193', '10', '7.628456', '0.804167', '1.054167', '173.333333', '43.333333', '5.098419', '6.117', '1.018581', '30550', '26356649.16885', 'OPEN', NULL, 3, '2026-06-03 04:41:28', '2026-06-03 04:41:28'),
(315, 36, 38, 'F19/26009/L', '26009', 'L', 'IMAM FAHRUDI', 'KENDARI', '2026-04-24 05:00:00', '81.595', 'WAYAME', '2026-04-26 04:30:00', '70.546', '336', '10', '7.073683', '1.4', '1.979167', '173.333333', '100.388946', '8.708', '11.049', '2.341', '30550', '60575364.85', 'OPEN', NULL, 3, '2026-06-03 04:42:22', '2026-06-03 04:42:22'),
(316, 36, 38, 'F19/26009/D1', '26009', 'D1', 'IMAM FAHRUDI', 'WAYAME', '2026-04-30 10:30:00', '113.308', 'KENDARI', '2026-05-02 07:00:00', '102.621', '336', '10', '7.55056', '1.4', '1.854167', '167.741935', '76.182851', '8.876', '10.687', '1.811', '30550', '46861164.35', 'OPEN', NULL, 3, '2026-06-03 04:43:21', '2026-06-03 04:43:21'),
(317, 36, 38, 'F19/26009/D2', '26009', 'D2', 'IMAM FAHRUDI', 'KENDARI', '2026-05-02 20:00:00', '101.395', 'LUWUK', '2026-05-03 21:00:00', '95.39', '193', '10', '7.719998', '0.804167', '1.041667', '167.741935', '39.83871', '5.098419', '6.005', '0.906581', '30550', '23458553.96885', 'OPEN', NULL, 3, '2026-06-03 04:44:15', '2026-06-03 04:44:15'),
(318, 36, 38, 'F19/26009/D3', '26009', 'D3', 'IMAM FAHRUDI', 'LUWUK', '2026-05-04 05:30:00', '94.621', 'BITUNG', '2026-05-05 09:30:00', '87.901', '215', '10', '7.678569', '0.895833', '1.166667', '167.741935', '45.430219', '5.679581', '6.72', '1.040419', '30550', '26921725.98115', 'OPEN', NULL, 3, '2026-06-03 04:45:02', '2026-06-03 04:45:02'),
(319, 36, 38, 'F19/26010/L', '26010', 'L', 'IMAM FAHRUDI', 'BITUNG', '2026-05-07 22:00:00', '84.776', 'WAYAME', '2026-05-10 05:30:00', '71.946', '385', '10', '6.936937', '1.604167', '2.3125', '167.741935', '118.817148', '9.977919', '12.83', '2.852081', '30550', '73800020.14385', 'OPEN', NULL, 3, '2026-06-03 04:45:48', '2026-06-03 04:45:48'),
(320, 36, 38, 'F19/26010/D1', '26010', 'D1', 'IMAM FAHRUDI', 'WAYAME', '2026-05-15 17:00:00', '118.896', 'BITUNG', '2026-05-17 22:00:00', '106.086', '385', '10', '7.264152', '1.604167', '2.208333', '167.741935', '101.343974', '10.170419', '12.81', '2.639581', '30550', '68301402.01885', 'OPEN', NULL, 3, '2026-06-03 04:46:28', '2026-06-03 04:46:28'),
(321, 36, 38, 'F19/26010/D2', '26010', 'D2', 'IMAM FAHRUDI', 'BITUNG', '2026-05-19 00:30:00', '104.23', 'GORONTALO', '2026-05-20 01:30:00', '98.185', '170', '10', '6.799998', '0.708333', '1.041667', '167.741935', '55.91409', '4.490831', '6.045', '1.554169', '30550', '40215443.91865', 'OPEN', NULL, 3, '2026-06-03 04:47:09', '2026-06-03 04:47:09'),
(322, 36, 38, 'F19/26010/D3', '26010', 'D3', 'IMAM FAHRUDI', 'GORONTALO', '2026-05-20 13:30:00', '97.23', 'LUWUK', '2026-05-21 07:00:00', '92.78', '137', '10', '7.828568', '0.570833', '0.729167', '167.741935', '26.559252', '3.619081', '4.45', '0.830919', '30550', '21500735.40615', 'OPEN', NULL, 3, '2026-06-03 04:47:59', '2026-06-03 04:47:59'),
(323, 46, 40, 'MMXII/25001/L', '25001', 'L', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-01-12 23:42:00', '97.923', 'BALONGAN', '2025-01-15 21:00:00', '83.44', '420', '10', '6.060606', '1.75', '2.8875', '185.483871', '210.987903', '12.88', '14.483', '1.603', '15250', '20705550.25', 'OPEN', NULL, 3, '2026-06-03 04:56:38', '2026-06-03 04:56:38');
INSERT INTO `t_master_cable` (`id`, `id_vessel`, `id_kontrak`, `no_voyage_gab`, `no_voyage`, `jenis_voyage`, `master`, `atd_port`, `atd_time`, `atd_rob`, `ata_port`, `ata_time`, `ata_rob`, `distance`, `speed`, `act_speed`, `est_sail_day`, `act_sail_day`, `charter_rate_day`, `est_claim_speed`, `std_bunker_cons`, `act_bunker_cons`, `excess_bunker`, `bunker_price`, `est_claim_bunker`, `status`, `keterangan`, `user_id`, `created_at`, `updated_at`) VALUES
(324, 46, 40, 'MMXII/25001/D1', '25001', 'D1', 'IMAM FAHRUDI', 'BALONGAN', '2025-01-17 13:30:00', '81.555', 'BANJARMASIN', '2025-01-20 03:30:00', '68.218', '420', '10', '6.774194', '1.75', '2.583333', '185.483871', '154.569831', '13.11625', '13.337', '0.22075', '14600', '2729838.65', 'OPEN', NULL, 3, '2026-06-03 04:58:57', '2026-06-03 04:58:57'),
(325, 46, 40, 'MMXII/25001/D2', '25001', 'D2', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-01-22 07:59:00', '64.811', 'DONGGALA', '2025-01-25 01:30:00', '50.723', '496', '10', '7.570593', '2.066667', '2.729861', '185.483871', '123.01179', '15.489669', '14.088', '-1.401669', '15250', '-18105008.05575', 'OPEN', NULL, 3, '2026-06-03 05:05:08', '2026-06-03 05:05:08'),
(326, 36, 38, 'F19/25007/D2', '25007', 'D2', 'IMAM FAHRUDI', 'KALBUT', '2025-04-11 11:00:00', '93.524', 'BENOA', '2025-04-12 09:00:00', '88.665', '0', '10', '0', '0', '0.916667', '173.333333', '158.888946', '0', '4.859', '4.859', '0', '0', 'OPEN', NULL, 10, '2026-06-03 05:05:39', '2026-06-03 05:05:39'),
(327, 46, 40, 'MMXII/25001/D3', '25001', 'D3', 'IMAM FAHRUDI', 'DONGGALA', '2025-01-26 00:30:00', '49.344', 'TARAKAN', '2025-01-27 20:29:00', '40.418', '270', '10', '6.138689', '1.125', '1.832639', '185.483871', '131.255621', '8.431875', '8.926', '0.494125', '14950', '6256931.93125', 'OPEN', NULL, 3, '2026-06-03 05:07:27', '2026-06-03 05:07:27'),
(328, 46, 40, 'MMXII/25001/D4', '25001', 'D4', 'IMAM FAHRUDI', 'TARAKAN', '2025-01-29 01:00:00', '38.228', 'BALIKPAPAN', '2025-01-31 01:30:00', '28.091', '355', '10', '7.319589', '1.479167', '2.020833', '185.483871', '100.470306', '11.086357', '10.137', '-0.949357', '14950', '-12021375.41605', 'OPEN', NULL, 3, '2026-06-03 05:08:52', '2026-06-03 05:08:52'),
(329, 46, 40, 'MMXII/25002/L', '25002', 'L', 'IMAM FAHRUDI', 'BALIKPAPAN', '2025-01-31 19:30:00', '119.308', 'KALBUT', '2025-02-03 22:00:00', '103.738', '455', '10', '6.107382', '1.895833', '3.104167', '205.357143', '248.140018', '13.953331', '15.57', '1.616669', '14800', '20265915.9164', 'OPEN', NULL, 3, '2026-06-03 05:09:58', '2026-06-03 05:09:58'),
(330, 46, 40, 'MMXII/25002/D1', '25002', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-02-10 20:29:00', '99.226', 'BANJARMASIN', '2025-02-12 22:30:00', '88.472', '245', '10', '4.898367', '1.020833', '2.084028', '205.357143', '218.334688', '7.651143', '10.754', '3.102857', '14800', '38896174.2092', 'OPEN', NULL, 3, '2026-06-03 05:11:12', '2026-06-03 05:11:12'),
(331, 46, 40, 'MMXII/25002/D2', '25002', 'D2', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-02-15 15:30:00', '83.66', 'PONTIANAK', '2025-02-19 07:59:00', '64.62', '520', '10', '5.876812', '2.166667', '3.686806', '205.357143', '312.171402', '16.239169', '19.04', '2.800831', '15450', '36652094.59065', 'OPEN', NULL, 3, '2026-06-03 05:12:10', '2026-06-03 05:12:10'),
(332, 46, 40, 'MMXII/25003/L', '25003', 'L', 'IMAM FAHRUDI', 'PONTIANAK', '2025-02-22 01:00:00', '128.38', 'BALONGAN', '2025-02-24 19:00:00', '114.582', '605', '10', '9.166667', '2.520833', '2.75', '205.357143', '47.06108', '18.553331', '13.798', '-4.755331', '14950', '-60215092.08715', 'OPEN', NULL, 3, '2026-06-03 05:13:48', '2026-06-03 05:13:48'),
(333, 46, 40, 'MMXII/25003/D1', '25003', 'D1', 'IMAM FAHRUDI', 'BALONGAN', '2025-03-01 09:30:00', '111.314', 'BANJARMASIN', '2025-03-04 03:30:00', '97.118', '425', '10', '6.439394', '1.770833', '2.75', '185.483871', '181.619686', '13.272393', '14.196', '0.923607', '14600', '11421508.8834', 'OPEN', NULL, 3, '2026-06-03 05:27:06', '2026-06-03 05:28:53'),
(334, 46, 40, 'MMXII/25003/D2', '25003', 'D2', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-03-06 05:30:00', '93.261', 'PANGKALAN BUN', '2025-03-07 17:00:00', '85.626', '234', '10', '6.591548', '0.975', '1.479167', '185.483871', '93.514847', '7.307625', '7.635', '0.327375', '15250', '4228621.03125', 'OPEN', NULL, 3, '2026-06-03 05:29:48', '2026-06-03 05:29:48'),
(335, 46, 40, 'MMXII/25003/D3', '25003', 'D3', 'IMAM FAHRUDI', 'PANGKALAN BUN', '2025-03-08 16:30:00', '83.653', 'BANJARMASIN', '2025-03-10 03:30:00', '76.125', '234', '10', '6.685716', '0.975', '1.458333', '185.483871', '89.650476', '7.307625', '7.528', '0.220375', '14950', '2790531.49375', 'OPEN', NULL, 3, '2026-06-03 05:31:05', '2026-06-03 05:31:05'),
(336, 46, 40, 'MMXII/25004/L', '25004', 'L', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-03-14 11:30:00', '138.768', 'BALONGAN', '2025-03-17 12:00:00', '123.497', '425', '10', '5.86207', '1.770833', '3.020833', '185.483871', '231.854839', '13.033331', '15.271', '2.237669', '15250', '28903411.05575', 'OPEN', NULL, 3, '2026-06-03 05:31:58', '2026-06-03 05:31:58'),
(337, 46, 40, 'MMXII/25004/D1', '25004', 'D1', 'IMAM FAHRUDI', 'BALONGAN', '2025-03-19 10:00:00', '121.79', 'BENOA', '2025-03-22 17:00:00', '104.799', '526', '10', '6.658227', '2.191667', '3.291667', '185.483871', '204.032258', '16.426544', '16.991', '0.564456', '14600', '6980175.7872', 'OPEN', NULL, 3, '2026-06-03 05:32:58', '2026-06-03 05:32:58'),
(339, 46, 40, 'MMXII/25005/L', '25005', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-03-24 21:30:00', '102.328', 'KALBUT', '2025-03-25 23:00:00', '96.998', '175', '10', '6.862745', '0.729167', '1.0625', '185.483871', '61.827895', '5.366669', '5.33', '-0.036669', '14600', '-453456.1878', 'OPEN', NULL, 3, '2026-06-03 05:46:10', '2026-06-03 05:46:10'),
(340, 46, 40, 'MMXII/25005/D1', '25005', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-03-27 09:00:00', '95.713', 'BENOA', '2025-03-28 10:48:00', '90.164', '175', '10', '6.782946', '0.729167', '1.075', '185.483871', '64.146444', '5.465107', '5.549', '0.083893', '14600', '1037437.6166', 'OPEN', NULL, 3, '2026-06-03 05:47:06', '2026-06-03 05:47:06'),
(341, 46, 40, 'MMXII/25006/L', '25006', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-04-04 18:30:00', '85.015', 'STS KALBUT', '2025-04-05 18:00:00', '80.103', '175', '10', '7.446806', '0.729167', '0.979167', '191.666667', '47.916667', '5.366669', '4.912', '-0.454669', '13900', '-5352954.5377', 'OPEN', NULL, 3, '2026-06-03 05:48:00', '2026-06-03 05:48:00'),
(342, 46, 40, 'MMXII/25006/D1', '25006', 'D1', 'IMAM FAHRUDI', 'STS KALBUT', '2025-04-07 10:00:00', '78.107', 'BENOA', '2025-04-08 12:30:00', '72.3', '175', '10', '6.603772', '0.729167', '1.104167', '191.666667', '71.875', '5.465107', '5.807', '0.341893', '13900', '4025208.8569', 'OPEN', NULL, 3, '2026-06-03 05:49:15', '2026-06-03 05:49:15'),
(343, 46, 40, 'MMXII/25007/L', '25007', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-04-10 08:00:00', '137.699', 'BALONGAN', '2025-04-13 13:30:00', '121.501', '526', '10', '6.787096', '2.191667', '3.229167', '191.666667', '198.854167', '16.130669', '16.198', '0.067331', '13900', '792708.0623', 'OPEN', NULL, 3, '2026-06-03 05:51:17', '2026-06-03 05:51:17'),
(344, 46, 40, 'MMXII/25007/D1', '25007', 'D1', 'IMAM FAHRUDI', 'BALONGAN', '2025-04-15 00:30:00', '119.943', 'BANJARMASIN', '2025-04-17 21:30:00', '105.102', '425', '10', '6.15942', '1.770833', '2.875', '191.666667', '211.632009', '13.272393', '14.841', '1.568607', '14500', '19264846.8705', 'OPEN', NULL, 3, '2026-06-03 05:52:24', '2026-06-03 05:52:24'),
(345, 46, 40, 'MMXII/25007/D2', '25007', 'D2', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-04-19 17:30:00', '101.64', 'P. BUN', '2025-04-21 05:30:00', '93.896', '234', '10', '6.5', '0.975', '1.5', '191.666667', '100.625', '7.307625', '7.744', '0.436375', '14200', '5248456.675', 'OPEN', NULL, 3, '2026-06-03 05:56:08', '2026-06-03 05:56:08'),
(346, 46, 40, 'MMXII/25007/D3', '25007', 'D3', 'IMAM FAHRUDI', 'P. BUN', '2025-04-22 01:00:00', '91.78', 'BANJARMASIN', '2025-04-23 13:00:00', '84.037', '234', '10', '6.5', '0.975', '1.5', '191.666667', '100.625', '7.307625', '7.743', '0.435375', '14500', '5347058.0625', 'OPEN', NULL, 3, '2026-06-03 05:56:49', '2026-06-03 05:56:49'),
(347, 46, 40, 'MMXII/25008/L', '25008', 'L', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-04-24 19:36:00', '81.182', 'BALONGAN', '2025-04-27 08:00:00', '68.559', '426', '10', '7.052979', '1.775', '2.516667', '191.666667', '142.152842', '13.064', '12.623', '-0.441', '13900', '-5192025.3', 'OPEN', NULL, 3, '2026-06-03 05:57:35', '2026-06-03 05:57:35'),
(348, 46, 40, 'MMXII/25008/D1', '25008', 'D1', 'IMAM FAHRUDI', 'BALONGAN', '2025-04-29 10:00:00', '66.403', 'PONTIANAK', '2025-05-02 16:30:00', '49.519', '534', '10', '6.802548', '2.225', '3.270833', '185.483871', '193.985153', '16.676375', '16.884', '0.207625', '14050', '2470810.16875', 'OPEN', NULL, 3, '2026-06-03 05:58:26', '2026-06-03 05:58:26'),
(349, 46, 40, 'MMXII/25008/D2', '25008', 'D2', 'IMAM FAHRUDI', 'PONTIANAK', '2025-05-05 22:30:00', '129.782', 'P. BUN', '2025-05-08 04:30:00', '118.167', '365', '10', '6.759259', '1.520833', '2.25', '185.483871', '135.248718', '11.398643', '11.615', '0.216357', '14050', '2574724.02495', 'OPEN', NULL, 3, '2026-06-03 06:00:37', '2026-06-03 06:00:37'),
(350, 46, 40, 'MMXII/25008/D3', '25008', 'D3', 'IMAM FAHRUDI', 'P. BUN', '2025-05-09 04:00:00', '116.005', 'BANJARMASIN', '2025-05-10 15:00:00', '108.478', '234', '10', '6.685716', '0.975', '1.458333', '185.483871', '89.650476', '7.307625', '7.527', '0.219375', '14350', '2666382.46875', 'OPEN', NULL, 3, '2026-06-03 06:01:23', '2026-06-03 06:01:23'),
(351, 46, 40, 'MMXII/25009/L', '25009', 'L', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-05-11 20:00:00', '105.205', 'BALONGAN', '2025-05-14 09:12:00', '92.414', '426', '10', '6.960784', '1.775', '2.55', '185.483871', '143.75', '13.064', '12.791', '-0.273', '13750', '-3179426.25', 'OPEN', NULL, 3, '2026-06-03 06:02:14', '2026-06-03 06:02:14'),
(352, 46, 40, 'MMXII/25009/D1', '25009', 'D1', 'IMAM FAHRUDI', 'BALONGAN', '2025-05-16 20:30:00', '90.38', 'PONTIANAK', '2025-05-19 19:00:00', '75.217', '450', '10', '6.382979', '1.875', '2.9375', '185.483871', '197.076613', '14.053125', '15.163', '1.109875', '14050', '13207900.95625', 'OPEN', NULL, 3, '2026-06-03 06:03:20', '2026-06-03 06:03:20'),
(353, 46, 40, 'MMXII/25009/D2', '25009', 'D2', 'IMAM FAHRUDI', 'PONTIANAK', '2025-05-20 23:00:00', '72.483', 'P. BUN', '2025-05-23 08:30:00', '60.115', '365', '10', '6.347827', '1.520833', '2.395833', '185.483871', '162.298387', '11.398643', '12.368', '0.969357', '14050', '11535687.57495', 'OPEN', NULL, 3, '2026-06-03 06:04:28', '2026-06-03 06:04:28'),
(354, 46, 40, 'MMXII/25009/D3', '25009', 'D3', 'IMAM FAHRUDI', 'P. BUN', '2025-05-24 20:00:00', '57.609', 'BANJARMASIN', '2025-05-26 10:30:00', '49.328', '234', '10', '6.077921', '0.975', '1.604167', '185.483871', '116.700331', '7.307625', '8.281', '0.973375', '14350', '11830837.76875', 'OPEN', NULL, 3, '2026-06-03 06:05:13', '2026-06-03 06:05:13'),
(357, 46, 40, 'MMXII/25010/L', '25010', 'L', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-06-01 08:30:00', '144.855', 'STS KALBUT', '2025-06-05 12:30:00', '123.954', '650', '10', '6.499999', '2.708333', '4.166667', '191.666667', '279.514017', '19.933331', '20.901', '0.967669', '13200', '10818926.4876', 'OPEN', NULL, 3, '2026-06-03 06:16:45', '2026-06-03 06:16:45'),
(358, 46, 40, 'MMXII/25010/D1', '25010', 'D1', 'IMAM FAHRUDI', 'STS KALBUT', '2025-06-07 12:00:00', '121.87', 'PONTIANAK', '2025-06-11 11:12:00', '101.394', '650', '10', '6.827731', '2.708333', '3.966667', '191.666667', '241.180684', '20.298956', '20.476', '0.177044', '13500', '2024409.618', 'OPEN', NULL, 3, '2026-06-03 06:17:53', '2026-06-03 06:17:53'),
(359, 46, 40, 'MMXII/25010/D2', '25010', 'D2', 'IMAM FAHRUDI', 'PONTIANAK', '2025-06-13 19:00:00', '97.617', 'P. BUN', '2025-06-16 04:06:00', '85.357', '326', '10', '5.709281', '1.358333', '2.379167', '191.666667', '195.65985', '10.180706', '12.26', '2.079294', '13500', '23775687.243', 'OPEN', NULL, 3, '2026-06-03 06:19:51', '2026-06-03 06:19:51'),
(360, 46, 40, 'MMXII/25010/D3', '25010', 'D3', 'IMAM FAHRUDI', 'P. BUN', '2025-06-17 08:00:00', '83.276', 'BANJARMASIN', '2025-06-19 01:30:00', '74.35', '234', '10', '5.638553', '0.975', '1.729167', '191.666667', '144.548675', '7.307625', '8.926', '1.618375', '13800', '18916538.025', 'OPEN', NULL, 3, '2026-06-03 06:21:40', '2026-06-03 06:21:40'),
(362, 46, 40, 'MMXII/25011/L', '25011', 'L', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-06-20 16:00:00', '71.033', 'BALIKPAPAN', '2025-06-22 16:30:00', '60.869', '330', '10', '6.804125', '1.375', '2.020833', '191.666667', '123.784659', '10.12', '10.164', '0.044', '13500', '503118', 'OPEN', NULL, 3, '2026-06-03 06:27:26', '2026-06-03 06:27:26'),
(363, 46, 40, 'MMXII/25011/D1', '25011', 'D1', 'IMAM FAHRUDI', 'BALIKPAPAN', '2025-06-24 14:00:00', '58.486', 'BANJARMASIN', '2025-06-26 18:30:00', '47.194', '350', '10', '6.666667', '1.458333', '2.1875', '191.666667', '139.757009', '10.930206', '11.292', '0.361794', '13800', '4228865.3484', 'OPEN', NULL, 3, '2026-06-03 06:28:49', '2026-06-03 06:28:49'),
(364, 46, 40, 'MMXII/25011/D2', '25011', 'D2', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-06-28 12:30:00', '68.47', 'P. BUN', '2025-06-29 22:00:00', '61.264', '234', '10', '6.985076', '0.975', '1.395833', '191.666667', '80.659658', '7.307625', '7.206', '-0.101625', '13500', '-1162031.0625', 'OPEN', NULL, 3, '2026-06-03 06:29:40', '2026-06-03 06:29:40'),
(365, 46, 40, 'MMXII/25011/D3', '25011', 'D3', 'IMAM FAHRUDI', 'P. BUN', '2025-07-01 15:30:00', '58.623', 'PONTIANAK', '2025-07-05 05:00:00', '40.233', '234', '10', '2.736842', '0.975', '3.5625', '185.483871', '479.939516', '7.307625', '18.39', '11.082375', '13950', '130945464.16875', 'OPEN', NULL, 3, '2026-06-03 06:30:56', '2026-06-03 06:30:56'),
(366, 46, 40, 'MMXII/25012/L', '25012', 'L', 'IMAM FAHRUDI', 'PONTIANAK', '2025-07-08 17:30:00', '137.399', 'BALONGAN', '2025-07-11 18:30:00', '122.102', '470', '10', '6.438355', '1.958333', '3.041667', '185.483871', '200.940984', '14.413331', '15.297', '0.883669', '13650', '10216583.32695', 'OPEN', NULL, 3, '2026-06-03 06:35:12', '2026-06-03 06:35:12'),
(367, 46, 40, 'MMXII/25012/D1', '25012', 'D1', 'IMAM FAHRUDI', 'BALONGAN', '2025-07-13 23:30:00', '120.096', 'BANJARMASIN', '2025-07-16 21:00:00', '105.148', '426', '10', '6.129497', '1.775', '2.895833', '185.483871', '207.896444', '13.303625', '14.948', '1.644375', '14250', '19847195.15625', 'OPEN', NULL, 3, '2026-06-03 06:36:16', '2026-06-03 06:36:16'),
(368, 46, 40, 'MMXII/25012/D2', '25012', 'D2', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-07-20 13:30:00', '100.94', 'PONTIANAK', '2025-07-23 21:12:00', '82.894', '520', '10', '6.524467', '2.166667', '3.320833', '185.483871', '214.079177', '16.239169', '18.046', '1.806831', '13950', '21348882.70515', 'OPEN', NULL, 3, '2026-06-03 06:37:16', '2026-06-03 06:37:16'),
(369, 46, 40, 'MMXII/25013/L', '25013', 'L', 'IMAM FAHRUDI', 'PONTIANAK', '2025-07-25 21:00:00', '79.462', 'BALONGAN', '2025-07-28 20:00:00', '64.623', '470', '10', '6.619719', '1.958333', '2.958333', '185.483871', '185.483871', '14.413331', '14.839', '0.425669', '13650', '4921393.42695', 'OPEN', NULL, 3, '2026-06-03 06:38:04', '2026-06-03 06:38:04'),
(370, 46, 40, 'MMXII/25013/D1', '25013', 'D1', 'IMAM FAHRUDI', 'BALONGAN', '2025-07-30 18:00:00', '62.902', 'BANJARMASIN', '2025-08-03 02:30:00', '45.587', '450', '10', '5.590062', '1.875', '3.354167', '185.483871', '274.361621', '14.053125', '17.315', '3.261875', '14750', '40751419.84375', 'OPEN', NULL, 3, '2026-06-03 06:39:18', '2026-06-03 06:39:18'),
(371, 46, 40, 'MMXII/25013/D2', '25013', 'D2', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-08-05 13:00:00', '143.187', 'PONTIANAK', '2025-08-08 23:30:00', '125.461', '550', '10', '6.666667', '2.291667', '3.4375', '185.483871', '212.53354', '17.176044', '17.726', '0.549956', '14450', '6730993.9774', 'OPEN', NULL, 3, '2026-06-03 06:40:04', '2026-06-03 06:40:04'),
(372, 46, 40, 'MMXII/25014/L', '25014', 'L', 'IMAM FAHRUDI', 'PONTIANAK', '2025-08-12 22:00:00', '120.614', 'BALONGAN', '2025-08-16 01:00:00', '104.939', '470', '10', '6.266667', '1.958333', '3.125', '185.483871', '216.397911', '14.413331', '15.675', '1.261669', '14150', '15121166.04845', 'OPEN', NULL, 3, '2026-06-03 06:40:47', '2026-06-03 06:40:47'),
(373, 46, 40, 'MMXII/25014/D1', '25014', 'D1', 'IMAM FAHRUDI', 'BALONGAN', '2025-08-17 18:00:00', '103.111', 'KUMAI', '2025-08-20 01:00:00', '90.96', '350', '10', '6.363635', '1.458333', '2.291667', '185.483871', '154.570016', '10.930206', '12.151', '1.220794', '14450', '14941480.8851', 'OPEN', NULL, 3, '2026-06-03 06:41:31', '2026-06-03 06:41:31'),
(374, 46, 40, 'MMXII/25014/D2', '25014', 'D2', 'IMAM FAHRUDI', 'KUMAI', '2025-08-21 07:30:00', '88.538', 'BANJARMASIN', '2025-08-23 00:30:00', '79.72', '350', '10', '8.536587', '1.458333', '1.708333', '185.483871', '46.370968', '10.930206', '8.818', '-2.112206', '14750', '-26388317.6095', 'OPEN', NULL, 3, '2026-06-03 06:42:10', '2026-06-03 06:42:10'),
(375, 46, 40, 'MMXII/25014/D3', '25014', 'D3', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-08-24 21:00:00', '76.156', 'PONTIANAK', '2025-08-28 03:30:00', '59.271', '550', '10', '7.00637', '2.291667', '3.270833', '185.483871', '181.6195', '17.176044', '16.885', '-0.291044', '14450', '-3562131.1726', 'OPEN', NULL, 3, '2026-06-03 06:43:45', '2026-06-03 06:43:45'),
(376, 46, 40, 'MMXII/25015/L', '25015', 'L', 'IMAM FAHRUDI', 'PONTIANAK', '2025-09-01 11:00:00', '155.863', 'STS KALBUT', '2025-09-06 03:00:00', '132.455', '650', '10', '5.803571', '2.708333', '4.666667', '191.666667', '375.347351', '19.933331', '23.408', '3.474669', '13850', '40761168.30555', 'OPEN', NULL, 3, '2026-06-03 06:45:14', '2026-06-03 06:45:14'),
(377, 46, 40, 'MMXII/25015/D1', '25015', 'D1', 'IMAM FAHRUDI', 'STS KALBUT', '2025-09-09 08:30:00', '129.88', 'BANJARMASIN', '2025-09-11 02:00:00', '120.954', '270', '10', '6.506023', '1.125', '1.729167', '191.666667', '115.798675', '8.431875', '8.926', '0.494125', '14450', '6047669.99375', 'OPEN', NULL, 3, '2026-06-03 06:46:08', '2026-06-03 07:04:46'),
(378, 46, 40, 'MMXII/25015/D2', '25015', 'D2', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-09-12 08:30:00', '117.43', 'P. BUN', '2025-09-14 06:30:00', '109.041', '260', '10', '5.652173', '1.083333', '1.916667', '191.666667', '159.72235', '8.119581', '8.389', '0.269419', '14150', '3229000.18595', 'OPEN', NULL, 3, '2026-06-03 07:05:55', '2026-06-03 07:05:55'),
(379, 46, 40, 'MMXII/25015/D3', '25015', 'D3', 'IMAM FAHRUDI', 'P. BUN', '2025-09-15 15:30:00', '107.013', 'PONTIANAK', '2025-09-17 14:30:00', '95.398', '350', '10', '7.44681', '1.458333', '1.958333', '191.666667', '95.833333', '10.930206', '11.615', '0.684794', '14150', '8207290.3297', 'OPEN', NULL, 3, '2026-06-03 07:09:12', '2026-06-03 07:09:12'),
(380, 46, 40, 'MMXII/25016/L', '25016', 'L', 'IMAM FAHRUDI', 'PONTIANAK', '2025-09-19 20:00:00', '91.994', 'KALBUT', '2025-09-23 20:00:00', '71.825', '650', '10', '6.770833', '2.708333', '4', '191.666667', '247.569509', '19.933331', '20.169', '0.235669', '13850', '2764621.25555', 'OPEN', NULL, 3, '2026-06-03 07:10:22', '2026-06-03 07:10:22'),
(381, 46, 40, 'MMXII/25016/D1', '25016', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-09-25 07:00:00', '70.556', 'PONTIANAK', '2025-09-29 00:30:00', '51.306', '650', '10', '7.262569', '2.708333', '3.729167', '191.666667', '195.65985', '20.298956', '19.25', '-1.048956', '14150', '-12571790.1078', 'OPEN', NULL, 3, '2026-06-03 07:11:06', '2026-06-03 07:11:06'),
(382, 46, 40, 'MMXII/25016/D2', '25016', 'D2', 'IMAM FAHRUDI', 'PONTIANAK', '2025-09-30 17:31:00', '47.714', 'BANJARMASIN', '2025-10-04 00:00:00', '30.829', '550', '10', '7.007857', '2.291667', '3.270139', '185.483871', '181.490774', '17.176044', '16.885', '-0.291044', '14600', '-3599108.3128', 'OPEN', NULL, 3, '2026-06-03 07:11:53', '2026-06-03 07:11:53'),
(383, 46, 40, 'MMXII/25016/D3', '25016', 'D3', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-10-06 08:24:00', '153.106', 'P. BUN', '2025-10-07 16:04:00', '146.331', '260', '10', '8.210529', '1.083333', '1.319444', '185.483871', '43.794782', '8.119581', '6.775', '-1.344581', '14300', '-16285699.5301', 'OPEN', NULL, 3, '2026-06-03 07:12:42', '2026-06-03 07:12:42'),
(384, 46, 40, 'MMXII/25017/L', '25017', 'L', 'IMAM FAHRUDI', 'P. BUN', '2025-10-08 18:28:00', '143.797', 'BALONGAN', '2025-10-10 07:26:00', '136.053', '350', '10', '9.467988', '1.458333', '1.540278', '185.483871', '15.199476', '10.733331', '7.744', '-2.989331', '14000', '-35447486.998', 'OPEN', NULL, 3, '2026-06-03 07:13:30', '2026-06-03 07:13:30'),
(385, 46, 40, 'MMXII/25017/D1', '25017', 'D1', 'IMAM FAHRUDI', 'BALONGAN', '2025-10-13 11:31:00', '133.495', 'BANJARMASIN', '2025-10-16 03:07:00', '119.836', '450', '10', '7.075472', '1.875', '2.65', '185.483871', '143.75', '14.053125', '13.659', '-0.394125', '14600', '-4873828.575', 'OPEN', NULL, 3, '2026-06-03 07:16:32', '2026-06-03 07:16:32'),
(386, 46, 40, 'MMXII/25017/D2', '25017', 'D2', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-10-21 01:55:00', '114.112', 'P. BUN', '2025-10-22 21:07:00', '104.863', '260', '10', '6.018519', '1.083333', '1.8', '185.483871', '132.930169', '8.119581', '9.249', '1.129419', '14300', '13679635.8699', 'OPEN', NULL, 3, '2026-06-03 07:17:29', '2026-06-03 07:17:29'),
(387, 46, 40, 'MMXII/25017/D3', '25017', 'D3', 'IMAM FAHRUDI', 'P. BUN', '2025-10-24 19:55:00', '101.884', 'BANJARMASIN', '2025-10-26 05:02:00', '94.785', '260', '10', '7.851032', '1.083333', '1.379861', '185.483871', '55.001161', '8.119581', '7.099', '-1.020581', '14600', '-12620708.7622', 'OPEN', NULL, 3, '2026-06-03 07:18:32', '2026-06-03 07:18:32'),
(388, 46, 40, 'MMXII/25018/L', '25018', 'L', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-10-31 14:00:00', '88.76', 'KALBUT', '2025-11-01 19:00:00', '82.699', '270', '10', '9.310347', '1.125', '1.208333', '191.666667', '15.972158', '8.28', '6.061', '-2.219', '14300', '-26876749.9', 'OPEN', NULL, 3, '2026-06-03 07:19:19', '2026-06-03 07:19:19'),
(389, 46, 40, 'MMXII/25018/D1', '25018', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-11-06 19:00:00', '78.516', 'PONTIANAK', '2025-11-10 22:18:00', '57.158', '650', '10', '6.545821', '2.708333', '4.1375', '191.666667', '273.923675', '20.298956', '21.358', '1.059044', '14300', '12827246.8324', 'OPEN', NULL, 3, '2026-06-03 07:20:00', '2026-06-03 07:20:00'),
(390, 46, 40, 'MMXII/25018/D2', '25018', 'D2', 'IMAM FAHRUDI', 'PONTIANAK', '2025-11-12 14:00:00', '53.766', 'BANJARMASIN', '2025-11-16 00:30:00', '36.021', '550', '10', '6.666667', '2.291667', '3.4375', '191.666667', '219.617992', '17.176044', '17.745', '0.568956', '14300', '6891251.9676', 'OPEN', NULL, 3, '2026-06-03 07:20:52', '2026-06-03 07:20:52'),
(391, 46, 40, 'MMXII/25018/D3', '25018', 'D3', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-11-18 03:30:00', '133.239', 'P. BUN', '2025-11-19 18:30:00', '124.849', '260', '10', '6.666667', '1.083333', '1.625', '191.666667', '103.819509', '8.119581', '8.39', '0.270419', '14300', '3275341.9699', 'OPEN', NULL, 3, '2026-06-03 07:21:36', '2026-06-03 07:21:36'),
(392, 46, 40, 'MMXII/25019/L', '25019', 'L', 'IMAM FAHRUDI', 'P. BUN', '2025-11-21 05:00:00', '122.618', 'BALONGAN', '2025-11-23 03:24:00', '112.982', '350', '10', '7.543105', '1.458333', '1.933333', '191.666667', '91.041667', '10.733331', '9.636', '-1.097331', '14300', '-13290982.8051', 'OPEN', NULL, 3, '2026-06-03 07:22:46', '2026-06-03 07:22:46'),
(393, 46, 40, 'MMXII/25019/D1', '25019', 'D1', 'IMAM FAHRUDI', 'BALONGAN', '2025-11-24 11:30:00', '111.475', 'PONTIANAK', '2025-11-29 14:00:00', '85.127', '811', '10', '6.620408', '3.379167', '5.104167', '191.666667', '330.625001', '25.326857', '26.348', '1.021143', '14300', '12368186.1303', 'OPEN', NULL, 3, '2026-06-03 07:23:33', '2026-06-03 07:23:33'),
(394, 46, 40, 'MMXII/25019/D2', '25019', 'D2', 'IMAM FAHRUDI', 'PONTIANAK', '2025-12-02 16:00:00', '81.142', 'BANJARMASIN', '2025-12-05 23:30:00', '64.042', '550', '10', '6.918239', '2.291667', '3.3125', '185.483871', '189.348056', '17.176044', '17.1', '-0.076044', '15300', '-985461.8004', 'OPEN', NULL, 3, '2026-06-03 07:24:23', '2026-06-03 07:24:23'),
(395, 46, 40, 'MMXII/25019/D3', '25019', 'D3', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-12-07 08:30:00', '60.472', 'P. BUN', '2025-12-09 09:00:00', '50.04', '260', '10', '5.360826', '1.083333', '2.020833', '185.483871', '173.891129', '8.119581', '10.432', '2.312419', '15300', '29966869.0629', 'OPEN', NULL, 3, '2026-06-03 07:25:01', '2026-06-03 07:25:01'),
(396, 46, 40, 'MMXII/25020/L', '25020', 'L', 'IMAM FAHRUDI', 'P. BUN', '2025-12-10 08:30:00', '47.888', 'KALBUT', '2025-12-12 04:30:00', '38.691', '360', '10', '8.18182', '1.5', '1.833333', '185.483871', '61.827895', '11.04', '9.197', '-1.843', '15300', '-23883621.3', 'OPEN', NULL, 3, '2026-06-03 07:25:54', '2026-06-03 07:25:54'),
(397, 46, 40, 'MMXII/25020/D1', '25020', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-12-15 15:00:00', '35.436', 'BANJARMASIN', '2025-12-18 05:00:00', '22.1', '403', '10', '6.500001', '1.679167', '2.583333', '185.483871', '167.70821', '12.585357', '13.336', '0.750643', '15300', '9727657.7013', 'OPEN', NULL, 3, '2026-06-03 07:26:46', '2026-06-03 07:26:46'),
(398, 46, 40, 'MMXII/25020/D2', '25020', 'D2', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-12-20 05:00:00', '144.626', 'P. BUN', '2025-12-21 16:30:00', '133.54', '260', '10', '7.323942', '1.083333', '1.479167', '185.483871', '73.420823', '8.119581', '11.086', '2.966419', '15300', '38442120.4629', 'OPEN', NULL, 3, '2026-06-03 07:46:56', '2026-06-03 07:46:56'),
(399, 46, 40, 'MMXII/25020/D3', '25020', 'D3', 'IMAM FAHRUDI', 'P. BUN', '2025-12-22 19:00:00', '129.865', 'BANJARMASIN', '2025-12-24 06:00:00', '118.935', '260', '10', '7.428573', '1.083333', '1.458333', '185.483871', '69.556452', '8.119581', '10.93', '2.810419', '15300', '36420500.8629', 'OPEN', NULL, 3, '2026-06-03 07:47:54', '2026-06-03 07:47:54'),
(400, 46, 40, 'MMXII/26001/L', '26001', 'L', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-12-30 12:30:00', '110.427', 'KALBUT', '2025-12-31 21:00:00', '100.449', '270', '10', '8.30769', '1.125', '1.354167', '185.483871', '42.506782', '8.28', '9.978', '1.698', '15300', '22004551.8', 'OPEN', NULL, 10, '2026-06-03 07:50:44', '2026-06-04 02:17:37'),
(401, 46, 40, 'MMXII/26001/D1', '26001', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2026-01-02 16:00:00', '97.411', 'PONTIANAK', '2026-01-07 00:00:00', '64.933', '650', '10', '6.25', '2.708333', '4.333333', '185.483871', '301.41129', '20.298956', '32.478', '12.179044', '20750', '214049743.061', 'OPEN', NULL, 3, '2026-06-03 07:53:06', '2026-06-03 07:53:06'),
(402, 46, 40, 'MMXII/26001/D2', '26001', 'D2', 'IMAM FAHRUDI', 'PONTIANAK', '2026-01-08 09:00:00', '60.467', 'BANJARMASIN', '2026-01-11 05:30:00', '39.075', '550', '10', '8.029196', '2.291667', '2.854167', '185.483871', '104.334677', '17.176044', '21.392', '4.215956', '20750', '74096480.689', 'OPEN', NULL, 3, '2026-06-03 07:53:54', '2026-06-03 07:53:54'),
(403, 46, 40, 'MMXII/26001/D3', '26001', 'D3', 'IMAM FAHRUDI', 'BANJARMASIN', '2026-01-13 22:30:00', '185.14', 'P. BUN', '2026-01-15 16:00:00', '172.179', '260', '10', '6.265059', '1.083333', '1.729167', '185.483871', '119.79179', '8.119581', '12.961', '4.841419', '20750', '85089149.27975', 'OPEN', NULL, 3, '2026-06-03 07:55:22', '2026-06-03 07:55:22'),
(404, 46, 40, 'MMXII/26002/L', '26002', 'L', 'IMAM FAHRUDI', 'P. BUN', '2026-01-17 06:00:00', '167.8', 'KALBUT', '2026-01-18 23:30:00', '155.078', '360', '10', '8.674697', '1.5', '1.729167', '185.483871', '42.506782', '11.04', '12.722', '1.682', '20750', '29561570.5', 'OPEN', NULL, 3, '2026-06-03 07:56:04', '2026-06-03 07:56:04'),
(405, 46, 40, 'MMXII/26002/D1', '26002', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2026-01-20 20:00:00', '155.26', 'BANJARMASIN', '2026-01-22 18:00:00', '137.901', '270', '10', '5.869564', '1.125', '1.916667', '185.483871', '146.84146', '8.431875', '17.359', '8.927125', '20750', '156896453.65625', 'OPEN', NULL, 3, '2026-06-03 07:56:58', '2026-06-03 07:56:58'),
(406, 46, 40, 'MMXII/26002/D2', '26002', 'D2', 'IMAM FAHRUDI', 'BANJARMASIN', '2026-01-24 20:00:00', '131.382', 'P. BUN', '2026-01-26 09:30:00', '119.672', '260', '10', '6.933333', '1.083333', '1.5625', '185.483871', '88.87775', '8.119581', '11.71', '3.590419', '20750', '63102511.52975', 'OPEN', NULL, 3, '2026-06-03 07:57:39', '2026-06-03 07:57:39'),
(407, 46, 40, 'MMXII/26002/D3', '26002', 'D3', 'IMAM FAHRUDI', 'P. BUN', '2026-01-28 16:30:00', '115.437', 'BANJARMASIN', '2026-01-29 22:00:00', '106.247', '270', '10', '9.15254', '1.125', '1.229167', '185.483871', '19.321298', '8.431875', '9.19', '0.758125', '20750', '13324236.40625', 'OPEN', NULL, 3, '2026-06-03 07:59:20', '2026-06-03 07:59:20'),
(408, 46, 40, 'MMXII/26002/D4', '26002', 'D4', 'IMAM FAHRUDI', 'BANJARMASIN', '2026-02-01 00:00:00', '185.166', 'AMPENAN', '2026-02-02 17:00:00', '172.362', '360', '10', '8.78049', '1.5', '1.708333', '205.357143', '42.78267', '11.2425', '12.804', '1.5615', '21200', '28038918.6', 'OPEN', NULL, 3, '2026-06-03 08:00:24', '2026-06-03 08:00:24'),
(409, 46, 40, 'MMXII/26003/L', '26003', 'L', 'IMAM FAHRUDI', 'AMPENAN', '2026-02-03 10:00:00', '171.066', 'KALBUT', '2026-02-04 00:00:00', '165.659', '170', '10', '12.142864', '0.708333', '0.583333', '205.357143', '-25.669643', '5.213331', '5.407', '0.193669', '21200', '3477598.0316', 'OPEN', NULL, 3, '2026-06-03 08:01:05', '2026-06-03 08:01:05'),
(410, 46, 40, 'MMXII/26003/D1', '26003', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2026-02-07 14:00:00', '162.114', 'BENOA', '2026-02-08 09:42:00', '155.962', '170', '10', '8.629445', '0.708333', '0.820833', '205.357143', '23.102679', '5.308956', '6.152', '0.843044', '21200', '15138035.2816', 'OPEN', NULL, 3, '2026-06-03 08:02:08', '2026-06-03 08:02:08'),
(411, 46, 40, 'MMXII/26004/L', '26004', 'L', 'IMAM FAHRUDI', 'BENOA', '2026-02-12 01:00:00', '149.252', 'KALBUT', '2026-02-12 16:30:00', '144.499', '170', '10', '10.967748', '0.708333', '0.645833', '205.357143', '-12.834821', '5.213331', '4.753', '-0.460331', '21200', '-8265887.5684', 'OPEN', NULL, 3, '2026-06-03 08:03:03', '2026-06-03 08:03:03'),
(412, 46, 40, 'MMXII/26004/D1', '26004', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2026-02-14 13:30:00', '141.355', 'AMPENAN', '2026-02-15 06:30:00', '136.046', '160', '10', '9.411769', '0.666667', '0.708333', '205.357143', '8.556411', '4.996669', '5.309', '0.312331', '21200', '5608340.3684', 'OPEN', NULL, 3, '2026-06-03 08:03:46', '2026-06-03 08:03:46'),
(413, 46, 40, 'MMXII/26004/D2', '26004', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2026-02-16 08:30:00', '133.377', 'BENOA', '2026-02-16 13:30:00', '131.816', '70', '10', '14.000022', '0.291667', '0.208333', '205.357143', '-17.113232', '2.186044', '1.561', '-0.625044', '21200', '-11223540.0816', 'OPEN', NULL, 3, '2026-06-03 08:04:22', '2026-06-03 08:04:22'),
(414, 46, 40, 'MMXII/26005/L', '26005', 'L', 'IMAM FAHRUDI', 'BENOA', '2026-02-19 17:00:00', '126.892', 'KALBUT', '2026-02-20 11:30:00', '121.219', '170', '10', '9.189193', '0.708333', '0.770833', '205.357143', '12.834821', '5.213331', '5.673', '0.459669', '21200', '8254000.4316', 'OPEN', NULL, 3, '2026-06-03 08:06:02', '2026-06-03 08:06:02'),
(415, 46, 40, 'MMXII/26005/D1', '26005', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2026-02-22 14:00:00', '117.825', 'AMPENAN', '2026-02-23 11:00:00', '111.267', '160', '10', '7.619048', '0.666667', '0.875', '205.357143', '42.78267', '4.996669', '6.558', '1.561331', '21200', '28035883.9684', 'OPEN', NULL, 3, '2026-06-03 08:06:46', '2026-06-03 08:06:46'),
(416, 46, 40, 'MMXII/26005/D2', '26005', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2026-02-25 01:00:00', '107.553', 'BENOA', '2026-02-26 08:00:00', '105.367', '70', '10', '2.258064', '0.291667', '1.291667', '205.357143', '205.357143', '2.186044', '2.186', '-0.000044', '21200', '-790.0816', 'OPEN', NULL, 3, '2026-06-03 08:08:47', '2026-06-03 08:08:47'),
(417, 46, 40, 'MMXII/26006/L', '26006', 'L', 'IMAM FAHRUDI', 'BENOA', '2026-03-02 00:00:00', '100.434', 'KALBUT', '2026-03-02 17:30:00', '95.068', '170', '10', '9.714281', '0.708333', '0.729167', '185.483871', '3.864371', '5.213331', '5.366', '0.152669', '23050', '2980610.32115', 'OPEN', NULL, 3, '2026-06-03 08:09:35', '2026-06-03 08:09:35'),
(418, 46, 40, 'MMXII/26006/D1', '26006', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2026-03-12 11:00:00', '87', 'AMPENAN', '2026-03-13 09:00:00', '80.13', '160', '10', '7.272725', '0.666667', '0.916667', '185.483871', '46.370968', '4.996669', '6.87', '1.873331', '23050', '36573696.77885', 'OPEN', NULL, 3, '2026-06-03 08:10:17', '2026-06-03 08:10:17'),
(419, 46, 40, 'MMXII/26006/D2', '26006', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2026-03-14 19:00:00', '77.522', 'BENOA', '2026-03-15 01:00:00', '75.648', '70', '10', '11.666667', '0.291667', '0.25', '185.483871', '-7.728556', '2.186044', '1.874', '-0.312044', '23050', '-6092144.2274', 'OPEN', NULL, 3, '2026-06-03 08:10:51', '2026-06-03 08:10:51'),
(420, 46, 40, 'MMXII/26007/L', '26007', 'L', 'IMAM FAHRUDI', 'BENOA', '2026-03-16 13:00:00', '71.807', 'KALBUT', '2026-03-17 06:30:00', '66.452', '170', '10', '9.714281', '0.708333', '0.729167', '185.483871', '3.864371', '5.213331', '5.355', '0.141669', '23050', '2765853.47115', 'OPEN', NULL, 3, '2026-06-03 08:11:58', '2026-06-03 08:11:58'),
(421, 46, 40, 'MMXII/26007/D1', '26007', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2026-03-23 18:00:00', '79.515', 'BENOA', '2026-03-24 16:00:00', '72.559', '170', '10', '7.72727', '0.708333', '0.916667', '185.483871', '38.642597', '5.308956', '6.956', '1.647044', '23050', '32155816.4774', 'OPEN', NULL, 3, '2026-06-03 08:12:32', '2026-06-03 08:12:32'),
(422, 46, 40, 'MMXII/26008/L', '26008', 'L', 'IMAM FAHRUDI', 'BENOA', '2026-03-25 22:30:00', '69.34', 'KALBUT', '2026-03-26 22:30:00', '61.982', '170', '10', '7.083333', '0.708333', '1', '185.483871', '54.099524', '5.213331', '7.358', '2.144669', '23050', '41871123.52115', 'OPEN', NULL, 3, '2026-06-03 08:13:11', '2026-06-03 08:13:11'),
(423, 46, 40, 'MMXII/26008/D1', '26008', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2026-03-30 10:30:00', '58.455', 'BENOA', '2026-03-31 09:30:00', '51.273', '170', '10', '7.391307', '0.708333', '0.958333', '185.483871', '46.370968', '5.308956', '7.182', '1.873044', '23050', '36568093.5774', 'OPEN', NULL, 3, '2026-06-03 08:13:56', '2026-06-03 08:13:56'),
(424, 46, 40, 'MMXII/26009/L', '26009', 'L', 'IMAM FAHRUDI', 'BENOA', '2026-04-02 19:00:00', '172.982', 'KALBUT', '2026-04-03 18:48:00', '165.684', '170', '10', '7.142855', '0.708333', '0.991667', '191.666667', '54.305683', '5.213331', '7.298', '2.084669', '28150', '49704867.20045', 'OPEN', NULL, 3, '2026-06-03 08:14:44', '2026-06-03 08:14:44'),
(425, 46, 40, 'MMXII/26009/D1', '26009', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2026-04-05 15:00:00', '162.095', 'BENOA', '2026-04-06 12:30:00', '155.381', '170', '10', '7.90698', '0.708333', '0.895833', '191.666667', '35.9375', '5.308956', '6.714', '1.405044', '28150', '33500534.3442', 'OPEN', NULL, 3, '2026-06-03 08:15:24', '2026-06-03 08:15:24'),
(426, 46, 40, 'MMXII/26010/L', '26010', 'L', 'IMAM FAHRUDI', 'BENOA', '2026-04-08 02:00:00', '151.755', 'KALBUT', '2026-04-09 00:30:00', '145.395', '170', '10', '7.555556', '0.708333', '0.9375', '191.666667', '43.923675', '5.213331', '6.36', '1.146669', '28150', '27340086.30045', 'OPEN', NULL, 3, '2026-06-03 08:16:04', '2026-06-03 08:16:04'),
(427, 46, 40, 'MMXII/26010/D1', '26010', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2026-04-11 16:00:00', '142.391', 'BENOA', '2026-04-12 13:30:00', '135.677', '170', '10', '7.90698', '0.708333', '0.895833', '191.666667', '35.9375', '5.308956', '6.714', '1.405044', '28150', '33500534.3442', 'OPEN', NULL, 3, '2026-06-03 08:16:56', '2026-06-03 08:16:56'),
(428, 46, 40, 'MMXII/26011/L', '26011', 'L', 'IMAM FAHRUDI', 'BENOA', '2026-04-13 23:00:00', '132.636', 'KALBUT', '2026-04-14 23:00:00', '125.277', '170', '10', '7.083333', '0.708333', '1', '191.666667', '55.902842', '5.213331', '7.359', '2.145669', '28150', '51159293.25045', 'OPEN', NULL, 3, '2026-06-03 08:18:12', '2026-06-03 08:18:12'),
(429, 46, 40, 'MMXII/26011/D1', '26011', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2026-04-19 17:00:00', '120.851', 'BENOA', '2026-04-20 15:30:00', '113.852', '170', '10', '7.555556', '0.708333', '0.9375', '191.666667', '43.923675', '5.308956', '6.999', '1.690044', '30550', '43731325.0374', 'OPEN', NULL, 3, '2026-06-03 08:18:51', '2026-06-03 08:18:51'),
(430, 46, 40, 'MMXII/26012/L', '26012', 'L', 'IMAM FAHRUDI', 'BENOA', '2026-04-22 22:30:00', '108.978', 'KALBUT', '2026-04-23 20:30:00', '102.232', '170', '10', '7.72727', '0.708333', '0.916667', '191.666667', '39.930683', '5.213331', '6.746', '1.532669', '30550', '39659113.14365', 'OPEN', NULL, 3, '2026-06-03 08:19:41', '2026-06-03 08:19:41'),
(431, 46, 40, 'MMXII/26012/D1', '26012', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2026-04-25 10:30:00', '99.842', 'BENOA', '2026-04-26 09:00:00', '92.816', '170', '10', '7.555556', '0.708333', '0.9375', '191.666667', '43.923675', '5.308956', '7.026', '1.717044', '30550', '44429972.9874', 'OPEN', NULL, 3, '2026-06-03 08:22:12', '2026-06-03 08:22:12'),
(432, 46, 40, 'MMXII/26013/L', '26013', 'L', 'IMAM FAHRUDI', 'BENOA', '2026-04-28 18:00:00', '89.416', 'KALBUT', '2026-04-29 16:00:00', '82.669', '170', '10', '7.72727', '0.708333', '0.916667', '191.666667', '39.930683', '5.213331', '6.747', '1.533669', '30550', '39684988.99365', 'OPEN', NULL, 3, '2026-06-03 08:22:59', '2026-06-03 08:22:59'),
(433, 46, 40, 'MMXII/26013/D1', '26013', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2026-05-02 13:00:00', '79.415', 'BENOA', '2026-05-03 10:00:00', '72.857', '170', '10', '8.095238', '0.708333', '0.875', '185.483871', '30.91404', '5.308956', '6.558', '1.249044', '30550', '32320075.1874', 'OPEN', NULL, 3, '2026-06-03 08:45:45', '2026-06-03 08:45:45'),
(434, 46, 40, 'MMXII/26014/L', '26014', 'L', 'IMAM FAHRUDI', 'BENOA', '2026-05-07 04:18:00', '194.269', 'KALBUT', '2026-05-08 02:30:00', '187.462', '170', '10', '7.657658', '0.708333', '0.925', '185.483871', '40.188234', '5.213331', '6.807', '1.593669', '30550', '41237539.99365', 'OPEN', NULL, 3, '2026-06-03 08:47:38', '2026-06-03 08:47:38'),
(435, 46, 40, 'MMXII/26014/D1', '26014', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2026-05-09 17:00:00', '184.619', 'BENOA', '2026-05-10 13:30:00', '178.218', '170', '10', '8.29268', '0.708333', '0.854167', '185.483871', '27.049855', '5.308956', '6.401', '1.092044', '30550', '28257566.7374', 'OPEN', NULL, 3, '2026-06-03 08:48:13', '2026-06-03 08:48:13'),
(436, 46, 40, 'MMXII/26015/L', '26015', 'L', 'IMAM FAHRUDI', 'BENOA', '2026-05-12 00:00:00', '174.697', 'KALBUT', '2026-05-12 23:30:00', '167.492', '170', '10', '7.23404', '0.708333', '0.979167', '185.483871', '50.235339', '5.213331', '7.205', '1.991669', '30550', '51536128.29365', 'OPEN', NULL, 3, '2026-06-03 08:48:54', '2026-06-03 08:48:54'),
(437, 46, 40, 'MMXII/26015/D1', '26015', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2026-05-14 12:00:00', '164.668', 'BENOA', '2026-05-15 09:00:00', '158.11', '170', '10', '8.095238', '0.708333', '0.875', '185.483871', '30.91404', '5.308956', '6.558', '1.249044', '30550', '32320075.1874', 'OPEN', NULL, 3, '2026-06-03 08:49:47', '2026-06-03 08:49:47'),
(438, 46, 40, 'MMXII/26016/L', '26016', 'L', 'IMAM FAHRUDI', 'BENOA', '2026-05-17 14:30:00', '153.172', 'KALBUT', '2026-05-18 12:30:00', '146.426', '170', '10', '7.72727', '0.708333', '0.916667', '185.483871', '38.642597', '5.213331', '6.746', '1.532669', '30550', '39659113.14365', 'OPEN', NULL, 3, '2026-06-03 08:50:47', '2026-06-03 08:50:47'),
(439, 46, 40, 'MMXII/26016/D1', '26016', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2026-05-20 13:00:00', '143.547', 'BENOA', '2026-05-21 10:00:00', '136.989', '170', '10', '8.095238', '0.708333', '0.875', '185.483871', '30.91404', '5.308956', '6.558', '1.249044', '30550', '32320075.1874', 'OPEN', NULL, 3, '2026-06-03 08:51:45', '2026-06-03 08:51:45'),
(440, 47, 42, 'MMXV/25001/L', '25001', 'L', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-01-14 02:29:00', '189.054', 'BALONGAN', '2025-01-17 18:30:00', '170.41', '468', '10', '5.317175', '1.95', '3.667361', '185.483871', '318.542766', '14.352', '18.644', '4.292', '15250', '55438691', 'OPEN', NULL, 3, '2026-06-03 08:54:49', '2026-06-03 08:54:49'),
(441, 47, 42, 'MMXV/25001/D1', '25001', 'D1', 'IMAM FAHRUDI', 'BALONGAN', '2025-01-19 11:29:00', '168.174', 'BANJARMASIN', '2025-01-22 16:59:00', '151.276', '468', '10', '6.038709', '1.95', '3.229167', '185.483871', '237.264847', '14.61525', '16.898', '2.28275', '14600', '28228943.05', 'OPEN', NULL, 3, '2026-06-03 08:55:48', '2026-06-03 08:55:48'),
(442, 47, 42, 'MMXV/25001/D2', '25001', 'D2', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-01-28 04:59:00', '145.296', 'KUMAI', '2025-01-30 05:29:00', '134.72', '320', '10', '6.597939', '1.333333', '2.020833', '185.483871', '127.520161', '9.993331', '10.576', '0.582669', '15250', '7526189.80575', 'OPEN', NULL, 3, '2026-06-03 08:57:16', '2026-06-03 08:57:16'),
(443, 47, 42, 'MMXV/25001/D3', '25001', 'D3', 'IMAM FAHRUDI', 'KALBUT', '2025-01-31 19:59:00', '131.579', 'BANJARMASIN', '2025-02-02 07:00:00', '121.492', '316', '10', '9.024273', '1.316667', '1.459028', '205.357143', '29.234848', '9.868419', '10.087', '0.218581', '14800', '2740043.9836', 'OPEN', NULL, 3, '2026-06-03 09:01:00', '2026-06-03 09:01:00'),
(444, 47, 42, 'MMXV/25002/L', '25002', 'L', 'IMAM FAHRUDI', 'BANJARMASIN', '2025-02-04 11:42:00', '188.901', 'KALBUT', '2025-02-06 07:59:00', '172.647', '316', '10', '7.135867', '1.316667', '1.845139', '205.357143', '108.5255', '9.690669', '16.254', '6.563331', '15450', '85888733.96565', 'OPEN', NULL, 3, '2026-06-03 09:01:51', '2026-06-03 09:01:51'),
(445, 47, 42, 'MMXV/25002/D1', '25002', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-02-15 07:59:00', '171.277', 'BENOA', '2025-02-16 08:29:00', '164.436', '180', '10', '7.346941', '0.75', '1.020833', '205.357143', '55.617491', '5.62125', '6.841', '1.21975', '14800', '15290298.1', 'OPEN', NULL, 3, '2026-06-03 09:02:45', '2026-06-03 09:02:45'),
(446, 47, 42, 'MMXV/25003/L', '25003', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-02-18 18:00:00', '162.84', 'KALBUT', '2025-02-19 21:05:00', '157.1', '180', '10', '6.646155', '0.75', '1.128472', '205.357143', '77.721929', '5.52', '5.74', '0.22', '14800', '2757832', 'OPEN', NULL, 3, '2026-06-03 09:03:34', '2026-06-03 09:03:34'),
(447, 47, 42, 'MMXV/25003/D1', '25003', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-02-21 19:00:00', '154.955', 'BENOA', '2025-02-22 19:59:00', '149.069', '180', '10', '7.204805', '0.75', '1.040972', '205.357143', '59.753179', '5.62125', '5.886', '0.26475', '14800', '3318800.1', 'OPEN', NULL, 3, '2026-06-03 09:04:20', '2026-06-03 09:04:20'),
(448, 47, 42, 'MMXV/25004/L', '25004', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-02-25 13:30:00', '145.507', 'BALONGAN', '2025-03-01 12:42:00', '124.576', '675', '10', '7.090336', '2.8125', '3.966667', '185.483871', '214.079363', '20.7', '20.931', '0.231', '14600', '2856592.2', 'OPEN', NULL, 3, '2026-06-03 09:05:53', '2026-06-03 09:05:53'),
(449, 47, 42, 'MMXV/25004/D1', '25004', 'D1', 'IMAM FAHRUDI', 'BALONGAN', '2025-03-03 00:30:00', '124.007', 'BENOA', '2025-03-06 15:48:00', '104.379', '675', '10', '7.731959', '2.8125', '3.6375', '185.483871', '153.024194', '21.079687', '19.628', '-1.451687', '14600', '-17951851.7794', 'OPEN', NULL, 3, '2026-06-03 09:06:40', '2026-06-03 09:06:40'),
(450, 47, 42, 'MMXV/25005/L', '25005', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-03-08 09:00:00', '100.686', 'BALONGAN', '2025-03-12 15:48:00', '78.858', '675', '10', '6.566148', '2.8125', '4.283333', '185.483871', '272.815798', '20.7', '21.828', '1.128', '14600', '13949073.6', 'OPEN', NULL, 3, '2026-06-03 09:07:51', '2026-06-03 09:07:51'),
(451, 47, 42, 'MMXV/25005/D1', '25005', 'D1', 'IMAM FAHRUDI', 'BALONGAN', '2025-03-15 08:00:00', '76.005', 'BENOA', '2025-03-19 03:30:00', '56.057', '675', '10', '7.377049', '2.8125', '3.8125', '185.483871', '185.483871', '21.079687', '19.948', '-1.131687', '14600', '-13994667.7794', 'OPEN', NULL, 3, '2026-06-03 09:09:38', '2026-06-03 09:09:38'),
(452, 47, 42, 'MMXV/25006/L', '25006', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-03-20 19:30:00', '162.43', 'KALBUT', '2025-03-21 20:30:00', '157.145', '180', '10', '7.199998', '0.75', '1.041667', '185.483871', '54.099524', '5.52', '5.285', '-0.235', '14600', '-2906057', 'OPEN', NULL, 3, '2026-06-03 09:12:15', '2026-06-03 09:12:15'),
(453, 47, 42, 'MMXV/25006/D1', '25006', 'D1', 'IMAM FAHRUDI', 'KALBUT', '2025-03-23 17:30:00', '154.691', 'BENOA', '2025-03-24 20:00:00', '148.912', '180', '10', '6.792451', '0.75', '1.104167', '185.483871', '65.692266', '5.62125', '5.779', '0.15775', '14600', '1950768.05', 'OPEN', NULL, 3, '2026-06-03 09:12:54', '2026-06-03 09:12:54'),
(454, 47, 42, 'MMXV/25007/L', '25007', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-04-03 20:30:00', '140.741', 'MANGGIS', '2025-04-04 23:42:00', '134.958', '100', '10', '3.676472', '0.416667', '1.133333', '191.666667', '137.360984', '3.066669', '5.783', '2.716331', '13900', '31980179.7623', 'OPEN', NULL, 3, '2026-06-03 09:15:32', '2026-06-03 09:15:32'),
(455, 47, 42, 'MMXV/25007/D1', '25007', 'D1', 'IMAM FAHRUDI', 'MANGGIS', '2025-04-06 20:00:00', '132.648', 'BADAS', '2025-04-07 19:42:00', '127.481', '158', '10', '6.666667', '0.658333', '0.9875', '191.666667', '63.090342', '4.934206', '5.167', '0.232794', '13900', '2740753.6002', 'OPEN', NULL, 3, '2026-06-03 09:17:21', '2026-06-03 09:17:21'),
(456, 47, 42, 'MMXV/25008/L', '25008', 'L', 'IMAM FAHRUDI', 'BADAS', '2025-04-09 04:42:00', '124.641', 'MANGGIS', '2025-04-09 22:00:00', '120.975', '158', '10', '9.132952', '0.658333', '0.720833', '191.666667', '11.979167', '4.845331', '3.666', '-1.179331', '13900', '-13884617.6623', 'OPEN', NULL, 3, '2026-06-03 09:18:06', '2026-06-03 09:18:06'),
(457, 47, 42, 'MMXV/25008/D1', '25008', 'D1', 'IMAM FAHRUDI', 'MANGGIS', '2025-04-10 22:00:00', '119.43', 'BADAS', '2025-04-11 20:00:00', '114.687', '158', '10', '7.181816', '0.658333', '0.916667', '191.666667', '49.514017', '4.934206', '4.743', '-0.191206', '13900', '-2251125.5998', 'OPEN', NULL, 3, '2026-06-03 09:19:17', '2026-06-03 09:19:17'),
(458, 47, 42, 'MMXV/25009/L', '25009', 'L', 'IMAM FAHRUDI', 'BADAS', '2025-04-13 12:00:00', '112.049', 'MANGGIS', '2025-04-14 06:30:00', '108.13', '158', '10', '8.540544', '0.658333', '0.770833', '191.666667', '21.5625', '4.845331', '3.919', '-0.926331', '13900', '-10905972.7623', 'OPEN', NULL, 3, '2026-06-03 09:20:12', '2026-06-03 09:20:12'),
(459, 47, 42, 'MMXV/25009/D1', '25009', 'D1', 'IMAM FAHRUDI', 'MANGGIS', '2025-04-16 07:00:00', '105.351', 'BADAS', '2025-04-17 02:00:00', '101.209', '158', '10', '8.315786', '0.658333', '0.791667', '191.666667', '25.555683', '4.934206', '4.142', '-0.792206', '13900', '-9326878.8998', 'OPEN', NULL, 3, '2026-06-03 09:21:20', '2026-06-03 09:21:20'),
(460, 47, 42, 'MMXV/25010/L', '25010', 'L', 'IMAM FAHRUDI', 'BADAS', '2025-04-20 09:30:00', '96.855', 'MANGGIS', '2025-04-21 03:18:00', '93.084', '158', '10', '8.876401', '0.658333', '0.741667', '191.666667', '15.97235', '4.845331', '3.771', '-1.074331', '13900', '-12648421.1623', 'OPEN', NULL, 3, '2026-06-03 09:22:20', '2026-06-03 09:22:20'),
(461, 47, 42, 'MMXV/25010/D1', '25010', 'D1', 'IMAM FAHRUDI', 'MANGGIS', '2025-04-22 16:00:00', '90.948', 'BADAS', '2025-04-23 16:42:00', '85.542', '158', '10', '6.396759', '0.658333', '1.029167', '191.666667', '71.076517', '4.934206', '5.406', '0.471794', '13900', '5554572.3002', 'OPEN', NULL, 3, '2026-06-03 09:22:55', '2026-06-03 09:22:55'),
(462, 47, 42, 'MMXV/25011/L', '25011', 'L', 'IMAM FAHRUDI', 'BADAS', '2025-04-24 18:00:00', '83.2', 'MANGGIS', '2025-04-25 11:18:00', '79.601', '158', '10', '9.132952', '0.658333', '0.720833', '191.666667', '11.979167', '4.845331', '3.599', '-1.246331', '13900', '-14673428.7623', 'OPEN', NULL, 3, '2026-06-03 09:23:42', '2026-06-03 09:23:42'),
(463, 47, 42, 'MMXV/25011/D1', '25011', 'D1', 'IMAM FAHRUDI', 'MANGGIS', '2025-04-27 06:30:00', '77.361', 'BADAS', '2025-04-28 01:00:00', '73.328', '158', '10', '8.540544', '0.658333', '0.770833', '191.666667', '21.5625', '4.934206', '4.033', '-0.901206', '13900', '-10610168.5998', 'OPEN', NULL, 3, '2026-06-03 09:24:49', '2026-06-03 09:24:49'),
(464, 47, 42, 'MMXV/25012/L', '25012', 'L', 'IMAM FAHRUDI', 'BADAS', '2025-04-29 09:30:00', '70.768', 'MANGGIS', '2025-04-30 04:18:00', '66.785', '158', '10', '8.404259', '0.658333', '0.783333', '191.666667', '23.958333', '4.845331', '3.983', '-0.862331', '13900', '-10152481.5623', 'OPEN', NULL, 3, '2026-06-03 09:25:26', '2026-06-03 09:25:26'),
(465, 47, 42, 'MMXV/25012/D1', '25012', 'D1', 'IMAM FAHRUDI', 'MANGGIS', '2025-05-03 13:30:00', '197.217', 'BADAS', '2025-05-04 15:30:00', '191.548', '158', '10', '6.076925', '0.658333', '1.083333', '185.483871', '78.830645', '4.934206', '5.669', '0.734794', '13750', '8557594.6225', 'OPEN', NULL, 3, '2026-06-03 09:26:04', '2026-06-03 09:26:04'),
(466, 47, 42, 'MMXV/25012/D2', '25012', 'D2', 'IMAM FAHRUDI', 'BADAS', '2025-09-21 22:00:00', '100.299', 'AMPENAN', '2025-09-22 15:30:00', '94.461', '46', '10', '2.62857', '0.191667', '0.729167', '191.666667', '103.020834', '1.436544', '5.838', '4.401456', '13850', '51633260.2632', 'OPEN', NULL, 3, '2026-06-03 09:26:55', '2026-06-03 09:26:55'),
(467, 47, 42, 'MMXV/25013/L', '25013', 'L', 'IMAM FAHRUDI', 'AMPENAN', '2025-09-23 23:00:00', '91.276', 'SURABAYA', '2025-09-26 05:30:00', '76.696', '353', '10', '6.477065', '1.470833', '2.270833', '191.666667', '153.333334', '10.825331', '14.58', '3.754669', '13850', '44045834.30555', 'OPEN', NULL, 3, '2026-06-03 09:27:39', '2026-06-03 09:27:39'),
(468, 47, 42, 'MMXV/25013/D1', '25013', 'D1', 'IMAM FAHRUDI', 'SURABAYA', '2025-09-28 22:30:00', '74.973', 'AMPENAN', '2025-10-02 03:30:00', '58.409', '353', '10', '4.584416', '1.470833', '3.208333', '185.483871', '322.278226', '11.023893', '16.564', '5.540107', '14000', '65694588.806', 'OPEN', NULL, 3, '2026-06-03 09:28:37', '2026-06-03 09:28:37'),
(469, 47, 42, 'MMXV/25013/D2', '25013', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2025-10-03 03:30:00', '56.275', 'BADAS', '2025-10-04 04:30:00', '50.817', '148', '10', '5.919998', '0.616667', '1.041667', '185.483871', '78.830645', '4.621919', '5.458', '0.836081', '14000', '9914248.498', 'OPEN', NULL, 3, '2026-06-03 09:29:13', '2026-06-03 09:29:13');
INSERT INTO `t_master_cable` (`id`, `id_vessel`, `id_kontrak`, `no_voyage_gab`, `no_voyage`, `jenis_voyage`, `master`, `atd_port`, `atd_time`, `atd_rob`, `ata_port`, `ata_time`, `ata_rob`, `distance`, `speed`, `act_speed`, `est_sail_day`, `act_sail_day`, `charter_rate_day`, `est_claim_speed`, `std_bunker_cons`, `act_bunker_cons`, `excess_bunker`, `bunker_price`, `est_claim_bunker`, `status`, `keterangan`, `user_id`, `created_at`, `updated_at`) VALUES
(470, 47, 42, 'MMXV/25013/D3', '25013', 'D3', 'IMAM FAHRUDI', 'BADAS', '2025-10-05 03:00:00', '48.9', 'BIMA', '2025-10-05 20:36:00', '45.065', '133', '10', '7.556822', '0.554167', '0.733333', '185.483871', '33.232403', '4.153482', '3.835', '-0.318482', '14000', '-3776559.556', 'OPEN', NULL, 3, '2026-06-03 09:30:22', '2026-06-03 09:30:22'),
(471, 47, 42, 'MMXV/25014/L', '25014', 'L', 'IMAM FAHRUDI', 'BIMA', '2025-10-06 21:30:00', '42.839', 'TG. MANGGIS', '2025-10-08 23:30:00', '32.244', '290', '10', '5.800001', '1.208333', '2.083333', '185.483871', '162.298387', '8.893331', '10.595', '1.701669', '14000', '20178391.002', 'OPEN', NULL, 3, '2026-06-03 09:31:30', '2026-06-03 09:31:30'),
(472, 47, 42, 'MMXV/25014/D1', '25014', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2025-10-12 23:30:00', '137.747', 'AMPENAN', '2025-10-13 11:12:00', '135.198', '46', '10', '3.931624', '0.191667', '0.4875', '185.483871', '54.87225', '1.436544', '2.549', '1.112456', '14000', '13191503.248', 'OPEN', NULL, 3, '2026-06-03 09:32:32', '2026-06-03 09:32:32'),
(473, 47, 42, 'MMXV/25014/D2', '25014', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2025-10-15 14:00:00', '132.377', 'BENOA', '2025-10-15 21:00:00', '130.851', '71', '10', '10.142846', '0.295833', '0.291667', '185.483871', '-0.772726', '2.217268', '1.526', '-0.691268', '14000', '-8197055.944', 'OPEN', NULL, 3, '2026-06-03 09:35:30', '2026-06-03 09:35:30'),
(475, 47, 42, 'MMXV/25015/L', '25015', 'L', 'IMAM FAHRUDI', 'BENOA', '2025-10-17 15:00:00', '128.868', 'TG. MANGGIS', '2025-10-17 22:00:00', '127.385', '29', '10', '4.142852', '0.120833', '0.291667', '185.483871', '31.686952', '0.889331', '1.483', '0.593669', '14000', '7039727.002', 'OPEN', NULL, 3, '2026-06-03 09:38:21', '2026-06-03 09:38:21'),
(476, 47, 42, 'MMXV/25015/D1', '25015', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2025-10-28 06:30:00', '119.412', 'AMPENAN', '2025-10-28 12:00:00', '118.213', '46', '10', '8.363624', '0.191667', '0.229167', '185.483871', '6.955645', '1.436544', '1.199', '-0.237544', '14000', '-2816796.752', 'OPEN', NULL, 3, '2026-06-03 09:39:07', '2026-06-03 09:39:07'),
(477, 47, 42, 'MMXV/25015/D2', '25015', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2025-10-29 10:30:00', '116.447', 'BADAS', '2025-10-30 00:30:00', '113.396', '128', '10', '9.142862', '0.533333', '0.583333', '185.483871', '9.274194', '3.997331', '3.051', '-0.946331', '14000', '-11221592.998', 'OPEN', NULL, 3, '2026-06-03 09:39:46', '2026-06-03 09:39:46'),
(478, 47, 42, 'MMXV/25015/D3', '25015', 'D3', 'IMAM FAHRUDI', 'BADAS', '2025-10-31 02:00:00', '111.237', 'BIMA', '2025-10-31 14:00:00', '108.621', '123', '10', '10.25', '0.5125', '0.5', '185.483871', '-2.318548', '3.841187', '2.616', '-1.225187', '14000', '-14528267.446', 'OPEN', NULL, 3, '2026-06-03 09:40:26', '2026-06-03 09:40:26'),
(479, 47, 42, 'MMXV/25016/L', '25016', 'L', 'IMAM FAHRUDI', 'BIMA', '2025-11-01 05:00:00', '106.847', 'TG. MANGGIS', '2025-11-02 12:30:00', '100.201', '246', '10', '7.809524', '1.025', '1.3125', '191.666667', '55.104167', '7.544', '6.646', '-0.898', '14300', '-10876665.8', 'OPEN', NULL, 3, '2026-06-03 09:43:40', '2026-06-03 09:43:40'),
(480, 47, 42, 'MMXV/25016/D1', '25016', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2025-11-06 14:30:00', '98.806', 'AMPENAN', '2025-11-06 19:18:00', '95.76', '46', '10', '9.583333', '0.191667', '0.2', '191.666667', '1.597158', '1.436544', '3.046', '1.609456', '14300', '19493892.0176', 'OPEN', NULL, 3, '2026-06-03 09:44:24', '2026-06-03 09:44:24'),
(481, 47, 42, 'MMXV/25016/D2', '25016', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2025-11-08 09:00:00', '93.5', 'TG. WANGI', '2025-11-09 01:00:00', '90.125', '132', '10', '8.249996', '0.55', '0.666667', '191.666667', '22.361175', '4.12225', '3.375', '-0.74725', '14300', '-9050766.725', 'OPEN', NULL, 3, '2026-06-03 09:45:40', '2026-06-03 09:45:40'),
(482, 47, 42, 'MMXV/25017/L', '25017', 'L', 'IMAM FAHRUDI', 'TG. WANGI', '2025-11-12 11:30:00', '87.661', 'TG. MANGGIS', '2025-11-13 04:00:00', '84.18', '136', '10', '8.242424', '0.566667', '0.6875', '191.666667', '23.159658', '4.170669', '3.481', '-0.689669', '14300', '-8353339.8949', 'OPEN', NULL, 3, '2026-06-03 09:47:43', '2026-06-03 09:47:43'),
(483, 47, 42, 'MMXV/25017/D1', '25017', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2025-11-16 15:30:00', '80.893', 'AMPENAN', '2025-11-16 21:42:00', '79.868', '40', '10', '6.451621', '0.166667', '0.258333', '191.666667', '17.569317', '1.249169', '1.025', '-0.224169', '14300', '-2715157.3449', 'OPEN', NULL, 3, '2026-06-03 09:48:26', '2026-06-03 09:48:26'),
(484, 47, 42, 'MMXV/25017/D2', '25017', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2025-11-18 21:30:00', '77.262', 'FT. BADAS', '2025-11-19 13:00:00', '73.3', '116', '10', '7.483875', '0.483333', '0.645833', '191.666667', '31.145833', '3.622581', '3.962', '0.339419', '14300', '4111076.8699', 'OPEN', NULL, 3, '2026-06-03 09:53:35', '2026-06-03 09:53:35'),
(485, 47, 42, 'MMXV/25018/L', '25018', 'L', 'IMAM FAHRUDI', 'FT. BADAS', '2025-11-20 04:30:00', '72.182', 'SURABAYA', '2025-11-22 04:30:00', '62.055', '410', '10', '8.541667', '1.708333', '2', '191.666667', '55.902842', '12.573331', '10.127', '-2.446331', '14300', '-29630205.7051', 'OPEN', NULL, 3, '2026-06-03 09:57:25', '2026-06-03 09:57:25'),
(486, 47, 42, 'MMXV/25018/D1', '25018', 'D1', 'IMAM FAHRUDI', 'SURABAYA', '2025-12-03 01:30:00', '53.837', 'AMPENAN', '2025-12-04 21:30:00', '42.997', '320', '10', '7.272729', '1.333333', '1.833333', '185.483871', '92.741935', '9.993331', '10.84', '0.846669', '15300', '10972068.2379', 'OPEN', NULL, 3, '2026-06-03 09:58:37', '2026-06-03 09:58:37'),
(487, 47, 42, 'MMXV/25019/L', '25019', 'L', 'IMAM FAHRUDI', 'AMPENAN', '2025-12-07 14:00:00', '39.94', 'TG. MANGGIS', '2025-12-07 18:30:00', '38.99', '40', '10', '8.888889', '0.166667', '0.1875', '185.483871', '3.864185', '1.226669', '0.95', '-0.276669', '15300', '-3585381.2379', 'OPEN', NULL, 3, '2026-06-03 10:02:45', '2026-06-03 10:02:45'),
(488, 47, 42, 'MMXV/25019/D1', '25019', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2025-12-12 11:30:00', '160.932', 'AMPENAN', '2025-12-12 16:30:00', '159.842', '45', '10', '9.000014', '0.1875', '0.208333', '185.483871', '3.864185', '1.405312', '1.09', '-0.315312', '15300', '-4086159.7392', 'OPEN', NULL, 3, '2026-06-03 10:03:48', '2026-06-03 10:03:48'),
(489, 47, 42, 'MMXV/25019/D2', '25019', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2025-12-13 09:30:00', '158.429', 'WAINGAPU', '2025-12-16 20:00:00', '145.678', '465', '10', '5.636364', '1.9375', '3.4375', '185.483871', '278.225806', '14.521562', '12.751', '-1.770562', '15300', '-22944890.0142', 'OPEN', NULL, 3, '2026-06-03 10:04:53', '2026-06-03 10:04:53'),
(490, 47, 42, 'MMXV/25019/D3', '25019', 'D3', 'IMAM FAHRUDI', 'WAINGAPU', '2025-12-17 02:00:00', '143.517', 'ENDE', '2025-12-18 05:00:00', '137.632', '348', '10', '12.888889', '1.45', '1.125', '185.483871', '-60.282258', '10.86775', '5.885', '-4.98275', '15300', '-64571955.525', 'OPEN', NULL, 3, '2026-06-03 10:08:53', '2026-06-03 10:08:53'),
(491, 47, 42, 'MMXV/25019/D4', '25019', 'D4', 'IMAM FAHRUDI', 'ENDE', '2025-12-18 22:00:00', '136.052', 'REO', '2025-12-20 13:30:00', '127.442', '350', '10', '8.860761', '1.458333', '1.645833', '185.483871', '34.778226', '10.930206', '8.61', '-2.320206', '15300', '-30067781.5746', 'OPEN', NULL, 3, '2026-06-03 10:09:37', '2026-06-03 10:09:37'),
(492, 47, 42, 'MMXV/25019/D5', '25019', 'D5', 'IMAM FAHRUDI', 'REO', '2025-12-21 05:00:00', '125.777', 'WAINGAPU', '2025-12-22 08:00:00', '119.892', '249', '10', '9.222222', '1.0375', '1.125', '185.483871', '16.229839', '7.776063', '5.885', '-1.891063', '15300', '-24506474.5233', 'OPEN', NULL, 3, '2026-06-03 10:10:26', '2026-06-03 10:10:26'),
(493, 47, 42, 'MMXV/25020/L', '25020', 'L', 'IMAM FAHRUDI', 'WAINGAPU', '2025-12-25 04:30:00', '116.963', 'TG. MANGGIS', '2025-12-28 11:00:00', '100.204', '640', '10', '8.152867', '2.666667', '3.270833', '185.483871', '112.063048', '19.626669', '16.759', '-2.867669', '15300', '-37162409.3379', 'OPEN', NULL, 3, '2026-06-03 10:12:13', '2026-06-03 10:12:13'),
(494, 47, 42, 'MMXV/25020/D1', '25020', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2025-12-30 10:30:00', '98.032', 'AMPENAN', '2025-12-30 15:30:00', '96.942', '45', '10', '9.000014', '0.1875', '0.208333', '185.483871', '3.864185', '1.405312', '1.09', '-0.315312', '15300', '-4086159.7392', 'OPEN', NULL, 3, '2026-06-03 10:12:52', '2026-06-03 10:12:52'),
(495, 47, 42, 'MMXV/25021/L', '25021', 'L', 'IMAM FAHRUDI', 'AMPENAN', '2025-12-31 22:30:00', '94.671', 'TG. MANGGIS', '2026-01-01 04:00:00', '93.51', '45', '10', '8.181806', '0.1875', '0.229167', '185.483871', '7.728556', '1.38', '1.161', '-0.219', '20750', '-3848979.75', 'OPEN', NULL, 3, '2026-06-03 10:13:39', '2026-06-03 10:13:39'),
(496, 47, 42, 'MMXV/26001/D1', '26001', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2026-01-07 14:42:00', '88.692', 'BADAS', '2026-01-08 11:00:00', '84.268', '158', '10', '7.783254', '0.658333', '0.845833', '185.483871', '34.778226', '4.934206', '4.424', '-0.510206', '20750', '-8966998.0015', 'OPEN', NULL, 3, '2026-06-03 10:15:37', '2026-06-03 10:15:37'),
(497, 47, 42, 'MMXV/26001/D2', '26001', 'D2', 'IMAM FAHRUDI', 'BADAS', '2026-01-09 05:30:00', '82.953', 'AMPENAN', '2026-01-09 23:00:00', '79.139', '152', '10', '8.68571', '0.633333', '0.729167', '185.483871', '17.775661', '4.746831', '3.814', '-0.932831', '20750', '-16394738.03275', 'OPEN', NULL, 3, '2026-06-03 10:16:18', '2026-06-03 10:16:18'),
(498, 47, 42, 'MMXV/26002/L', '26002', 'L', 'IMAM FAHRUDI', 'AMPENAN', '2026-01-11 20:30:00', '76.854', 'TG. MANGGIS', '2026-01-12 01:42:00', '75.757', '45', '10', '8.653833', '0.1875', '0.216667', '185.483871', '5.410008', '1.38', '1.097', '-0.283', '20750', '-4973795.75', 'OPEN', NULL, 3, '2026-06-03 10:55:36', '2026-06-03 10:55:36'),
(499, 47, 42, 'MMXV/26002/D1', '26002', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2026-01-16 04:42:00', '72.301', 'AMPENAN', '2026-01-16 10:00:00', '71.146', '45', '10', '8.490579', '0.1875', '0.220833', '185.483871', '6.182734', '1.405312', '1.155', '-0.250312', '20750', '-4399295.978', 'OPEN', NULL, 3, '2026-06-03 10:56:21', '2026-06-03 10:56:21'),
(500, 47, 42, 'MMXV/26002/D2', '26002', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2026-01-18 04:00:00', '68.876', 'BIMA', '2026-01-19 18:54:00', '61.247', '235', '10', '6.041132', '0.979167', '1.620833', '185.483871', '119.018694', '7.338857', '7.629', '0.290143', '20750', '5099335.76075', 'OPEN', NULL, 3, '2026-06-03 10:57:16', '2026-06-03 10:57:16'),
(501, 47, 42, 'MMXV/26003/L', '26003', 'L', 'IMAM FAHRUDI', 'BIMA', '2026-01-21 14:00:00', '58.653', 'TG. MANGGIS', '2026-01-25 02:00:00', '40.933', '280', '10', '3.333333', '1.166667', '3.5', '185.483871', '432.795637', '8.586669', '17.72', '9.133331', '20750', '160520575.65775', 'OPEN', NULL, 3, '2026-06-03 10:58:38', '2026-06-03 10:58:38'),
(502, 47, 42, 'MMXV/26003/D1', '26003', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2026-01-27 22:00:00', '147.828', 'BIMA', '2026-01-29 15:00:00', '138.526', '300', '10', '7.317075', '1.25', '1.708333', '185.483871', '85.013379', '9.36875', '9.302', '-0.06675', '20750', '-1173147.9375', 'OPEN', NULL, 3, '2026-06-03 11:01:05', '2026-06-03 11:01:05'),
(503, 47, 42, 'MMXV/26003/D2', '26003', 'D2', 'IMAM FAHRUDI', 'BIMA', '2026-01-30 12:00:00', '131.362', 'AMPENAN', '2026-02-01 02:00:00', '128.311', '235', '10', '6.184212', '0.979167', '1.583333', '205.357143', '124.069804', '7.338857', '3.051', '-4.287857', '21200', '-76994475.4348', 'OPEN', NULL, 3, '2026-06-03 11:02:53', '2026-06-03 11:02:53'),
(504, 47, 42, 'MMXV/26004/L', '26004', 'L', 'IMAM FAHRUDI', 'AMPENAN', '2026-02-04 09:00:00', '125.045', 'TG. MANGGIS', '2026-02-04 13:36:00', '124.075', '45', '10', '9.782592', '0.1875', '0.191667', '205.357143', '0.855723', '1.38', '0.97', '-0.41', '21200', '-7362124', 'OPEN', NULL, 3, '2026-06-03 11:03:48', '2026-06-03 11:03:48'),
(505, 47, 42, 'MMXV/26004/D1', '26004', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2026-02-10 09:00:00', '119.62', 'AMPENAN', '2026-02-10 15:00:00', '118.312', '45', '10', '7.5', '0.1875', '0.25', '205.357143', '12.834821', '1.405312', '1.308', '-0.097312', '21200', '-1747373.1968', 'OPEN', NULL, 3, '2026-06-03 11:05:20', '2026-06-03 11:05:20'),
(506, 47, 42, 'MMXV/26004/D2', '26004', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2026-02-11 22:00:00', '116.421', 'BIMA', '2026-02-13 04:00:00', '109.883', '235', '10', '7.833333', '0.979167', '1.25', '205.357143', '55.617491', '7.338857', '6.538', '-0.800857', '21200', '-14380508.6348', 'OPEN', NULL, 3, '2026-06-03 11:22:36', '2026-06-03 11:22:36'),
(507, 47, 42, 'MMXV/26005/L', '26005', 'L', 'IMAM FAHRUDI', 'BIMA', '2026-02-15 01:00:00', '107.201', 'TG. MANGGIS', '2026-02-16 18:00:00', '98.551', '300', '10', '7.317075', '1.25', '1.708333', '205.357143', '94.121955', '9.2', '8.65', '-0.55', '21200', '-9876020', 'OPEN', NULL, 3, '2026-06-03 11:24:06', '2026-06-03 11:24:06'),
(508, 47, 42, 'MMXV/26005/D1', '26005', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2026-02-20 16:30:00', '95.19', 'BIMA', '2026-02-22 04:00:00', '87.453', '300', '10', '8.450702', '1.25', '1.479167', '205.357143', '47.06108', '9.36875', '7.737', '-1.63175', '21200', '-29300355.7', 'OPEN', NULL, 3, '2026-06-03 11:24:49', '2026-06-03 11:24:49'),
(509, 47, 42, 'MMXV/26005/D2', '26005', 'D2', 'IMAM FAHRUDI', 'BIMA', '2026-02-23 12:00:00', '85.234', 'BADAS', '2026-02-24 11:12:00', '80.177', '150', '10', '6.465515', '0.625', '0.966667', '205.357143', '70.163759', '4.684375', '5.057', '0.372625', '21200', '6691003.55', 'OPEN', NULL, 3, '2026-06-03 11:25:23', '2026-06-03 11:25:23'),
(510, 47, 42, 'MMXV/26005/D3', '26005', 'D3', 'IMAM FAHRUDI', 'BADAS', '2026-02-25 00:30:00', '79.083', 'AMPENAN', '2026-02-25 23:00:00', '74.178', '152', '10', '6.755556', '0.633333', '0.9375', '205.357143', '62.462866', '4.746831', '4.905', '0.158169', '21200', '2840145.8316', 'OPEN', NULL, 3, '2026-06-03 11:26:02', '2026-06-03 11:26:02'),
(511, 47, 42, 'MMXV/26006/L', '26006', 'L', 'IMAM FAHRUDI', 'AMPENAN', '2026-02-27 20:30:00', '71.939', 'TG. MANGGIS', '2026-02-28 01:42:00', '70.778', '45', '10', '8.653833', '0.1875', '0.216667', '205.357143', '5.989652', '1.38', '1.161', '-0.219', '21200', '-3932451.6', 'OPEN', NULL, 3, '2026-06-03 11:26:52', '2026-06-03 11:26:52'),
(512, 47, 42, 'MMXV/26006/D1', '26006', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2026-03-02 07:30:00', '68.448', 'BADAS', '2026-03-03 04:30:00', '63.911', '158', '10', '7.52381', '0.658333', '0.875', '185.483871', '40.188234', '4.934206', '4.537', '-0.397206', '23050', '-7754791.7601', 'OPEN', NULL, 3, '2026-06-03 11:27:44', '2026-06-03 11:27:44'),
(513, 47, 42, 'MMXV/26006/D2', '26006', 'D2', 'IMAM FAHRUDI', 'BADAS', '2026-03-04 01:30:00', '62.132', 'AMPENAN', '2026-03-04 23:42:00', '57.293', '152', '10', '6.846847', '0.633333', '0.925', '185.483871', '54.099524', '4.746831', '4.839', '0.092169', '23050', '1799447.64615', 'OPEN', NULL, 3, '2026-06-03 11:28:28', '2026-06-03 11:28:28'),
(514, 47, 42, 'MMXV/26007/L', '26007', 'L', 'IMAM FAHRUDI', 'AMPENAN', '2026-03-07 02:00:00', '54.876', 'TG. MANGGIS', '2026-03-07 10:12:00', '52.772', '45', '10', '5.4878', '0.1875', '0.341667', '185.483871', '28.595492', '1.38', '2.104', '0.724', '23050', '14134905.4', 'OPEN', NULL, 3, '2026-06-03 11:29:14', '2026-06-03 11:29:14'),
(515, 47, 42, 'MMXV/26007/D1', '26007', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2026-03-09 03:30:00', '51.338', 'AMPENAN', '2026-03-09 10:30:00', '49.812', '45', '10', '6.428564', '0.1875', '0.291667', '185.483871', '19.321298', '1.405312', '1.526', '0.120688', '23050', '2356234.0648', 'OPEN', NULL, 3, '2026-06-03 11:30:00', '2026-06-03 11:30:00'),
(516, 47, 42, 'MMXV/26007/D2', '26007', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2026-03-10 22:30:00', '47.623', 'BADAS', '2026-03-11 17:18:00', '43.526', '152', '10', '8.08511', '0.633333', '0.783333', '185.483871', '27.822581', '4.746831', '4.097', '-0.649831', '23050', '-12686878.05385', 'OPEN', NULL, 3, '2026-06-03 11:30:52', '2026-06-03 11:30:52'),
(517, 47, 42, 'MMXV/26007/D3', '26007', 'D3', 'IMAM FAHRUDI', 'BADAS', '2026-03-12 10:00:00', '42.029', 'BENOA', '2026-03-13 12:30:00', '36.362', '210', '10', '7.924526', '0.875', '1.104167', '185.483871', '42.506782', '6.558125', '5.667', '-0.891125', '23050', '-17397745.26875', 'OPEN', NULL, 3, '2026-06-03 11:32:12', '2026-06-03 11:32:12'),
(518, 47, 42, 'MMXV/26008/L', '26008', 'L', 'IMAM FAHRUDI', 'BENOA', '2026-03-14 10:00:00', '34.496', 'TG. MANGGIS', '2026-03-14 13:00:00', '33.863', '30', '10', '10', '0.125', '0.125', '185.483871', '0', '0.92', '0.633', '-0.287', '23050', '-5603201.45', 'OPEN', NULL, 3, '2026-06-03 11:33:14', '2026-06-03 11:33:14'),
(519, 47, 42, 'MMXV/26008/D1', '26008', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2026-03-17 16:00:00', '140.177', 'BADAS', '2026-03-18 14:30:00', '135.273', '158', '10', '7.022222', '0.658333', '0.9375', '185.483871', '51.780976', '4.934206', '4.904', '-0.030206', '23050', '-589722.3101', 'OPEN', NULL, 3, '2026-06-03 11:34:15', '2026-06-03 11:34:15'),
(520, 47, 42, 'MMXV/26008/D2', '26008', 'D2', 'IMAM FAHRUDI', 'BADAS', '2026-03-19 13:30:00', '133.454', 'BIMA', '2026-03-20 07:00:00', '129.64', '150', '10', '8.571425', '0.625', '0.729167', '185.483871', '19.321298', '4.684375', '3.814', '-0.870375', '23050', '-16992635.75625', 'OPEN', NULL, 3, '2026-06-03 11:35:12', '2026-06-03 11:35:12'),
(521, 47, 42, 'MMXV/26009/L', '26009', 'L', 'IMAM FAHRUDI', 'BIMA', '2026-03-21 00:12:00', '128.122', 'TG. MANGGIS', '2026-03-22 15:30:00', '119.83', '300', '10', '7.633588', '1.25', '1.6375', '185.483871', '71.875', '9.2', '8.292', '-0.908', '23050', '-17727201.8', 'OPEN', NULL, 3, '2026-06-03 11:35:58', '2026-06-03 11:35:58'),
(522, 47, 42, 'MMXV/26029/D1', '26009', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2026-03-27 09:30:00', '115.789', 'AMPENAN', '2026-03-27 16:24:00', '114.285', '45', '10', '6.521739', '0.1875', '0.2875', '185.483871', '18.548387', '1.405312', '1.504', '0.098688', '23050', '1926720.3648', 'OPEN', NULL, 3, '2026-06-03 11:36:46', '2026-06-03 11:36:46'),
(523, 47, 42, 'MMXV/26009/D2', '26009', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2026-03-29 04:30:00', '112.001', 'BADAS', '2026-03-29 21:30:00', '108.295', '152', '10', '8.941181', '0.633333', '0.708333', '185.483871', '13.91129', '4.746831', '3.706', '-1.040831', '23050', '-20320507.90385', 'OPEN', NULL, 3, '2026-06-03 11:37:25', '2026-06-03 11:37:25'),
(524, 47, 42, 'MMXV/26010/L', '26010', 'L', 'IMAM FAHRUDI', 'BADAS', '2026-03-30 11:30:00', '107.093', 'TG. MANGGIS', '2026-03-31 07:24:00', '102.894', '178.5', '10', '8.969846', '0.74375', '0.829167', '185.483871', '15.843476', '5.474', '4.199', '-1.275', '23050', '-24892271.25', 'OPEN', NULL, 3, '2026-06-03 11:38:16', '2026-06-03 11:38:16'),
(525, 47, 42, 'MMXV/26010/D1', '26010', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2026-04-03 05:42:00', '100.46', 'AMPENAN', '2026-04-03 13:00:00', '98.869', '45', '10', '6.164377', '0.1875', '0.304167', '191.666667', '22.361175', '1.405312', '1.591', '0.185688', '28150', '4427368.2684', 'OPEN', NULL, 3, '2026-06-03 11:38:56', '2026-06-03 11:38:56'),
(526, 47, 42, 'MMXV/26010/D2', '26010', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2026-04-04 12:30:00', '97.12', 'BADAS', '2026-04-05 04:42:00', '93.589', '152', '10', '9.382716', '0.633333', '0.675', '191.666667', '7.986175', '4.746831', '3.531', '-1.215831', '28150', '-28989119.32455', 'OPEN', NULL, 3, '2026-06-03 11:39:42', '2026-06-03 11:39:42'),
(527, 47, 42, 'MMXV/26011/L', '26011', 'L', 'IMAM FAHRUDI', 'BADAS', '2026-04-05 23:00:00', '92.37', 'TG. MANGGIS', '2026-04-06 21:30:00', '87.623', '178.5', '10', '7.933333', '0.74375', '0.9375', '191.666667', '37.135417', '5.474', '4.747', '-0.727', '28150', '-17333897.35', 'OPEN', NULL, 3, '2026-06-03 11:40:42', '2026-06-03 11:40:42'),
(528, 47, 42, 'MMXV/26011/D1', '26011', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2026-04-10 19:30:00', '84.387', 'AMPENAN', '2026-04-11 04:00:00', '82.534', '45', '10', '5.294113', '0.1875', '0.354167', '191.666667', '31.944508', '1.405312', '1.853', '0.447688', '28150', '10674247.3684', 'OPEN', NULL, 3, '2026-06-03 11:41:26', '2026-06-03 11:41:26'),
(529, 47, 42, 'MMXV/26011/D2', '26011', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2026-04-11 18:00:00', '81.412', 'BADAS', '2026-04-12 13:00:00', '77.27', '152', '10', '7.999997', '0.633333', '0.791667', '191.666667', '30.34735', '4.746831', '4.142', '-0.604831', '28150', '-14421015.77455', 'OPEN', NULL, 3, '2026-06-03 11:42:12', '2026-06-03 11:42:12'),
(530, 47, 42, 'MMXV/26011/D3', '26011', 'D3', 'IMAM FAHRUDI', 'BADAS', '2026-04-13 09:42:00', '75.617', 'CAMPLONG', '2026-04-15 07:00:00', '65.743', '376.5', '10', '8.311258', '1.56875', '1.8875', '191.666667', '61.09375', '11.757781', '9.874', '-1.883781', '28150', '-44915084.57205', 'OPEN', NULL, 3, '2026-06-03 11:43:21', '2026-06-03 11:43:21'),
(531, 47, 42, 'MMXV/26012/L', '26012', 'L', 'IMAM FAHRUDI', 'CAMPLONG', '2026-04-15 21:30:00', '64.507', 'TG. MANGGIS', '2026-04-17 05:00:00', '57.862', '277.5', '10', '8.809524', '1.15625', '1.3125', '191.666667', '29.947917', '8.51', '6.645', '-1.865', '30550', '-48258460.25', 'OPEN', NULL, 3, '2026-06-03 11:46:21', '2026-06-03 11:46:21'),
(532, 47, 42, 'MMXV/26012/D1', '26012', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2026-04-22 23:30:00', '154.799', 'AMPENAN', '2026-04-23 07:12:00', '152.682', '45', '10', '5.844162', '0.1875', '0.320833', '191.666667', '25.555492', '1.405312', '2.117', '0.711688', '30550', '18415531.9348', 'OPEN', NULL, 3, '2026-06-03 11:48:08', '2026-06-03 11:48:08'),
(533, 47, 42, 'MMXV/26012/D2', '26012', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2026-04-24 03:00:00', '151.073', 'BADAS', '2026-04-24 20:00:00', '147.367', '152', '10', '8.941181', '0.633333', '0.708333', '191.666667', '14.375', '4.746831', '3.706', '-1.040831', '30550', '-26932386.83135', 'OPEN', NULL, 3, '2026-06-03 11:48:59', '2026-06-03 11:48:59'),
(534, 47, 42, 'MMXV/26013/L', '26013', 'L', 'IMAM FAHRUDI', 'BADAS', '2026-04-25 13:42:00', '146.046', 'TG. MANGGIS', '2026-04-26 12:00:00', '141.342', '178.5', '10', '8.004481', '0.74375', '0.929167', '191.666667', '35.538258', '5.474', '4.704', '-0.77', '30550', '-19924404.5', 'OPEN', NULL, 3, '2026-06-03 11:49:55', '2026-06-03 11:49:55'),
(535, 47, 42, 'MMXV/26013/D1', '26013', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2026-04-29 15:00:00', '138.694', 'AMPENAN', '2026-04-29 22:30:00', '137.059', '45', '7', '6', '0.267857', '0.3125', '191.666667', '8.556575', '2.007588', '1.635', '-0.372588', '30.550', '-9641.0312', 'OPEN', NULL, 3, '2026-06-03 11:54:05', '2026-06-03 11:54:05'),
(536, 47, 42, 'MMXV/26013/D2', '26013', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2026-05-01 18:42:00', '134.763', 'BADAS', '2026-05-02 12:12:00', '130.949', '152', '10', '8.68571', '0.633333', '0.729167', '185.483871', '17.775661', '4.746831', '3.814', '-0.932831', '30550', '-24137795.03135', 'OPEN', NULL, 3, '2026-06-03 11:55:00', '2026-06-03 11:55:00'),
(537, 47, 42, 'MMXV/26014/L', '26014', 'L', 'IMAM FAHRUDI', 'BADAS', '2026-05-03 13:30:00', '129.231', 'TG. MANGGIS', '2026-05-04 10:30:00', '124.801', '178.5', '10', '8.5', '0.74375', '0.875', '185.483871', '24.344758', '5.474', '4.43', '-1.044', '30550', '-27014387.4', 'OPEN', NULL, 3, '2026-06-03 11:56:06', '2026-06-03 11:56:06'),
(538, 47, 42, 'MMXV/26014/D1', '26014', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2026-05-06 23:30:00', '122.565', 'AMPENAN', '2026-05-07 08:00:00', '120.712', '45', '10', '5.294113', '0.1875', '0.354167', '185.483871', '30.91404', '1.405312', '1.853', '0.447688', '30550', '11584307.5348', 'OPEN', NULL, 3, '2026-06-03 11:59:23', '2026-06-03 11:59:23'),
(539, 47, 42, 'MMXV/26014/D2', '26014', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2026-05-07 22:30:00', '119.622', 'BADAS', '2026-05-08 17:12:00', '115.546', '152', '10', '8.128339', '0.633333', '0.779167', '185.483871', '27.049855', '4.746831', '4.076', '-0.670831', '30550', '-17358322.33135', 'OPEN', NULL, 3, '2026-06-03 12:01:52', '2026-06-03 12:01:52'),
(540, 47, 42, 'MMXV/26014/D3', '26014', 'D3', 'IMAM FAHRUDI', 'BADAS', '2026-05-09 15:30:00', '114.138', 'AMPENAN', '2026-05-10 09:06:00', '110.302', '152', '10', '8.636368', '0.633333', '0.733333', '185.483871', '18.548387', '4.746831', '3.836', '-0.910831', '30550', '-23568526.33135', 'OPEN', NULL, 3, '2026-06-03 12:02:56', '2026-06-03 12:02:56'),
(542, 47, 42, 'MMXV/26015/L', '26015', 'L', 'IMAM FAHRUDI', 'AMPENAN', '2026-05-11 12:42:00', '108.714', 'TG. MANGGIS', '2026-05-11 17:12:00', '107.764', '45', '10', '10', '0.1875', '0.1875', '185.483871', '0', '1.38', '0.95', '-0.43', '30550', '-11126615.5', 'OPEN', NULL, 3, '2026-06-03 12:05:56', '2026-06-03 12:05:56'),
(543, 47, 42, 'MMXV/26015/D1', '26015', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2026-05-13 00:42:00', '106.182', 'BIMA', '2026-05-14 15:30:00', '97.725', '300', '10', '7.731957', '1.25', '1.616667', '185.483871', '68.010815', '9.36875', '8.457', '-0.91175', '30550', '-23592306.2375', 'OPEN', NULL, 3, '2026-06-03 12:06:38', '2026-06-03 12:06:38'),
(544, 47, 42, 'MMXV/26015/D2', '26015', 'D2', 'IMAM FAHRUDI', 'BIMA', '2026-05-15 08:00:00', '96.073', 'AMPENAN', '2026-05-16 19:12:00', '88.401', '273', '10', '7.75568', '1.1375', '1.466667', '185.483871', '61.055169', '8.525562', '7.672', '-0.853562', '30550', '-22086642.2777', 'OPEN', NULL, 3, '2026-06-03 12:07:21', '2026-06-03 12:07:21'),
(545, 47, 42, 'MMXV/26016/L', '26016', 'L', 'IMAM FAHRUDI', 'AMPENAN', '2026-05-18 07:00:00', '86.28', 'TG. MANGGIS', '2026-05-18 12:12:00', '85.183', '45', '10', '8.653833', '0.1875', '0.216667', '185.483871', '5.410008', '1.38', '1.097', '-0.283', '30550', '-7322865.55', 'OPEN', NULL, 3, '2026-06-03 12:08:01', '2026-06-03 12:08:01'),
(546, 47, 42, 'MMXV/26016/D1', '26016', 'D1', 'IMAM FAHRUDI', 'TG. MANGGIS', '2026-05-19 21:30:00', '83.47', 'AMPENAN', '2026-05-20 04:00:00', '82.053', '45', '7', '6.923085', '0.267857', '0.270833', '185.483871', '0.552', '2.007588', '1.417', '-0.590588', '30550', '-15281966.4998', 'OPEN', NULL, 3, '2026-06-03 12:10:04', '2026-06-03 12:10:04'),
(547, 47, 42, 'MMXV/26016/D2', '26016', 'D2', 'IMAM FAHRUDI', 'AMPENAN', '2026-05-20 23:30:00', '80.427', 'BADAS', '2026-05-21 18:00:00', '76.395', '152', '10', '8.21622', '0.633333', '0.770833', '185.483871', '25.504032', '4.746831', '4.032', '-0.714831', '30550', '-18496859.73135', 'OPEN', NULL, 3, '2026-06-03 12:10:57', '2026-06-03 12:10:57'),
(548, 47, 42, 'MMXV/26017/L', '26017', 'L', 'IMAM FAHRUDI', 'BADAS', '2026-05-22 13:00:00', '74.953', 'TG. MANGGIS', '2026-05-23 10:12:00', '70.481', '178.5', '10', '8.419814', '0.74375', '0.883333', '185.483871', '25.890395', '5.474', '4.472', '-1.002', '30550', '-25927601.7', 'OPEN', NULL, 3, '2026-06-03 12:11:48', '2026-06-03 12:11:48'),
(549, 44, 44, 'SG201/25001/L', '25001', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2025-09-15 09:30:00', '20.9', 'TG. UBAN', '2025-09-17 06:00:00', '13.046', '251', '7', '5.640448', '1.494048', '1.854167', '86.666667', '31.210313', '5.968722', '7.854', '1.885278', '14450', '23074200.2337', 'OPEN', NULL, 3, '2026-06-03 12:40:55', '2026-06-03 12:40:55'),
(550, 44, 44, 'SG201/25001/D1', '25001', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-09-22 08:30:00', '30.818', 'P. BALAM', '2025-09-24 14:00:00', '21.916', '251', '7', '4.691588', '1.494048', '2.229167', '86.666667', '63.710314', '6.038942', '8.902', '2.863058', '14150', '34313893.2829', 'OPEN', NULL, 3, '2026-06-03 12:42:30', '2026-06-03 12:42:30'),
(551, 44, 44, 'SG201/25002/L', '25002', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2025-09-29 07:55:00', '18.152', 'TG. UBAN', '2025-10-01 05:02:00', '10.664', '251', '7', '5.563355', '1.494048', '1.879861', '83.870968', '32.35851', '5.968722', '7.488', '1.519278', '14300', '18401647.0638', 'OPEN', NULL, 3, '2026-06-03 12:44:37', '2026-06-03 12:44:37'),
(552, 44, 44, 'SG201/25002/D1', '25002', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-10-09 10:04:00', '29.599', 'P. BALAM', '2025-10-11 05:02:00', '22.447', '251', '7', '5.841737', '1.494048', '1.790278', '83.870968', '24.845097', '6.038942', '7.152', '1.113058', '14300', '13481469.8018', 'OPEN', NULL, 3, '2026-06-03 12:48:05', '2026-06-03 12:48:05'),
(553, 44, 44, 'SG201/25003/L', '25003', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2025-10-14 09:07:00', '20.364', 'TG. UBAN', '2025-10-16 05:02:00', '10.978', '251', '7', '5.71537', '1.494048', '1.829861', '83.870968', '28.164961', '5.968722', '9.386', '3.417278', '14300', '41390412.8638', 'OPEN', NULL, 3, '2026-06-03 12:48:55', '2026-06-03 12:48:55'),
(554, 44, 44, 'SG201/25003/D1', '25003', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-10-20 05:31:00', '31.518', 'P. BALAM', '2025-10-22 00:00:00', '24.446', '251', '7', '5.908199', '1.494048', '1.770139', '83.870968', '23.156019', '6.038942', '7.072', '1.033058', '14300', '12512501.8018', 'OPEN', NULL, 3, '2026-06-03 12:49:35', '2026-06-03 12:49:35'),
(555, 44, 44, 'SG201/25004/L', '25004', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2025-10-25 06:57:00', '21.559', 'PANJANG', '2025-10-27 21:36:00', '11.159', '325', '7', '5.187549', '1.934524', '2.610417', '83.870968', '56.6878', '7.728423', '10.4', '2.671577', '14300', '32358407.7817', 'OPEN', NULL, 3, '2026-06-03 12:51:35', '2026-06-03 12:51:35'),
(556, 44, 44, 'SG201/25004/D1', '25004', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2025-10-28 18:57:00', '31.494', 'P. BALAM', '2025-10-31 05:31:00', '21.607', '325', '7', '5.549231', '1.934524', '2.440278', '83.870968', '42.418078', '7.819346', '9.887', '2.067654', '15300', '26794934.9514', 'OPEN', NULL, 3, '2026-06-03 12:52:25', '2026-06-03 12:52:25'),
(557, 44, 44, 'SG201/25005/L', '25005', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2025-12-11 10:00:00', '29.771', 'TG. UBAN', '2025-12-13 10:12:00', '21.699', '251', '7', '5.20747', '1.494048', '2.008333', '83.870968', '43.133581', '5.968722', '8.072', '2.103278', '15300', '27256589.9298', 'OPEN', NULL, 3, '2026-06-03 12:53:07', '2026-06-03 12:53:07'),
(558, 44, 44, 'SG201/25005/D1', '25005', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-12-19 03:42:00', '29.737', 'BELINYU', '2025-12-20 15:00:00', '23.866', '189', '7', '5.354109', '1.125', '1.470833', '83.870968', '29.005348', '4.54725', '5.871', '1.32375', '15300', '17154608.625', 'OPEN', NULL, 3, '2026-06-03 12:53:57', '2026-06-03 12:53:57'),
(559, 44, 44, 'SG201/25006/L', '25006', 'L', 'IMAM FAHRUDI', 'BELINYU', '2025-12-22 13:00:00', '21.296', 'TG. UBAN', '2025-12-24 12:06:00', '13.47', '189', '7', '4.012739', '1.125', '1.9625', '83.870968', '70.241936', '4.494375', '7.826', '3.331625', '15300', '43174861.5375', 'OPEN', NULL, 3, '2026-06-03 12:54:40', '2026-06-03 12:54:40'),
(560, 44, 44, 'SG201/25006/D1', '25006', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-12-30 07:00:00', '27.269', 'BELINYU', '2025-12-31 21:54:00', '21.293', '189', '7', '4.858613', '1.125', '1.620833', '83.870968', '41.585994', '4.54725', '5.976', '1.42875', '15300', '18515314.125', 'OPEN', NULL, 3, '2026-06-03 12:55:21', '2026-06-03 12:55:21'),
(561, 44, 44, 'SG201/26001/L', '26001', 'L', 'IMAM FAHRUDI', 'BELINYU', '2026-01-04 09:00:00', '18.415', 'TG. UBAN', '2026-01-06 05:00:00', '11.111', '189', '7', '4.295455', '1.125', '1.833333', '83.870968', '59.408574', '4.494375', '7.304', '2.809625', '20750', '49379861.78125', 'OPEN', NULL, 3, '2026-06-03 12:57:12', '2026-06-03 12:57:12'),
(562, 44, 44, 'SG201/26001/D1', '26001', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-01-12 18:30:00', '28.515', 'INDRAGIRI HILIR', '2026-01-13 23:00:00', '23.705', '127', '7', '4.45614', '0.755952', '1.1875', '83.870968', '36.194348', '3.055558', '4.81', '1.754442', '20750', '30834756.7605', 'OPEN', NULL, 3, '2026-06-03 12:58:08', '2026-06-03 12:58:08'),
(563, 44, 44, 'SG201/26002/L', '26002', 'L', 'IMAM FAHRUDI', 'INDRAGIRI HILIR', '2026-01-15 13:00:00', '19.871', 'TG. UBAN', '2026-01-16 12:30:00', '15.904', '127', '7', '5.404253', '0.755952', '0.979167', '83.870968', '18.721258', '3.020028', '3.967', '0.946972', '20750', '16643269.643', 'OPEN', NULL, 3, '2026-06-03 12:58:53', '2026-06-03 12:58:53'),
(564, 44, 44, 'SG201/26002/D1', '26002', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-01-18 20:30:00', '31.041', 'KABIL', '2026-01-18 22:00:00', '30.791', '10', '7', '6.666667', '0.059524', '0.0625', '83.870968', '0.2496', '0.240596', '0.25', '0.009404', '20750', '165277.651', 'OPEN', NULL, 3, '2026-06-03 13:00:06', '2026-06-03 13:00:06'),
(565, 44, 44, 'SG201/26003/L', '26003', 'L', 'IMAM FAHRUDI', 'KABIL', '2026-01-21 00:00:00', '28.147', 'TG. UBAN', '2026-01-21 03:00:00', '27.647', '10', '7', '3.333333', '0.059524', '0.125', '83.870968', '5.491536', '0.237798', '0.5', '0.262202', '20750', '4608265.7005', 'OPEN', NULL, 3, '2026-06-03 13:00:56', '2026-06-03 13:00:56'),
(566, 44, 44, 'SG201/26003/D1', '26003', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-01-25 09:00:00', '25.458', 'BELINYU', '2026-01-26 23:30:00', '19.039', '189', '7', '4.90909', '1.125', '1.604167', '83.870968', '40.1882', '4.54725', '6.419', '1.87175', '20750', '32896474.1875', 'OPEN', NULL, 3, '2026-06-03 13:01:42', '2026-06-03 13:01:42'),
(567, 44, 44, 'SG201/26004/L', '26004', 'L', 'IMAM FAHRUDI', 'BELINYU', '2026-01-28 23:00:00', '16.072', 'TG. UBAN', '2026-01-30 19:00:00', '8.735', '189', '7', '4.295455', '1.125', '1.833333', '83.870968', '59.408574', '4.494375', '7.337', '2.842625', '20750', '49959845.03125', 'OPEN', NULL, 3, '2026-06-03 13:02:52', '2026-06-03 13:02:52'),
(568, 44, 44, 'SG201/26004/D1', '26004', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-02-02 12:00:00', '29.863', 'P. BALAM', '2026-02-04 16:30:00', '20.751', '251', '7', '4.780952', '1.494048', '2.1875', '92.857143', '64.391972', '6.038942', '9.112', '3.073058', '21200', '55181058.6712', 'OPEN', NULL, 3, '2026-06-03 13:03:31', '2026-06-03 13:03:31'),
(569, 44, 44, 'SG201/26005/L', '26005', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2026-02-07 08:30:00', '17.659', 'TG. UBAN', '2026-02-09 21:00:00', '7.57', '251', '7', '4.148761', '1.494048', '2.520833', '92.857143', '95.344322', '5.968722', '10.089', '4.120278', '21200', '73985359.8792', 'OPEN', NULL, 3, '2026-06-03 13:04:16', '2026-06-03 13:04:16'),
(570, 44, 44, 'SG201/26005/D1', '26005', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-02-13 17:00:00', '25.497', 'P. BALAM', '2026-02-15 20:00:00', '17.003', '251', '7', '4.921569', '1.494048', '2.125', '92.857143', '58.5884', '6.038942', '8.494', '2.455058', '21200', '44084003.4712', 'OPEN', NULL, 3, '2026-06-03 13:05:13', '2026-06-03 13:05:13'),
(571, 44, 44, 'SG201/26006/L', '26006', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2026-02-17 10:00:00', '14.365', 'TG. UBAN', '2026-02-20 01:30:00', '3.79', '251', '7', '3.952756', '1.494048', '2.645833', '92.857143', '106.951464', '5.968722', '10.575', '4.606278', '21200', '82712170.2792', 'OPEN', NULL, 3, '2026-06-03 13:06:57', '2026-06-03 13:06:57'),
(572, 44, 44, 'SG201/26006/D1', '26006', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-02-25 06:30:00', '28.216', 'P. BALAM', '2026-02-27 12:12:00', '19.284', '251', '7', '4.674115', '1.494048', '2.2375', '92.857143', '69.034829', '6.038942', '8.932', '2.893058', '21200', '51948906.6712', 'OPEN', NULL, 3, '2026-06-03 13:08:25', '2026-06-03 13:08:25'),
(573, 44, 44, 'SG201/26007/L', '26007', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2026-03-01 08:30:00', '16.801', 'TG. UBAN', '2026-03-03 12:06:00', '8.218', '251', '7', '4.864341', '1.494048', '2.15', '83.870968', '55.015329', '5.968722', '8.583', '2.614278', '23050', '51039464.3913', 'OPEN', NULL, 3, '2026-06-03 13:09:45', '2026-06-03 13:09:45'),
(574, 44, 44, 'SG201/26007/D1', '26007', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-03-04 23:30:00', '32.458', 'P. BALAM', '2026-03-07 02:30:00', '23.974', '251', '7', '4.921569', '1.494048', '2.125', '83.870968', '52.918555', '6.038942', '8.484', '2.445058', '23050', '47735723.1043', 'OPEN', NULL, 3, '2026-06-03 13:10:29', '2026-06-03 13:10:29'),
(575, 44, 44, 'SG201/26008/L', '26008', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2026-03-08 08:30:00', '21.914', 'TG. UBAN', '2026-03-10 21:30:00', '11.767', '251', '7', '4.114754', '1.494048', '2.541667', '83.870968', '87.86482', '5.968722', '10.147', '4.178278', '23050', '81573983.7913', 'OPEN', NULL, 3, '2026-06-03 13:11:09', '2026-06-03 13:11:09'),
(576, 44, 44, 'SG201/26008/D1', '26008', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-03-12 03:00:00', '29.368', 'P. BALAM', '2026-03-14 05:00:00', '21.041', '251', '7', '5.020001', '1.494048', '2.083333', '83.870968', '49.423903', '6.038942', '8.327', '2.288058', '23050', '44670557.1543', 'OPEN', NULL, 3, '2026-06-03 13:11:49', '2026-06-03 13:11:49'),
(577, 44, 44, 'SG201/26009/L', '26009', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2026-03-15 08:00:00', '19.135', 'TG. UBAN', '2026-03-17 21:00:00', '8.976', '251', '7', '4.114754', '1.494048', '2.541667', '83.870968', '87.86482', '5.968722', '10.159', '4.190278', '23050', '81808263.9913', 'OPEN', NULL, 3, '2026-06-03 13:12:53', '2026-06-03 13:12:53'),
(578, 44, 44, 'SG201/26009/D1', '26009', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-03-21 21:00:00', '30.105', 'P. BALAM', '2026-03-24 05:00:00', '20.41', '251', '7', '4.482143', '1.494048', '2.333333', '83.870968', '70.391645', '6.038942', '9.695', '3.656058', '23050', '71378499.9543', 'OPEN', NULL, 3, '2026-06-03 13:13:26', '2026-06-03 13:13:26'),
(579, 44, 44, 'SG201/26010/L', '26010', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2026-03-25 23:00:00', '18.37', 'TG. UBAN', '2026-03-28 11:00:00', '8.365', '251', '7', '4.183333', '1.494048', '2.5', '83.870968', '84.370168', '5.968722', '10.005', '4.036278', '23050', '78801668.0913', 'OPEN', NULL, 3, '2026-06-03 13:14:02', '2026-06-03 13:14:02'),
(580, 44, 44, 'SG201/26010/D1', '26010', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-03-29 19:12:00', '31.616', 'P. BALAM', '2026-04-01 00:06:00', '22.736', '251', '7', '4.744801', '1.494048', '2.204167', '86.666667', '61.543647', '6.038942', '8.88', '2.841058', '28150', '67739487.9469', 'OPEN', NULL, 3, '2026-06-03 13:14:35', '2026-06-03 13:14:35'),
(581, 44, 44, 'SG201/26011/L', '26011', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2026-04-02 06:00:00', '20.372', 'TG. UBAN', '2026-04-04 12:12:00', '11.358', '251', '7', '4.630997', '1.494048', '2.258333', '86.666667', '66.238034', '5.968722', '9.014', '3.045278', '28150', '72608715.6179', 'OPEN', NULL, 3, '2026-06-03 13:15:07', '2026-06-03 13:15:07'),
(582, 44, 44, 'SG201/26011/D1', '26011', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-04-08 22:00:00', '31.617', 'P. BALAM', '2026-04-11 05:00:00', '22.471', '251', '7', '4.563636', '1.494048', '2.291667', '86.666667', '69.12698', '6.038942', '9.146', '3.107058', '28150', '74081739.2469', 'OPEN', NULL, 3, '2026-06-03 13:15:38', '2026-06-03 13:15:38'),
(583, 44, 44, 'SG201/26012/L', '26012', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2026-04-12 22:30:00', '19.867', 'TG. UBAN', '2026-04-15 05:00:00', '10.803', '251', '7', '4.605505', '1.494048', '2.270833', '86.666667', '67.321367', '5.968722', '9.064', '3.095278', '28150', '73800868.1179', 'OPEN', NULL, 3, '2026-06-03 13:16:11', '2026-06-03 13:16:11'),
(584, 44, 44, 'SG201/26012/D1', '26012', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-04-23 17:30:00', '28.665', 'P. BALAM', '2026-04-26 04:00:00', '18.912', '251', '7', '4.290598', '1.494048', '2.4375', '86.666667', '81.76584', '6.038942', '9.753', '3.714058', '30550', '96104407.6993', 'OPEN', NULL, 3, '2026-06-03 13:16:40', '2026-06-03 13:16:40'),
(585, 44, 44, 'SG201/26013/L', '26013', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2026-04-30 19:30:00', '15.106', 'TG. UBAN', '2026-05-03 04:00:00', '5.687', '251', '7', '4.442477', '1.494048', '2.354167', '83.870968', '72.139013', '5.968722', '9.419', '3.450278', '30550', '89278875.9863', 'OPEN', NULL, 3, '2026-06-03 13:17:13', '2026-06-03 13:17:13'),
(586, 44, 44, 'SG201/26013/D1', '26013', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-05-06 09:00:00', '30.292', 'P. BALAM', '2026-05-08 17:30:00', '20.884', '251', '7', '4.442477', '1.494048', '2.354167', '83.870968', '72.139013', '6.038942', '9.408', '3.369058', '30550', '87177239.4493', 'OPEN', NULL, 3, '2026-06-03 13:17:52', '2026-06-03 13:17:52'),
(587, 44, 44, 'SG201/26014/L', '26014', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2026-05-11 00:30:00', '18.424', 'TG. UBAN', '2026-05-12 19:00:00', '11.347', '251', '7', '5.905883', '1.494048', '1.770833', '83.870968', '23.214226', '5.968722', '7.077', '1.108278', '30550', '28677635.2863', 'OPEN', NULL, 3, '2026-06-03 13:18:24', '2026-06-03 13:18:24'),
(588, 44, 44, 'SG201/26014/D1', '26014', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-05-16 18:00:00', '32.022', 'P. BALAM', '2026-05-18 23:00:00', '23.197', '251', '7', '4.73585', '1.494048', '2.208333', '83.870968', '59.907774', '6.038942', '8.825', '2.786058', '30550', '72091618.8993', 'OPEN', NULL, 3, '2026-06-03 13:19:02', '2026-06-03 13:19:02'),
(589, 43, 46, 'SG202/26001/L', '26001', 'L', 'IMAM FAHRUDI', 'JOBBER KETAPANG', '2024-12-31 04:59:00', '17.764', 'PONTIANAK', '2025-01-01 16:00:00', '13.007', '150', '7', '4.283674', '0.892857', '1.459028', '85.483871', '48.398489', '2.9375', '4.757', '1.8195', '14800', '22808524.2', 'OPEN', NULL, 3, '2026-06-03 13:20:14', '2026-06-03 13:20:14'),
(590, 43, 46, 'SG202/25001/D1', '25001', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-01-04 12:30:00', '0.031', 'JOBBER KETAPANG', '2025-01-05 12:30:00', '27.917', '150', '7', '6.25', '0.892857', '1', '85.483871', '9.158998', '2.982142', '-27.886', '-30.868142', '15150', '-396101541.5511', 'OPEN', NULL, 3, '2026-06-03 13:22:00', '2026-06-03 13:22:00'),
(591, 43, 46, 'SG202/25002/L', '25002', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-01-06 07:30:00', '26.625', 'PONTIANAK', '2025-01-07 10:30:00', '22.978', '150', '7', '5.555556', '0.892857', '1.125', '85.483871', '19.844482', '2.9375', '3.647', '0.7095', '14800', '8894008.2', 'OPEN', NULL, 3, '2026-06-03 13:23:06', '2026-06-03 13:23:06'),
(592, 43, 46, 'SG202/25002/D1', '25002', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-01-09 13:00:00', '21.36', 'JOBBER KETAPANG', '2025-01-10 10:30:00', '18.485', '150', '7', '6.976747', '0.892857', '0.895833', '85.483871', '0.2544', '2.982142', '2.875', '-0.107142', '15150', '-1374851.5011', 'OPEN', NULL, 3, '2026-06-03 13:23:52', '2026-06-03 13:23:52'),
(593, 43, 46, 'SG202/25003/L', '25003', 'L', 'IMAM FAHRUDI', 'JOBBER KETAPANG', '2025-01-11 06:18:00', '17.281', 'PONTIANAK', '2025-01-12 09:30:00', '13.607', '150', '7', '5.514708', '0.892857', '1.133333', '85.483871', '20.556819', '2.9375', '3.674', '0.7365', '14800', '9232469.4', 'OPEN', NULL, 3, '2026-06-03 13:24:35', '2026-06-03 13:24:35'),
(594, 43, 46, 'SG202/25003/D1', '25003', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-01-15 03:30:00', '31.65', 'JOBBER KETAPANG', '2025-01-16 02:29:00', '28.558', '150', '7', '6.526468', '0.892857', '0.957639', '85.483871', '5.537816', '2.982142', '3.092', '0.109858', '15150', '1409703.3489', 'OPEN', NULL, 3, '2026-06-03 13:25:51', '2026-06-03 13:25:51'),
(595, 43, 46, 'SG202/25004/L', '25004', 'L', 'IMAM FAHRUDI', 'JOBBER KETAPANG', '2025-01-17 07:59:00', '26.942', 'PONTIANAK', '2025-01-18 11:29:00', '23.311', '150', '7', '5.454547', '0.892857', '1.145833', '85.483871', '21.625368', '2.9375', '3.631', '0.6935', '14800', '8693438.6', 'OPEN', NULL, 3, '2026-06-03 13:26:49', '2026-06-03 13:26:49'),
(596, 43, 46, 'SG202/25004/D1', '25004', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-01-20 13:00:00', '21.569', 'JOBBER KETAPANG', '2025-01-21 13:00:00', '18.275', '150', '7', '6.25', '0.892857', '1', '85.483871', '9.158998', '2.982142', '3.294', '0.311858', '15150', '4001777.4489', 'OPEN', NULL, 3, '2026-06-03 13:27:19', '2026-06-03 13:27:19'),
(597, 43, 46, 'SG202/25005/L', '25005', 'L', 'IMAM FAHRUDI', 'JOBBER KETAPANG', '2025-01-23 07:30:00', '16.478', 'PONTIANAK', '2025-01-24 07:59:00', '13.184', '150', '7', '6.126616', '0.892857', '1.020139', '85.483871', '10.880558', '2.9375', '3.294', '0.3565', '14800', '4468941.4', 'OPEN', NULL, 3, '2026-06-03 13:28:11', '2026-06-03 13:28:11'),
(598, 43, 46, 'SG202/25005/D1', '25005', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-01-28 08:42:00', '31.107', 'JOBBER KETAPANG', '2025-01-29 06:41:00', '28.117', '150', '7', '6.823353', '0.892857', '0.915972', '85.483871', '1.97596', '2.982142', '2.99', '0.007858', '15150', '100834.2489', 'OPEN', NULL, 3, '2026-06-03 13:29:04', '2026-06-03 13:29:04'),
(599, 43, 46, 'SG202/25006/L', '25006', 'L', 'IMAM FAHRUDI', 'JOBBER KETAPANG', '2025-01-31 07:00:00', '26.117', 'PONTIANAK', '2025-02-01 16:00:00', '21.63', '150', '7', '4.545455', '0.892857', '1.375', '94.642857', '45.631391', '2.9375', '4.487', '1.5495', '15150', '19883261.475', 'OPEN', NULL, 3, '2026-06-03 13:29:35', '2026-06-03 13:29:35'),
(600, 43, 46, 'SG202/25006/D1', '25006', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-02-05 08:29:00', '20.068', 'JOBBER KETAPANG', '2025-02-06 10:00:00', '15.759', '150', '7', '5.878513', '0.892857', '1.063194', '94.642857', '16.12118', '2.982142', '4.309', '1.326858', '15150', '17026308.1989', 'OPEN', NULL, 3, '2026-06-03 13:30:08', '2026-06-03 13:30:08'),
(601, 43, 46, 'SG202/25006/D2', '25006', 'D2', 'IMAM FAHRUDI', 'STS PONTIANAK', '2025-03-17 07:06:00', '31.528', 'SIANTAN', '2025-03-17 12:12:00', '30.961', '30', '7', '5.882353', '0.178571', '0.2125', '85.483871', '2.900382', '0.596427', '0.567', '-0.029427', '15150', '-377608.73535', 'OPEN', NULL, 3, '2026-06-03 13:31:08', '2026-06-03 13:31:08'),
(602, 43, 46, 'SG202/25007/L', '25007', 'L', 'IMAM FAHRUDI', 'SIANTAN', '2025-03-21 18:24:00', '28.791', 'STS PONTIANAK', '2025-03-21 21:30:00', '28.446', '30', '7', '9.677394', '0.178571', '0.129167', '85.483871', '-4.223245', '0.587499', '0.345', '-0.242499', '15150', '-3111759.29295', 'OPEN', NULL, 3, '2026-06-03 13:31:54', '2026-06-03 13:31:54'),
(603, 43, 46, 'SG202/25007/D1', '25007', 'D1', 'IMAM FAHRUDI', 'STS PONTIANAK', '2025-03-23 20:18:00', '27.606', 'KETAPANG', '2025-03-24 18:00:00', '24.643', '150', '7', '6.91244', '0.892857', '0.904167', '85.483871', '0.966823', '2.982142', '2.963', '-0.019142', '15150', '-245631.1011', 'OPEN', NULL, 3, '2026-06-03 13:33:10', '2026-06-03 13:33:10'),
(604, 43, 46, 'SG202/25008/L', '25008', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-03-26 00:06:00', '23.107', 'PONTIANAK', '2025-03-26 22:00:00', '20.116', '150', '7', '6.849315', '0.892857', '0.9125', '85.483871', '1.67916', '2.9375', '2.991', '0.0535', '14600', '661591.7', 'OPEN', NULL, 3, '2026-06-03 13:33:39', '2026-06-03 13:33:39'),
(605, 43, 46, 'SG202/25008/D1', '25008', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-03-31 18:54:00', '17.774', 'SIANTAN', '2025-03-31 23:24:00', '17.203', '30', '7', '6.666667', '0.178571', '0.1875', '85.483871', '0.763285', '0.596427', '0.571', '-0.025427', '15150', '-326280.53535', 'OPEN', NULL, 3, '2026-06-03 13:38:38', '2026-06-03 13:38:38'),
(606, 43, 46, 'SG202/25009/L', '25009', 'L', 'IMAM FAHRUDI', 'SIANTAN', '2025-04-03 17:12:00', '32.223', 'STS PONTIANAK', '2025-04-03 20:36:00', '31.845', '30', '7', '8.823509', '0.178571', '0.141667', '88.333333', '-3.259853', '0.587499', '0.378', '-0.209499', '14200', '-2519728.2726', 'OPEN', NULL, 3, '2026-06-03 13:39:22', '2026-06-03 13:39:22'),
(607, 43, 46, 'SG202/25009/D1', '25009', 'D1', 'IMAM FAHRUDI', 'STS PONTIANAK', '2025-04-05 11:42:00', '30.725', 'SANGGAU', '2025-04-05 21:30:00', '29.387', '65', '7', '6.632658', '0.386905', '0.408333', '88.333333', '1.892807', '1.292263', '1.338', '0.045737', '14200', '550097.1938', 'OPEN', NULL, 3, '2026-06-03 13:40:55', '2026-06-03 13:40:55'),
(608, 43, 46, 'SG202/25010/L', '25010', 'L', 'IMAM FAHRUDI', 'SANGGAU', '2025-04-11 06:30:00', '18.963', 'STS PONTIANAK', '2025-04-11 15:30:00', '17.735', '65', '7', '7.222222', '0.386905', '0.375', '88.333333', '-1.051608', '1.272917', '1.228', '-0.044917', '14200', '-540234.7258', 'OPEN', NULL, 3, '2026-06-03 13:41:34', '2026-06-03 13:41:34'),
(609, 43, 46, 'SG202/25010/D1', '25010', 'D1', 'IMAM FAHRUDI', 'STS PONTIANAK', '2025-04-14 06:00:00', '30.315', 'SANGGAU', '2025-04-14 17:30:00', '28.747', '65', '7', '5.65217', '0.386905', '0.479167', '88.333333', '8.14981', '1.292263', '1.568', '0.275737', '14200', '3316399.1938', 'OPEN', NULL, 3, '2026-06-03 13:42:05', '2026-06-03 13:42:05'),
(610, 43, 46, 'SG202/25011/L', '25011', 'L', 'IMAM FAHRUDI', 'SANGGAU', '2025-04-20 23:00:00', '16.947', 'PONTIANAK', '2025-04-21 08:12:00', '15.692', '65', '7', '7.065224', '0.386905', '0.383333', '88.333333', '-0.315527', '1.272917', '1.255', '-0.017917', '14200', '-215494.9258', 'OPEN', NULL, 3, '2026-06-03 13:42:35', '2026-06-03 13:43:39'),
(611, 43, 46, 'SG202/25011/D1', '25011', 'D1', 'IMAM FAHRUDI', 'STS PONTIANAK', '2025-04-24 20:12:00', '31.308', 'SANGGAU', '2025-04-25 06:00:00', '29.971', '65', '7', '6.632658', '0.386905', '0.408333', '88.333333', '1.892807', '1.292263', '1.337', '0.044737', '14200', '538069.7938', 'OPEN', NULL, 3, '2026-06-03 13:44:32', '2026-06-03 13:44:32'),
(612, 43, 46, 'SG202/25012/L', '25012', 'L', 'IMAM FAHRUDI', 'SANGGAU', '2025-04-30 05:30:00', '19.757', 'STS PONTIANAK', '2025-04-30 14:18:00', '18.556', '65', '7', '7.386357', '0.386905', '0.366667', '88.333333', '-1.78769', '1.272917', '1.201', '-0.071917', '14200', '-864974.5258', 'OPEN', NULL, 3, '2026-06-03 13:45:12', '2026-06-03 13:45:12'),
(613, 43, 46, 'SG202/25012/D1', '25012', 'D1', 'IMAM FAHRUDI', 'STS PONTIANAK', '2025-05-03 01:30:00', '31.302', 'KETAPANG', '2025-05-04 03:00:00', '27.824', '150', '7', '5.882353', '0.892857', '1.0625', '85.483871', '14.50174', '2.982142', '3.478', '0.495858', '14050', '5900883.7503', 'OPEN', NULL, 3, '2026-06-03 13:45:54', '2026-06-03 13:45:54'),
(614, 43, 46, 'SG202/25013/L', '25013', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-05-05 23:00:00', '25.891', 'STS PONTIANAK', '2025-05-06 20:30:00', '22.966', '150', '7', '6.976747', '0.892857', '0.895833', '85.483871', '0.2544', '2.9375', '2.925', '-0.0125', '14050', '-148754.375', 'OPEN', NULL, 3, '2026-06-03 13:46:31', '2026-06-03 13:46:31');
INSERT INTO `t_master_cable` (`id`, `id_vessel`, `id_kontrak`, `no_voyage_gab`, `no_voyage`, `jenis_voyage`, `master`, `atd_port`, `atd_time`, `atd_rob`, `ata_port`, `ata_time`, `ata_rob`, `distance`, `speed`, `act_speed`, `est_sail_day`, `act_sail_day`, `charter_rate_day`, `est_claim_speed`, `std_bunker_cons`, `act_bunker_cons`, `excess_bunker`, `bunker_price`, `est_claim_bunker`, `status`, `keterangan`, `user_id`, `created_at`, `updated_at`) VALUES
(615, 43, 46, 'SG202/25013/D1', '25013', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-05-11 20:00:00', '32.897', 'SANGGAU', '2025-05-12 07:00:00', '31.396', '65', '7', '5.909095', '0.386905', '0.458333', '85.483871', '6.105942', '1.292263', '1.501', '0.208737', '14050', '2484043.35795', 'OPEN', NULL, 3, '2026-06-03 13:47:34', '2026-06-03 13:47:34'),
(616, 43, 46, 'SG202/25014/L', '25014', 'L', 'IMAM FAHRUDI', 'M. KUBU', '2025-05-17 13:00:00', '20.937', 'STS PONTIANAK', '2025-05-17 22:00:00', '19.71', '65', '7', '7.222222', '0.386905', '0.375', '85.483871', '-1.017685', '1.272917', '1.227', '-0.045917', '14050', '-546428.37095', 'OPEN', NULL, 3, '2026-06-03 13:48:10', '2026-06-03 13:48:10'),
(617, 43, 46, 'SG202/25014/D1', '25014', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-05-29 19:42:00', '28.394', 'M. KUBU', '2025-05-30 10:00:00', '26.438', '65', '7', '4.545457', '0.386905', '0.595833', '85.483871', '17.859974', '1.292263', '1.956', '0.663737', '14050', '7898702.60795', 'OPEN', NULL, 3, '2026-06-03 13:48:50', '2026-06-03 13:48:50'),
(618, 43, 46, 'SG202/25015/L', '25015', 'L', 'IMAM FAHRUDI', 'M. KUBU', '2025-06-04 15:12:00', '14.715', 'STS PONTIANAK', '2025-06-04 23:30:00', '13.557', '65', '7', '7.831333', '0.386905', '0.345833', '88.333333', '-3.628027', '1.272917', '1.158', '-0.114917', '13500', '-1314018.4365', 'OPEN', NULL, 3, '2026-06-03 13:52:17', '2026-06-03 13:52:17'),
(619, 43, 46, 'SG202/25015/D1', '25015', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-06-14 20:30:00', '26.282', 'M. KUBU', '2025-06-15 08:30:00', '24.641', '65', '7', '5.416667', '0.386905', '0.5', '88.333333', '9.990058', '1.292263', '1.641', '0.348737', '13500', '3987633.2265', 'OPEN', NULL, 3, '2026-06-03 13:54:15', '2026-06-03 13:54:15'),
(620, 43, 46, 'SG202/25016/L', '25016', 'L', 'IMAM FAHRUDI', 'M. KUBU', '2025-06-21 08:00:00', '14.005', 'STS PONTIANAK', '2025-06-21 16:30:00', '12.483', '65', '7', '7.647052', '0.386905', '0.354167', '88.333333', '-2.891857', '1.272917', '1.522', '0.249083', '13500', '2848139.5635', 'OPEN', NULL, 3, '2026-06-03 13:54:56', '2026-06-03 13:54:56'),
(621, 43, 46, 'SG202/25016/D1', '25016', 'D1', 'IMAM FAHRUDI', 'STS PONTIANAK', '2025-06-25 17:18:00', '29.586', 'M. KUBU', '2025-06-26 07:00:00', '27.719', '65', '7', '4.744528', '0.386905', '0.570833', '88.333333', '16.246973', '1.292263', '1.867', '0.574737', '13500', '6571830.2265', 'OPEN', NULL, 3, '2026-06-03 13:55:46', '2026-06-03 13:55:46'),
(622, 43, 46, 'SG202/25017/L', '25017', 'L', 'IMAM FAHRUDI', 'M. KUBU', '2025-06-30 12:30:00', '18.037', 'PONTIANAK', '2025-06-30 21:00:00', '16.879', '65', '7', '7.647052', '0.386905', '0.354167', '88.333333', '-2.891857', '1.272917', '1.158', '-0.114917', '13500', '-1314018.4365', 'OPEN', NULL, 3, '2026-06-03 13:56:27', '2026-06-03 13:56:27'),
(623, 43, 46, 'SG202/25017/D1', '25017', 'D1', 'IMAM FAHRUDI', 'IT PONTIANAK', '2025-07-06 17:00:00', '29.64', 'M. KUBU', '2025-07-07 05:30:00', '27.93', '65', '7', '5.200003', '0.386905', '0.520833', '85.483871', '11.448684', '1.292263', '1.71', '0.417737', '13950', '4935834.18405', 'OPEN', NULL, 3, '2026-06-03 13:57:31', '2026-06-03 13:57:31'),
(624, 43, 46, 'SG202/25018/L', '25018', 'L', 'IMAM FAHRUDI', 'M. KUBU', '2025-07-12 11:30:00', '17.383', 'PONTIANAK', '2025-07-12 20:30:00', '16.152', '65', '7', '7.222222', '0.386905', '0.375', '85.483871', '-1.017685', '1.272917', '1.231', '-0.041917', '13950', '-495276.60105', 'OPEN', NULL, 3, '2026-06-03 13:58:36', '2026-06-03 13:58:36'),
(625, 43, 46, 'SG202/25018/D1', '25018', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-07-14 20:00:00', '32.019', 'KETAPANG', '2025-07-15 21:30:00', '28.536', '150', '7', '5.882353', '0.892857', '1.0625', '85.483871', '14.50174', '2.982142', '3.483', '0.500858', '13950', '5917962.8277', 'OPEN', NULL, 3, '2026-06-03 13:59:24', '2026-06-03 13:59:24'),
(626, 43, 46, 'SG202/25019/L', '25019', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-07-17 18:42:00', '25.744', 'PONTIANAK', '2025-07-18 15:42:00', '22.876', '150', '7', '7.142857', '0.892857', '0.875', '85.483871', '-1.526485', '2.9375', '2.868', '-0.0695', '13950', '-821187.675', 'OPEN', NULL, 3, '2026-06-03 14:00:05', '2026-06-03 14:00:05'),
(627, 43, 46, 'SG202/25019/D1', '25019', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-07-21 15:30:00', '20.676', 'KETAPANG', '2025-07-22 20:00:00', '16.786', '150', '7', '5.263158', '0.892857', '1.1875', '85.483871', '25.187224', '2.982142', '3.89', '0.907858', '13950', '10726932.3777', 'OPEN', NULL, 3, '2026-06-03 14:00:52', '2026-06-03 14:00:52'),
(628, 43, 46, 'SG202/25020/L', '25020', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-07-24 15:30:00', '15.014', 'PONTIANAK', '2025-07-25 12:42:00', '12.119', '150', '7', '7.075474', '0.892857', '0.883333', '85.483871', '-0.814148', '2.9375', '2.895', '-0.0425', '13950', '-502165.125', 'OPEN', NULL, 3, '2026-06-03 14:01:36', '2026-06-03 14:01:36'),
(629, 43, 46, 'SG202/25020/D1', '25020', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-07-27 23:00:00', '32.876', 'KETAPANG', '2025-07-29 02:00:00', '29.202', '150', '7', '5.555556', '0.892857', '1.125', '85.483871', '19.844482', '2.982142', '3.674', '0.691858', '13950', '8174751.9777', 'OPEN', NULL, 3, '2026-06-03 14:02:48', '2026-06-03 14:02:48'),
(630, 43, 46, 'SG202/25021/L', '25021', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-08-01 17:30:00', '26.441', 'PONTIANAK', '2025-08-02 14:30:00', '23.583', '150', '7', '7.142857', '0.892857', '0.875', '85.483871', '-1.526485', '2.9375', '2.858', '-0.0795', '14450', '-973012.425', 'OPEN', NULL, 3, '2026-06-03 14:03:29', '2026-06-03 14:03:29'),
(631, 43, 46, 'SG202/25021/D1', '25021', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-08-05 14:42:00', '21.649', 'KETAPANG', '2025-08-06 19:00:00', '17.798', '150', '7', '5.300352', '0.892857', '1.179167', '85.483871', '24.474887', '2.982142', '3.851', '0.868858', '14450', '10634083.3907', 'OPEN', NULL, 3, '2026-06-03 14:04:02', '2026-06-03 14:04:02'),
(632, 43, 46, 'SG202/25022/L', '25022', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-08-07 22:00:00', '16.36', 'PONTIANAK', '2025-08-08 19:18:00', '13.471', '150', '7', '7.042254', '0.892857', '0.8875', '85.483871', '-0.457937', '2.9375', '2.889', '-0.0485', '14450', '-593598.775', 'OPEN', NULL, 3, '2026-06-03 14:04:35', '2026-06-03 14:04:35'),
(633, 43, 46, 'SG202/25022/D1', '25022', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-08-10 17:30:00', '32.416', 'KETAPANG', '2025-08-11 18:30:00', '29.01', '150', '7', '5.999998', '0.892857', '1.041667', '85.483871', '12.720855', '2.982142', '3.406', '0.423858', '14450', '5187661.6407', 'OPEN', NULL, 3, '2026-06-03 14:05:10', '2026-06-03 14:05:10'),
(634, 43, 46, 'SG202/25023/L', '25023', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-08-12 22:48:00', '27.36', 'PONTIANAK', '2025-08-13 20:00:00', '24.472', '150', '7', '7.075474', '0.892857', '0.883333', '85.483871', '-0.814148', '2.9375', '2.888', '-0.0495', '14450', '-605837.925', 'OPEN', NULL, 3, '2026-06-03 14:05:46', '2026-06-03 14:05:46'),
(635, 43, 46, 'SG202/25023/D1', '25023', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-08-15 21:00:00', '22.695', 'KETAPANG', '2025-08-17 00:00:00', '19.018', '150', '7', '5.555556', '0.892857', '1.125', '85.483871', '19.844482', '2.982142', '3.677', '0.694858', '14450', '8504471.2907', 'OPEN', NULL, 3, '2026-06-03 14:28:53', '2026-06-03 14:28:53'),
(636, 43, 46, 'SG202/25024/L', '25024', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-08-21 16:00:00', '16.529', 'PONTIANAK', '2025-08-22 13:00:00', '13.668', '150', '7', '7.142857', '0.892857', '0.875', '85.483871', '-1.526485', '2.9375', '2.861', '-0.0765', '14450', '-936294.975', 'OPEN', NULL, 3, '2026-06-03 14:29:27', '2026-06-03 14:29:27'),
(637, 43, 46, 'SG202/25024/D1', '25024', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-08-24 19:30:00', '30.92', 'KETAPANG', '2025-08-25 18:30:00', '27.772', '150', '7', '6.521741', '0.892857', '0.958333', '85.483871', '5.597142', '2.982142', '3.148', '0.165858', '14450', '2029960.9407', 'OPEN', NULL, 3, '2026-06-03 14:30:13', '2026-06-03 14:30:13'),
(638, 43, 46, 'SG202/25025/L', '25025', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-08-28 09:48:00', '25.447', 'PONTIANAK', '2025-08-29 07:00:00', '22.846', '150', '7', '7.075474', '0.892857', '0.883333', '85.483871', '-0.814148', '2.9375', '2.601', '-0.3365', '14450', '-4118473.975', 'OPEN', NULL, 3, '2026-06-03 14:30:44', '2026-06-03 14:30:44'),
(639, 43, 46, 'SG202/25025/D1', '25025', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-09-02 13:00:00', '20.341', 'KETAPANG', '2025-09-03 12:00:00', '17.192', '150', '7', '6.521741', '0.892857', '0.958333', '88.333333', '5.783713', '2.982142', '3.149', '0.166858', '14150', '1999801.4729', 'OPEN', NULL, 3, '2026-06-03 14:31:14', '2026-06-03 14:31:14'),
(640, 43, 46, 'SG202/25026/L', '25026', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-09-05 21:00:00', '15.474', 'PONTIANAK', '2025-09-06 19:18:00', '12.421', '150', '7', '6.726455', '0.892857', '0.929167', '88.333333', '3.207383', '2.9375', '3.053', '0.1155', '14150', '1384273.275', 'OPEN', NULL, 3, '2026-06-03 14:31:43', '2026-06-03 14:31:43'),
(641, 43, 46, 'SG202/25026/D1', '25026', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-09-09 18:00:00', '31.219', 'M. KUBU', '2025-09-10 05:30:00', '29.645', '65', '7', '5.65217', '0.386905', '0.479167', '88.333333', '8.14981', '1.292263', '1.574', '0.281737', '14150', '3376632.03185', 'OPEN', NULL, 3, '2026-06-03 14:32:17', '2026-06-03 14:32:17'),
(642, 43, 46, 'SG202/25026/D2', '25026', 'D2', 'IMAM FAHRUDI', 'PONTIANAK', '2025-10-25 13:12:00', '29.942', 'KETAPANG', '2025-10-26 14:38:00', '26.46', '150', '7', '5.897773', '0.892857', '1.059722', '85.483871', '14.264266', '2.982142', '3.482', '0.499858', '14300', '6054330.0818', 'OPEN', NULL, 3, '2026-06-03 14:33:11', '2026-06-03 14:33:11'),
(643, 43, 46, 'SG202/25027/L', '25027', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-10-28 09:50:00', '24.672', 'PONTIANAK', '2025-10-29 07:24:00', '21.763', '150', '7', '6.955179', '0.892857', '0.898611', '85.483871', '0.491874', '2.9375', '2.909', '-0.0285', '14300', '-345194.85', 'OPEN', NULL, 3, '2026-06-03 14:33:51', '2026-06-03 14:33:51'),
(644, 43, 46, 'SG202/25027/D1', '25027', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-11-01 23:00:00', '19.734', 'KETAPANG', '2025-11-02 11:24:00', '16.811', '150', '7', '12.096766', '0.892857', '0.516667', '88.333333', '-33.230117', '2.982142', '2.923', '-0.059142', '14300', '-716333.8182', 'OPEN', NULL, 3, '2026-06-03 14:34:38', '2026-06-03 14:34:38'),
(645, 43, 46, 'SG202/25028/L', '25028', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-11-03 15:00:00', '15.27', 'PONTIANAK', '2025-11-04 14:00:00', '12.135', '150', '7', '6.521741', '0.892857', '0.958333', '88.333333', '5.783713', '2.9375', '3.135', '0.1975', '14300', '2392139.75', 'OPEN', NULL, 3, '2026-06-03 14:35:22', '2026-06-03 14:35:22'),
(646, 43, 46, 'SG202/25028/D1', '25028', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-11-06 12:30:00', '32.319', 'KETAPANG', '2025-11-07 13:42:00', '28.89', '150', '7', '5.952381', '0.892857', '1.05', '88.333333', '13.880965', '2.982142', '3.429', '0.446858', '14300', '5412388.7818', 'OPEN', NULL, 3, '2026-06-03 14:35:59', '2026-06-03 14:35:59'),
(647, 43, 46, 'SG202/25029/L', '25029', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-11-09 10:30:00', '26.884', 'PONTIANAK', '2025-11-10 07:00:00', '24.611', '150', '7', '7.31707', '0.892857', '0.854167', '88.333333', '-3.417617', '2.9375', '2.273', '-0.6645', '14300', '-8048490.45', 'OPEN', NULL, 3, '2026-06-03 14:36:35', '2026-06-03 14:36:35'),
(648, 43, 46, 'SG202/25029/D1', '25029', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-11-12 14:18:00', '22.205', 'KETAPANG', '2025-11-13 14:00:00', '18.972', '150', '7', '6.329114', '0.892857', '0.9875', '88.333333', '8.360132', '2.982142', '3.233', '0.250858', '14300', '3038417.1818', 'OPEN', NULL, 3, '2026-06-03 14:37:18', '2026-06-03 14:37:18'),
(649, 43, 46, 'SG202/25030/L', '25030', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-11-15 09:00:00', '17.376', 'PONTIANAK', '2025-11-16 09:30:00', '14.035', '150', '7', '6.122451', '0.892857', '1.020833', '88.333333', '11.304547', '2.9375', '3.341', '0.4035', '14300', '4887232.35', 'OPEN', NULL, 3, '2026-06-03 14:37:54', '2026-06-03 14:37:54'),
(650, 43, 46, 'SG202/25030/D1', '25030', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-11-18 05:30:00', '32.769', 'KETAPANG', '2025-11-19 03:42:00', '29.753', '150', '7', '6.756757', '0.892857', '0.925', '88.333333', '2.839298', '2.982142', '3.016', '0.033858', '14300', '410091.4818', 'OPEN', NULL, 3, '2026-06-03 14:38:32', '2026-06-03 14:38:32'),
(651, 43, 46, 'SG202/25031/L', '25031', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-11-21 07:42:00', '27.375', 'PONTIANAK', '2025-11-22 07:42:00', '24.184', '150', '7', '6.25', '0.892857', '1', '88.333333', '9.464298', '2.9375', '3.191', '0.2535', '14300', '3070417.35', 'OPEN', NULL, 3, '2026-06-03 14:39:32', '2026-06-03 14:39:32'),
(652, 43, 46, 'SG202/25031/D1', '25031', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-11-25 10:30:00', '22.086', 'KETAPANG', '2025-11-26 07:54:00', '19.188', '150', '7', '7.009343', '0.892857', '0.891667', '88.333333', '-0.105117', '2.982142', '2.898', '-0.084142', '14300', '-1019136.3182', 'OPEN', NULL, 3, '2026-06-03 14:40:09', '2026-06-03 14:40:09'),
(653, 43, 46, 'SG202/25032/L', '25032', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-11-27 11:36:00', '17.918', 'PONTIANAK', '2025-11-28 09:00:00', '15.013', '150', '7', '7.009343', '0.892857', '0.891667', '88.333333', '-0.105117', '2.9375', '2.905', '-0.0325', '14300', '-393643.25', 'OPEN', NULL, 3, '2026-06-03 14:40:48', '2026-06-03 14:40:48'),
(654, 43, 46, 'SG202/25032/D1', '25032', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-12-02 04:48:00', '33.645', 'KETAPANG', '2025-12-03 06:00:00', '30.194', '150', '7', '5.952381', '0.892857', '1.05', '85.483871', '13.433192', '2.982142', '3.451', '0.468858', '15300', '6075977.7078', 'OPEN', NULL, 3, '2026-06-03 14:41:38', '2026-06-03 14:41:38'),
(655, 43, 46, 'SG202/25033/L', '25033', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-12-04 08:00:00', '28.6', 'PONTIANAK', '2025-12-05 05:18:00', '25.841', '150', '7', '7.042254', '0.892857', '0.8875', '85.483871', '-0.457937', '2.9375', '2.759', '-0.1785', '15300', '-2313199.35', 'OPEN', NULL, 3, '2026-06-03 14:42:15', '2026-06-03 14:42:15'),
(656, 43, 46, 'SG202/25033/D1', '25033', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-12-07 08:00:00', '23.922', 'KETAPANG', '2025-12-08 06:12:00', '20.882', '150', '7', '6.756757', '0.892857', '0.925', '85.483871', '2.747708', '2.982142', '3.04', '0.057858', '15300', '749787.6078', 'OPEN', NULL, 3, '2026-06-03 14:42:51', '2026-06-03 14:42:51'),
(657, 43, 46, 'SG202/25034/L', '25034', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-12-10 12:00:00', '19.085', 'PONTIANAK', '2025-12-11 09:12:00', '16.183', '150', '7', '7.075474', '0.892857', '0.883333', '85.483871', '-0.814148', '2.9375', '2.902', '-0.0355', '15300', '-460048.05', 'OPEN', NULL, 3, '2026-06-03 14:43:33', '2026-06-03 14:43:33'),
(658, 43, 46, 'SG202/25034/D1', '25034', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-12-16 09:00:00', '32.927', 'KETAPANG', '2025-12-17 06:24:00', '30.008', '150', '7', '7.009343', '0.892857', '0.891667', '85.483871', '-0.101726', '2.982142', '2.919', '-0.063142', '15300', '-818263.4922', 'OPEN', NULL, 3, '2026-06-03 14:45:59', '2026-06-03 14:45:59'),
(659, 43, 46, 'SG202/25035/L', '25035', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-12-18 08:00:00', '28.18', 'PONTIANAK', '2025-12-19 07:18:00', '24.929', '150', '7', '6.43777', '0.892857', '0.970833', '85.483871', '6.66569', '2.9375', '3.251', '0.3135', '15300', '4062677.85', 'OPEN', NULL, 10, '2026-06-03 14:46:54', '2026-06-03 19:44:24'),
(660, 43, 46, 'SG202/25035/D1', '25035', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2025-12-27 09:30:00', '21.892', 'KETAPANG', '2025-12-28 07:00:00', '18.959', '150', '7', '6.976747', '0.892857', '0.895833', '85.483871', '0.2544', '2.982142', '2.933', '-0.049142', '15300', '-636836.0922', 'OPEN', NULL, 3, '2026-06-03 14:47:28', '2026-06-03 14:47:28'),
(661, 43, 46, 'SG202/25036/L', '25036', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2025-12-30 06:30:00', '16.831', 'PONTIANAK', '2025-12-31 13:00:00', '12.671', '150', '7', '4.918034', '0.892857', '1.270833', '85.483871', '32.310852', '2.9375', '4.16', '1.2225', '15300', '15842499.75', 'OPEN', NULL, 10, '2026-06-03 14:48:03', '2026-06-03 19:45:01'),
(662, 43, 46, 'SG202/26001/D1', '26001', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-01-04 04:30:00', '31.983', 'KETAPANG', '2026-01-05 02:48:00', '28.207', '150', '7', '6.726455', '0.892857', '0.929167', '85.483871', '3.103919', '2.982142', '3.776', '0.793858', '20750', '13952252.8145', 'OPEN', NULL, 3, '2026-06-03 14:48:40', '2026-06-03 14:48:40'),
(663, 43, 46, 'SG202/26002/L', '26002', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-01-08 13:00:00', '25.357', 'PONTIANAK', '2026-01-09 22:48:00', '20.737', '150', '7', '4.437871', '0.892857', '1.408333', '85.483871', '44.064884', '2.9375', '4.62', '1.6825', '20750', '29570358.125', 'OPEN', NULL, 3, '2026-06-03 14:49:46', '2026-06-03 14:49:46'),
(664, 43, 46, 'SG202/26002/D1', '26002', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-01-12 16:00:00', '18.518', 'KETAPANG', '2026-01-13 13:18:00', '15.607', '150', '7', '7.042254', '0.892857', '0.8875', '85.483871', '-0.457937', '2.982142', '2.911', '-0.071142', '20750', '-1250338.4355', 'OPEN', NULL, 3, '2026-06-03 14:50:17', '2026-06-03 14:50:17'),
(665, 43, 46, 'SG202/26003/L', '26003', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-01-16 12:00:00', '13.314', 'PONTIANAK', '2026-01-17 19:00:00', '9.079', '150', '7', '4.838708', '0.892857', '1.291667', '85.483871', '34.091823', '2.9375', '4.235', '1.2975', '20750', '22803886.875', 'OPEN', NULL, 3, '2026-06-03 14:50:56', '2026-06-03 14:50:56'),
(666, 43, 46, 'SG202/26003/D1', '26003', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-01-20 05:00:00', '27.998', 'KETAPANG', '2026-01-21 02:18:00', '25.08', '150', '7', '7.042254', '0.892857', '0.8875', '85.483871', '-0.457937', '2.982142', '2.918', '-0.064142', '20750', '-1127311.6855', 'OPEN', NULL, 3, '2026-06-03 14:51:38', '2026-06-03 14:51:38'),
(667, 43, 46, 'SG202/26004/L', '26004', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-01-23 10:30:00', '22.969', 'PONTIANAK', '2026-01-24 21:00:00', '18.243', '150', '7', '4.347826', '0.892857', '1.4375', '85.483871', '46.558192', '2.9375', '4.726', '1.7885', '20750', '31433334.625', 'OPEN', NULL, 3, '2026-06-03 14:52:07', '2026-06-03 14:52:07'),
(668, 43, 46, 'SG202/26004/D1', '26004', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-01-26 10:30:00', '17.045', 'KETAPANG', '2026-01-27 08:24:00', '13.437', '150', '7', '6.849315', '0.892857', '0.9125', '85.483871', '1.67916', '2.982142', '3.608', '0.625858', '20750', '10999610.8145', 'OPEN', NULL, 3, '2026-06-03 14:52:44', '2026-06-03 14:52:44'),
(669, 43, 46, 'SG202/26005/L', '26005', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-01-29 06:00:00', '11.73', 'PONTIANAK', '2026-01-30 11:00:00', '7.293', '150', '7', '5.172415', '0.892857', '1.208333', '85.483871', '26.96811', '2.9375', '4.437', '1.4995', '20750', '26354087.375', 'OPEN', NULL, 3, '2026-06-03 14:53:20', '2026-06-03 14:53:20'),
(670, 43, 46, 'SG202/26005/D1', '26005', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-02-01 05:00:00', '32.41', 'KETAPANG', '2026-02-02 04:00:00', '28.553', '150', '7', '6.521741', '0.892857', '0.958333', '94.642857', '6.196836', '2.982142', '3.857', '0.874858', '21200', '15709300.1912', 'OPEN', NULL, 3, '2026-06-03 14:54:22', '2026-06-03 14:54:22'),
(671, 43, 46, 'SG202/26006/L', '26006', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-02-03 13:00:00', '26.812', 'PONTIANAK', '2026-02-04 17:00:00', '22.542', '150', '7', '5.357141', '0.892857', '1.166667', '94.642857', '25.914161', '2.9375', '4.27', '1.3325', '21200', '23926903', 'OPEN', NULL, 3, '2026-06-03 14:55:03', '2026-06-03 14:55:03'),
(672, 43, 46, 'SG202/26006/D1', '26006', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-02-06 12:00:00', '21.591', 'KETAPANG', '2026-02-07 10:30:00', '17.804', '150', '7', '6.666667', '0.892857', '0.9375', '94.642857', '4.225141', '2.982142', '3.787', '0.804858', '21200', '14452352.1912', 'OPEN', NULL, 3, '2026-06-03 14:55:33', '2026-06-03 14:55:33'),
(673, 43, 46, 'SG202/26007/L', '26007', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-02-11 06:00:00', '15.492', 'PONTIANAK', '2026-02-12 07:30:00', '11.535', '150', '7', '5.882353', '0.892857', '1.0625', '94.642857', '16.055498', '2.9375', '3.957', '1.0195', '21200', '18306549.8', 'OPEN', NULL, 3, '2026-06-03 14:56:22', '2026-06-03 14:56:22'),
(674, 43, 46, 'SG202/26007/D1', '26007', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-02-15 11:00:00', '30.238', 'KETAPANG', '2026-02-16 09:00:00', '26.779', '150', '7', '6.818179', '0.892857', '0.916667', '94.642857', '2.253446', '2.982142', '3.459', '0.476858', '21200', '8562652.9912', 'OPEN', NULL, 3, '2026-06-03 14:57:16', '2026-06-03 14:57:16'),
(675, 43, 46, 'SG202/26008/L', '26008', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-02-19 09:00:00', '24.339', 'PONTIANAK', '2026-02-20 10:00:00', '20.342', '150', '7', '5.999998', '0.892857', '1.041667', '94.642857', '14.083804', '2.9375', '3.997', '1.0595', '21200', '19024805.8', 'OPEN', NULL, 3, '2026-06-03 14:57:52', '2026-06-03 14:57:52'),
(676, 43, 46, 'SG202/26008/D1', '26008', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-02-24 20:30:00', '18.351', 'KETAPANG', '2026-02-25 20:30:00', '14.431', '150', '7', '6.25', '0.892857', '1', '94.642857', '10.14032', '2.982142', '3.92', '0.937858', '21200', '16840553.3912', 'OPEN', NULL, 3, '2026-06-03 14:58:25', '2026-06-03 14:58:25'),
(677, 43, 46, 'SG202/26009/L', '26009', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-02-27 07:30:00', '12.611', 'PONTIANAK', '2026-02-28 06:00:00', '8.89', '150', '7', '6.666667', '0.892857', '0.9375', '94.642857', '4.225141', '2.9375', '3.721', '0.7835', '21200', '14068839.4', 'OPEN', NULL, 3, '2026-06-03 14:59:03', '2026-06-03 14:59:03'),
(678, 43, 46, 'SG202/26009/D1', '26009', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-03-03 09:00:00', '29.486', 'KETAPANG', '2026-03-04 05:30:00', '26.247', '150', '7', '7.31707', '0.892857', '0.854167', '85.483871', '-3.307371', '2.982142', '3.239', '0.256858', '23050', '5014728.6343', 'OPEN', NULL, 3, '2026-06-03 14:59:44', '2026-06-03 14:59:44'),
(679, 43, 46, 'SG202/26010/L', '26010', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-03-05 13:00:00', '24.185', 'PONTIANAK', '2026-03-06 18:30:00', '20.137', '150', '7', '5.084744', '0.892857', '1.229167', '85.483871', '28.749081', '2.9375', '4.048', '1.1105', '23050', '21680680.175', 'OPEN', NULL, 3, '2026-06-03 15:01:06', '2026-06-03 15:01:06'),
(680, 43, 46, 'SG202/26010/D1', '26010', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-03-11 04:00:00', '17.778', 'KETAPANG', '2026-03-12 01:00:00', '14.892', '150', '7', '7.142857', '0.892857', '0.875', '85.483871', '-1.526485', '2.982142', '2.886', '-0.096142', '23050', '-1877013.9157', 'OPEN', NULL, 3, '2026-06-03 15:01:57', '2026-06-03 15:01:57'),
(681, 43, 46, 'SG202/26011/L', '26011', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-03-13 04:00:00', '12.767', 'PONTIANAK', '2026-03-14 06:00:00', '9.2', '150', '7', '5.769233', '0.892857', '1.083333', '85.483871', '16.282626', '2.9375', '3.567', '0.6295', '23050', '12289948.825', 'OPEN', NULL, 3, '2026-06-03 15:02:34', '2026-06-03 15:02:34'),
(682, 43, 46, 'SG202/26011/D1', '26011', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-03-20 19:00:00', '29.241', 'KETAPANG', '2026-03-21 16:00:00', '26.372', '150', '7', '7.142857', '0.892857', '0.875', '85.483871', '-1.526485', '2.982142', '2.869', '-0.113142', '23050', '-2208910.8657', 'OPEN', NULL, 3, '2026-06-03 15:05:36', '2026-06-03 15:05:36'),
(683, 43, 46, 'SG202/26012/L', '26012', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-03-23 02:30:00', '24.566', 'PONTIANAK', '2026-03-24 03:30:00', '21.149', '150', '7', '5.999998', '0.892857', '1.041667', '85.483871', '12.720855', '2.9375', '3.417', '0.4795', '23050', '9361446.325', 'OPEN', NULL, 3, '2026-06-03 15:06:16', '2026-06-03 15:06:16'),
(684, 43, 46, 'SG202/26012/D1', '26012', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-03-27 08:00:00', '19.139', 'KETAPANG', '2026-03-28 06:00:00', '16.133', '150', '7', '6.818179', '0.892857', '0.916667', '85.483871', '2.035371', '2.982142', '3.006', '0.023858', '23050', '465788.0843', 'OPEN', NULL, 3, '2026-06-03 15:06:58', '2026-06-03 15:06:58'),
(685, 43, 46, 'SG202/26013/L', '26013', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-03-30 10:00:00', '13.183', 'PONTIANAK', '2026-03-31 07:30:00', '10.245', '150', '7', '6.976747', '0.892857', '0.895833', '85.483871', '0.2544', '2.9375', '2.938', '0.0005', '23050', '9761.675', 'OPEN', NULL, 3, '2026-06-03 15:07:30', '2026-06-03 15:07:30'),
(686, 43, 46, 'SG202/26013/D1', '26013', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-04-02 16:00:00', '29.704', 'KETAPANG', '2026-04-03 17:00:00', '26.252', '150', '7', '5.999998', '0.892857', '1.041667', '88.333333', '13.144883', '2.982142', '3.452', '0.469858', '28150', '11202847.7869', 'OPEN', NULL, 3, '2026-06-03 15:08:14', '2026-06-03 15:08:53'),
(687, 43, 46, 'SG202/26014/L', '26014', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-04-07 02:00:00', '23.286', 'PONTIANAK', '2026-04-08 01:00:00', '20.111', '150', '7', '6.521741', '0.892857', '0.958333', '88.333333', '5.783713', '2.9375', '3.175', '0.2375', '28150', '5662724.375', 'OPEN', NULL, 3, '2026-06-03 15:09:27', '2026-06-03 15:09:27'),
(688, 43, 46, 'SG202/26014/D1', '26014', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-04-10 21:00:00', '17.899', 'KETAPANG', '2026-04-11 21:30:00', '14.518', '150', '7', '6.122451', '0.892857', '1.020833', '88.333333', '11.304547', '2.982142', '3.381', '0.398858', '28150', '9509991.2369', 'OPEN', NULL, 3, '2026-06-03 15:10:37', '2026-06-03 15:10:59'),
(689, 43, 46, 'SG202/26015/L', '26015', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-04-14 01:30:00', '11.939', 'PONTIANAK', '2026-04-15 00:30:00', '8.764', '150', '7', '6.521741', '0.892857', '0.958333', '88.333333', '5.783713', '2.9375', '3.175', '0.2375', '28150', '5662724.375', 'OPEN', NULL, 3, '2026-06-03 15:11:38', '2026-06-03 15:11:38'),
(690, 43, 46, 'SG202/26015/D1', '26015', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-04-17 16:30:00', '29.436', 'KETAPANG', '2026-04-18 15:30:00', '26.279', '150', '7', '6.521741', '0.892857', '0.958333', '88.333333', '5.783713', '2.982142', '3.157', '0.174858', '30550', '4524599.3793', 'OPEN', NULL, 3, '2026-06-03 15:12:08', '2026-06-03 15:12:08'),
(691, 43, 46, 'SG202/26016/L', '26016', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-04-21 19:00:00', '22.785', 'PONTIANAK', '2026-04-22 17:00:00', '19.765', '150', '7', '6.818179', '0.892857', '0.916667', '88.333333', '2.103217', '2.9375', '3.02', '0.0825', '30550', '2134757.625', 'OPEN', NULL, 3, '2026-06-03 15:12:43', '2026-06-03 15:12:43'),
(692, 43, 46, 'SG202/26016/D1', '26016', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-04-25 05:00:00', '17.701', 'KETAPANG', '2026-04-26 04:00:00', '14.543', '150', '7', '6.521741', '0.892857', '0.958333', '88.333333', '5.783713', '2.982142', '3.158', '0.175858', '30550', '4550475.2293', 'OPEN', NULL, 3, '2026-06-03 15:13:16', '2026-06-03 15:13:16'),
(693, 43, 46, 'SG202/26017/L', '26017', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-04-29 01:00:00', '11.696', 'PONTIANAK', '2026-04-29 23:00:00', '8.676', '150', '7', '6.818179', '0.892857', '0.916667', '88.333333', '2.103217', '2.9375', '3.02', '0.0825', '30550', '2134757.625', 'OPEN', NULL, 3, '2026-06-03 15:14:01', '2026-06-03 15:14:01'),
(694, 43, 46, 'SG202/26017/D1', '26017', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-05-02 17:00:00', '28.794', 'KETAPANG', '2026-05-03 16:30:00', '25.581', '150', '7', '6.382977', '0.892857', '0.979167', '85.483871', '7.378113', '2.982142', '3.213', '0.230858', '30550', '5973646.9793', 'OPEN', NULL, 3, '2026-06-03 15:14:53', '2026-06-03 15:14:53'),
(695, 43, 46, 'SG202/26018/L', '26018', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-05-05 04:00:00', '22.813', 'PONTIANAK', '2026-05-06 00:00:00', '20.078', '150', '7', '7.500003', '0.892857', '0.833333', '85.483871', '-5.088342', '2.9375', '2.735', '-0.2025', '30550', '-5239859.625', 'OPEN', NULL, 3, '2026-06-03 15:15:38', '2026-06-03 15:15:38'),
(696, 43, 46, 'SG202/26018/D1', '26018', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-05-07 21:00:00', '18.12', 'KETAPANG', '2026-05-08 21:00:00', '14.839', '150', '7', '6.25', '0.892857', '1', '85.483871', '9.158998', '2.982142', '3.281', '0.298858', '30550', '7733204.7793', 'OPEN', NULL, 3, '2026-06-03 15:16:14', '2026-06-03 15:16:14'),
(697, 43, 46, 'SG202/26019/L', '26019', 'L', 'IMAM FAHRUDI', 'KETAPANG', '2026-05-12 00:30:00', '12.135', 'PONTIANAK', '2026-05-13 00:00:00', '8.923', '150', '7', '6.382977', '0.892857', '0.979167', '85.483871', '7.378113', '2.9375', '3.212', '0.2745', '30550', '7102920.825', 'OPEN', NULL, 3, '2026-06-03 15:16:51', '2026-06-03 15:16:51'),
(698, 43, 46, 'SG202/26019/D1', '26019', 'D1', 'IMAM FAHRUDI', 'PONTIANAK', '2026-05-15 18:30:00', '28.761', 'KETAPANG', '2026-05-16 17:00:00', '25.69', '150', '7', '6.666667', '0.892857', '0.9375', '85.483871', '3.816256', '2.982142', '3.071', '0.088858', '30550', '2299276.2793', 'OPEN', NULL, 3, '2026-06-03 15:17:30', '2026-06-03 15:17:30'),
(700, 41, 48, 'SG351/25001/D1', '25001', 'D1', 'IMAM FAHRUDI', 'TELUK KABUNG', '2025-01-03 19:53:00', '32855', 'PULAU BAAI', '2025-01-06 12:00:00', '21863', '247', '7', '3.852352', '1.470238', '2.671528', '108.064516', '129.816822', '7.671702', '10992', '10984.328298', '15250', '141881822543.1915', 'OPEN', NULL, 10, '2026-06-03 21:39:58', '2026-06-03 21:54:16'),
(701, 41, 48, 'SG351/25002/L', '25002', 'L', 'IMAM FAHRUDI', 'PULAU BAAI', '2025-01-09 21:30:00', '17228', 'TELUK KABUNG', '2025-01-12 07:00:00', '7.52', '247', '7', '4.295653', '1.470238', '2.395833', '108.064516', '100.023976', '7.480571', '17220.48', '17212.999429', '15250', '222336010374.53574', 'OPEN', NULL, 10, '2026-06-03 21:41:34', '2026-06-03 21:54:27'),
(702, 41, 48, 'SG351/25002/D1', '25002', 'D1', 'IMAM FAHRUDI', 'TELUK KABUNG', '2025-01-17 17:35:00', '30493', 'PULAU BAAI', '2025-01-20 01:59:00', '20921', '247', '7', '4.379433', '1.470238', '2.35', '108.064516', '95.071055', '7.671702', '9572', '9564.328298', '15250', '123540037543.1915', 'OPEN', NULL, 10, '2026-06-03 21:42:35', '2026-06-03 21:54:42'),
(703, 41, 48, 'SG351/25003/L', '25003', 'L', 'IMAM FAHRUDI', 'PULAU BAAI', '2025-01-21 22:36:00', '18078', 'TG. GEREM', '2025-01-24 06:05:00', '8.71', '298', '7', '5.370981', '1.77381', '2.311806', '108.064516', '58.138277', '9.025145', '18069.29', '18060.264855', '15250', '233279926065.82123', 'OPEN', NULL, 10, '2026-06-03 21:45:05', '2026-06-03 21:56:26'),
(704, 41, 48, 'SG351/25003/D1', '25003', 'D1', 'IMAM FAHRUDI', 'TG. GEREM', '2025-01-27 10:30:00', '39535', 'PULAU BAAI', '2025-02-01 04:59:00', '20163', '298', '7', '2.602999', '1.77381', '4.770139', '119.642857', '358.489362', '9.255741', '19372', '19362.744259', '15250', '250103726907.43823', 'OPEN', NULL, 10, '2026-06-03 21:46:23', '2026-06-03 21:56:37'),
(705, 41, 48, 'SG351/25004/L', '25004', 'L', 'IMAM FAHRUDI', 'PULAU BAAI', '2025-02-03 10:00:00', '16513', 'IT. PANJANG', '2025-02-06 13:53:00', '3699', '285', '7', '3.755765', '1.696429', '3.161806', '119.642857', '175.321891', '8.631431', '12814', '12805.368569', '15450', '167572973899.21936', 'OPEN', NULL, 10, '2026-06-03 21:50:30', '2026-06-03 21:56:49'),
(706, 41, 48, 'SG351/25004/D1', '25004', 'D1', 'IMAM FAHRUDI', 'IT. PANJANG', '2025-02-08 00:30:00', '40487', 'PULAU BAAI', '2025-11-02 15:30:00', '25465', '285', '7', '0.044372', '1.696429', '267.625', '111.666667', '29695.357184', '8.851967', '15022', '15013.148033', '15150', '192649466216.85764', 'OPEN', NULL, 10, '2026-06-03 21:53:51', '2026-06-03 21:56:57'),
(707, 41, 48, 'SG351/25005/L', '25005', 'L', 'IMAM FAHRUDI', 'PULAU BAAI', '2025-02-12 15:30:00', '23276', 'IT. PANJANG', '2025-02-17 04:59:00', '10106', '285', '7', '2.603136', '1.696429', '4.561806', '119.642857', '342.821891', '8.631431', '13170', '13161.368569', '15450', '172231643299.21936', 'OPEN', NULL, 10, '2026-06-03 22:47:31', '2026-06-03 22:47:31'),
(708, 41, 48, 'SG351/25005/D1', '25005', 'D1', 'IMAM FAHRUDI', 'IT. PANJANG', '2025-02-17 19:59:00', '37542', 'PULAU BAAI', '2025-02-21 13:30:00', '22431', '285', '7', '3.183765', '1.696429', '3.729861', '119.642857', '243.285614', '8.851967', '15111', '15102.148033', '15150', '193791518666.85764', 'OPEN', NULL, 10, '2026-06-03 22:54:30', '2026-06-03 22:54:30'),
(709, 41, 48, 'SG351/25006/L', '25006', 'L', 'IMAM FAHRUDI', 'PULAU BAAI', '2025-02-24 16:30:00', '18737', 'TELUK KABUNG', '2025-02-27 06:30:00', '8268', '285', '7', '4.596775', '1.696429', '2.583333', '119.642857', '106.111728', '8.631431', '10469', '10460.368569', '15250', '135113965713.63075', 'OPEN', NULL, 10, '2026-06-03 22:55:28', '2026-06-03 22:55:28'),
(710, 41, 48, 'SG351/25006/D1', '25006', 'D1', 'IMAM FAHRUDI', 'TELUK KABUNG', '2025-02-28 20:00:00', '38134', 'PULAU BAAI', '2025-03-03 10:30:00', '26821', '285', '7', '4.559999', '1.696429', '2.604167', '108.064516', '98.094268', '8.851967', '11313', '11304.148033', '15250', '146012854105.25275', 'OPEN', NULL, 10, '2026-06-04 18:29:55', '2026-06-04 18:29:55'),
(711, 41, 48, 'SG351/25007/L', '25007', 'L', 'IMAM FAHRUDI', 'PULAU BAAI', '2025-03-06 15:00:00', '22655', 'TELUK KABUNG', '2025-09-03 10:30:00', '11.09', '285', '7', '0.065676', '1.696429', '180.8125', '111.666667', '20001.294655', '8.631431', '22643.91', '22635.278569', '15250', '292374234456.1307', 'OPEN', NULL, 10, '2026-06-04 18:31:48', '2026-06-04 18:32:14'),
(712, 41, 48, 'SG351/25007/D1', '25007', 'D1', 'IMAM FAHRUDI', 'TELUK KABUNG', '2025-03-10 08:00:00', '38743', 'PULAU BAAI', '2025-03-12 19:00:00', '28782', '285', '7', '4.830509', '1.696429', '2.458333', '108.064516', '82.334787', '8.851967', '9961', '9952.148033', '15250', '128549408105.25275', 'OPEN', NULL, 10, '2026-06-04 18:33:59', '2026-06-04 18:33:59'),
(713, 41, 48, 'SG351/25008/L', '25008', 'L', 'IMAM FAHRUDI', 'PULAU BAAI', '2025-03-15 09:30:00', '25519', 'TELUK KABUNG', '2025-03-17 19:30:00', '15726', '285', '7', '4.913792', '1.696429', '2.416667', '108.064516', '77.832171', '8.631431', '9793', '9784.368569', '15250', '126382242713.63075', 'OPEN', NULL, 10, '2026-06-04 18:38:51', '2026-06-04 18:39:02'),
(716, 41, 48, 'SG351/25008/D1', '25008', 'D1', 'IMAM FAHRUDI', 'TELUK KABUNG', '2025-03-19 02:00:00', '41.584', 'PULAU BAAI', '2025-03-21 06:54:00', '33.014', '285', '7', '5.387523', '1.696429', '2.204167', '108.064516', '54.868461', '8.851967', '8.57', '-0.281967', '15250', '-3642097.24725', 'OPEN', NULL, 3, '2026-06-04 18:53:19', '2026-06-04 18:53:19'),
(717, 41, 48, 'SG351/25009/L', '25009', 'L', 'IMAM FAHRUDI', 'PULAU BAAI', '2025-03-23 17:00:00', '29.691', 'TELUK KABUNG', '2025-03-26 01:00:00', '20.236', '285', '7', '5.089286', '1.696429', '2.333333', '108.064516', '68.826722', '8.631431', '9.455', '0.823569', '15250', '10637834.88075', 'OPEN', NULL, 3, '2026-06-04 18:55:14', '2026-06-04 18:55:33'),
(718, 41, 48, 'SG351/25009/D1', '25009', 'D1', 'IMAM FAHRUDI', 'T. KABUNG', '2025-03-27 02:00:00', '40.412', 'P. BAAI', '2025-03-29 14:36:00', '30.18', '247', '7', '4.075908', '1.470238', '2.525', '108.064516', '113.982345', '7.671702', '10.232', '2.560298', '14350', '31119014.0261', 'OPEN', NULL, 3, '2026-06-04 18:57:04', '2026-06-04 19:01:07'),
(719, 41, 48, 'SG351/25009/D2', '25009', 'D2', 'IMAM FAHRUDI', 'P. BAAI', '2025-05-02 20:00:00', '20.073', 'PANJANG', '2025-05-06 06:30:00', '6.144', '285', '7', '3.454545', '1.696429', '3.4375', '108.064516', '188.147995', '8.851967', '13.929', '5.077033', '14050', '60418469.66155', 'OPEN', NULL, 3, '2026-06-04 18:58:33', '2026-06-04 19:00:42'),
(720, 41, 48, 'SG351/25009/D3', '25009', 'D3', 'IMAM FAHRUDI', 'PANJANG', '2025-05-06 19:00:00', '37.253', 'P. BALAM', '2025-05-11 06:00:00', '19.186', '351', '7', '3.280374', '2.089286', '4.458333', '108.064516', '256.009917', '10.901894', '18.067', '7.165106', '14050', '85267269.1871', 'OPEN', NULL, 3, '2026-06-04 19:02:21', '2026-06-04 19:02:21'),
(721, 41, 48, 'SG351/25010/L', '25010', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2025-05-13 19:00:00', '16.141', 'PANJANG', '2025-05-17 07:00:00', '1.957', '351', '7', '4.178571', '2.089286', '3.5', '108.064516', '152.448126', '10.630287', '14.184', '3.553713', '14050', '42290428.49955', 'OPEN', NULL, 3, '2026-06-04 19:03:31', '2026-06-04 19:04:12'),
(722, 41, 48, 'SG351/25010/D1', '25010', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2025-05-18 23:30:00', '37.812', 'P. BALAM', '2025-05-23 00:00:00', '21.518', '351', '7', '3.637306', '2.089286', '4.020833', '108.064516', '208.731692', '10.901894', '16.294', '5.392106', '14050', '64167948.6371', 'OPEN', NULL, 3, '2026-06-04 19:05:20', '2026-06-04 19:05:20'),
(723, 41, 48, 'SG351/25011/L', '25011', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2025-06-05 20:30:00', '14.23', 'TG. UBAN', '2025-06-08 04:00:00', '4.837', '270', '7', '4.864865', '1.607143', '2.3125', '111.666667', '78.764865', '8.177144', '9.393', '1.215856', '13800', '14211654.4416', 'OPEN', NULL, 3, '2026-06-04 19:08:59', '2026-06-04 19:09:23'),
(724, 41, 48, 'SG351/25011/D1', '25011', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-06-09 18:00:00', '37.384', 'P. BALAM', '2025-06-13 03:06:00', '23.691', '270', '7', '3.329223', '1.607143', '3.379167', '111.666667', '197.876014', '8.386072', '13.693', '5.306928', '13500', '60682068.216', 'OPEN', NULL, 3, '2026-06-04 19:10:34', '2026-06-04 19:10:34'),
(725, 41, 48, 'SG351/25012/L', '25012', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2025-06-14 23:00:00', '21.153', 'TG. UBAN', '2025-06-17 11:36:00', '10.928', '270', '7', '4.455446', '1.607143', '2.525', '111.666667', '102.494032', '8.177144', '10.225', '2.047856', '13800', '23936569.6416', 'OPEN', NULL, 3, '2026-06-04 19:11:30', '2026-06-04 19:11:49'),
(726, 41, 48, 'SG351/25012/D1', '25012', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-06-18 17:00:00', '40.313', 'P. BALAM', '2025-06-21 18:30:00', '27.903', '270', '7', '3.673469', '1.607143', '3.0625', '111.666667', '162.514865', '8.386072', '12.41', '4.023928', '13500', '46011604.716', 'OPEN', NULL, 3, '2026-06-04 19:12:55', '2026-06-04 19:12:55'),
(727, 41, 48, 'SG351/25013/L', '25013', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2025-06-26 23:00:00', '24.302', 'TG. UBAN', '2025-06-29 16:30:00', '13.243', '270', '7', '4.122137', '1.607143', '2.729167', '111.666667', '125.29268', '8.177144', '11.059', '2.881856', '13800', '33684862.0416', 'OPEN', NULL, 3, '2026-06-04 19:13:55', '2026-06-04 19:14:05'),
(728, 41, 48, 'SG351/25013/D1', '25013', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2025-06-30 21:36:00', '40.086', 'P. BALAM', '2025-07-04 09:00:00', '26.004', '270', '7', '3.23741', '1.607143', '3.475', '108.064516', '201.849063', '8.386072', '14.082', '5.695928', '13950', '67301091.6732', 'OPEN', NULL, 3, '2026-06-04 19:16:19', '2026-06-04 19:16:19'),
(729, 41, 48, 'SG351/25014/L', '25014', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2025-07-09 07:00:00', '22.622', 'PANJANG', '2025-07-13 11:00:00', '7.089', '360', '7', '3.6', '2.142857', '4.166667', '108.064516', '218.702048', '10.902856', '15.533', '4.630144', '13950', '54708160.9536', 'OPEN', NULL, 3, '2026-06-04 19:17:09', '2026-06-04 19:17:20'),
(730, 41, 48, 'SG351/25014/D1', '25014', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2025-07-14 21:00:00', '38.273', 'P. BAAI', '2025-07-18 10:30:00', '24.287', '285', '7', '3.333333', '1.696429', '3.5625', '108.064516', '201.656059', '8.851967', '13.986', '5.134033', '14250', '61966494.80175', 'OPEN', NULL, 3, '2026-06-04 19:18:19', '2026-06-04 19:18:19'),
(731, 41, 48, 'SG351/25015/L', '25015', 'L', 'IMAM FAHRUDI', 'P. BAAI', '2025-08-08 10:00:00', '18.66', 'T. KABUNG', '2025-08-11 04:30:00', '7.431', '247', '7', '3.714286', '1.470238', '2.770833', '108.064516', '140.548169', '7.480571', '11.229', '3.748429', '14450', '45877584.79535', 'OPEN', NULL, 3, '2026-06-04 19:19:18', '2026-06-04 19:19:29'),
(732, 41, 48, 'SG351/25015/D1', '25015', 'D1', 'IMAM FAHRUDI', 'T. KABUNG', '2025-08-15 16:30:00', '37.477', 'P. BAAI', '2025-08-18 04:30:00', '27.345', '247', '7', '4.116667', '1.470238', '2.5', '108.064516', '111.280732', '7.671702', '10.132', '2.460298', '14750', '30737117.9885', 'OPEN', NULL, 3, '2026-06-04 19:20:19', '2026-06-04 19:20:19'),
(733, 41, 48, 'SG351/25016/L', '25016', 'L', 'IMAM FAHRUDI', 'P. BAAI', '2025-08-20 05:30:00', '25.476', 'T. KABUNG', '2025-08-22 17:00:00', '15.429', '247', '7', '4.15126', '1.470238', '2.479167', '108.064516', '109.029424', '7.480571', '10.047', '2.566429', '14450', '31410909.49535', 'OPEN', NULL, 3, '2026-06-04 19:21:35', '2026-06-04 19:21:45'),
(734, 41, 48, 'SG351/25016/D1', '25016', 'D1', 'IMAM FAHRUDI', 'T. KABUNG', '2025-08-23 17:00:00', '39.67', 'P. BAAI', '2025-08-26 11:00:00', '28.526', '247', '7', '3.742424', '1.470238', '2.75', '108.064516', '138.296861', '7.671702', '11.144', '3.472298', '14750', '43380286.9885', 'OPEN', NULL, 3, '2026-06-04 19:22:25', '2026-06-04 19:22:25'),
(735, 41, 48, 'SG351/25017/L', '25017', 'L', 'IMAM FAHRUDI', 'P. BAAI', '2025-08-29 00:00:00', '26.253', 'TG. GEREM', '2025-09-02 22:00:00', '6.33', '298', '7', '2.525424', '1.77381', '4.916667', '111.666667', '350.952366', '9.025145', '19.923', '10.897855', '13850', '127842192.11225', 'OPEN', NULL, 3, '2026-06-04 19:25:21', '2026-06-04 19:26:03'),
(736, 41, 48, 'SG351/25017/D1', '25017', 'D1', 'IMAM FAHRUDI', 'TG. GEREM', '2025-09-04 02:00:00', '33.02', 'P. BAAI', '2025-09-07 12:30:00', '19.09', '298', '7', '3.612121', '1.77381', '3.4375', '111.666667', '185.778717', '9.255741', '13.93', '4.674259', '14150', '56021227.82795', 'OPEN', NULL, 3, '2026-06-04 19:26:53', '2026-06-04 19:26:53'),
(737, 41, 48, 'SG351/25018/L', '25018', 'L', 'IMAM FAHRUDI', 'P. BAAI', '2025-09-09 09:30:00', '16.793', 'TG. GEREM', '2025-09-12 11:00:00', '4.383', '298', '7', '4.054422', '1.77381', '3.0625', '111.666667', '143.903717', '9.025145', '12.41', '3.384855', '13850', '39707564.76225', 'OPEN', NULL, 3, '2026-06-04 19:27:38', '2026-06-04 19:27:53'),
(738, 41, 48, 'SG351/25018/D1', '25018', 'D1', 'IMAM FAHRUDI', 'TG. GEREM', '2025-09-15 15:00:00', '39.955', 'P. BAAI', '2025-09-18 16:00:00', '27.629', '298', '7', '4.082191', '1.77381', '3.041667', '111.666667', '141.577365', '9.255741', '12.326', '3.070259', '14150', '36797207.62795', 'OPEN', NULL, 3, '2026-06-04 19:28:40', '2026-06-04 19:28:40'),
(739, 41, 48, 'SG351/25019/L', '25019', 'L', 'IMAM FAHRUDI', 'P. BAAI', '2025-09-20 07:00:00', '25.65', 'T. KABUNG', '2025-09-22 15:00:00', '16.195', '247', '7', '4.410715', '1.470238', '2.333333', '111.666667', '96.378942', '7.480571', '9.455', '1.974429', '14450', '24165332.69535', 'OPEN', NULL, 3, '2026-06-04 19:29:59', '2026-06-04 19:30:10'),
(740, 41, 48, 'SG351/25019/D1', '25019', 'D1', 'IMAM FAHRUDI', 'T. KABUNG', '2025-09-23 23:00:00', '40.185', 'P. BAAI', '2025-09-26 23:00:00', '28.028', '247', '7', '3.430556', '1.470238', '3', '111.666667', '170.823424', '7.671702', '12.157', '4.485298', '14150', '53756520.7949', 'OPEN', NULL, 3, '2026-06-04 19:30:57', '2026-06-04 19:30:57'),
(741, 41, 48, 'SG351/25020/L', '25020', 'L', 'IMAM FAHRUDI', 'P. BAAI', '2025-09-30 00:00:00', '25.153', 'T. KABUNG', '2025-10-02 12:00:00', '15.023', '247', '7', '4.116667', '1.470238', '2.5', '108.064516', '111.280732', '7.480571', '10.13', '2.649429', '14600', '32763368.8998', 'OPEN', NULL, 3, '2026-06-04 19:31:35', '2026-06-04 19:31:47'),
(742, 41, 48, 'SG351/25020/D1', '25020', 'D1', 'IMAM FAHRUDI', 'T. KABUNG', '2025-10-03 06:57:00', '38.429', 'P. BAAI', '2025-10-05 01:26:00', '28.72', '247', '7', '5.814044', '1.470238', '1.770139', '108.064516', '32.408656', '7.671702', '9.709', '2.037298', '14300', '24675957.1058', 'OPEN', NULL, 3, '2026-06-04 19:32:41', '2026-06-04 19:32:41'),
(743, 41, 48, 'SG351/25021/L', '25021', 'L', 'IMAM FAHRUDI', 'P. BAAI', '2025-10-07 10:04:00', '26.8', 'T. KABUNG', '2025-10-09 18:57:00', '17.176', '247', '7', '4.342221', '1.470238', '2.370139', '108.064516', '97.247366', '7.480571', '9.624', '2.143429', '14600', '26506071.6998', 'OPEN', NULL, 3, '2026-06-04 19:33:14', '2026-06-04 19:33:23'),
(744, 41, 48, 'SG351/25021/D1', '25021', 'D1', 'IMAM FAHRUDI', 'T. KABUNG', '2025-10-11 15:07:00', '39.599', 'P. BAAI', '2025-10-14 04:33:00', '29.215', '247', '7', '4.020619', '1.470238', '2.559722', '108.064516', '117.734561', '7.671702', '10.384', '2.712298', '14300', '32851624.6058', 'OPEN', NULL, 3, '2026-06-04 19:34:20', '2026-06-04 19:34:20'),
(745, 41, 48, 'SG351/25022/L', '25022', 'L', 'IMAM FAHRUDI', 'P. BAAI', '2025-10-20 07:55:00', '26.368', 'T. KABUNG', '2025-10-21 21:36:00', '19.911', '247', '7', '6.554621', '1.470238', '1.570139', '108.064516', '10.795753', '7.480571', '6.457', '-1.023571', '14600', '-12657683.7002', 'OPEN', NULL, 3, '2026-06-04 19:35:05', '2026-06-04 19:35:17'),
(746, 41, 48, 'SG351/25022/D1', '25022', 'D1', 'IMAM FAHRUDI', 'T. KABUNG', '2025-10-25 10:04:00', '39.509', 'P. BAAI', '2025-10-27 21:36:00', '29.315', '247', '7', '4.148935', '1.470238', '2.480556', '108.064516', '109.179526', '7.671702', '10.194', '2.522298', '14300', '30550325.6058', 'OPEN', NULL, 3, '2026-06-04 19:36:22', '2026-06-04 19:36:22'),
(747, 41, 48, 'SG351/25023/L', '25023', 'L', 'IMAM FAHRUDI', 'P. BAAI', '2025-11-01 02:00:00', '26.315', 'T. KABUNG', '2025-11-03 12:00:00', '16.522', '247', '7', '4.25862', '1.470238', '2.416667', '111.666667', '105.684572', '7.480571', '9.793', '2.312429', '14300', '28008371.2909', 'OPEN', NULL, 3, '2026-06-04 19:37:00', '2026-06-04 19:37:08'),
(748, 41, 48, 'SG351/25023/D1', '25023', 'D1', 'IMAM FAHRUDI', 'T. KABUNG', '2025-11-12 05:00:00', '37.408', 'P. BAAI', '2025-11-14 09:00:00', '28.628', '247', '7', '4.749999', '1.470238', '2.166667', '111.666667', '77.767905', '7.671702', '8.78', '1.108298', '14300', '13423816.2058', 'OPEN', NULL, 3, '2026-06-04 19:38:56', '2026-06-04 19:38:56'),
(749, 41, 48, 'SG351/25024/L', '25024', 'L', 'IMAM FAHRUDI', 'P. BAAI', '2025-11-15 18:30:00', '26.116', 'T. KABUNG', '2025-11-18 17:00:00', '14.213', '247', '7', '3.503546', '1.470238', '2.9375', '111.666667', '163.844257', '7.480571', '11.903', '4.422429', '14300', '53564902.2909', 'OPEN', NULL, 3, '2026-06-04 19:39:45', '2026-06-04 19:39:54'),
(750, 41, 48, 'SG351/25024/D1', '25024', 'D1', 'IMAM FAHRUDI', 'T. KABUNG', '2025-11-19 14:00:00', '38.585', 'P. BAAI', '2025-11-21 23:30:00', '28.877', '247', '7', '4.295653', '1.470238', '2.395833', '111.666667', '103.358109', '7.671702', '9.708', '2.036298', '14300', '24663845.0058', 'OPEN', NULL, 3, '2026-06-04 19:40:42', '2026-06-04 19:40:42'),
(751, 41, 48, 'SG351/25025/L', '25025', 'L', 'IMAM FAHRUDI', 'P. BAAI', '2025-11-24 00:00:00', '26.121', 'TG. GEREM', '2025-11-26 23:00:00', '14.133', '298', '7', '4.197184', '1.77381', '2.958333', '111.666667', '132.271735', '9.025145', '11.988', '2.962855', '14300', '35886396.0455', 'OPEN', NULL, 3, '2026-06-04 19:41:29', '2026-06-04 19:41:40'),
(752, 41, 48, 'SG351/25025/D1', '25025', 'D1', 'IMAM FAHRUDI', 'TG. GEREM', '2025-11-30 02:00:00', '41.001', 'P. BAAI', '2025-12-03 18:30:00', '26.396', '298', '7', '3.367232', '1.77381', '3.6875', '108.064516', '206.801984', '9.255741', '14.605', '5.349259', '15300', '69321582.3069', 'OPEN', NULL, 3, '2026-06-04 19:42:24', '2026-06-04 19:42:24'),
(753, 41, 48, 'SG351/25026/L', '25026', 'L', 'IMAM FAHRUDI', 'P. BAAI', '2025-12-05 04:00:00', '24.169', 'T. KABUNG', '2025-12-07 16:00:00', '14.039', '247', '7', '4.116667', '1.470238', '2.5', '108.064516', '111.280732', '7.480571', '10.13', '2.649429', '15300', '34334215.3539', 'OPEN', NULL, 3, '2026-06-04 19:43:12', '2026-06-04 19:43:21'),
(754, 41, 48, 'SG351/25026/D1', '25026', 'D1', 'IMAM FAHRUDI', 'T. KABUNG', '2025-12-08 19:30:00', '38.214', 'P. BAAI', '2025-12-11 05:00:00', '28.505', '247', '7', '4.295653', '1.470238', '2.395833', '108.064516', '100.023976', '7.671702', '9.709', '2.037298', '15300', '26401548.5118', 'OPEN', NULL, 3, '2026-06-04 19:44:08', '2026-06-04 19:44:08'),
(755, 41, 48, 'SG351/25027/L', '25027', 'L', 'IMAM FAHRUDI', 'P. BAAI', '2025-12-12 22:30:00', '25.196', 'T. KABUNG', '2025-12-15 15:00:00', '14.305', '247', '7', '3.829457', '1.470238', '2.6875', '108.064516', '131.542829', '7.480571', '10.891', '3.410429', '15300', '44196090.4539', 'OPEN', NULL, 3, '2026-06-04 19:44:48', '2026-06-04 19:44:56'),
(756, 41, 48, 'SG351/25027/D1', '25027', 'D1', 'IMAM FAHRUDI', 'T. KABUNG', '2025-12-18 06:00:00', '37.38', 'P. BAAI', '2025-12-20 18:30:00', '27.165', '247', '7', '4.082645', '1.470238', '2.520833', '108.064516', '113.53204', '7.671702', '10.215', '2.543298', '15300', '32958853.1118', 'OPEN', NULL, 3, '2026-06-04 19:45:39', '2026-06-04 19:45:39'),
(757, 41, 48, 'SG351/25028/L', '25028', 'L', 'IMAM FAHRUDI', 'P. BAAI', '2025-12-22 06:00:00', '24.467', 'PANJANG', '2025-12-24 19:30:00', '14.083', '285', '7', '4.634146', '1.696429', '2.5625', '108.064516', '93.591543', '8.631431', '10.384', '1.752569', '13900', '20633520.6077', 'OPEN', NULL, 3, '2026-06-04 19:46:30', '2026-06-04 19:46:39'),
(758, 41, 48, 'SG351/25028/D1', '25028', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2026-01-01 13:00:00', '40.6', 'BELINYU', '2026-01-06 18:00:00', '19.495', '450', '7', '3.6', '2.678571', '5.208333', '108.064516', '273.377506', '13.976783', '21.105', '7.128217', '20750', '125280195.82925', 'OPEN', NULL, 3, '2026-06-04 19:51:12', '2026-06-04 19:51:12'),
(759, 41, 48, 'SG351/25028/D2', '25028', 'D2', 'IMAM FAHRUDI', 'BELINYU', '2026-01-08 18:00:00', '16.437', 'T. GEREM', '2026-01-12 05:30:00', '2.339', '373', '7', '4.467065', '2.220238', '3.479167', '108.064516', '136.045553', '11.585202', '14.098', '2.512798', '20750', '44163053.0495', 'OPEN', NULL, 3, '2026-06-04 19:52:19', '2026-06-04 19:52:19'),
(760, 41, 48, 'SG351/26001/L', '26001', 'L', 'IMAM FAHRUDI', 'T. GEREM', '2026-01-14 14:30:00', '41.42', 'PANJANG', '2026-01-15 14:00:00', '37.451', '55', '7', '2.340425', '0.327381', '0.979167', '108.064516', '70.434939', '1.665715', '3.969', '2.303285', '20750', '40480809.69625', 'OPEN', NULL, 3, '2026-06-04 19:53:09', '2026-06-04 19:53:09');
INSERT INTO `t_master_cable` (`id`, `id_vessel`, `id_kontrak`, `no_voyage_gab`, `no_voyage`, `jenis_voyage`, `master`, `atd_port`, `atd_time`, `atd_rob`, `ata_port`, `ata_time`, `ata_rob`, `distance`, `speed`, `act_speed`, `est_sail_day`, `act_sail_day`, `charter_rate_day`, `est_claim_speed`, `std_bunker_cons`, `act_bunker_cons`, `excess_bunker`, `bunker_price`, `est_claim_bunker`, `status`, `keterangan`, `user_id`, `created_at`, `updated_at`) VALUES
(761, 41, 48, 'SG351/26001/D1', '26001', 'D1', 'IMAM FAHRUDI', 'PANJANG', '2026-01-17 11:30:00', '36.469', 'P. BALAM', '2026-01-21 22:30:00', '18.403', '360', '7', '3.364486', '2.142857', '4.458333', '108.064516', '250.220793', '11.181428', '18.066', '6.884572', '20750', '120998074.043', 'OPEN', NULL, 3, '2026-06-04 19:55:08', '2026-06-04 19:55:08'),
(762, 41, 48, 'SG351/26002/L', '26002', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2026-01-26 09:00:00', '35.943', 'T. GEREM', '2026-01-28 14:00:00', '26.994', '360', '7', '6.792454', '2.142857', '2.208333', '108.064516', '7.075632', '10.902856', '8.949', '-1.953856', '20750', '-34339507.664', 'OPEN', NULL, 3, '2026-06-04 19:56:04', '2026-06-04 19:56:04'),
(763, 41, 48, 'SG351/26002/D1', '26002', 'D1', 'IMAM FAHRUDI', 'T. GEREM', '2026-01-30 16:00:00', '38.256', 'P. BALAM', '2026-02-03 18:30:00', '21.625', '360', '7', '3.654822', '2.142857', '4.104167', '119.642857', '234.656732', '11.181428', '16.631', '5.449572', '21200', '97854694.6608', 'OPEN', NULL, 3, '2026-06-04 19:56:43', '2026-06-04 19:56:43'),
(764, 41, 48, 'SG351/26003/L', '26003', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2026-02-06 07:30:00', '35.279', 'TG. UBAN', '2026-02-09 06:00:00', '23.376', '270', '7', '3.829787', '1.607143', '2.9375', '119.642857', '159.167712', '8.177144', '11.903', '3.725856', '21200', '66902960.6784', 'OPEN', NULL, 3, '2026-06-04 19:57:26', '2026-06-04 19:57:26'),
(765, 41, 48, 'SG351/26003/D1', '26003', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-02-15 10:00:00', '33.498', 'BELINYU', '2026-02-18 00:00:00', '23.029', '220', '7', '3.548388', '1.309524', '2.583333', '119.642857', '152.402148', '6.833096', '10.469', '3.635904', '21200', '65287746.5856', 'OPEN', NULL, 3, '2026-06-04 19:58:11', '2026-06-04 19:58:11'),
(766, 41, 48, 'SG351/26003/D2', '26003', 'D2', 'IMAM FAHRUDI', 'BELINYU', '2026-02-19 17:00:00', '21.062', 'P. BALAM', '2026-02-20 14:00:00', '17.517', '106', '7', '5.047619', '0.630952', '0.875', '119.642857', '29.1986', '3.292308', '3.545', '0.252692', '21200', '4537438.6288', 'OPEN', NULL, 3, '2026-06-04 19:59:24', '2026-06-04 19:59:24'),
(767, 41, 48, 'SG351/26004/L', '26004', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2026-02-23 08:30:00', '36.991', 'PLAJU', '2026-02-24 18:00:00', '31.335', '291', '7', '8.686569', '1.732143', '1.395833', '119.642857', '-40.237089', '8.813144', '5.656', '-3.157144', '21200', '-56690940.5216', 'OPEN', NULL, 3, '2026-06-04 20:00:03', '2026-06-04 20:00:03'),
(768, 41, 48, 'SG351/26004/D1', '26004', 'D1', 'IMAM FAHRUDI', 'PLAJU', '2026-03-05 21:00:00', '24.72', 'BELINYU', '2026-03-06 17:00:00', '21.343', '170', '7', '8.500003', '1.011905', '0.833333', '108.064516', '-19.297297', '5.28012', '3.377', '-1.90312', '23050', '-37155277.852', 'OPEN', NULL, 3, '2026-06-04 20:00:47', '2026-06-04 20:00:47'),
(769, 41, 48, 'SG351/26005/L', '26005', 'L', 'IMAM FAHRUDI', 'BELINYU', '2026-03-10 07:30:00', '38.847', 'TG. UBAN', '2026-03-12 05:00:00', '31.164', '220', '7', '4.835166', '1.309524', '1.895833', '108.064516', '63.359198', '6.662858', '7.683', '1.020142', '23050', '19916589.3157', 'OPEN', NULL, 3, '2026-06-04 20:01:42', '2026-06-04 20:01:42'),
(770, 41, 48, 'SG351/26005/D1', '26005', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-03-16 08:30:00', '29.111', 'BELINYU', '2026-03-18 15:30:00', '19.824', '220', '7', '3.999999', '1.309524', '2.291667', '108.064516', '106.134808', '6.833096', '9.287', '2.453904', '23050', '47908426.6584', 'OPEN', NULL, 3, '2026-06-04 20:02:26', '2026-06-04 20:02:26'),
(771, 41, 48, 'SG351/26006/L', '26006', 'L', 'IMAM FAHRUDI', 'BELINYU', '2026-03-20 12:30:00', '38.02', 'TG. UBAN', '2026-03-22 15:30:00', '29.409', '220', '7', '4.313725', '1.309524', '2.125', '108.064516', '88.124019', '6.662858', '8.611', '1.948142', '23050', '38034258.1157', 'OPEN', NULL, 3, '2026-06-04 20:03:06', '2026-06-04 20:03:06'),
(772, 41, 48, 'SG351/26006/D1', '26006', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-03-25 14:00:00', '27.565', 'BELINYU', '2026-03-27 14:00:00', '19.461', '220', '7', '4.583333', '1.309524', '2', '108.064516', '74.615955', '6.833096', '8.104', '1.270904', '23050', '24812303.6084', 'OPEN', NULL, 3, '2026-06-04 20:03:53', '2026-06-04 20:03:53'),
(773, 41, 48, 'SG351/26007/L', '26007', 'L', 'IMAM FAHRUDI', 'BELINYU', '2026-03-29 08:00:00', '40.06', 'TG. UBAN', '2026-03-31 05:00:00', '32.463', '220', '7', '4.888889', '1.309524', '1.875', '108.064516', '61.10789', '6.662858', '7.597', '0.934142', '23050', '18237581.2157', 'OPEN', NULL, 3, '2026-06-04 20:04:38', '2026-06-04 20:04:38'),
(774, 41, 48, 'SG351/26007/D1', '26007', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-04-01 16:30:00', '41.925', 'BELINYU', '2026-04-03 16:30:00', '33.82', '220', '7', '4.583333', '1.309524', '2', '111.666667', '77.103154', '6.833096', '8.105', '1.271904', '28150', '30326070.6672', 'OPEN', NULL, 3, '2026-06-04 20:05:23', '2026-06-04 20:05:23'),
(775, 41, 48, 'SG351/26008/L', '26008', 'L', 'IMAM FAHRUDI', 'BELINYU', '2026-04-05 00:30:00', '31.634', 'TG. UBAN', '2026-04-06 21:00:00', '24.053', '220', '7', '4.943819', '1.309524', '1.854167', '111.666667', '60.818469', '6.662858', '7.581', '0.918142', '28150', '21891305.6131', 'OPEN', NULL, 3, '2026-06-04 20:06:04', '2026-06-04 20:06:04'),
(776, 41, 48, 'SG351/26008/D1', '26008', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-04-08 09:00:00', '44.123', 'BELINYU', '2026-04-10 16:00:00', '34.45', '220', '7', '3.999999', '1.309524', '2.291667', '111.666667', '109.672635', '6.833096', '9.673', '2.839904', '28150', '67711973.0672', 'OPEN', NULL, 3, '2026-06-04 20:06:39', '2026-06-04 20:06:39'),
(777, 41, 48, 'SG351/26009/L', '26009', 'L', 'IMAM FAHRUDI', 'BELINYU', '2026-04-19 00:00:00', '29.927', 'TG. UBAN', '2026-04-21 07:00:00', '20.642', '220', '7', '3.999999', '1.309524', '2.291667', '111.666667', '109.672635', '6.662858', '9.285', '2.622142', '30550', '67850153.0707', 'OPEN', NULL, 3, '2026-06-04 20:07:22', '2026-06-04 20:07:22'),
(778, 41, 48, 'SG351/26009/D1', '26009', 'D1', 'IMAM FAHRUDI', 'TG. UBAN', '2026-04-23 08:30:00', '36.424', 'P. BALAM', '2026-04-26 06:00:00', '24.69', '270', '7', '3.884893', '1.607143', '2.895833', '111.666667', '143.903717', '8.386072', '11.734', '3.347928', '30550', '86630482.7388', 'OPEN', NULL, 3, '2026-06-04 20:08:00', '2026-06-04 20:08:00'),
(779, 41, 48, 'SG351/26010/L', '26010', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2026-04-28 02:30:00', '21.794', 'MUNTOK', '2026-04-29 08:30:00', '16.729', '150', '7', '5', '0.892857', '1.25', '111.666667', '39.880968', '4.542856', '5.065', '0.522144', '30550', '13510919.8224', 'OPEN', NULL, 3, '2026-06-04 20:08:50', '2026-06-04 20:08:50'),
(780, 41, 48, 'SG351/26010/D1', '26010', 'D1', 'IMAM FAHRUDI', 'MUNTOK', '2026-04-30 21:30:00', '15.502', 'BELINYU', '2026-05-01 12:00:00', '13.055', '86', '7', '5.931031', '0.511905', '0.604167', '108.064516', '9.970248', '2.67112', '2.447', '-0.22412', '30550', '-5799295.502', 'OPEN', NULL, 3, '2026-06-04 20:09:26', '2026-06-04 20:09:26'),
(781, 41, 48, 'SG351/26011/L', '26011', 'L', 'IMAM FAHRUDI', 'BELINYU', '2026-05-03 00:06:00', '40.194', 'MUNTOK', '2026-05-03 14:36:00', '37.746', '86', '7', '5.931031', '0.511905', '0.604167', '108.064516', '9.970248', '2.604573', '2.448', '-0.156573', '30550', '-4051459.46205', 'OPEN', NULL, 3, '2026-06-04 20:10:02', '2026-06-04 20:10:02'),
(782, 41, 48, 'SG351/26011/D1', '26011', 'D1', 'IMAM FAHRUDI', 'MUNTOK', '2026-05-04 20:00:00', '36.773', 'BELINYU', '2026-05-05 11:00:00', '34.24', '86', '7', '5.733333', '0.511905', '0.625', '108.064516', '12.221556', '2.67112', '2.533', '-0.13812', '30550', '-3573972.402', 'OPEN', NULL, 3, '2026-06-04 20:10:33', '2026-06-04 20:10:33'),
(783, 41, 48, 'SG351/26012/L', '26012', 'L', 'IMAM FAHRUDI', 'BELINYU', '2026-05-12 04:48:00', '30.305', 'MUNTOK', '2026-05-12 21:12:00', '27.227', '86', '7', '5.243905', '0.511905', '0.683333', '108.064516', '18.525284', '2.604573', '3.078', '0.473427', '30550', '12250326.03795', 'OPEN', NULL, 3, '2026-06-04 20:11:08', '2026-06-04 20:11:08'),
(784, 41, 48, 'SG351/26012/D1', '26012', 'D1', 'IMAM FAHRUDI', 'MUNTOK', '2026-05-14 16:30:00', '26.188', 'P. BALAM', '2026-05-16 05:00:00', '20.026', '150', '7', '4.10959', '0.892857', '1.520833', '108.064516', '67.861922', '4.658928', '6.162', '1.503072', '30550', '38893265.6112', 'OPEN', NULL, 3, '2026-06-04 20:11:47', '2026-06-04 20:11:47'),
(785, 41, 48, 'SG351/26013/L', '26013', 'L', 'IMAM FAHRUDI', 'P. BALAM', '2026-05-20 00:30:00', '16.829', 'MUNTOK', '2026-05-21 08:42:00', '11.393', '150', '7', '4.658384', '0.892857', '1.341667', '108.064516', '48.500435', '4.542856', '5.436', '0.893144', '30550', '23110860.1724', 'OPEN', NULL, 3, '2026-06-04 20:12:31', '2026-06-04 20:12:31');

-- --------------------------------------------------------

--
-- Table structure for table `t_off_hire`
--

CREATE TABLE `t_off_hire` (
  `id` int(11) NOT NULL,
  `id_kontrak` int(11) DEFAULT NULL,
  `id_vessel` int(11) NOT NULL,
  `no_sertifikat` varchar(100) DEFAULT NULL,
  `no_kontrak` varchar(100) DEFAULT NULL,
  `bunker_price` varchar(100) DEFAULT NULL,
  `est_oh` varchar(100) DEFAULT NULL,
  `est_boh` varchar(100) DEFAULT NULL,
  `date_time_off_hire` varchar(100) DEFAULT NULL,
  `tempat_off_hire` varchar(100) DEFAULT NULL,
  `bunker_off_hire` varchar(100) DEFAULT NULL,
  `date_time_on_hire` varchar(100) DEFAULT NULL,
  `tempat_on_hire` varchar(100) DEFAULT NULL,
  `bunker_on_hire` varchar(100) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `t_off_hire`
--

INSERT INTO `t_off_hire` (`id`, `id_kontrak`, `id_vessel`, `no_sertifikat`, `no_kontrak`, `bunker_price`, `est_oh`, `est_boh`, `date_time_off_hire`, `tempat_off_hire`, `bunker_off_hire`, `date_time_on_hire`, `tempat_on_hire`, `bunker_on_hire`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(5, 30, 41, '0509/OFFHIRE/Q22075/2025', '146/TCP/X/2023', '14300', '33646.25', '54383329', '2025-05-25 21:48:00', 'P.BALAM', '19.307', '2025-06-05 02:30:00', 'P.BALAM', '14.817', 'OPEN', 2, '2026-05-13 08:14:30', '2026-05-28 13:11:38'),
(6, 30, 41, '0727/OFFHIRE/Q22076/2025', '146/TCP/X/2023', '14300', '58025', '31770038.3', '2025-07-20 02:00:00', 'P.BAAI', '22.16', '2025-08-06 16:00:00', 'P.BAAI', '19.537', 'APPROVE', 7, '2026-05-15 03:55:00', '2026-05-28 13:26:31');

-- --------------------------------------------------------

--
-- Table structure for table `t_redelivery_delivery`
--

CREATE TABLE `t_redelivery_delivery` (
  `id` int(11) NOT NULL,
  `id_kontrak` int(11) NOT NULL,
  `id_vessel` int(11) NOT NULL,
  `no_sertifikat` varchar(100) DEFAULT NULL,
  `no_kontrak` varchar(100) DEFAULT NULL,
  `bunker_price` varchar(100) DEFAULT NULL,
  `est_bod` varchar(100) DEFAULT NULL,
  `date_time_redelivery` varchar(100) DEFAULT NULL,
  `tempat_redelivery` varchar(100) DEFAULT NULL,
  `bunker_redelivery` varchar(100) DEFAULT NULL,
  `date_time_delivery` varchar(100) DEFAULT NULL,
  `tempat_delivery` varchar(100) DEFAULT NULL,
  `bunker_delivery` varchar(100) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
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
(4, 'tes', 'tes@gmail.com', NULL, '$2y$12$JUrGA6No6dHs.BU2QcLhEOLyCIR8OzqW3IBIYxwEhROVsEPyn8VBG', NULL, '2026-04-11 23:33:52', '2026-04-11 23:33:52'),
(5, 'hermanto', 'hermanto@gmail.com', NULL, '$2y$12$30miqRzGHA57aNPSt34J5effJrq0yMqH9dZrTK8xWLW60QfyNO5qW', NULL, '2026-04-15 16:41:47', '2026-04-15 16:41:47'),
(6, 'vivi', 'vivi@gmail.com', NULL, '$2y$12$E97ELfGwdnvMaS.1d2bH/uEiEQ8/pAQ8KVaCkMIeqYQn7xVyLi4Sq', NULL, '2026-04-16 03:28:20', '2026-04-16 03:30:21'),
(7, 'approval', 'approval@gmail.com', NULL, '$2y$12$bfcKtCAotQUWOTXYs9WOP.MT8UJ1w1tBvhUc8eiiJWDotdyVbYj.6', NULL, '2026-04-16 04:37:13', '2026-04-16 04:37:13'),
(8, 'superadmin1', 'superadmin1@gmail.com', NULL, '$2y$12$st1uoPfRwEYElQUM1ApRMeQT6StzokE2DNizzgvNb37ViuFEqSiVS', NULL, '2026-04-22 08:45:56', '2026-04-22 08:45:56'),
(9, 'admin1', 'admin1@gmail.com', NULL, '$2y$12$91WJtY3N.KZvTYsC7GzfhOmpcQe9lHZqmlF5099KbupU4k7VDmG5a', NULL, '2026-04-29 08:12:06', '2026-04-29 08:12:06'),
(10, 'admin', 'admin@gmail.com', NULL, '$2y$12$4r6mnHASIViqxyspL79BYee5ZbivXCHO/bJTK1qyJsm0eZD0MFymy', NULL, '2026-05-05 06:32:20', '2026-05-05 06:32:20'),
(11, 'commercial', 'commercial@odysseylines.com', NULL, '$2y$12$g68XgofZ.9u6rTGmM9ZQIean0Ris0rdd2tQ5g9nqYXR.Es80y8Go6', NULL, '2026-05-05 06:55:35', '2026-05-05 06:55:35'),
(12, 'operation3', 'operation3@odysseylines.com', NULL, '$2y$12$5kmRYRZGG2TpSr7EzpnglOJjEG2jVHTiPscW.aMu.d2rNcjhxqU2S', NULL, '2026-05-07 08:49:37', '2026-05-07 08:49:37');

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
  ADD KEY `id_off_hire` (`id_off_hire`),
  ADD KEY `id_on_hire` (`id_on_hire`),
  ADD KEY `id_redelivery` (`id_redelivery`),
  ADD KEY `id_delivery` (`id_delivery`),
  ADD KEY `id_klaim_awal` (`id_klaim_awal`),
  ADD KEY `id_klaim_akhir` (`id_klaim_akhir`);

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
  ADD KEY `id_off_hire` (`id_off_hire`),
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
  ADD KEY `user_id` (`user_id`),
  ADD KEY `id_kontrak` (`id_kontrak`);

--
-- Indexes for table `t_off_hire`
--
ALTER TABLE `t_off_hire`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `id_vessel` (`id_vessel`) USING BTREE,
  ADD KEY `id_kontrak` (`id_kontrak`);

--
-- Indexes for table `t_redelivery_delivery`
--
ALTER TABLE `t_redelivery_delivery`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `id_vessel` (`id_vessel`) USING BTREE,
  ADD KEY `id_kontrak` (`id_kontrak`) USING BTREE;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `file_upload`
--
ALTER TABLE `file_upload`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=955;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `m_grade`
--
ALTER TABLE `m_grade`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `m_kontrak`
--
ALTER TABLE `m_kontrak`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `m_vessel`
--
ALTER TABLE `m_vessel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=205;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `t_doc_cargo`
--
ALTER TABLE `t_doc_cargo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `t_doc_cargo_detail`
--
ALTER TABLE `t_doc_cargo_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `t_klaim`
--
ALTER TABLE `t_klaim`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `t_klaim_detail`
--
ALTER TABLE `t_klaim_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `t_klaim_detail_nilai`
--
ALTER TABLE `t_klaim_detail_nilai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `t_master_cable`
--
ALTER TABLE `t_master_cable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=786;

--
-- AUTO_INCREMENT for table `t_off_hire`
--
ALTER TABLE `t_off_hire`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `t_redelivery_delivery`
--
ALTER TABLE `t_redelivery_delivery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
