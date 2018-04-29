-- 7.1 表的加减法

/*
在数据库领域，集合表示“记录的集合”，具体来说，
表、视图和查询的执行结果都是“记录的集合”
*/
USE shop;
-- 表的加法 UNION（并集）

-- 创建表并插入数据

CREATE TABLE Shohin2 (
shohin_id		CHAR(4) 		NOT NULL,
shohin_mei		VARCHAR(100)	NOT NULL,
shohin_bunrui	VARCHAR(32)		NOT NULL,
hanbai_tanka	INTEGER			,
shiire_tanka	INTEGER			,
torokubi		date			,
PRIMARY KEY (shohin_id));

START TRANSACTION;

INSERT INTO Shohin2 VALUES ('0001', 'T恤衫', '衣服', 1000, 500, '2008-09-20');
INSERT INTO Shohin2 VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
INSERT INTO Shohin2 VALUES ('0003', '运动T恤', '衣服', 4000, 2800, NULL);
INSERT INTO Shohin2 VALUES ('0009', '手套', '衣服', 800, 500, NULL);
INSERT INTO Shohin2 VALUES ('0010', '水壶', '厨房用具', 2000, 1700, '2009-09-20');

COMMIT;

/*
表加法运算，将Shopin和Shohin2的数据并起来
1. 作为运算对象的记录的列数必须相同
2. 作为运算对象的记录中列的类型必须一致
3. 可以使用任何SELECT语句，但ORDER BY子句只能在最后一次使用

*/
SELECT shohin_id, shohin_mei
FROM Shopin
UNION
SELECT shohin_id, shohin_mei
FROM Shohin2;

SELECT shohin_id, shohin_mei
FROM Shopin
WHERE shohin_bunrui = '厨房用具'
UNION
SELECT shohin_id, shohin_mei
FROM Shopin
WHERE shohin_bunrui = '厨房用具'
ORDER BY shohin_id;

/*
采用 UNION 执行并集操作会将重复的行去掉
使用 UNION ALL 可以保留重复的行
*/
SELECT shohin_id, shohin_mei
FROM Shopin
UNION ALL
SELECT shohin_id, shohin_mei
FROM Shohin2;

/*
UNION 和 UNION ALL的区别
1. UNION 在进行表链接后会筛选掉重复的行
   UNION ALL不会去除重复的行
2. UNION将会按照字段的顺序进行排序
   UNION ALL只是简单的将两个结果合并后返回
3. UNION ALL效率上比UNION高很多
*/

-- 7.2 联结
/*
联结：就是将其他表中的列添加过来，进行“添加列”的运算
使用联结就可以从多张表中选取数据了
*/

/*
内联结 -- INNER JOIN
对于多张表来说，列可以大致分为两类：
1. 每张表都包含的列
2. 只存在于一张表内的列
联结运算就是“用相同的列，将每张表满足相同条件的列汇集到同一结果之中”
*/

SELECT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id,
	   S.shohin_mei, S.hanbai_tanka
FROM TenpoShohin AS TS INNER JOIN Shopin AS S
	 ON TS.shohin_id = S.shohin_id;		-- ON 子句表示联结的条件
     
SELECT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id,
	   S.shohin_id, S.hanbai_tanka
FROM TenpoShohin AS TS INNER JOIN Shopin AS S
	 ON TS.shohin_id = S.shohin_id
WHERE TS.tenpo_id = '000A';

-- 外联结 -- OUTER JOIN

/*
选取单张表中全部的信息
大致就是以一张表为主表，然后选取全部的数据，然后另一张表往主表这边插
LEFT 和 RIGHT 决定哪个是主表
*/
SELECT TS.tenpo_id, TS.tenpo_mei,
	   S.shohin_id, S.shohin_mei, S.hanbai_tanka
FROM TenpoShohin AS TS RIGHT OUTER JOIN Shopin AS S
	 ON TS.shohin_id = S.shohin_id;
     
SELECT TS.tenpo_id, TS.tenpo_mei,
	   S.shohin_id, S.shohin_mei, S.hanbai_tanka
FROM TenpoShohin AS TS LEFT OUTER JOIN Shopin AS S
	 ON TS.shohin_id = S.shohin_id;
     
-- 三张以上表的联结
CREATE TABLE ZaikoShohin(
souko_id		CHAR(4) 	NOT NULL,
shohin_id		CHAR(4)		NOT NULL,
zaiko_suryo		INTEGER		NOT NULL,
PRIMARY KEY (souko_id, shohin_id));

START TRANSACTION;
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo)
			VALUES ('S001', '0001', 0);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo)
			VALUES ('S001', '0002', 120);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo)
			VALUES ('S001', '0003', 200);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo)
			VALUES ('S001', '0004', 3);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo)
			VALUES ('S001', '0005', 0);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo)
			VALUES ('S001', '0006', 99);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo)
			VALUES ('S001', '0007', 999);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo)
			VALUES ('S001', '0008', 200);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo)
			VALUES ('S002', '0001', 10);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo)
			VALUES ('S002', '0002', 25);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo)
			VALUES ('S002', '0003', 34);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo)
			VALUES ('S002', '0004', 19);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo)
			VALUES ('S002', '0005', 99);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo)
			VALUES ('S002', '0006', 0);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo)
			VALUES ('S002', '0007', 0);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo)
			VALUES ('S002', '0008', 18);
COMMIT;


SELECT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id,
	   S.shohin_mei, S.hanbai_tanka, ZS.zaiko_suryo
FROM TenpoShohin AS TS INNER JOIN Shopin AS S
	 ON TS.shohin_id = S.shohin_id
			INNER JOIN ZaikoShohin AS ZS
            ON TS.shohin_id = ZS.shohin_id
WHERE ZS.souko_id = 'S001';

-- 交叉联结 -- CROSS JOIN (笛卡尔积)
SELECT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id, S.shohin_mei
FROM TenpoShohin AS TS CROSS JOIN Shopin AS S;

-- 习题
-- 7.2 
SELECT COALESCE(TS.tenpo_id, '不明') AS tenpo_id,
	   COALESCE(TS.tenpo_mei, '不明') AS tenpo_mei,
       S.shohin_id, S.shohin_mei, S.hanbai_tanka
FROM TenpoShohin AS TS RIGHT OUTER JOIN Shopin AS S
	 ON TS.shohin_id = S.shohin_id;
     
SELECT IF(TS.tenpo_id IS NULL, '不明', TS.tenpo_id) AS tenpo_id,
	   IF(TS.tenpo_mei IS NULL, '不明', TS.tenpo_mei) AS tenpo_mei,
       S.shohin_id, S.shohin_mei, S.hanbai_tanka
FROM TenpoShohin AS TS RIGHT OUTER JOIN Shopin AS S
	 ON TS.shohin_id = S.shohin_id;