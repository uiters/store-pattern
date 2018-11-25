-------------------------------------------------------------------------------------
------------------------------ procedure for server ------------------------------
-------------------------------------------------------------------------------------

-- Save Token
DELIMITER $$
CREATE PROCEDURE USP_SaveToken(IN user VARCHAR(32),IN token1 VARCHAR(100),IN timeOut1 DATETIME)
BEGIN
    DECLARE count1 INT(11) DEFAULT 0;
    SELECT count(*) INTO count1 FROM AUTHENTICATION WHERE AUTHENTICATION.Username = user LIMIT 1;
    IF(count1 < 1) THEN
        INSERT INTO AUTHENTICATION(`Username`, `Token`, `TimeOut`) VALUES(user, token1, timeOut1)
    ELSEIF
        UPDATE AUTHENTICATION SET `Token` = token1 , `TimeOut` = timeOut1 WHERE `Username` = user
    END IF
END$$
DELIMITER ;

-- Login1
CREATE PROCEDURE USP_Login1(`user` VARCHAR(32))
    SELECT Password FROM `ACCOUNT` WHERE `Username` = `user` LIMIT 1;

-- CheckToken
CREATE PROCEDURE USP_CheckToken(`token1` VARCHAR(100))
    SELECT * FROM `AUTHENTICATION` WHERE `Token` = `token1`;

-------------------------------------------------------------------------------------
------------------------------ procedure for order_app ------------------------------
-------------------------------------------------------------------------------------

-- Get Account Types
DELIMITER $$
CREATE DEFINER=`id6231058_meomeo`@`%` PROCEDURE `USP_GetAccountTypes`()
SELECT *
    FROM ACCOUNTTYPE$$
DELIMITER ;

-- Get Bill Detail By Bill
DELIMITER $$
CREATE DEFINER=`id6231058_meomeo`@`%` PROCEDURE `USP_GetBillDetailByBill`(IN `id` INT(11))
SELECT *
    FROM BILLINFO A, BILL B, FOOD C
    WHERE A.IDBill = B.ID and C.ID = A.IDFood and B.ID = `id`$$
DELIMITER ;

-- Get Bills
DELIMITER $$
CREATE DEFINER=`id6231058_meomeo`@`%` PROCEDURE `USP_GetBills`(IN `currentDate` DATETIME)
SELECT A.*, B.ID as IDTable, B.Name, C.*
    FROM BILL AS A, `TABLE` AS B, ACCOUNT as C
    WHERE A.IDTable = B.ID AND YEAR(A.DateCheckOut) = YEAR(currentDate) and MONTH(A.DateCheckOut) = MONTH(currentDate) and DAY(A.DateCheckOut) = DAY(currentDate) and A.Status = 1 and C.Username = A.Username
    ORDER BY A.DateCheckOut DESC$$
DELIMITER ;

-- Get Food Categories
DELIMITER $$
CREATE DEFINER=`id6231058_meomeo`@`%` PROCEDURE `USP_GetFoodCategories`()
SELECT * from FOODCATEGORY$$
DELIMITER ;

-- Get Foods
DELIMITER $$
CREATE DEFINER=`id6231058_meomeo`@`%` PROCEDURE `USP_GetFoods`()
SELECT FOOD.ID, FOOD.IDCategory, FOOD.Name, FOOD.Price, FOOD.IDImage
FROM FOOD$$
DELIMITER ;

-- Get ID Bill Max
DELIMITER $$
CREATE DEFINER=`id6231058_meomeo`@`%` PROCEDURE `USP_GetIdMax`()
SELECT MAX(ID) as ID
    from BILL$$
DELIMITER ;

-- Get Image
DELIMITER $$
CREATE DEFINER=`id6231058_meomeo`@`%` PROCEDURE `USP_GetImages`()
SELECT ID , CONVERT(DATA USING utf8) Data FROM IMAGE$$
DELIMITER ;

-- Get Tables
DELIMITER $$
CREATE DEFINER=`id6231058_meomeo`@`%` PROCEDURE `USP_GetTables`()
SELECT * FROM `TABLE`$$
DELIMITER ;

-- Insert Bill
DELIMITER $$
CREATE DEFINER=`id6231058_meomeo`@`%` PROCEDURE `USP_InsertBill`(IN `_IDTable` INT(11), IN `_DateCheckIn` DATETIME, IN `_DateCheckOut` DATETIME, IN `_Discount` DOUBLE,`_TotalPrice` int, IN `_Status` INT, `_Username` varchar(32))
insert into `BILL`(`IDTable`, `DateCheckIn`,`DateCheckOut`, `Discount`, BILL.TotalPrice, `Status`, `Username`)
    values(_IDTable, _DateCheckIn, _DateCheckOut, _Discount,_TotalPrice, _Status, _Username)$$
DELIMITER ;

-- Insert BillInfo
DELIMITER $$
CREATE DEFINER=`id6231058_meomeo`@`%` PROCEDURE `USP_InsertBillInfo`(_IDBill int ,_IDFood int, _Quantity int)
insert into `BILLINFO`(`IDBill`, `IDFood`, `Quantity`)
    values(_IDBill, _IDFood, _Quantity)$$
DELIMITER ;

-- Login
DELIMITER $$
CREATE DEFINER=`id6231058_meomeo`@`%` PROCEDURE `USP_Login`(IN `username` VARCHAR(32))
SELECT A.Username, A.Password, A.DisplayName, A.Sex, A.IDCard, A.Address, A.PhoneNumber, A.IDAccountType, A.IDImage, CONVERT(B.Data USING utf8) `Data`, C.Name, A.BirthDay, C.Name
    FROM ACCOUNT A, IMAGE B, ACCOUNTTYPE C
    WHERE A.IDAccountType = C.ID and A.IDImage = B.ID and A.Username = username$$
DELIMITER ;

-------------------------------------------------------------------------------------
------------------------------ procedure for admin_app ------------------------------
-------------------------------------------------------------------------------------





















