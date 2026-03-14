-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 14, 2026 at 08:04 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `library`
--

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `ISBN` varchar(20) NOT NULL,
  `Title` varchar(200) DEFAULT NULL,
  `Author` varchar(100) DEFAULT NULL,
  `Publisher` varchar(100) DEFAULT NULL,
  `Publication_Year` int(11) DEFAULT NULL,
  `Genre` varchar(50) DEFAULT NULL,
  `Total_Copies` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`ISBN`, `Title`, `Author`, `Publisher`, `Publication_Year`, `Genre`, `Total_Copies`) VALUES
('978-1111111111', 'Winds of Tomorrow', 'Maria Holt', 'Maple Tree Press', 2020, 'Historical Fiction', 8),
('978-1234567890', 'Tales Among the Stars', 'Nolan Elson', 'Galaxy Publishers', 2014, 'SciFi', 5);

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

CREATE TABLE `loan` (
  `LoanID` int(11) NOT NULL,
  `Loan_Date` date DEFAULT NULL,
  `Due_Date` date DEFAULT NULL,
  `MemberID` int(11) DEFAULT NULL,
  `ISBN` varchar(20) DEFAULT NULL,
  `WorkerID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan`
--

INSERT INTO `loan` (`LoanID`, `Loan_Date`, `Due_Date`, `MemberID`, `ISBN`, `WorkerID`) VALUES
(201, '2025-04-06', '2025-04-20', NULL, '978-1111111111', 301),
(1001, '2025-04-01', '2025-04-15', 1, '978-1234567890', 301),
(1002, '2025-04-01', '2025-04-15', 1, '978-1234567890', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `MemberID` int(11) NOT NULL,
  `NAME` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Joining_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`MemberID`, `NAME`, `Email`, `Address`, `Joining_Date`) VALUES
(1, 'Peter Smith', 'peter@elo.com', '123 Main Street', '2025-04-05'),
(101, 'Linda Green', 'linda.green@email.com', '42 Oak Avenue', '2025-04-01');

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE `purchase` (
  `PurchaseID` int(11) NOT NULL,
  `Purchase_Date` date DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Amount_Paid` decimal(10,2) DEFAULT NULL,
  `ISBN` varchar(20) DEFAULT NULL,
  `WorkerID` int(11) DEFAULT NULL,
  `MemberID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchase`
--

INSERT INTO `purchase` (`PurchaseID`, `Purchase_Date`, `Quantity`, `Amount_Paid`, `ISBN`, `WorkerID`, `MemberID`) VALUES
(501, '2025-03-30', 3, 89.99, '978-1234567890', 2001, 1),
(701, '2025-04-07', 2, 59.90, '978-1111111111', 301, 101);

-- --------------------------------------------------------

--
-- Table structure for table `workers`
--

CREATE TABLE `workers` (
  `WorkerID` int(11) NOT NULL,
  `NAME` varchar(100) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Role` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `workers`
--

INSERT INTO `workers` (`WorkerID`, `NAME`, `Address`, `Role`) VALUES
(301, 'Ethan Wells', '78 Pine Street', 'Assistant Librarian'),
(2001, 'Bob Carter', '456 Elm St', 'Librarian');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`ISBN`);

--
-- Indexes for table `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`LoanID`),
  ADD KEY `MemberID` (`MemberID`),
  ADD KEY `ISBN` (`ISBN`),
  ADD KEY `WorkerID` (`WorkerID`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`MemberID`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`PurchaseID`),
  ADD KEY `MemberID` (`MemberID`),
  ADD KEY `ISBN` (`ISBN`),
  ADD KEY `WorkerID` (`WorkerID`);

--
-- Indexes for table `workers`
--
ALTER TABLE `workers`
  ADD PRIMARY KEY (`WorkerID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`MemberID`) REFERENCES `members` (`MemberID`),
  ADD CONSTRAINT `loan_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`),
  ADD CONSTRAINT `loan_ibfk_3` FOREIGN KEY (`WorkerID`) REFERENCES `workers` (`WorkerID`);

--
-- Constraints for table `purchase`
--
ALTER TABLE `purchase`
  ADD CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`MemberID`) REFERENCES `members` (`MemberID`),
  ADD CONSTRAINT `purchase_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`),
  ADD CONSTRAINT `purchase_ibfk_3` FOREIGN KEY (`WorkerID`) REFERENCES `workers` (`WorkerID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
