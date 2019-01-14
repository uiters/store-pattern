-------------------------------------------------------------------------------------
------------------------------ procedure for server ------------------------------
-------------------------------------------------------------------------------------

-- Save Token
DELIMITER $$
CREATE PROCEDURE `USP_SaveToken`(IN user VARCHAR(32),IN token1 VARCHAR(100),IN timeOut1 DATETIME)
BEGIN
 	DECLARE count1 INT;
    SELECT count(*) INTO count1 FROM AUTHENTICATION WHERE AUTHENTICATION.Username = user LIMIT 1;
    IF count1 < 1 THEN
        	INSERT INTO AUTHENTICATION(`Username`, `Token`, `TimeOut`) VALUES(user, token1, timeOut1);
        ELSE
            UPDATE AUTHENTICATION 
            SET `Token` = token1 , `TimeOut` = timeOut1 
            WHERE `Username` = user;
    END IF;
END$$
DELIMITER ;

-- Login1
CREATE PROCEDURE USP_Login1(`user` VARCHAR(32))
    SELECT Password FROM `ACCOUNT` WHERE `Username` = `user` LIMIT 1;

-- CheckToken
DELIMITER $$
CREATE PROCEDURE `USP_CheckToken`(`token1` VARCHAR(100))
SELECT * FROM `AUTHENTICATION` WHERE `Token` = `token1`$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_DeleteAcc`( username varchar(32))
DELETE FROM ACCOUNT
    WHERE ACCOUNT.Username = username$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE `USP_DelBill`(id int)
BEGIN
    DELETE FROM BILLINFO
    WHERE BILLINFO.IDBill = id;
    DELETE FROM BILL
    WHERE BILL.ID = id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_DeleteCategory`( id int(11) )
DELETE FROM FOODCATEGORY
WHERE FOODCATEGORY.ID = id$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_DeleteAccType`( id int(11) )
DELETE FROM ACCOUNTTYPE
WHERE ACCOUNTTYPE.ID = id$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_DeleteFood`( id int(11) )
DELETE FROM FOOD
WHERE FOOD.ID = id$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_DeleteTable`( id int(11) )
DELETE from `TABLE`
WHERE TABLE.ID = id$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetAccountTypes`()
SELECT *
    FROM ACCOUNTTYPE$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetAccounts`()
SELECT *
FROM ACCOUNT A, ACCOUNTTYPE B, IMAGE C
WHERE A.IDAccountType = B.ID and A.IDImage = C.ID$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetFoodCategories`()
SELECT * from FOODCATEGORY$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetBills`(IN `currentDate` DATETIME)
SELECT A.*, B.ID as IDTable, B.Name, C.*
    FROM BILL AS A, `TABLE` AS B, ACCOUNT as C
    WHERE A.IDTable = B.ID AND YEAR(A.DateCheckOut) = YEAR(currentDate) and MONTH(A.DateCheckOut) = MONTH(currentDate) and DAY(A.DateCheckOut) = DAY(currentDate) and A.Status = 1 and C.Username = A.Username
    ORDER BY A.DateCheckOut DESC$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetFoods`()
SELECT FOOD.ID, FOOD.IDCategory, FOOD.Name, FOOD.Price, FOOD.IDImage
FROM FOOD$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetBillDetailByBill`(IN `id` INT(11))
SELECT *
    FROM BILLINFO A, BILL B, FOOD C
    WHERE A.IDBill = B.ID and C.ID = A.IDFood and B.ID = `id`$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetFoodsPlus`()
SELECT A.ID `IdFood`, A.Name `FoodName`, C.Name `CategoryName`, A.Price `Price`, B.ID `IdImage`, B.Data `Image`, A.IDCategory `IDCategory`
FROM FOOD A, IMAGE B, FOODCATEGORY C
WHERE A.IDCategory = C.ID and A.IDImage = B.ID$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetFoods1`()
SELECT *
FROM FOOD
WHERE FOOD.IDImage$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetFoodsPlusByIDBill`(idBill int(11))
SELECT A.ID `IdFood`, A.Name `FoodName`, C.Name `CategoryName`, A.Price `Price`, B.ID `IdImage`, B.Data `Image`, A.IDCategory `IDCategory`
FROM FOOD A, IMAGE B, FOODCATEGORY C, BILLINFO D
WHERE A.IDCategory = C.ID and A.IDImage = B.ID and A.ID = D.IDFood and D.IDBill = idBill$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetIdAccTypeMax`()
SELECT MAX(ACCOUNTTYPE.ID) as ID
from ACCOUNTTYPE$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetIDImages`()
SELECT ID FROM IMAGE$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetIdMax`()
SELECT MAX(ID) as ID
    from BILL$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetIdFoodMax`()
SELECT MAX(ID) as ID
    from FOOD$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetIdCategoryMax`()
SELECT MAX(FOODCATEGORY.ID) as ID
from FOODCATEGORY$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetImageByID`(IN `_id` INT(11))
SELECT CONVERT(DATA USING utf8) "Image" FROM IMAGE WHERE IMAGE.ID = `_id` LIMIT 1$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetIdTableMax`()
SELECT MAX(`TABLE`.`ID`) as ID
from `TABLE`$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetTables`()
SELECT TABLE.ID,TABLE.Name,TABLE.Status FROM `TABLE`$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_GetImages`()
SELECT ID , CONVERT(DATA USING utf8) Data FROM IMAGE$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_InsertAccType`(in _Name varchar(100))
BEGIN
	insert into ACCOUNTTYPE(`Name`)
    values(_Name);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_InsertBill`(IN `_IDTable` INT(11), IN `_DateCheckIn` DATETIME, IN `_DateCheckOut` DATETIME, IN `_Discount` DOUBLE,`_TotalPrice` int, IN `_Status` INT, `_Username` varchar(32))
insert into `BILL`(`IDTable`, `DateCheckIn`,`DateCheckOut`, `Discount`, BILL.TotalPrice, `Status`, `Username`)
    values(_IDTable, _DateCheckIn, _DateCheckOut, _Discount,_TotalPrice, _Status, _Username)$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_InsertAccount`(IN `username` varchar(32), IN `password` varchar(128), IN `displayname` varchar(100), IN `sex` int(11), IN `idCard` varchar(30), IN `address` varchar(100), IN `phoneNumber` varchar(30), IN `birthday` datetime, IN `idAccountType` int(11), IN `image` LONGTEXT)
BEGIN
    DECLARE idImage int ;

	INSERT INTO IMAGE(IMAGE.Data)
    VALUES (image) ;
    
    select MAX(IMAGE.ID) into idImage
    FROM IMAGE ;
    
    INSERT INTO ACCOUNT(ACCOUNT.Username, ACCOUNT.Password, ACCOUNT.DisplayName, ACCOUNT.Sex, ACCOUNT.IDCard, ACCOUNT.Address, ACCOUNT.PhoneNumber, ACCOUNT.BirthDay, ACCOUNT.IDAccountType, ACCOUNT.IDImage)
    VALUES(`username`, `password`, `displayname`, `sex`, `idCard`, `address`, `phoneNumber`, `birthday`, `idAccountType`, `idImage`) ;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_InsertBillInfo`(_IDBill int ,_IDFood int, _Quantity int)
insert into `BILLINFO`(`IDBill`, `IDFood`, `Quantity`)
    values(_IDBill, _IDFood, _Quantity)$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_InsertBin`(in IDCollect int,in ID int)
BEGIN
		insert BIN(`IDCollection`,`IDElement`)
		values(IDCollect,ID);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_InsertFoodCatetory`(in _Name varchar(100))
BEGIN
	insert into FOODCATEGORY(`Name`)
    values(_Name);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_InsertFood`(name varchar(100), price double, idCategory int(11), image LONGTEXT)
BEGIN
    DECLARE idImage int ;

	INSERT INTO IMAGE(IMAGE.Data)
    VALUES (image) ;
    
    select MAX(IMAGE.ID) into idImage
    FROM IMAGE ;
    
	INSERT INTO FOOD(FOOD.Name, FOOD.Price, FOOD.IDCategory, FOOD.IDImage)
    VALUES(name, price, idCategory, idImage) ;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_IsAccExists`( username varchar(32) )
SELECT *
    FROM BILL
    WHERE BILL.Username = username$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_InsertPending`(in ID int)
BEGIN
	insert PENDING(`IDBill`)
    values(ID);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_IsAccTypeExists`( id int(11) )
SELECT *
from ACCOUNT
WHERE ACCOUNT.IDAccountType = id$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_IsCategoryExists`( id int(11) )
SELECT *
from FOOD
WHERE FOOD.IDCategory = id$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_IsTableExists`( id int(11) )
SELECT *
from BILL
WHERE BILL.IDTable = id$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_IsFoodExists`( id int(11) )
SELECT *
FROM BILLINFO
WHERE BILLINFO.IDFood = id$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_Login`(IN `username` VARCHAR(32))
SELECT A.Username, A.Password, A.DisplayName, A.Sex, A.IDCard, A.Address, A.PhoneNumber, A.IDAccountType, A.IDImage, CONVERT(B.Data USING utf8) `Data`, C.Name, A.BirthDay, C.Name
    FROM ACCOUNT A, IMAGE B, ACCOUNTTYPE C
    WHERE A.IDAccountType = C.ID and A.IDImage = B.ID and A.Username = username$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_InsertTable`(in Nametable varchar(100))
BEGIN
	insert into `TABLE`(`Name`,`Status`)
    values (Nametable,-1);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_LoginAdmin`(IN `username` VARCHAR(32))
SELECT A.Username, A.Password, A.DisplayName, A.Sex, A.IDCard, A.Address, A.PhoneNumber, A.IDAccountType, A.IDImage, CONVERT(B.Data USING utf8) `Data`, C.Name, A.BirthDay, C.Name
    FROM ACCOUNT A, IMAGE B, ACCOUNTTYPE C
    WHERE A.IDAccountType = C.ID and C.ID = 1 and A.IDImage = B.ID and A.Username = username$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_ShowReport`(in _Date date)
select * from REPORT
    where REPORT._Date = _Date$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_Login1`(IN `user` VARCHAR(32))
SELECT * FROM `ACCOUNT` WHERE `Username` = `user`$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE `USP_TVC12_GetReport_Month`()
SELECT SQL_NO_CACHE DATE_FORMAT(_Date, '%Y-%m-01') '_Date', SUM(TotalPrice) 'TotalPrice'
	FROM REPORT
    WHERE YEAR(REPORT._Date) = YEAR(Now())
	GROUP BY DATE_FORMAT(_Date, '%Y%m')$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_TVC12_DeleteBill`( id1 int )
BEGIN
	DELETE FROM BILLINFO
    WHERE BILLINFO.IDBill = id1;
	DELETE FROM BILL
    WHERE BILL.ID = id1;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_TVC12_GetBill`()
SELECT BILL.ID, BILL.IDTable, BILL.DateCheckIn, BILL.DateCheckOut,
    	BILL.Discount, BILL.TotalPrice, BILL.Status, BILL.Username, TABLE.Name
    FROM 
    BILL INNER JOIN `TABLE` on BILL.IDTable = `TABLE`.`ID`$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_TVC12_GetReport_Today`()
BEGIN
DECLARE check1 int DEFAULT 0;
SELECT COUNT(*) INTO check1
FROM REPORT
WHERE Date(Now()) = _Date;
IF check1 = 0 THEN
	INSERT INTO REPORT(_Date, TotalPrice) VALUES(NOW(), 0);
END IF;
SELECT * FROM REPORT
	WHERE Date(Now()) = _Date
    ORDER BY ID DESC
    LIMIT 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_UpdateAccAvatar`(IN `username` VARCHAR(32), IN `_image` LONGTEXT)
BEGIN
	DECLARE idImage int ;
	SELECT ACCOUNT.IDImage into idImage
    FROM ACCOUNT
    WHERE ACCOUNT.Username = username ;
    UPDATE IMAGE
    SET IMAGE.Data = _image
    WHERE IMAGE.ID = idImage ;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_TVC12_GetReport_Year`()
SELECT SQL_NO_CACHE _Date, SUM(TotalPrice) 'TotalPrice'
	FROM REPORT
	GROUP BY YEAR(_Date)$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_TVC12_GetReport_Week`()
SELECT * FROM (SELECT DISTINCT *
	FROM REPORT
	ORDER BY REPORT.ID DESC
    LIMIT 7) as tb
ORDER BY tb._Date ASC$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_UpdateAccInfo`( username varchar(32), displayName varchar(100), sex int(11), birthday datetime, idCard varchar(30), address varchar(100), phone varchar(30))
UPDATE ACCOUNT
    SET ACCOUNT.DisplayName = displayName, ACCOUNT.Sex = sex, ACCOUNT.BirthDay = birthday, ACCOUNT.IDCard = idCard, ACCOUNT.Address = address, ACCOUNT.PhoneNumber = phone
    WHERE ACCOUNT.Username = username$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_UpdateAccPass`(username varchar(32), newPass varchar(128))
UPDATE ACCOUNT
    SET ACCOUNT.Password = newPass
    WHERE ACCOUNT.Username = username$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_UpdateAccount`(IN `username` varchar(32), IN `displayname` varchar(100), IN `sex` int(11), IN `idCard` varchar(30), IN `address` varchar(100), IN `phoneNumber` varchar(30), IN `birthday` datetime, IN `idAccountType` int(11), IN `image` LONGTEXT)
BEGIN
	DECLARE idImageDelete, idImage int ;
    
    SELECT ACCOUNT.IDImage into idImageDelete
    FROM ACCOUNT
    WHERE ACCOUNT.Username = username ;
    
	INSERT INTO IMAGE(IMAGE.Data)
    VALUES (image) ;
    
    select MAX(IMAGE.ID) into idImage
    FROM IMAGE ;
    
    UPDATE ACCOUNT
    SET ACCOUNT.DisplayName = displayname, ACCOUNT.Sex = sex, ACCOUNT.IDCard = idCard, ACCOUNT.Address = address, ACCOUNT.PhoneNumber = phoneNumber, ACCOUNT.BirthDay = birthday, ACCOUNT.IDAccountType = idAccountType, ACCOUNT.IDImage = idImage
    WHERE ACCOUNT.Username = username ;
    
    DELETE FROM IMAGE
    WHERE IMAGE.ID = idImageDelete ;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_UpdateAccType`(IN `_ID` INT, IN `_Name` VARCHAR(100))
BEGIN
	update ACCOUNTTYPE
    set `Name`=_Name
    where `ID`=_ID;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_UpdateFood`(id int(11), name varchar(100), price double, idCategory int(11), image LONGTEXT)
BEGIN
	DECLARE idImageDelete, idImage int ;
    
    SELECT FOOD.IDImage into idImageDelete
    FROM FOOD
    WHERE FOOD.ID = id ;
    
	INSERT INTO IMAGE(IMAGE.Data)
    VALUES (image) ;
    
    select MAX(IMAGE.ID) into idImage
    FROM IMAGE ;
    
    UPDATE FOOD
    SET FOOD.Name = name, FOOD.Price = price, FOOD.IDCategory = idCategory, FOOD.IDImage = idImage
    WHERE FOOD.ID = id ;
    
    DELETE FROM IMAGE
    WHERE IMAGE.ID = idImageDelete ;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_UpdateReport`(in _Date date,in Price double)
BEGIN
	declare _count int;
    select count(*) into _count
    from REPORT
    where REPORT._Date=_Date;
	if(_count>0) then
		update REPORT
		set REPORT.TotalPrice=REPORT.TotalPrice+Price
		where REPORT._Date=_Date;
	end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_UpdateTable`(in _ID int, in _Name varchar(100), in _Status int)
BEGIN
	update `TABLE`
    set `Name`=_Name , `Status`=_Status
    where `ID`=_ID;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `USP_UpdateFoodCategory`(IN `_ID` INT, IN `_Name` VARCHAR(100))
BEGIN
	update FOODCATEGORY
    set `Name`=_Name
    where `ID`=_ID;
END$$
DELIMITER ;

















