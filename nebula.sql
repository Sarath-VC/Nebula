-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 10, 2018 at 09:08 PM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nebula`
--

-- --------------------------------------------------------

--
-- Table structure for table `cloud`
--

CREATE TABLE `cloud` (
  `cloud_id` int(11) NOT NULL,
  `host` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cloud`
--

INSERT INTO `cloud` (`cloud_id`, `host`, `username`, `password`, `type`) VALUES
(1, '192.168.43.100', 'root', 'root', 'main'),
(2, '192.168.43.209', 'root', 'root', 'sub');

-- --------------------------------------------------------

--
-- Table structure for table `db`
--

CREATE TABLE `db` (
  `db_id` int(11) NOT NULL,
  `db_name` varchar(50) NOT NULL,
  `db_status` varchar(10) NOT NULL DEFAULT 'available'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `db`
--

INSERT INTO `db` (`db_id`, `db_name`, `db_status`) VALUES
(1, 'prison', 'available');

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `log_id` int(11) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cloud_id` int(11) NOT NULL,
  `db_id` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`log_id`, `datetime`, `cloud_id`, `db_id`) VALUES
(2, '2018-04-10 20:19:27', 1, 1),
(3, '2018-04-10 20:20:38', 2, 1),
(4, '2018-04-10 20:22:10', 1, 1),
(5, '2018-04-10 20:23:41', 2, 1),
(6, '2018-04-10 20:32:03', 1, 1),
(7, '2018-04-10 20:37:33', 2, 1),
(8, '2018-04-10 20:43:02', 1, 1),
(9, '2018-04-10 20:48:36', 2, 1),
(10, '2018-04-10 20:54:06', 1, 1),
(11, '2018-04-10 20:59:35', 2, 1),
(12, '2018-04-10 21:05:04', 1, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cloud`
--
ALTER TABLE `cloud`
  ADD PRIMARY KEY (`cloud_id`);

--
-- Indexes for table `db`
--
ALTER TABLE `db`
  ADD PRIMARY KEY (`db_id`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`log_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cloud`
--
ALTER TABLE `cloud`
  MODIFY `cloud_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `db`
--
ALTER TABLE `db`
  MODIFY `db_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
