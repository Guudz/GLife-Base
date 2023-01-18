-- Leak By SinLoww#2191
-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : mar. 31 août 2021 à 13:00
-- Version du serveur : 10.3.29-MariaDB-0+deb10u1
-- Version de PHP : 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `oliann`
--

-- --------------------------------------------------------

--
-- Structure de la table `accounts_panel`
--

CREATE TABLE `accounts_panel` (
  `id` int(11) NOT NULL,
  `steamhex` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `last_connection` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `banking_account`
--

CREATE TABLE `banking_account` (
  `id` int(11) NOT NULL,
  `label` varchar(50) NOT NULL DEFAULT '0',
  `uuid` varchar(255) NOT NULL DEFAULT '0',
  `coowner` longtext DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `iban` longtext DEFAULT NULL,
  `todayratio` varchar(255) DEFAULT '{"remove":0,"deposit":0,"maxRemove":5000,"maxDeposit":5000}',
  `phone_number` int(11) DEFAULT NULL,
  `bloqued` varchar(50) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Déchargement des données de la table `banking_account`
--

INSERT INTO `banking_account` (`id`, `label`, `uuid`, `coowner`, `amount`, `iban`, `todayratio`, `phone_number`, `bloqued`) VALUES
(84, 'Compte LSMS', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, 72249, 'lsms', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(85, 'Compte LS Custom', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, 35523, 'mecano', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(86, 'Compte FlyWheels', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, -799950, 'mecano2', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(87, 'Compte Banquier', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, 370909, 'banker', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(88, 'Compte Epicier', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, 0, 'ltd', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(89, 'Compte Coiffeur', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, 4150, 'coiffeur', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(90, 'Compte Tatoueur', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, 0, 'tatoueur', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(91, 'Compte MerryWeather', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, 0, 'merrywheather', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(92, 'Compte Raffinerie', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, 0, 'raffinerie', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(93, 'Compte Concess Avion', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, 0, 'bikershop', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(94, 'Compte Concess', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, 144936, 'concess', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(95, 'Compte Agent Immo', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, 0, 'immo', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(96, 'Compte Unicorn', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, 6500, 'unicorn', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(97, 'Compte LSPD', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, 55934, 'police', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(98, 'Compte Gouvernement', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, 55619, 'gouv', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '1'),
(99, 'Compte Avocat', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, 0, 'avocat', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(100, 'Compte Taxi', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, -11200, 'taxi', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(101, 'Compte Ammunation', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, 8502, 'ammunation', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(102, 'Compte Journaliste', '1ebc03d8-60e8-6a50-b203-57f8ce04f5e8', NULL, 0, 'journaliste', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0'),
(103, 'Compte NightClub', '1ebc05d7-2778-68a0-a416-c4b1d8cf5468', NULL, 10, 'night', '{\"remove\": 0, \"deposit\": 0, \"maxRemove\": 5000, \"maxDeposit\": 5000}', NULL, '0');

-- --------------------------------------------------------

--
-- Structure de la table `banking_cards`
--

CREATE TABLE `banking_cards` (
  `id` int(11) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `uuid` varchar(50) DEFAULT NULL,
  `account` int(11) DEFAULT NULL,
  `code` int(11) DEFAULT NULL,
  `number` varchar(50) NOT NULL DEFAULT '0',
  `current_ratio` varchar(120) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `banking_prets`
--

CREATE TABLE `banking_prets` (
  `id` int(11) NOT NULL,
  `label` varchar(50) NOT NULL DEFAULT '0',
  `account` int(11) NOT NULL DEFAULT 0,
  `total` int(11) NOT NULL DEFAULT 0,
  `current` int(11) NOT NULL DEFAULT 0,
  `percent` int(11) NOT NULL DEFAULT 0,
  `amount` int(11) NOT NULL DEFAULT 0,
  `base_amount` int(11) NOT NULL DEFAULT 0,
  `type` int(2) NOT NULL DEFAULT 0,
  `date` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `banking_transactions`
--

CREATE TABLE `banking_transactions` (
  `id` int(11) NOT NULL,
  `src` varchar(50) DEFAULT NULL,
  `dest` varchar(50) DEFAULT NULL,
  `montant` varchar(50) DEFAULT NULL,
  `details` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `crew`
--

CREATE TABLE `crew` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `identifier` varchar(100) DEFAULT NULL,
  `grade` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `criminal_records`
--

CREATE TABLE `criminal_records` (
  `id` int(11) NOT NULL,
  `title` int(11) NOT NULL DEFAULT 0,
  `author` varchar(255) NOT NULL DEFAULT '0',
  `desc` varchar(255) NOT NULL DEFAULT '0',
  `coupable` varchar(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `darknet_messages`
--

CREATE TABLE `darknet_messages` (
  `id` int(11) NOT NULL,
  `src` varchar(50) NOT NULL DEFAULT '0',
  `dest` varchar(50) NOT NULL DEFAULT '0',
  `content` longtext NOT NULL,
  `date` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `dpkeybinds`
--

CREATE TABLE `dpkeybinds` (
  `id` varchar(50) DEFAULT NULL,
  `keybind1` varchar(50) DEFAULT 'num4',
  `emote1` varchar(255) DEFAULT '',
  `keybind2` varchar(50) DEFAULT 'num5',
  `emote2` varchar(255) DEFAULT '',
  `keybind3` varchar(50) DEFAULT 'num6',
  `emote3` varchar(255) DEFAULT '',
  `keybind4` varchar(50) DEFAULT 'num7',
  `emote4` varchar(255) DEFAULT '',
  `keybind5` varchar(50) DEFAULT 'num8',
  `emote5` varchar(255) DEFAULT '',
  `keybind6` varchar(50) DEFAULT 'num9',
  `emote6` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `lotery`
--

CREATE TABLE `lotery` (
  `id` int(11) NOT NULL,
  `participants` longtext NOT NULL,
  `winner_number` int(11) NOT NULL DEFAULT 0,
  `winners` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `mailing`
--

CREATE TABLE `mailing` (
  `id` int(11) NOT NULL,
  `mailTo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `mailFrom` varchar(255) NOT NULL DEFAULT '0',
  `expeditor` varchar(255) NOT NULL DEFAULT '0',
  `receiver` varchar(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `migration`
--

CREATE TABLE `migration` (
  `id` int(11) NOT NULL,
  `migration_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `motos_sold`
--

CREATE TABLE `motos_sold` (
  `id` int(11) NOT NULL,
  `buyer` varchar(50) NOT NULL DEFAULT '0',
  `model` varchar(50) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `prices` varchar(50) NOT NULL DEFAULT '0',
  `vendor` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `phone_app_chat`
--

CREATE TABLE `phone_app_chat` (
  `id` int(11) NOT NULL,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `phone_calls`
--

CREATE TABLE `phone_calls` (
  `id` int(11) NOT NULL,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `phone_messages`
--

CREATE TABLE `phone_messages` (
  `id` int(11) NOT NULL,
  `transmitter` varchar(10) DEFAULT NULL,
  `receiver` varchar(10) DEFAULT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `phone_users_contacts`
--

CREATE TABLE `phone_users_contacts` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `players_appartement`
--

CREATE TABLE `players_appartement` (
  `id` int(11) NOT NULL,
  `capacity` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `pos` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `indexx` int(11) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `coowner` text DEFAULT NULL,
  `table_index` int(11) DEFAULT NULL,
  `time` bigint(11) DEFAULT NULL,
  `garagePos` varchar(255) DEFAULT NULL,
  `garageMax` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `players_appearance`
--

CREATE TABLE `players_appearance` (
  `id` int(11) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL DEFAULT 'mp_m_freemode_01',
  `face` text DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `tattoo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `players_bans`
--

CREATE TABLE `players_bans` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `moderator` varchar(50) NOT NULL DEFAULT '0',
  `unbandate` varchar(50) NOT NULL DEFAULT '0',
  `date` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `players_computer_accounts`
--

CREATE TABLE `players_computer_accounts` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL DEFAULT '0',
  `password` varchar(255) NOT NULL DEFAULT '0',
  `perms` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `players_identity`
--

CREATE TABLE `players_identity` (
  `id` int(11) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `face_picutre` text NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `birth_date` text NOT NULL,
  `origine` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `players_inventory`
--

CREATE TABLE `players_inventory` (
  `id` int(11) DEFAULT NULL,
  `uuid` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `inventory` longtext COLLATE utf8mb4_bin NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `players_jobs`
--

CREATE TABLE `players_jobs` (
  `id` int(11) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `name` text NOT NULL,
  `rank` int(11) NOT NULL,
  `orga` text DEFAULT NULL,
  `orga_rank` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `players_labo`
--

CREATE TABLE `players_labo` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `capacity` varchar(50) DEFAULT NULL,
  `entry` varchar(250) DEFAULT NULL,
  `indexx` int(11) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `coowner` varchar(255) DEFAULT NULL,
  `current` varchar(255) DEFAULT NULL,
  `workers` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `players_needs`
--

CREATE TABLE `players_needs` (
  `id` int(11) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `food` int(11) NOT NULL,
  `drink` int(11) NOT NULL,
  `sickness` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `players_parking`
--

CREATE TABLE `players_parking` (
  `id` int(11) NOT NULL,
  `garage` varchar(50) NOT NULL DEFAULT '0',
  `vehicles` longtext NOT NULL,
  `uuid` varchar(255) NOT NULL DEFAULT '0',
  `label` varchar(50) NOT NULL DEFAULT '0',
  `plate` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `players_settings`
--

CREATE TABLE `players_settings` (
  `id` int(11) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `bind` text NOT NULL,
  `colors` text NOT NULL,
  `outfit` text NOT NULL,
  `farm_limit` int(11) NOT NULL,
  `demarche` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `players_vehicles`
--

CREATE TABLE `players_vehicles` (
  `id` int(11) NOT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `settings` longtext DEFAULT NULL,
  `data` varchar(255) NOT NULL DEFAULT '',
  `pound` tinyint(1) DEFAULT 0,
  `label` varchar(50) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `players_warns`
--

CREATE TABLE `players_warns` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `moderator` varchar(50) NOT NULL DEFAULT '0',
  `date` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `players_weapon`
--

CREATE TABLE `players_weapon` (
  `id` int(11) NOT NULL,
  `serial` int(11) NOT NULL DEFAULT 0,
  `weapon_name` varchar(50) NOT NULL DEFAULT '0',
  `user` varchar(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `ranking_crew`
--

CREATE TABLE `ranking_crew` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `members` int(11) DEFAULT 1,
  `kills` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `server_logs`
--

CREATE TABLE `server_logs` (
  `id` int(11) NOT NULL,
  `data` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `storages_inventory_accounts`
--

CREATE TABLE `storages_inventory_accounts` (
  `id` int(11) NOT NULL,
  `money` int(11) NOT NULL DEFAULT 0,
  `dark_money` int(11) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `storages_inventory_items`
--

CREATE TABLE `storages_inventory_items` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `itemName` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `metadata` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `label` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `type` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `storages_inventory_items2`
--

CREATE TABLE `storages_inventory_items2` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `storage_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qty` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `twitter_accounts`
--

CREATE TABLE `twitter_accounts` (
  `id` int(11) NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `twitter_likes`
--

CREATE TABLE `twitter_likes` (
  `id` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `twitter_tweets`
--

CREATE TABLE `twitter_tweets` (
  `id` int(11) NOT NULL,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `position` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `food` int(11) DEFAULT 100,
  `thirst` int(11) DEFAULT 100,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `money` int(11) DEFAULT 1500,
  `black_money` int(11) DEFAULT 0,
  `permission_level` int(11) DEFAULT 0,
  `xp` int(11) DEFAULT 0,
  `group` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `phone_number` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL,
  `farm_limit` int(8) DEFAULT 0,
  `strength` int(11) NOT NULL DEFAULT 0,
  `colors` varchar(255) COLLATE utf8mb4_bin DEFAULT '[]',
  `demarche` int(11) NOT NULL DEFAULT 1,
  `binds` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `vehicles_sold`
--

CREATE TABLE `vehicles_sold` (
  `id` int(11) NOT NULL,
  `buyer` varchar(50) DEFAULT '0',
  `model` varchar(50) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `prices` varchar(50) NOT NULL DEFAULT '0',
  `vendor` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `vehicles_sold_nord`
--

CREATE TABLE `vehicles_sold_nord` (
  `id` int(11) NOT NULL,
  `buyer` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '0',
  `model` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `plate` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `prices` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '0',
  `vendor` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `date` varchar(50) CHARACTER SET latin1 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `waveshield_ban`
--

CREATE TABLE `waveshield_ban` (
  `license` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `identifier` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `targetplayername` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `sourceplayername` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `timeat` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `expiration` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `permanent` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `whitelist`
--

CREATE TABLE `whitelist` (
  `id` int(11) NOT NULL,
  `identifier` text NOT NULL,
  `character_count` int(11) NOT NULL DEFAULT 0,
  `character_limit` int(1) NOT NULL DEFAULT 1,
  `permanent_ban` tinyint(1) DEFAULT 0,
  `ban_expire_at` int(11) DEFAULT NULL,
  `reason` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `accounts_panel`
--
ALTER TABLE `accounts_panel`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `banking_account`
--
ALTER TABLE `banking_account`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uuid` (`uuid`);

--
-- Index pour la table `banking_cards`
--
ALTER TABLE `banking_cards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uuid` (`uuid`),
  ADD KEY `account` (`account`);

--
-- Index pour la table `banking_prets`
--
ALTER TABLE `banking_prets`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `banking_transactions`
--
ALTER TABLE `banking_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `src` (`src`),
  ADD KEY `dest` (`dest`);

--
-- Index pour la table `crew`
--
ALTER TABLE `crew`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `darknet_messages`
--
ALTER TABLE `darknet_messages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `dest` (`dest`);

--
-- Index pour la table `lotery`
--
ALTER TABLE `lotery`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `mailing`
--
ALTER TABLE `mailing`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `migration`
--
ALTER TABLE `migration`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `motos_sold`
--
ALTER TABLE `motos_sold`
  ADD PRIMARY KEY (`id`),
  ADD KEY `buyer` (`buyer`),
  ADD KEY `vendor` (`vendor`);

--
-- Index pour la table `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_calls`
--
ALTER TABLE `phone_calls`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`),
  ADD KEY `num` (`num`);

--
-- Index pour la table `phone_messages`
--
ALTER TABLE `phone_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transmitter` (`transmitter`),
  ADD KEY `receiver` (`receiver`),
  ADD KEY `time` (`time`);

--
-- Index pour la table `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `players_appartement`
--
ALTER TABLE `players_appartement`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Index pour la table `players_appearance`
--
ALTER TABLE `players_appearance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uuid` (`uuid`);

--
-- Index pour la table `players_bans`
--
ALTER TABLE `players_bans`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `players_computer_accounts`
--
ALTER TABLE `players_computer_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `players_identity`
--
ALTER TABLE `players_identity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uuid` (`uuid`);

--
-- Index pour la table `players_inventory`
--
ALTER TABLE `players_inventory`
  ADD KEY `uuid` (`uuid`),
  ADD KEY `id` (`id`);

--
-- Index pour la table `players_jobs`
--
ALTER TABLE `players_jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uuid` (`uuid`);

--
-- Index pour la table `players_labo`
--
ALTER TABLE `players_labo`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `players_needs`
--
ALTER TABLE `players_needs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `players_parking`
--
ALTER TABLE `players_parking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plate` (`plate`);

--
-- Index pour la table `players_settings`
--
ALTER TABLE `players_settings`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `players_vehicles`
--
ALTER TABLE `players_vehicles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uuid` (`uuid`),
  ADD KEY `plate` (`plate`);

--
-- Index pour la table `players_warns`
--
ALTER TABLE `players_warns`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `players_weapon`
--
ALTER TABLE `players_weapon`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Index pour la table `ranking_crew`
--
ALTER TABLE `ranking_crew`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `server_logs`
--
ALTER TABLE `server_logs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `storages_inventory_accounts`
--
ALTER TABLE `storages_inventory_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `storages_inventory_items`
--
ALTER TABLE `storages_inventory_items`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `storages_inventory_items2`
--
ALTER TABLE `storages_inventory_items2`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_storage_item` (`storage_name`,`item_name`);

--
-- Index pour la table `twitter_accounts`
--
ALTER TABLE `twitter_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Index pour la table `twitter_likes`
--
ALTER TABLE `twitter_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  ADD KEY `FK_twitter_likes_twitter_tweets` (`tweetId`);

--
-- Index pour la table `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_twitter_tweets_twitter_accounts` (`authorId`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uuid` (`uuid`),
  ADD KEY `identifier` (`identifier`);

--
-- Index pour la table `vehicles_sold`
--
ALTER TABLE `vehicles_sold`
  ADD PRIMARY KEY (`id`),
  ADD KEY `buyer` (`buyer`),
  ADD KEY `plate` (`plate`),
  ADD KEY `vendor` (`vendor`);

--
-- Index pour la table `vehicles_sold_nord`
--
ALTER TABLE `vehicles_sold_nord`
  ADD PRIMARY KEY (`id`),
  ADD KEY `buyer` (`buyer`),
  ADD KEY `plate` (`plate`),
  ADD KEY `vendor` (`vendor`);

--
-- Index pour la table `waveshield_ban`
--
ALTER TABLE `waveshield_ban`
  ADD PRIMARY KEY (`license`);

--
-- Index pour la table `whitelist`
--
ALTER TABLE `whitelist`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `accounts_panel`
--
ALTER TABLE `accounts_panel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `banking_account`
--
ALTER TABLE `banking_account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `banking_cards`
--
ALTER TABLE `banking_cards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `banking_prets`
--
ALTER TABLE `banking_prets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `banking_transactions`
--
ALTER TABLE `banking_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `crew`
--
ALTER TABLE `crew`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `darknet_messages`
--
ALTER TABLE `darknet_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `lotery`
--
ALTER TABLE `lotery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `mailing`
--
ALTER TABLE `mailing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `migration`
--
ALTER TABLE `migration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `motos_sold`
--
ALTER TABLE `motos_sold`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_calls`
--
ALTER TABLE `phone_calls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_messages`
--
ALTER TABLE `phone_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `players_appartement`
--
ALTER TABLE `players_appartement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `players_appearance`
--
ALTER TABLE `players_appearance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `players_bans`
--
ALTER TABLE `players_bans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `players_computer_accounts`
--
ALTER TABLE `players_computer_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `players_identity`
--
ALTER TABLE `players_identity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `players_jobs`
--
ALTER TABLE `players_jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `players_labo`
--
ALTER TABLE `players_labo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `players_needs`
--
ALTER TABLE `players_needs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `players_parking`
--
ALTER TABLE `players_parking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `players_settings`
--
ALTER TABLE `players_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `players_vehicles`
--
ALTER TABLE `players_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `players_warns`
--
ALTER TABLE `players_warns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `players_weapon`
--
ALTER TABLE `players_weapon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `ranking_crew`
--
ALTER TABLE `ranking_crew`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `server_logs`
--
ALTER TABLE `server_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `storages_inventory_accounts`
--
ALTER TABLE `storages_inventory_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `storages_inventory_items`
--
ALTER TABLE `storages_inventory_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `storages_inventory_items2`
--
ALTER TABLE `storages_inventory_items2`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `twitter_accounts`
--
ALTER TABLE `twitter_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `twitter_likes`
--
ALTER TABLE `twitter_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `vehicles_sold`
--
ALTER TABLE `vehicles_sold`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `vehicles_sold_nord`
--
ALTER TABLE `vehicles_sold_nord`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `whitelist`
--
ALTER TABLE `whitelist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `twitter_likes`
--
ALTER TABLE `twitter_likes`
  ADD CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  ADD CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  ADD CONSTRAINT `FK_twitter_tweets_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
