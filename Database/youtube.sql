-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 06, 2022 at 01:59 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `youtube`
--

-- --------------------------------------------------------

--
-- Table structure for table `channel`
--

CREATE TABLE `channel` (
  `sn` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `channel_name` varchar(255) NOT NULL,
  `detail` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `date` varchar(255) NOT NULL,
  `status` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `channel`
--

INSERT INTO `channel` (`sn`, `code`, `channel_name`, `detail`, `email`, `category`, `date`, `status`) VALUES
(1, 'gbk5Dm_1', 'Anime ', 'Entertainment and Gamming', 'rb083380@gmail.com', 'Anime', 'Thu Dec 16 20:02:43 IST 2021', '0'),
(2, 'mREyTS_2', 'Punjabi Edits', 'Latest Video Edits', 'rb083380@gmail.com', 'Music', 'Thu Dec 16 20:27:15 IST 2021', '0'),
(3, 'kjHvYO_3', 'Indian Army', 'Army Training and Teaching Video', 'rb083380@gmail.com', 'Film', 'Thu Dec 16 14:43:35 IST 2021', '0'),
(4, 'tur90c_4', 'Yoga and Exercise', '#yoga #exercise #yogaandexercise \r\nall about yoga and morning exercise provide through this channel.', 'rb083380@gmail.com', 'Yoga', 'Thu Dec 23 19:43:41 IST 2021', '0'),
(5, 'pH05tm_5', 'Vivek Bindra Speech Video', '#video #motivational #quotes #vivekbindra ', 'rb083380@gmail.com', 'Motivation', 'Thu Dec 23 20:14:59 IST 2021', '0'),
(6, 'qCQY19_6', 'Short Clips', 'This Channel is contains short videos related to movies and funny videos .\r\n#shortclips #movies #comedy #entertainment', 'krishana45@gmail.com', 'Entertainment', 'Sat Feb 26 11:12:38 IST 2022', '0');

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `sn` int(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `from_name` varchar(255) NOT NULL,
  `from_email` varchar(255) NOT NULL,
  `comment` blob NOT NULL,
  `to_email` varchar(255) NOT NULL,
  `video_code` varchar(255) NOT NULL,
  `date` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`sn`, `code`, `from_name`, `from_email`, `comment`, `to_email`, `video_code`, `date`) VALUES
(1, 'LYMQBx_1', 'Radhika', 'radhika@gmail.com', 0x4e69636520566964656f204a697261796120426573742073656e73616920616e6420426573742053696e6f62692e, 'rb083380@gmail.com', 'qh06HQ_6', ''),
(2, 'v84zgR_2', 'Radhika', 'radhika@gmail.com', 0x4a61692048696e64203a29, 'rb083380@gmail.com', 'ow7aDm_14', 'Thu Mar 10 10:01:55 IST 2022'),
(3, 'gnG9Qc_3', 'Radhika', 'radhika@gmail.com', 0x4e69636520536f6e6720, 'rb083380@gmail.com', 'uknJrv_9', 'Thu Mar 10 12:01:55 IST 2022'),
(4, 'HrQCiq_4', 'Rahul Bhati', 'rb083380@gmail.com', 0x686c6f, 'rb083380@gmail.com', 'zXTrIC_3', 'Fri Mar 11 15:40:02 IST 2022'),
(5, 'lqIYCr_5', 'Krishana', 'krishana45@gmail.com', 0x4e69636520566964656f, 'rb083380@gmail.com', 'd6jh8B_4', 'Tue Mar 15 11:55:08 IST 2022'),
(6, 'rXcWOx_6', 'Rahul Bhati', 'rb083380@gmail.com', 0x686c6f, 'rb083380@gmail.com', 'd6jh8B_4', 'Tue Mar 22 12:51:18 IST 2022'),
(7, 'npNsbO_7', 'Rahul Bhati', 'rb083380@gmail.com', 0x6a6a, 'rb083380@gmail.com', 'd6jh8B_4', 'Tue Mar 22 12:51:50 IST 2022'),
(8, 'AXFNGl_8', 'Rahul Bhati', 'rb083380@gmail.com', 0x6767, 'rb083380@gmail.com', 'd6jh8B_4', 'Tue Mar 22 12:51:57 IST 2022');

-- --------------------------------------------------------

--
-- Table structure for table `favourite`
--

CREATE TABLE `favourite` (
  `video_code` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `favourite`
--

INSERT INTO `favourite` (`video_code`, `email`) VALUES
('4ulqpA_1', 'rb083380@gmail.com'),
('aWPEsg_2', 'rb083380@gmail.com'),
('Jqd3sE_7', 'rb083380@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `video_code` varchar(11) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`video_code`, `email`) VALUES
('4ulqpA_1', 'krishana45@gmail.com'),
('uknJrv_9', 'krishana45@gmail.com'),
('ow7aDm_14', 'krishana45@gmail.com'),
('d6jh8B_4', 'krishana45@gmail.com'),
('aWPEsg_2', 'rb083380@gmail.com'),
('gsy1Z0_16', 'rb083380@gmail.com'),
('4ulqpA_1', 'rb083380@gmail.com'),
('e9XyLT_15', 'rb083380@gmail.com'),
('Jqd3sE_7', 'rb083380@gmail.com'),
('d6jh8B_4', 'rb083380@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `liked`
--

CREATE TABLE `liked` (
  `video_code` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `ptr` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `liked`
--

INSERT INTO `liked` (`video_code`, `email`, `ptr`) VALUES
('d6jh8B_4', 'rb083380@gmail.com', 'like'),
('qh06HQ_6', 'krishana45@gmail.com', 'like'),
('qh06HQ_6', 'radhika@gmail.com', 'like'),
('qh06HQ_6', 'rb083380@gmail.com', 'like'),
('zXTrIC_3', 'rb083380@gmail.com', 'like'),
('4ulqpA_1', 'rb083380@gmail.com', 'like'),
('B07RZ2_5', 'rb083380@gmail.com', 'like'),
('d6jh8B_4', 'krishana45@gmail.com', 'like'),
('aWPEsg_2', 'rb083380@gmail.com', 'like');

-- --------------------------------------------------------

--
-- Table structure for table `subscribe`
--

CREATE TABLE `subscribe` (
  `channel_code` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `subscribe`
--

INSERT INTO `subscribe` (`channel_code`, `email`) VALUES
('gbk5Dm_1', 'rb083380@gmail.com'),
('mREyTS_2', 'rb083380@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `sn` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `dob` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`sn`, `code`, `username`, `email`, `pass`, `phone`, `dob`, `gender`, `country`) VALUES
(1, '9C8vYL_1', 'Rahul Bhati', 'rb083380@gmail.com', '7773', '09001285492', '2001-06-08', 'Male', 'India'),
(2, 'stgdex_2', 'Radhika', 'radhika@gmail.com', '43545', '8934512742', '2001-02-09', 'Female', 'India'),
(3, '1KMF0i_3', 'Krishana', 'krishana45@gmail.com', '34523', '9928549254', '2002-03-04', 'Male', 'India');

-- --------------------------------------------------------

--
-- Table structure for table `user_view`
--

CREATE TABLE `user_view` (
  `video_code` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_view`
--

INSERT INTO `user_view` (`video_code`, `email`) VALUES
('4ulqpA_1', 'rb083380@gmail.com'),
('zXTrIC_3', 'rb083380@gmail.com'),
('4ulqpA_1', 'radhika@gmail.com'),
('4ulqpA_1', 'krishana45@gmail.com'),
('uknJrv_9', 'krishana45@gmail.com'),
('ow7aDm_14', 'krishana45@gmail.com'),
('d6jh8B_4', 'krishana45@gmail.com'),
('aWPEsg_2', 'rb083380@gmail.com'),
('gsy1Z0_16', 'rb083380@gmail.com'),
('qh06HQ_6', 'rb083380@gmail.com'),
('e9XyLT_15', 'rb083380@gmail.com'),
('Jqd3sE_7', 'rb083380@gmail.com'),
('d6jh8B_4', 'rb083380@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `video`
--

CREATE TABLE `video` (
  `sn` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `video_name` varchar(255) NOT NULL,
  `detail` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `date` varchar(255) NOT NULL,
  `channel_code` varchar(255) NOT NULL,
  `status` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `video`
--

INSERT INTO `video` (`sn`, `code`, `video_name`, `detail`, `email`, `date`, `channel_code`, `status`) VALUES
(1, '4ulqpA_1', 'Bishmilla Song', 'Punjabi Song Edits', 'rb083380@gmail.com', 'Sun Dec 12 19:22:35 IST 2021', 'mREyTS_2', '0'),
(2, 'aWPEsg_2', 'Fark', 'Gippy Garwal ', 'rb083380@gmail.com', 'Tue Dec 14 18:56:32 IST 2021', 'mREyTS_2', '0'),
(3, 'zXTrIC_3', 'Anime Moment', 'Range Moments', 'rb083380@gmail.com', 'Thu Dec 16 18:37:12 IST 2021', 'gbk5Dm_1', '0'),
(4, 'd6jh8B_4', 'Naruto Entry ', 'Naruto Entry in war 3 againts tails beasts.', 'rb083380@gmail.com', 'Thu Dec 23 19:37:14 IST 2021', 'gbk5Dm_1', '0'),
(5, 'B07RZ2_5', 'Might Guy Speech to Rock Lee_ Naruto Shippuden Quotes(480P)', '#NarutoShippuden #narutoshippuden #anime #entertainment #naruto', 'rb083380@gmail.com', 'Thu Dec 23 19:48:25 IST 2021', 'gbk5Dm_1', '0'),
(6, 'qh06HQ_6', 'Jiraiya the Gallant _ The tale of Naruto Uzumaki(720P_HD)_1', '#naruto #anime #narutoshippuden #entertainment #jiraiya', 'rb083380@gmail.com', 'Thu Dec 23 19:51:53 IST 2021', 'gbk5Dm_1', '0'),
(8, 'bilGZy_8', 'Armaan Bedil _ Love You (Official Video)', '#song #punjabisong #entertainment #punjabi', 'rb083380@gmail.com', 'Thu Dec 23 19:59:14 IST 2021', 'mREyTS_2', '0'),
(9, 'uknJrv_9', 'Akhil Feat Adah Sharma _ Life Official Video _ Pre(360P)', '#punjabisong #song #entertainment #punjabi', 'rb083380@gmail.com', 'Thu Dec 23 20:02:39 IST 2021', 'mREyTS_2', '0'),
(10, 'WdG3bQ_10', 'How to Control Your Mind _ Emotions in BhagwatGeeta', '#vivekbindra #motivational #bhagwatgeeta #geeta', 'rb083380@gmail.com', 'Thu Dec 23 20:18:03 IST 2021', 'pH05tm_5', '0'),
(11, 'Weqmr1_11', 'How to study by Dr. Bindra sir', '#vivekbindra #motivational #business', 'rb083380@gmail.com', 'Thu Dec 23 20:20:39 IST 2021', 'pH05tm_5', '0'),
(12, 'OmYskP_12', 'How to use your brain by Dr. Bindra sir', '#vivekbindra #motivational ', 'rb083380@gmail.com', 'Thu Dec 23 20:21:59 IST 2021', 'pH05tm_5', '0'),
(13, 'xCjbGW_13', 'Digital Marketing by _ _ Dr Vi(360P)', '#vivekbindra #motivational #marketing #advice', 'rb083380@gmail.com', 'Thu Dec 23 20:27:04 IST 2021', 'pH05tm_5', '0'),
(14, 'ow7aDm_14', 'Army Day_Indian Heroes(360P)_1', '#army #indianarmy #armyday #celebration', 'rb083380@gmail.com', 'Thu Dec 23 20:37:16 IST 2021', 'kjHvYO_3', '0'),
(15, 'e9XyLT_15', 'Indian Army day Status _ 15 January', '#army #indianarmy #celebration #15january', 'rb083380@gmail.com', 'Thu Dec 23 20:39:34 IST 2021', 'kjHvYO_3', '0'),
(16, 'gsy1Z0_16', 'Funny Panda Race Animation', '#entertainment #comedy #funny', 'krishana45@gmail.com', 'Sun Feb 27 09:00:40 IST 2022', 'qCQY19_6', '0');

-- --------------------------------------------------------

--
-- Table structure for table `watch_later`
--

CREATE TABLE `watch_later` (
  `video_code` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `watch_later`
--

INSERT INTO `watch_later` (`video_code`, `email`) VALUES
('d6jh8B_4', 'krishana45@gmail.com');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
