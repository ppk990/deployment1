#COMPLEX SELECT QUERIES

#1  #A Trainer want to view the Members weight greter than 50 
# and Age less than 25;

SELECT Member_id,Member_name From Member
Where WEIGHT>45 and age<28;


#2  A trainer Wants Members with their age ,Member_id with last three characters of name.

SELECT Age,CONCAT(Member_id,'-',SUBSTR(Member_name,length(Member_name)-3)) AS IdWITHNAME
From Member;


#3  Write a query for retriving Exercise_type ,Month and date from start_date from Exercise table

SELECT Exercise_type,MONTH(start_date) MONTH,date(start_date) DAY FROM Exercise 
INNER JOIN AIM on exercise.Member_id=Aim.Member_id 
Where exercise.Exercise_duration>=45;

#4 IDENTIFY RECORDS OF Member_name and Machine_type who are using trademills

SELECT Member.Member_name,Machine.Machine_type From Member 
Left JOIN Machine ON Member.Member_id=Machine.Member_id 
Where Machine_name='treadmill';


#Identify Aim_id and Heart_rate From Tables it must include all AIMS

SELECT Aim_id,Heart_rate From HealthRecord 
Right Join Aim On HealthRecord.Member_id=Aim.Member_id;


#Identify Minimum and Maximum weight from a Members

SELECT MIN(weight) AS MINNWT,Max(weight)AS  MAXWT FROM Member;


#take Member_name ,sum of all calories burned by each member and  arrange them in decreasing order of weight;


SELECT Member_name,SUM(calories_burned) calories from Exercise 
INNER JOIN Member ON Exercise.Member_id=Member.Member_id
Group by Member_name ORDER BY Weight DESC;



#find the water intake greater than AVERAGE WATER INTAKE AND Memberid ,height and weight of THe members 

SELECT Member_id,Height,Weight fROM Member where MEMBER_ID IN(
SELECT MEMBER_ID FROM HealthRecord WHERE water_intake_ml >
(SELECT AVG(water_intake_ml) FROM HealthRecord));

# Find members whose height is greater than average height  and completed fitness training

SELECT Member.Member_id FROM Member INNER JOIN AIM 
ON Member.Member_id=AIM.Member_id WHERE Status='Start_soon' AND MEMBER_name IN( 
SELECT Member.Member_name From Member WHERE Height>
(SELECT AVG(Height) From Member));



#STORED PROCEDURE ON Fitness Tracker


ALTER TABLE MEMBER MODIFY MEMBER_ID INT NOT NULL auto_increment;


SELECT * FROM MEMBER;

DELETE FROM MEMBER WHERE MEMBER_NAME='PRATIK_K';


DELIMITER //

CREATE PROCEDURE AddMemberWithAim (
  IN p_name VARCHAR(100),
  IN p_email VARCHAR(100),
  IN p_gender VARCHAR(10),
  IN p_age INT,
  IN p_height INT,
  IN p_weight INT
)
BEGIN
  DECLARE new_member_id INT;

  -- Insert into Member table
  INSERT INTO Member(member_name, email, gender, age, height, weight, created_at)
  VALUES(p_name, p_email, p_gender, p_age, p_height, p_weight, NOW());

  -- Get the last inserted member_id
  SET new_member_id = LAST_INSERT_ID();

  -- Insert default goal
  INSERT INTO Aim(aim_id,aim_type, target_in_days, start_date, end_date, status, member_id)
  VALUES(108,'General Fitness', 30, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 30 DAY), 'Ongoing', new_member_id);
END //

DELIMITER ;


CALL AddMemberWithAim('PRATIK_K','KPKP913290@GMAIL.COM','MALE',24,160,57);


#Exception handler if any erro exists

#1]safeinsertallgenders-insert -roll back if any error occours.

DELIMITER //

CREATE PROCEDURE safeinsertallgenders(
IN P_Member_id VARCHAR(50),
IN P_Member_name varchar(50),
IN P_Email varchar(50) ,
IN P_Gendar CHAR(10),
IN P_Age INT,
IN P_Height INT,
IN P_Weight INT,
IN P_Doj DATE

)
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
	END;
    
    START TRANSACTION;
    INSERT INTO MEMBER(Member_id,Member_name,Email,Gender,Age,Height,Weight,DOJ)
	VALUES(P_Member_id,P_Member_NAME,P_email,P_gender,P_Age,P_Height,P_weight,P_Doj);
    COMMIT;
    
    END//
    
    DELIMITER //
    
    DELIMITER //
    CREATE  PROCEDURE Machineaccident(
    IN p_machine_id varchar(50),
    IN p_machine_type varchar(50),
    IN p_machine_name varchar(50),
    IN p_Member_id varchar(50)
    )
    
    BEGIN 
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN 
            ROLLBACK;
		END;
        
        START TRANSACTION;
        UPDATE Machine_id
        
        SET Machine_id=p_machine_id
        WHERE Member_id=p_Member_id;
        COMMIT;
	END //
    

#EVENT
DELIMITER //
#EVENT 1 Archieve DATA OF mEMBERS WHO HAVE COMPLETED FITNESS TRAINING 
#CREATE AND EVENT FOR THIS AS EVENET_FOR_COMPLTION
#ON SCHEDUKE EVERY 1 MONTH

DO 
BEGIN
    DELETE FROM AIM WHERE status='Completed' -INTERVAL  1 MONTH;
   
END 

SET GLOBAL event_scheduler=ON;

   
DELIMITER ;

-- ROLES

CREATE USER 'pk@localhost' IDENTIFIED BY 'PASSWORD7099';


GRANT SELECT, INSERT ON Member TO 'pk'@'localhost';
GRANT SELECT ON AIM TO 'pk'@'localhost';



