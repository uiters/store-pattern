CREATE TABLE `AUTHENTICATION`(
    `Username`      VARCHAR(32) PRIMARY KEY,
    `Token`         VARCHAR(100),
    `TimeOut`       DATETIME,
    FOREIGN KEY (`Username`) REFERENCES ACCOUNT(Username),
)

CREATE TABLE `ACCOUNTTYPE`(
    `ID`            INT AUTO_INCREMENT PRIMARY KEY,
    `Name`          VARCHAR(100)
);

CREATE TABLE `ACCOUNT` (
    `Username`      VARCHAR(32) PRIMARY KEY,
    `Password`      VARCHAR(128) NOT NULL,
    `DisplayName`   VARCHAR(100),
    `Sex`           INT(11),
    `IDCard`        VARCHAR(30),
    `Address`       VARCHAR(100),
    `PhoneNumber`   VARCHAR(30),
    `BirthDay`      DATETIME,
    `IDAccountType` INT,
    `IDImage`       INT,
    FOREIGN KEY(`IDAccountType`) REFERENCES ACCOUNTTYPE(ID),
    FOREIGN KEY(`IDImage`) REFERENCES image(ID)
);

CREATE TABLE `IMAGE`(
    `ID` INT AUTO_INCREMENT PRIMARY KEY,
    `Data` LONGBLOD
)

CREATE TABLE `TABLE` (
	`ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Name` VARCHAR(100) DEFAULT 'No Name',
    `Status` INT DEFAULT -1
);

CREATE TABLE `FOODCATEGORY`(
	`ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Name` VARCHAR(100) DEFAULT 'No Name'
);

CREATE TABLE `FOOD`(
    `ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `IDCategory` INT NOT NULL,
    `Name` VARCHAR(100) DEFAULT 'No Name',
    `Price` DOUBLE DEFAULT 0,
    'IDImage' int(11) DEFAULT '1'
    FOREIGN KEY(IDImage) REFERENCES IMAGE(ID),
    FOREIGN KEY(ID) REFERENCES FOODCATEGORY(ID)
);

CREATE TABLE `BILL`(
    `ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `IDTable` INT NOImageT NULL ,
    `DateCheckIn` DAImageTETIME,
    `DateCheckOut` DImageATETIME,
    `Discount` DOUBLImageE DEFAULT 0,
    `TotalPrice` DOUImageBLE DEFAULT 0,
    `Status` INT DEFImageAULT -1,
    `Username` varchar(32) NOT NULL,
    FOREIGN KEY(Username) REFERENCES`ACCOUNT`(Username),
    FOREIGN KEY(IDTaImageble) REFERENCES `TABLE`(ID)
);
DELIMITER $$
CREATE TRIGGER `UTG_Report_Delete` BEFORE DELETE ON `BILL` FOR EACH ROW BEGIN
	IF old.Status = 1 THEN
    	UPDATE REPORT
        SET REPORT.TotalPrice = REPORT.TotalPrice - old.TotalPrice
        WHERE DATE(REPORT._Date) = DATE(old.DateCheckIn);
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UTG_Report_Update` BEFORE UPDATE ON `BILL` FOR EACH ROW BEGIN
	DECLARE id1 int;
    SET id1 = 0;
	IF OLD.Status <> NEW.Status THEN 
        SELECT REPORT.ID
        INTO id1
        FROM 
        	REPORT
        WHERE 
        	DATE(REPORT._Date) = DATE(NEW.DateCheckIn);
        IF id1 = 0 THEN
            INSERT INTO REPORT(_Date, TotalPrice) VALUES(DATE(NEW.DateCheckIn), NEW.TotalPrice);
            ELSE
            UPDATE
                REPORT
            SET
                REPORT.TotalPrice = REPORT.TotalPrice + (IF(NEW.Status > 0,NEW.TotalPrice,-NEW.TotalPrice))
            WHERE ID = id1;
       	END IF;
    END IF;
END
$$
DELIMITER ;

CREATE TABLE `BILLINFO`(
    `IDBill` int(11) NOT NULL,
    `IDFood` int(11) NOT NULL,
    `Quantity` int(11) DEFAULT '0'
    FOREIGN KEY(IDBill) REFERENCES BILL(ID),
    FOREIGN KEY(IDFood) REFERENCES FOOD(ID)
);


CREATE TABLE `REPORT`(
    `ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `_Date` Date,
    `TotalPrice` DOUBLE DEFAULT 0
);