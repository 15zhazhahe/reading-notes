-- 6-1 各种各样的函数

/*
算术函数（用来进行数值计算的函数）
字符串函数（用来进行字符串操作的函数）
日期函数（用来进行日期操作的函数）
转换函数（用来转换数据类型和值的函数）
聚合函数（用来进行数据聚合的函数）
*/
USE shop;
-- 算术函数
-- DDL：创建SampleMath表
CREATE TABLE SampleMath(
m	NUMERIC (10, 3),
n	INTEGER,
p	INTEGER);

-- DML：插入数据
START TRANSACTION;

INSERT INTO SampleMath(m, n, p) VALUES (500, 0, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (-180, 0, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, NULL, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 7, 3);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 5, 2);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 4, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (8, NULL, 3);
INSERT INTO SampleMath(m, n, p) VALUES (2.27, 1, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (5.555, 2, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 1, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (8.76, NULL, NULL);

COMMIT;

SELECT * FROM SampleMath;

/*
绝对值ABS函数：
ABS(数值)
NULL的结果为NULL
*/
SELECT m, ABS(m) AS abs_col
FROM SampleMath;

/*
取摸MOD函数：
MOD(被除数，除数)
*/
SELECT n, p, MOD(n, p) AS mod_col
FROM SampleMath;

/*
四舍五入ROUND函数：
ROUND(对象数值，保留小数的位数)
*/
SELECT m, n, ROUND(m, n) AS round_col
FROM SampleMath;

-- 字符串函数
-- DDL：创建SampleStr表
CREATE TABLE SampleStr(
str1	VARCHAR(40),
str2	VARCHAR(40),
str3	VARCHAR(40));

-- DML：插入数据
START TRANSACTION;

INSERT  INTO SampleStr (str1, str2, str3) VALUES('opx', 'rt', NULL);
INSERT  INTO SampleStr (str1, str2, str3) VALUES('abc', 'def', NULL);
INSERT  INTO SampleStr (str1, str2, str3) VALUES('山田', '太郎', '是我');
INSERT  INTO SampleStr (str1, str2, str3) VALUES('aa', NULL, NULL);
INSERT  INTO SampleStr (str1, str2, str3) VALUES(NULL, 'xyz', NULL);
INSERT  INTO SampleStr (str1, str2, str3) VALUES('@!#$%', NULL, NULL);
INSERT  INTO SampleStr (str1, str2, str3) VALUES('ABC', NULL, NULL);
INSERT  INTO SampleStr (str1, str2, str3) VALUES('aBC', NULL, NULL);
INSERT  INTO SampleStr (str1, str2, str3) VALUES('abc太郎', 'abc', 'ABC');
INSERT  INTO SampleStr (str1, str2, str3) VALUES('abcdefabc', 'abc', 'ABC');
INSERT  INTO SampleStr (str1, str2, str3) VALUES('micmic', 'i', 'I');

COMMIT;

SELECT * FROM SampleStr;

/*
在MySQL中的，字符串拼接函数CONCAT函数
CONCAT(str, str, str)
*/
SELECT str1, str2, str3,
	   CONCAT(str1, str2) AS str_concat
FROM SampleStr;

/*
求字符串长度LENGTH函数
是以字节为单位来表示长度的
*/
SELECT str1, LENGTH(str1) AS len_str
FROM SampleStr;

/*
小写转换LOWER函数：将字符串中的所有字母转换为小写
LOWER(字符串)
大写转换UPPER函数
*/
SELECT str1, LOWER(str1) AS low_str
FROM SampleStr
WHERE str1 IN ('ABC', 'aBC', 'abc', '山田');

SELECT str1, UPPER(str1) AS low_str
FROM SampleStr
WHERE str1 IN ('ABC', 'aBC', 'abc', '山田');

/*
字符串替换REPLACE函数：将字符串的一部分替换成其他字符串
REPLACE(对象字符串, 替换前字符串, 替换后字符串)
*/
SELECT str1, str2, str3,
	   REPLACE(str1, str2, str3) AS rep_str
FROM SampleStr;

/*
字符串截取SUBSTRING函数
SUBSTRING(对象字符串 FROM 截取位置 FOR 截取的字符数)
*/
SELECT str1, substring(str1 FROM 3 FOR 2) AS sub_str
FROM SampleStr;

-- 日期函数

-- 获取当前日期 CURRENT_DATE
SELECT CURRENT_DATE;

-- 获取当前时间 CURRENT_TIME
SELECT CURRENT_TIME;

-- 获取当前日期和时间
SELECT CURRENT_TIMESTAMP;

/*
截取日期元素
EXTRACT(日期元素 FROM 日期)
*/
SELECT CURRENT_TIMESTAMP,
	   EXTRACT(YEAR		FROM CURRENT_TIMESTAMP) AS year,
       EXTRACT(MONTH	FROM CURRENT_TIMESTAMP)	AS month,
       EXTRACT(DAY		FROM CURRENT_TIMESTAMP) AS day,
       EXTRACT(HOUR		FROM CURRENT_TIMESTAMP) AS hour,
       EXTRACT(MINUTE 	FROM CURRENT_TIMESTAMP) AS minute,
       EXTRACT(SECOND	FROM CURRENT_TIMESTAMP) AS second;
       
-- 转换函数
/*
类型转换CAST函数
CAST(转换前的值 AS 想要转换的数据类型)
*/
-- 将字符串转换为数值类型
SELECT CAST('0001' AS SIGNED INTEGER) AS int_col;

-- 将字符串转换为日期类型
SELECT CAST('2009-12-14' AS DATE) AS date_col;

/*
将NULL转换为其他值COALESCE函数
COALESCE(数据1, 数据2, 数据3, ...)
*/
SELECT COALESCE(NULL, 1) AS col_1,
	   COALESCE(NULL, 'test', NULL) AS col_2,
       COALESCE(NULL, NULL, '2009-11-01') AS col_3;
       
-- 6-2 谓词
/*
谓词为返回值为真值的函数
谓词有：
LIKE; BETWEEN; IS NULL, IS NOT NULL
IN; EXISTS
*/

-- LIKE谓词--字符串的部分一致查询（模糊查询）
-- DDL：创建表
CREATE TABLE SampleLike(
strcol 	VARCHAR(6)	NOT NULL,
PRIMARY KEY (strcol));

-- DML：插入数据
START TRANSACTION;

INSERT INTO SampleLike(strcol) VALUES('abcddd');
INSERT INTO SampleLike(strcol) VALUES('dddabc');
INSERT INTO SampleLike(strcol) VALUES('abdddc');
INSERT INTO SampleLike(strcol) VALUES('abcdd');
INSERT INTO SampleLike(strcol) VALUES('ddabc');
INSERT INTO SampleLike(strcol) VALUES('abddc');

COMMIT;

-- % 匹配“0字符以上的任意字符串”
SELECT * FROM SampleLike
WHERE strcol LIKE 'ddd%';

SELECT * FROM SampleLike
WHERE strcol LIKE '%ddd%';

SELECT * FROM SampleLike
WHERE strcol LIKE '%ddd';

-- _ 匹配"任意一个字符"
SELECT * FROM SampleLike
WHERE strcol LIKE 'abc__';

-- BETWEEN谓词--范围查询
SELECT shohin_mei, hanbai_tanka
FROM Shopin
WHERE hanbai_tanka BETWEEN 300 AND 1000;

SELECT shohin_mei, hanbai_tanka
FROM Shopin
WHERE hanbai_tanka >= 300
	  AND hanbai_tanka <= 1000;
      
-- IS NULL, IS NOT NULL--判断是否为NULL
SELECT shohin_mei, shiire_tanka
FROM Shopin
WHERE shiire_tanka IS NULL;

SELECT shohin_mei, shiire_tanka
FROM Shopin
WHERE shiire_tanka IS NOT NULL;

/*
IN谓词--OR的简便用法
无法选取出NULL数据的
*/
SELECT shohin_mei, shiire_tanka
FROM Shopin
WHERE shiire_tanka = 320
	  OR shiire_tanka = 500
      OR shiire_tanka = 5000;

SELECT shohin_mei, shiire_tanka
FROM Shopin
WHERE shiire_tanka IN (320, 500, 5000);

SELECT shohin_mei, shiire_tanka
FROM Shopin
WHERE shiire_tanka NOT IN (320, 500, 5000);

-- 使用子查询作为IN谓词的参数
-- 创建数据库
CREATE TABLE TenpoShohin(
tenpo_id	CHAR(4) 		NOT NULL,
tenpo_mei	VARCHAR(200)	NOT NULL,
shohin_id	CHAR(4) 		NOT NULL,
suryo		INTEGER			NOT NULL,
PRIMARY KEY (tenpo_id, shohin_id));

-- 插入数据
START TRANSACTION;

INSERT INTO TenpoShohin(tenpo_id, tenpo_mei, shohin_id, suryo) 
	   VALUES('000A', '东京', '0001', 30);
INSERT INTO TenpoShohin(tenpo_id, tenpo_mei, shohin_id, suryo) 
	   VALUES('000A', '东京', '0002', 50);
INSERT INTO TenpoShohin(tenpo_id, tenpo_mei, shohin_id, suryo) 
	   VALUES('000A', '东京', '0003', 15);
INSERT INTO TenpoShohin(tenpo_id, tenpo_mei, shohin_id, suryo) 
	   VALUES('000B', '名古屋', '0002', 30);
INSERT INTO TenpoShohin(tenpo_id, tenpo_mei, shohin_id, suryo) 
	   VALUES('000B', '名古屋', '0003', 120);
INSERT INTO TenpoShohin(tenpo_id, tenpo_mei, shohin_id, suryo) 
	   VALUES('000B', '名古屋', '0004', 20);
INSERT INTO TenpoShohin(tenpo_id, tenpo_mei, shohin_id, suryo) 
	   VALUES('000B', '名古屋', '0006', 10);
INSERT INTO TenpoShohin(tenpo_id, tenpo_mei, shohin_id, suryo) 
	   VALUES('000B', '名古屋', '0007', 40);
INSERT INTO TenpoShohin(tenpo_id, tenpo_mei, shohin_id, suryo) 
	   VALUES('000C', '大阪', '0003', 20);
INSERT INTO TenpoShohin(tenpo_id, tenpo_mei, shohin_id, suryo) 
	   VALUES('000C', '大阪', '0004', 50);
INSERT INTO TenpoShohin(tenpo_id, tenpo_mei, shohin_id, suryo) 
	   VALUES('000C', '大阪', '0006', 90);
INSERT INTO TenpoShohin(tenpo_id, tenpo_mei, shohin_id, suryo) 
	   VALUES('000C', '大阪', '0007', 70);
INSERT INTO TenpoShohin(tenpo_id, tenpo_mei, shohin_id, suryo) 
	   VALUES('000D', '福冈', '0001', 100);
       
COMMIT;

-- 使用子查询作为IN的参数
SELECT shohin_mei, hanbai_tanka
FROM Shopin
WHERE shohin_id IN (SELECT shohin_id
					FROM TenpoShohin
                    WHERE tenpo_id = '000C');
                    
-- EXIST谓词
SELECT shohin_mei, hanbai_tanka
FROM Shopin AS S
WHERE EXISTS (SELECT *
			  FROM TenpoShohin AS TS
              WHERE TS.tenpo_id = '000C'
					AND TS.shohin_id = S.shohin_id);
                    
-- CASE表达式
/*
CASE表达式的语法
CASE WHEN <判断表达式> THEN <表达式>
CASE WHEN <判断表达式> THEN <表达式>
CASE WHEN <判断表达式> THEN <表达式>
	 .
     .
     .
     ELSE <表达式>
END
*/
SELECT shohin_mei, shohin_bunrui,
	   CASE WHEN shohin_bunrui = '衣服'
			THEN CONCAT('A: ',shohin_bunrui)
			WHEN shohin_bunrui = '办公用品'
            THEN CONCAT('B: ', shohin_bunrui)
            WHEN shohin_bunrui = '厨房用具'
            THEN CONCAT('C: ', shohin_bunrui)
            ELSE NULL
		END AS abc_shohin_bunrui
FROM Shopin;

SELECT SUM(CASE WHEN shohin_bunrui = '衣服'
				THEN hanbai_tanka
                ELSE 0
                END) AS sum_tanka_ihuku,
		SUM(CASE WHEN shohin_bunrui = '厨房用具'
				THEN hanbai_tanka
                ELSE 0
                END) AS sum_tanka_kitchen,
		SUM(CASE WHEN shohin_bunrui = '办公用品'
				THEN hanbai_tanka
                ELSE 0
                END) AS sum_tanka_jimu
FROM Shopin;

SELECT shohin_mei,
	   IF(shohin_bunrui = '衣服', 
			CONCAT('A:', shohin_bunrui), NULL)
FROM Shopin;

-- 练习题
-- 6.1
SELECT shohin_mei, shiire_tanka
FROM Shopin
WHERE shiire_tanka NOT IN (500, 2800, 5000);

SELECT shohin_mei, shiire_tanka
FROM Shopin
WHERE shiire_tanka NOT IN (500, 2800, 5000, NULL);

-- 6.2
SELECT SUM(IF ( hanbai_tanka <= 1000,
			1, 0)) AS low_price,
	   SUM(IF ( hanbai_tanka > 1000 AND hanbai_tanka <= 3000,
			1, 0)) AS mid_price,
	   SUM(IF ( hanbai_tanka > 3000,
			1, 0)) AS high_price
FROM Shopin;