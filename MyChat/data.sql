

SELECT * FROM USER


/*初始化用户信息*/
INSERT INTO USER VALUES(NULL,'huage','123','the coder!','xxx.png','online');
INSERT INTO USER VALUES(NULL,'陆离','123','this is luli~','xxx.png','online');
INSERT INTO USER VALUES(NULL,'姜源','123','姜源二货!','xxx.png','online');

/*初始化分组*/
INSERT INTO `group` VALUES(NULL,1,'家人');
INSERT INTO `group` VALUES(NULL,1,'朋友');

/*初始化好友关系信息*/
INSERT INTO friends VALUES(1,2,1);
INSERT INTO friends VALUES(1,3,2);
INSERT INTO friends VALUES(2,1,1);


/*初始化消息列表*/
INSERT INTO message VALUES(NULL,'申请添加你为好友',1,2,1,1,'我答应嫁给你','',0,'2017-06-06');
INSERT INTO message VALUES(NULL,'申请添加你为好友',1,2,1,1,'我们结婚吧','',0,'2017-06-07');
INSERT INTO message VALUES(NULL,'申请添加你为好友',1,2,1,1,'我爱你一辈子','',0,'2017-06-08');

-- DELETE FROM `group`


SELECT * FROM `group`  WHERE user_id IN (1)

UPDATE message SET `read`=1  WHERE uid=1


SELECT * FROM message  WHERE uid=7

/*初始化群*/
INSERT INTO flock VALUES(NULL,'激情的java','/mychat/imgs/java.jpg');
INSERT INTO flock VALUES(NULL,'老铁一家人','/mychat/imgs/laotie.jpg');
INSERT INTO flock VALUES(NULL,'实现你的梦想','/mychat/imgs/dream.jpg');


/*初始化群关系*/
INSERT INTO flockrefuser VALUES(1,1);
INSERT INTO flockrefuser VALUES(2,1);
INSERT INTO flockrefuser VALUES(3,1);

INSERT INTO flockrefuser VALUES(6,2);
INSERT INTO flockrefuser VALUES(7,2);
INSERT INTO flockrefuser VALUES(8,2);




SELECT * FROM chatmessage WHERE `from` = 1 AND toid = 2 AND `type` = 1 ORDER BY `timestamp` DESC



SELECT * FROM chatmessage  WHERE `from`=1 AND toid=2 AND TYPE=1 ORDER BY `timestamp` DESC   LIMIT 0, 10 

SELECT * FROM chatmessage  WHERE `from`=1 AND toid=2 
UNION
SELECT * FROM chatmessage  WHERE `from`=2 AND toid=1 
ORDER BY `timestamp` DESC

SELECT * FROM chatmessage WHERE (`from`=1 AND toid=2) OR (`from`= 2 AND toid=1)


SELECT * FROM chatmessage  WHERE `from`=1 AND toid=2 
AND
SELECT * FROM chatmessage  WHERE `from`=2 AND toid=1 

SELECT COUNT(*) FROM chatmessage  WHERE `from`=1 AND toid=2 AND TYPE=1

DELETE FROM chatmessage WHERE content LIKE 'I love you~'

SELECT * FROM chatmessage  WHERE (`from`=1 AND toid=2) OR (`from`=1 AND toid=2) ORDER BY `timestamp` DESC


/*查看是否是好友关系*/
SELECT * FROM friends WHERE me = 1 AND friend =2
