-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 13, 2018 at 09:07 AM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `prison`
--

-- --------------------------------------------------------

--
-- Table structure for table `block`
--

CREATE TABLE `block` (
  `block_id` int(5) NOT NULL,
  `p_id` int(5) NOT NULL,
  `block_name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `block`
--

INSERT INTO `block` (`block_id`, `p_id`, `block_name`) VALUES
(1, 1, 'NorthBlock'),
(2, 1, 'EastBlock'),
(3, 1, 'SouthBlock'),
(4, 1, 'WestBlock'),
(5, 1, 'MainBlock'),
(6, 4, 'ABlock'),
(7, 4, 'BBlock'),
(8, 4, 'CBlock'),
(9, 2, 'MainBlock'),
(10, 2, 'NewBlock'),
(11, 2, 'SWBlock');

-- --------------------------------------------------------

--
-- Table structure for table `cases`
--

CREATE TABLE `cases` (
  `case_id` int(5) NOT NULL,
  `case_name` varchar(50) NOT NULL,
  `case_discription` varchar(10000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cases`
--

INSERT INTO `cases` (`case_id`, `case_name`, `case_discription`) VALUES
(1, 'Theft', 'IPC 301 3 MONTH PRISONING ,Fine=2000'),
(2, 'MURDER', 'IPC 102,103 Imprisonment of 14 years and Hang to Death');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `cat_id` int(5) NOT NULL,
  `cat_category` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`cat_id`, `cat_category`) VALUES
(1, 'CENTRAL JAIL'),
(2, 'SUB JAIL'),
(3, 'DISTRICT JAIL'),
(4, 'OPEN JAIL');

-- --------------------------------------------------------

--
-- Table structure for table `cell`
--

CREATE TABLE `cell` (
  `cell_id` int(5) NOT NULL,
  `block_id` int(5) NOT NULL,
  `cell_num` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cell`
--

INSERT INTO `cell` (`cell_id`, `block_id`, `cell_num`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6);

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `eve_id` int(5) NOT NULL,
  `eve_name` varchar(100) NOT NULL,
  `eve_description` varchar(1000) NOT NULL,
  `eve_date` date NOT NULL,
  `eve_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`eve_id`, `eve_name`, `eve_description`, `eve_date`, `eve_time`) VALUES
(1, 'Indipendence day', 'flag off', '2018-08-15', '11:00:00'),
(3, 'Gandhi Jayanthi', 'gandhi anusmaranam', '2018-10-02', '10:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `login_id` int(5) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(20) NOT NULL,
  `user_type` varchar(5) NOT NULL,
  `login_flag` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`login_id`, `username`, `password`, `user_type`, `login_flag`) VALUES
(1, 'admin', 'newadmin', 'ADMIN', 2),
(4, 'sasidaranm@gmail.com', 'sasisasi', 'USER', 1),
(5, 'cristicristina@gmail.com', '8utfeehh', 'USER', 1);

-- --------------------------------------------------------

--
-- Table structure for table `logtype`
--

CREATE TABLE `logtype` (
  `logtype_id` int(5) NOT NULL,
  `logtype_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logtype`
--

INSERT INTO `logtype` (`logtype_id`, `logtype_name`) VALUES
(1, 'PAROLE'),
(2, 'COURT APPEARANCE'),
(3, 'MEDICAL'),
(4, 'OTHERS');

-- --------------------------------------------------------

--
-- Table structure for table `prisonerchild`
--

CREATE TABLE `prisonerchild` (
  `pc_id` int(5) NOT NULL,
  `pm_id` int(5) NOT NULL,
  `case_id` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prisonerduty`
--

CREATE TABLE `prisonerduty` (
  `pd_id` int(5) NOT NULL,
  `pm_id` int(5) NOT NULL,
  `pd_date` date NOT NULL,
  `pd_time` time NOT NULL,
  `pd_type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prisonerlog`
--

CREATE TABLE `prisonerlog` (
  `pl_id` int(5) NOT NULL,
  `pm_id` int(5) NOT NULL,
  `logtype_id` int(5) NOT NULL,
  `pl_exitdate` date NOT NULL,
  `pl_exittime` time NOT NULL,
  `pl_entrydate` date NOT NULL,
  `pl_entrytime` time NOT NULL,
  `pl_status` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `prisonerlog`
--

INSERT INTO `prisonerlog` (`pl_id`, `pm_id`, `logtype_id`, `pl_exitdate`, `pl_exittime`, `pl_entrydate`, `pl_entrytime`, `pl_status`) VALUES
(1, 1, 2, '2018-02-12', '10:35:00', '2018-06-12', '13:00:00', 'COMPLETED'),
(3, 5, 3, '2018-03-19', '13:00:00', '2018-03-20', '13:00:00', 'ACTIVE'),
(4, 5, 2, '2018-03-22', '14:00:00', '2019-01-01', '13:00:00', 'ACTIVE');

-- --------------------------------------------------------

--
-- Table structure for table `prisonermaster`
--

CREATE TABLE `prisonermaster` (
  `pm_id` int(5) NOT NULL,
  `pm_fname` varchar(100) NOT NULL,
  `pm_mname` varchar(100) DEFAULT NULL,
  `pm_lname` varchar(100) NOT NULL,
  `pm_gender` varchar(10) NOT NULL,
  `pm_dob` date NOT NULL,
  `pm_house` varchar(100) NOT NULL,
  `pm_post` varchar(100) NOT NULL,
  `pm_city` varchar(100) NOT NULL,
  `pm_district` varchar(100) NOT NULL,
  `pm_state` varchar(100) NOT NULL,
  `pm_pin` varchar(10) NOT NULL,
  `pm_contact` varchar(10) NOT NULL,
  `cell_id` int(5) NOT NULL,
  `pm_entry` date NOT NULL,
  `pm_release` date NOT NULL,
  `pm_flag` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prisons`
--

CREATE TABLE `prisons` (
  `p_id` int(5) NOT NULL,
  `p_name` varchar(150) NOT NULL,
  `cat_id` int(5) NOT NULL,
  `p_post` varchar(150) NOT NULL,
  `p_city` varchar(150) NOT NULL,
  `p_district` varchar(150) NOT NULL,
  `p_state` varchar(150) NOT NULL,
  `p_pin` varchar(10) NOT NULL,
  `p_contact` varchar(10) NOT NULL,
  `p_email` varchar(50) NOT NULL,
  `p_flag` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `prisons`
--

INSERT INTO `prisons` (`p_id`, `p_name`, `cat_id`, `p_post`, `p_city`, `p_district`, `p_state`, `p_pin`, `p_contact`, `p_email`, `p_flag`) VALUES
(1, 'Kannur Central Jail ', 1, 'Pallikunnu', 'Kannur', 'Kannur', 'Kerala', '670004', '4972746141', 'kannurcentraljail@gmail.com', 1),
(2, 'Poojappura Central Jail', 1, 'Poojappura', 'Poojappura', 'Thiruvanathapuram', 'Kerala', '695012', '4712342138', 'poojapuracentraljail@gmail.com', 1),
(3, 'Viyyur Central Jail ', 1, 'Viyyur', 'Viyyur', 'Thrissur', 'Kerala', '680010', '4872334267', 'viyyurjail@gmail.com', 1),
(4, 'Vadakara Sub Jail', 2, 'Badagara', 'Vadakara', 'Kozhicode', 'Kerala', '673104', '4962522975', 'vadakarasubjail@gmail.com', 1),
(5, 'Kakkanada District Jail', 3, 'Chittethukara', 'Kakkanad', 'Ernakulam', 'Kerala', '682037', '4842428520', 'districtjailernakulam@gmail.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(5) NOT NULL,
  `staff_fname` varchar(100) NOT NULL,
  `staff_mname` varchar(100) DEFAULT NULL,
  `staff_lname` varchar(100) DEFAULT NULL,
  `staff_gender` varchar(6) NOT NULL,
  `staff_dob` date NOT NULL,
  `staff_house` varchar(100) NOT NULL,
  `staff_post` varchar(100) NOT NULL,
  `staff_city` varchar(100) NOT NULL,
  `staff_district` varchar(100) NOT NULL,
  `staff_state` varchar(100) NOT NULL,
  `staff_pin` varchar(10) NOT NULL,
  `staff_contact` varchar(100) NOT NULL,
  `staff_email` varchar(100) NOT NULL,
  `staff_rank` varchar(100) NOT NULL,
  `p_id` int(5) NOT NULL,
  `staff_flag` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `staff_fname`, `staff_mname`, `staff_lname`, `staff_gender`, `staff_dob`, `staff_house`, `staff_post`, `staff_city`, `staff_district`, `staff_state`, `staff_pin`, `staff_contact`, `staff_email`, `staff_rank`, `p_id`, `staff_flag`) VALUES
(1, 'Kuttan', 'Pilla', 'P', 'Male', '1960-07-20', 'Pottakuzhi', 'Palarivattom', 'Palarivattom', 'Ernakulam', 'Kerala', '693636', '7236359419', 'kuttanpottakuzhi001@gmail.com', 'HEAD CONSTEBLE', 1, 1),
(2, 'Deenamma', 'George', 'Vargees', 'Female', '1978-06-22', 'Mekkattil', 'Ittammal', 'Pala', 'Kottayam', 'Kerala', '673232', '9897952361', 'denammadeenu@hotmail.com', 'CONSTEBLE', 1, 1),
(3, 'Aju', 'Vargees', 'C', 'Male', '1985-12-10', 'Cheriyattil', 'Palarivattom', 'Palarivattom', 'Ernakulam', 'Kerala', '633639', '6563698653', 'ajuaju@outlook.com', 'CONSTEBLE', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `staffduty`
--

CREATE TABLE `staffduty` (
  `sd_id` int(5) NOT NULL,
  `staff_id` int(5) NOT NULL,
  `sd_date` date NOT NULL,
  `sd_time` time NOT NULL,
  `sd_type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `userchild`
--

CREATE TABLE `userchild` (
  `u_id` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `p_id` int(5) NOT NULL,
  `u_flag` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userchild`
--

INSERT INTO `userchild` (`u_id`, `user_id`, `p_id`, `u_flag`) VALUES
(1, 1, 1, 1),
(2, 2, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `usermaster`
--

CREATE TABLE `usermaster` (
  `user_id` int(5) NOT NULL,
  `user_fname` varchar(50) NOT NULL,
  `user_mname` varchar(50) DEFAULT NULL,
  `user_lname` varchar(50) DEFAULT NULL,
  `user_gender` varchar(10) NOT NULL,
  `user_dob` varchar(10) NOT NULL,
  `user_house` varchar(100) NOT NULL,
  `user_post` varchar(50) NOT NULL,
  `user_city` varchar(50) NOT NULL,
  `user_district` varchar(50) NOT NULL,
  `user_state` varchar(50) NOT NULL,
  `user_pin` varchar(10) NOT NULL,
  `user_contact` varchar(15) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_rank` varchar(50) NOT NULL,
  `login_id` int(5) NOT NULL,
  `user_flag` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usermaster`
--

INSERT INTO `usermaster` (`user_id`, `user_fname`, `user_mname`, `user_lname`, `user_gender`, `user_dob`, `user_house`, `user_post`, `user_city`, `user_district`, `user_state`, `user_pin`, `user_contact`, `user_email`, `user_rank`, `login_id`, `user_flag`) VALUES
(1, 'Sasi', 'Dharan', 'M', 'Male', '1965-07-07', 'Manakkal', 'Pookkatupadi', 'Kochi', 'Ernakulam', 'Kerala', '672526', '9865321047', 'sasidaranm@gmail.com', 'SI', 4, 1),
(2, 'Cristina', 'Sebastian', 'T', 'Female', '1976-06-15', 'Thaikatt House', 'Westhill', 'Calicut', 'Kozhicode', 'Kerala', '673432', '8653921474', 'cristicristina@gmail.com', 'SI', 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `visitors`
--

CREATE TABLE `visitors` (
  `v_id` int(5) NOT NULL,
  `v_fname` varchar(100) NOT NULL,
  `v_mname` varchar(100) NOT NULL,
  `v_lname` varchar(100) NOT NULL,
  `v_dob` date DEFAULT NULL,
  `v_gender` varchar(10) NOT NULL,
  `v_house` varchar(100) NOT NULL,
  `v_post` varchar(100) NOT NULL,
  `v_city` varchar(100) NOT NULL,
  `v_district` varchar(100) NOT NULL,
  `v_state` varchar(100) NOT NULL,
  `v_pin` varchar(10) NOT NULL,
  `v_contact` varchar(10) NOT NULL,
  `pm_id` int(5) NOT NULL,
  `v_time` time NOT NULL,
  `v_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `block`
--
ALTER TABLE `block`
  ADD PRIMARY KEY (`block_id`);

--
-- Indexes for table `cases`
--
ALTER TABLE `cases`
  ADD PRIMARY KEY (`case_id`);

--
-- Indexes for table `cell`
--
ALTER TABLE `cell`
  ADD PRIMARY KEY (`cell_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`eve_id`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`login_id`);

--
-- Indexes for table `logtype`
--
ALTER TABLE `logtype`
  ADD PRIMARY KEY (`logtype_id`);

--
-- Indexes for table `prisonerchild`
--
ALTER TABLE `prisonerchild`
  ADD PRIMARY KEY (`pc_id`);

--
-- Indexes for table `prisonerduty`
--
ALTER TABLE `prisonerduty`
  ADD PRIMARY KEY (`pd_id`);

--
-- Indexes for table `prisonerlog`
--
ALTER TABLE `prisonerlog`
  ADD PRIMARY KEY (`pl_id`);

--
-- Indexes for table `prisonermaster`
--
ALTER TABLE `prisonermaster`
  ADD PRIMARY KEY (`pm_id`);

--
-- Indexes for table `prisons`
--
ALTER TABLE `prisons`
  ADD PRIMARY KEY (`p_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`);

--
-- Indexes for table `staffduty`
--
ALTER TABLE `staffduty`
  ADD PRIMARY KEY (`sd_id`);

--
-- Indexes for table `userchild`
--
ALTER TABLE `userchild`
  ADD PRIMARY KEY (`u_id`);

--
-- Indexes for table `usermaster`
--
ALTER TABLE `usermaster`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `visitors`
--
ALTER TABLE `visitors`
  ADD PRIMARY KEY (`v_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `block`
--
ALTER TABLE `block`
  MODIFY `block_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `cases`
--
ALTER TABLE `cases`
  MODIFY `case_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `cell`
--
ALTER TABLE `cell`
  MODIFY `cell_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `eve_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `login_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `logtype`
--
ALTER TABLE `logtype`
  MODIFY `logtype_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `prisonerchild`
--
ALTER TABLE `prisonerchild`
  MODIFY `pc_id` int(5) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prisonerduty`
--
ALTER TABLE `prisonerduty`
  MODIFY `pd_id` int(5) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prisonerlog`
--
ALTER TABLE `prisonerlog`
  MODIFY `pl_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `prisonermaster`
--
ALTER TABLE `prisonermaster`
  MODIFY `pm_id` int(5) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prisons`
--
ALTER TABLE `prisons`
  MODIFY `p_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `staffduty`
--
ALTER TABLE `staffduty`
  MODIFY `sd_id` int(5) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `userchild`
--
ALTER TABLE `userchild`
  MODIFY `u_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `usermaster`
--
ALTER TABLE `usermaster`
  MODIFY `user_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `visitors`
--
ALTER TABLE `visitors`
  MODIFY `v_id` int(5) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
