create database Fitness;

Use Fitness;



CREATE TABLE Member (
    member_id VARCHAR(50) PRIMARY KEY,
    member_name VARCHAR(50),
    email VARCHAR(50),
    gender ENUM('Male', 'Female'),
age INT,
    height INT,
    weight INT,
    doj DATETIME 
);

Create table Exercise(
Exercise_Id varchar(50) primary key,

Exercise_type varchar(50),
Exercise_duration varchar(50),
calories_burned INT,
Exercise_start_time  Time,
Exercise_end_time Time,

Member_id varchar(50) references Member(Member_id)


);


create table HealthRecord(
Record_id varchar(50) primary key,
daily_hours INT,
heart_rate INT,
sleep_hours INT,
Water_intake_ml INT,
Member_id varchar(50) references Member(Member_id)


);


create table Aim(
	Aim_id varchar(50) primary key,
	Aim_type varchar(50),
    Target_in_days varchar(50),
    start_date DATE,
    end_date DATE,
    status varchar(50),
    Member_id varchar(50) references Member(Member_id)

);


create table Machine(
Machine_id varchar(50),
Machine_name varchar(50),
Machine_type varchar(50),
Member_id varchar(50) references Member(Member_id)

);


















INSERT INTO Member  
VALUES  
(1,'Amit Mane','amit71m@gmail.com','Male',30,165,55,NOW()),
(2,'Aniket Gandhi','aniket21@gmail.com','Male',28,155,50,NOW()),
(3,'Rajesh Parade','raj8133@gmail.com','Male',25,155,50,NOW()),
(4,'Avinash Dhabade','avinash1212@gmail.com','Male',25,155,50,NOW()),
(5,'Sameer Bandgar','sameer0101@gmail.com','Male',24,155,50,NOW()),
(6,'Anisha Phade','Anisha7099@gmail.com','Female',23,155,50,NOW());




ALTER TABLE Exercise Modify Column Exercise_type INT;
ALTER TABLE Exercise Modify Column Exercise_duration INT;
ALTER TABLE Exercise Modify Column Exercise_type VARCHAR(50);



INSERT INTO Exercise VALUES(11,1,'Cardio',1,320,07,08),
(12,2,'Running',2,120,07,09),
(13,3,'Chest',1,100,04,05),
(14,4,'Shoulders',1,390,05,06),
(15,5,'Leg',1,410,06,07),
(16,6,'biceps',2,220,06,08);







INSERT INTO Exercise VALUES(11,'Cardio',2,320,'07:00:00','08:00:00',1),
(12,'Running',1,520,'07:00:00','09:00:00',2),
(13,'chest',1,220,'05:00:00','06:00:00',3),
(14,'Shoulder',2,120,'05:00:00','07:00:00',4),
(15,'Leg',1,390,'09:00:00','10:00:00',5),
(16,'Biceps',2,340,'05:00:00','06:00:00',6);



INSERT INTO HealthRecord VALUES(101,2,82,7,2000,1),
(102,3,89,6,2500,2),
(103,1,91,8,1900,3),
(104,4,81,9,1600,4),
(105,3,90,5,1850,5),
(106,4,80,8,2200,6);


INSERT INTO Aim VALUES(001,'Weight loss',90,'2025-07-01','2024-10-31','Start Soon',1),
(002,'Weight loss',70,'2024-07-01','2024-09-11','Completed',2),
(003,'Body_Shaping',50,'2025-07-14','2025-09-04','Start Soon',3),
(004,'Weight gain',40,'2024-09-21','2024-11-01','Completed',4),
(005,'Weight loss',90,'2024-04-23','2024-07-23','Completed',5),
(006,'Body Shaping',100,'2025-04-01','2025-07-10','Ongoing',6);






INSERT INTO Aim VALUES(101,'Weight loss',90,'2025-07-01','2024-10-31','Start Soon',1),
(102,'Weight loss',70,'2024-07-01','2024-09-11','Completed',2),
(103,'Body_Shaping',50,'2025-07-14','2025-09-04','Start Soon',3),
(104,'Weight gain',40,'2024-09-21','2024-11-01','Completed',4),
(105,'Weight loss',90,'2024-04-23','2024-07-23','Completed',5),
(106,'Body Shaping',100,'2025-04-01','2025-07-10','Ongoing',6);




INSERT INTO Machine VALUES(401,'Stationary bikes','cardio',1),
(402,'treadmills','Running',2),
(403,'pek deck','chest',3),
(404,'lateral raise','shoulder',4),
(1,'Leg press','leg',5),
(1,'isolater','biceps',6);



INSERT INTO Member VALUES
(7,'Nishant Ghodke','nishant@gmail.com','Male',1995-12-07,165,55,now()),
(9,'Mahadev Kale','Mahdev99@gmail.com','Male',1999-12-27,168,60,now()),
(11,'Anita Mali','Anita1304@gmail.com','Female',1989-09-09,154,54,now()),
(12,'Priya Shinde','priyashinde@gmail.com','Female',1993-12-11,159,52,now());


INSERT INTO Exercise VALUES
(17,'Leg',1,300,'6:00:00','7:00:00',9),
(18,'Running',2,500,'6:30:00','8:30:00',12);



INSERT INTO HealthRecord VALUES

(107,2,84,7,2000,7),
(108,3,88,9,2400,11);

INSERT INTO Machine VALUES
(408,'Leg press','Leg',9),
(409,'treadmill','Running',12);














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


#identify Members who burns less  calories and AND HAVING less weight

SELECT MEMBER.MEMBER_ID ,Min(weight) MINWT FROM Member WHERE Member_id IN(
SELECT Member_id FROM Exercise WHERE CALORIES_BURNED <(
SELECT AVG(calories_burned) FROM Exercise))GROUP BY Member.Member_id;


#Members attending fitness training atleast two hours

SELECT Exercise_id,Exercise_type From Exercise 
WHERE Exercise_duration >=2;


#Select Machines with similar machine types.

SELECT DISTINCT M.Machine_id,M.Machine_type From Machine
M Inner join Machine N ON M.Machine_type=N.Machine_type;

#Display all Member healthrecord who are having  sleep hours 
#less than  average sleep_hours in each exercise type.


SELECT Record_id,daily_hours,heart_rate ,healthrecord.Member_id FROM
healthrecord INNER JOIN EXERCISE ON HealthRecord.Member_id=Exercise.Member_id
WHERE
sleep_hours<(

SELECT AVG(sleep_hours) FROM HealthRecord) GROUP BY Exercise_type;




#STORED PROCEDURE ON Fitness Tracker




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

DELIMITER //

CREATE TRIGGER update_aim_status_after_update
AFTER UPDATE ON Aim
FOR EACH ROW
BEGIN
  IF NEW.end_date < CURDATE() THEN
    UPDATE Aim SET status = 'Completed' WHERE aim_id = NEW.aim_id;
  END IF;
END;
//

DELIMITER ;

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

CREATE USER 'admin@localhost' IDENTIFIED BY 'administ1212';
GRANT SELECT, INSERT ON Member TO 'pk'@'localhost';
GRANT SELECT ON AIM TO 'pk'@'localhost';



