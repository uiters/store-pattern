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

CREATE PROCEDURE USP_Login1(`user` VARCHAR(32))
    SELECT Password FROM `ACCOUNT` WHERE `Username` = `user` LIMIT 1;
