-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 24, 2023 at 12:29 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `redu`
--

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
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `acronym` varchar(10) NOT NULL,
  `user_teacher_id` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `acronym`, `user_teacher_id`, `created_at`, `updated_at`) VALUES
(1, 'Informatics', 'IT', 2, '2023-04-06 04:11:28', '2023-04-06 04:11:28'),
(2, 'Biology2', 'BY', 2, '2023-04-06 04:41:30', '2023-04-11 07:06:28'),
(3, 'Cooking', 'CK', 2, '2023-04-17 07:51:42', '2023-04-17 07:51:42'),
(4, 'Lengua', 'LG', 2, '2023-04-17 07:52:30', '2023-04-17 07:52:30'),
(5, 'Informatica', 'IT', 2, '2023-04-17 07:53:09', '2023-04-17 07:53:09'),
(6, 'Informatics', 'IT', 33, '2023-05-12 07:24:51', '2023-05-12 07:24:51');

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
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_02_06_145451_esquemaInicial', 1);

-- --------------------------------------------------------

--
-- Table structure for table `own_tasks`
--

CREATE TABLE `own_tasks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `group_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `own_tasks`
--

INSERT INTO `own_tasks` (`id`, `title`, `description`, `user_id`, `group_id`) VALUES
(8, 'HOlaaa', 'löadijfasoidjf sadf', 32, 6),
(9, 'hola2', 'ölasdfösadg', 32, 6);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_tasks`
--

CREATE TABLE `student_tasks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `img` varchar(1000) DEFAULT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `task_id` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `mark` int(11) NOT NULL DEFAULT 0,
  `feedback` varchar(1000) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `student_tasks`
--

INSERT INTO `student_tasks` (`id`, `name`, `description`, `img`, `student_id`, `task_id`, `mark`, `feedback`, `created_at`, `updated_at`) VALUES
(22, 'fgh', 'sdfgh', '/data/user/0/com.example.users_login_db/cache/c80d627c-c2c5-4d24-a963-5093d3ec8c77692885291244241819.jpg', 8, 3, 0, NULL, '2023-04-11 07:29:31', '2023-04-11 07:29:31'),
(23, 'noniii', 'falafel', '/data/user/0/com.example.users_login_db/cache/c88a53fd-6e79-445a-9992-0fe77b93acf47065652527601385822.jpg', 9, 3, 5, 'Hoalfölamdasdfs sa,f sdf lkndf aslfasdf asdfj nafHoalfölamdasdfs sa,f sdf lkndf aslfasdf asdfj nafHoalfölamdasdfs sa,f sdf lkndf aslfasdf asdfj nafHoalfölamdasdfs sa,f sdf lkndf aslfasdf asdfj nafHoalfölamdasdfs sa,f sdf lkndf aslfasdf asdfj nafHoalfölamdasdfs sa,f sdf lkndf aslfasdf asdfj naf', '2023-04-13 06:37:53', '2023-04-13 06:37:53'),
(24, 'holaaa', 'asdfsdg', '/data/user/0/com.example.users_login_db/cache/950c8778-ed32-4633-9080-216b610111233658712043851117278.jpg', 9, 5, 0, '', '2023-04-12 09:25:31', '2023-04-14 06:43:44'),
(25, 'zfg', 'zdfgzsdg', '/data/user/0/com.example.users_login_db/cache/d02580af-f066-435d-bb88-502b48a80ee03110766446731857474.jpg', 9, 5, 0, '', '2023-04-12 09:25:39', '2023-04-12 09:25:39'),
(26, 'dsfg', 'afgdfg', '/data/user/0/com.example.users_login_db/cache/a40395c2-d036-4050-8641-b1cd848e22a37580782140432008255.jpg', 9, 7, 0, '', '2023-04-13 06:43:05', '2023-04-17 10:27:50'),
(27, 'cvfvdfv', 'xvvfvfv', '/data/user/0/com.example.users_login_db/cache/c80d627c-c2c5-4d24-a963-5093d3ec8c77692885291244241819.jpg', 9, 2, 0, '', '2023-04-14 05:09:44', '2023-04-14 05:09:44'),
(29, 'Ya he cocinado cosas', 'Para hacer esta tarea he tenido que hacer muchas cosas como cocinara y esas vainas jejeje.', '/data/user/0/com.example.users_login_db/cache/c80d627c-c2c5-4d24-a963-5093d3ec8c77692885291244241819.jpg', 9, 8, 5, 'Muy bien hecho!!', '2023-04-19 03:55:26', '2023-04-19 04:18:59'),
(31, 'fghjfghj', 'fghjfghj', '/data/user/0/com.example.users_login_db/cache/-task.jpg', 9, 11, 0, NULL, '2023-04-25 07:30:58', '2023-04-25 07:30:58'),
(32, 'gnkjfngd', 'dfhfgmhflgmh äfdgh', '/data/user/0/com.example.users_login_db/cache/04ef2686-ce7a-4b28-bd25-0e583b13ca3f6609406175737893195.jpg', 32, 12, 4, 'cvnjvcbncv bn vcgjb cvb', '2023-05-12 09:30:05', '2023-05-12 07:30:53');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `date_end` date NOT NULL,
  `user_teacher_id` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `group_id` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `title`, `description`, `date_end`, `user_teacher_id`, `group_id`, `created_at`, `updated_at`) VALUES
(1, 'Create html2', 'ölfaösd fjasödf jsadfj sadgjkasdhglasjkd fjkas ldkfj askjdgkjsdg asdf', '2023-04-13', 2, 1, '2023-04-06 04:19:52', '2023-04-06 04:20:17'),
(2, 'fdgjdfg', 'jdfgjdfghj', '2023-04-21', 2, 1, '2023-04-06 04:35:37', '2023-04-06 04:35:37'),
(3, 'lkasndflnsad2', 'klsadnölskadnfskladfnöskla d', '2023-04-13', 2, 2, '2023-04-06 04:42:14', '2023-04-06 04:42:28'),
(4, 'fhsuiafhsiaudh', 'iosjdgöoifjd gösdjf gölskd fgjskld fö df gsdfg', '2023-04-15', 2, 1, '2023-04-11 04:04:25', '2023-04-11 04:04:25'),
(5, 'ghjfghj', 'gdhjfghjfgh', '2023-04-14', 2, 2, '2023-04-12 06:30:33', '2023-04-12 06:30:33'),
(6, 'jhlghjkl', 'ghjlghjlg', '2023-04-05', 2, 2, '2023-04-12 06:30:40', '2023-04-12 06:30:40'),
(7, 'yeyeyeyyeyeyee', 'fkjasd fjasd fjasdlk jöaskld öfakl jöskld jölaskdfjsklödfjasö lkjfdökl jas ghu dfj nkg', '2023-04-28', 2, 2, '2023-04-13 04:40:16', '2023-04-13 04:40:16'),
(8, 'Cocinar', 'Hay que cocinar cosas', '2023-04-23', 2, 3, '2023-04-18 03:49:00', '2023-04-18 03:49:00'),
(9, 'Hornear', 'Hay que hornear cosas', '2023-05-05', 2, 3, '2023-04-18 03:49:19', '2023-04-25 07:18:25'),
(10, 'Precalentar', 'Hay que precalentar cosas', '2023-04-13', 2, 3, '2023-04-18 03:49:46', '2023-04-18 07:02:47'),
(11, 'hjkgh', 'jkghjkghjk', '2023-05-04', 2, 3, '2023-04-25 07:30:37', '2023-04-25 07:30:37'),
(12, 'Make a website', 'diof sdflskdn glkfj gdölk fnsdölf gs', '2023-05-25', 33, 6, '2023-05-12 07:27:00', '2023-05-12 07:27:00'),
(13, 'llkfdndfg', 'hdfghdfj', '2023-05-23', 33, 6, '2023-05-12 07:32:15', '2023-05-12 07:33:26');

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
  `rol` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `rol`, `remember_token`, `created_at`, `updated_at`) VALUES
(2, 'Pepe', 'pepe@gmail.com', NULL, '$2y$10$MbEM5/aelYW/adDAdnn5wuTTVo9zrK7oaiUJzBwH0H2MMbOCvPsiC', 'teacher', NULL, '2023-04-06 04:09:18', '2023-04-06 04:09:18'),
(8, 'Paco', 'paco@gmail.com', NULL, '$2y$10$YEEez.HhaxcY.c1YjudP/eaoT5EIypQ2xXsCRFrTrpmfCxTuBTzNq', 'alumn', NULL, '2023-04-11 07:15:47', '2023-04-11 07:15:47'),
(9, 'Pau', 'pau@gmail.com', NULL, '$2y$10$OoHl..dImU1/995FBfe3xe0uuS9yi33Ch0hC/UEUajMaETDeaO7Gq', 'alumn', NULL, '2023-04-12 06:52:00', '2023-04-12 06:52:00'),
(30, '24', '24@gmail.com', NULL, '$2y$10$tlXtpIEPgVLBFGjzCPmA4O3RaBTzUIouBJIs0GxuvYoAdCUKmnwJG', 'alumn', NULL, '2023-04-21 06:02:08', '2023-04-21 06:02:08'),
(31, 'Jose Enrique', 'josepe@gmail.com', NULL, '$2y$10$SVwG9r7.04ZR9EaINvvamuubPbmC9/PU3oHgMaup9YH/4Xf8za7Ty', 'alumn', NULL, '2023-04-21 06:10:28', '2023-04-21 06:10:28'),
(32, 'hey', 'hey@gmail.com', NULL, '$2y$10$CXqLwcwevd3NDCgFla6R6.66XxvU7eOoO/9EVmw9QoI3uguQLcEyW', 'alumn', NULL, '2023-05-12 09:18:23', '2023-05-12 09:18:23'),
(33, 'heidi', 'heidi@gmail.com', NULL, '$2y$10$oxJLja0Q/b6pZ0ypAYKuj.E5kloP4/5UtSVA408Q0ben70YVkATJ6', 'teacher', NULL, '2023-05-12 07:24:01', '2023-05-12 07:24:01');

-- --------------------------------------------------------

--
-- Table structure for table `user_group`
--

CREATE TABLE `user_group` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `groups_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_group`
--

INSERT INTO `user_group` (`user_id`, `groups_id`) VALUES
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(8, 2),
(9, 1),
(9, 2),
(9, 3),
(32, 6),
(33, 6);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `groups_user_teacher_id_foreign` (`user_teacher_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `own_tasks`
--
ALTER TABLE `own_tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `student_tasks`
--
ALTER TABLE `student_tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_tasks_student_id_foreign` (`student_id`),
  ADD KEY `student_tasks_task_id_foreign` (`task_id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tasks_user_teacher_id_foreign` (`user_teacher_id`),
  ADD KEY `tasks_group_id_foreign` (`group_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`user_id`,`groups_id`),
  ADD KEY `user_group_groups_id_foreign` (`groups_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `own_tasks`
--
ALTER TABLE `own_tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_tasks`
--
ALTER TABLE `student_tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_user_teacher_id_foreign` FOREIGN KEY (`user_teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `own_tasks`
--
ALTER TABLE `own_tasks`
  ADD CONSTRAINT `own_tasks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `own_tasks_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`);

--
-- Constraints for table `student_tasks`
--
ALTER TABLE `student_tasks`
  ADD CONSTRAINT `student_tasks_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_tasks_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_user_teacher_id_foreign` FOREIGN KEY (`user_teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_group`
--
ALTER TABLE `user_group`
  ADD CONSTRAINT `user_group_groups_id_foreign` FOREIGN KEY (`groups_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_group_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
