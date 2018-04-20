-- 4.1 数据的插入

-- 创建一个ShohinIns表以供插入
CREATE TABLE ShohinIns(
shohin_id		CHAR(4)		 NOT NULL,
shohin_mei		VARCHAR(100) NOT NULL,
shohin_bunrui	VARCHAR(32)	 NOT NULL,
hanbai_tanka	INTEGER		 DEFAULT 0,
shiire_tanka	INTEGER		 ,
torokubi		DATE		 ,
PRIMARY KEY	(shohin_id));

/*
INSERT语句的基本语法
INSERT INTO <表名> (列1, 列2, 列3, ...)	-- 列清单
VALUES (值1, 值2, 值3, ...);				-- 值清单
*/

INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui,
					   hanbai_tanka, shiire_tanka, torokubi)
VALUES ('0001', 'T恤衫', '衣服', 1000, 500, '2009-09-20');

SELECT * FROM ShohinIns;

/*
多行插入
原则上,执行一次INSERT语句只插入一行数据
可以采取多行INSERT
*/
INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui,
					   hanbai_tanka, shiire_tanka, torokubi)
VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11'),
       ('0003', '运动T恤', '衣服', 4000, 2800, NULL),
	   ('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');

/*
插入语句可以省略列清单,这样VALUES子句会
默认按照从左到右的顺序赋给每一列

INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui,
					   hanbai_tanka, shiire_tanka, torokubi)
VALUES ('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');
该语句与下述一致
*/
INSERT INTO ShohinIns
VALUES ('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');

-- 可以给某一列赋予NULL值,前提是该列允许NULL值
INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui,
					   hanbai_tanka, shiire_tanka, torokubi)
VALUES ('0006', '叉子', '厨房用具', 500, NULL, '2009-09-20');

/*
插入默认值
在创建表时,DEFAULT <默认值>用于约束
当不被指定具体值时,插入的为默认值(没有设置默认值时,插入为NULL)
使用显示插入默认值时,只需在对应的列,插入DEFAULT即可
使用隐式的方法插入默认值,省略该列和该列的值
*/
-- 显示插入默认值
INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui,
					   hanbai_tanka, shiire_tanka, torokubi)
VALUES ('0007', '擦菜板', '厨房用具', DEFAULT, 790, '2009-04-28');

-- 从其他表复制数据

-- 创建用于插入数据的商品复制表
CREATE TABLE ShohinCopy(
shohin_id		CHAR(4)			NOT NULL,
shohin_mei		VARCHAR(100)	NOT NULL,
shohin_bunrui	VARCHAR(32)		NOT NULL,
hanbai_tanka	INTEGER			,
shiire_tanka	INTEGER			,
torokubi		DATE			,
PRIMARY KEY (shohin_id));

-- 用INSERT ... SELECT语句
INSERT INTO ShohinCopy (shohin_id, shohin_mei, shohin_bunrui,
					   hanbai_tanka, shiire_tanka, torokubi)
SELECT shohin_id, shohin_mei, shohin_bunrui,
					   hanbai_tanka, shiire_tanka, torokubi
FROM Shopin;

SELECT * FROM ShohinCopy;

-- 4.2 数据的删除
/*
DROP TABLE 语句可以将表完全删除
DELETE 语句会留下表,而删除表中的数据
*/

/*
DELETE语句的基本语法
DELETE FROM <表名>;
保留数据表,仅删除全部数据行的DELETE数据
*/

DELETE FROM Shopin;

/*
指定删除对象的DELETE语句
DELETE FROM <表名>
FROM <条件>;
不能使用GROUP BY, HAVING, ORDER BY三类子句
*/
-- 1175错误码 
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Shopin
WHERE hanbai_tanka >= 4000;

SELECT * FROM Shopin;

/*
只能删除表中全部数据的TRUNCATE语句
TRUNCATE <表名>;
使用TRUNCATE可以缩短执行时间
*/

-- 4.3 数据的更新
/*
UPDATE语句的基本语法
UPDATE <表名>
SET <列名> = <表达式>;
*/
UPDATE Shopin
SET torokubi = '2009-10-10';

SELECT * FROM Shopin;

/*
指定条件的UPDATE语句
UPDATE <表名>
SET <列名> = <表达式>
WHERE <条件>;
*/
UPDATE Shopin
SET hanbai_tanka = hanbai_tanka * 10
WHERE shohin_bunrui = '厨房用具';

-- 使用NULL进行更新(NULL清空)
UPDATE Shopin
SET torokubi = NULL
WHERE shohin_id = '0008';

-- 多列更新
UPDATE Shopin
SET hanbai_tanka = hanbai_tanka * 10,
	shiire_tanka = shiire_tanka / 2
WHERE shohin_bunrui = '厨房用具';

-- 4.4 事物
/*
需要在同一个处理单元中执行的一系列更新处理的集合
语法:
START TRANSACTION -- 事物开始语句;
	DML语句;
    DML语句;
    DML语句;
事物结束语句(COMMIT或者ROLLBACK);
*/

/*
COMMIT提交处理,处理顺序
事物开始语句 -> 执行更新语句 -> 执行COMMIT
结束后,所有的更新都被反映到了数据库中
*/
START TRANSACTION;
	-- 将运动T恤的销售单价降低1000日元
    UPDATE Shopin
    SET hanbai_tanka = hanbai_tanka - 1000
    WHERE shohin_mei = '运动T恤';
    
    -- 将T恤的销售单价上浮1000日元
    UPDATE Shopin
    SET hanbai_tanka = hanbai_tanka + 1000
    WHERE shohin_mei = 'T恤衫';
COMMIT;

/*
ROLLBACK取消处理
事物开始语句 -> 执行更新语句 -> 执行ROLLBACK
执行结束后,和执行前状态相同(即所有处理都被取消了)
*/
START TRANSACTION;
	-- 将运动T恤的销售单价降低1000日元
    UPDATE Shopin
    SET hanbai_tanka = hanbai_tanka - 1000
    WHERE shohin_mei = '运动T恤';
    
    -- 将T恤的销售单价上浮1000日元
    UPDATE Shopin
    SET hanbai_tanka = hanbai_tanka + 1000
    WHERE shohin_mei = 'T恤衫';
ROLLBACK;

-- 习题
-- 4.2
-- 报错,一行数据也无法添加,因为违反主键约束

-- 4.3
CREATE TABLE ShohinSaeki(
shohin_id		CHAR(4)		NOT NULL,
shohin_mei		CHAR(100)	NOT NULL,
hanbai_tanka	INTEGER		,
shiire_tank		INTEGER		,
saeki			INTEGER		,
PRIMARY KEY(shohin_id));

INSERT INTO ShohinSaeki 
SELECT shohin_id, shohin_mei, hanbai_tanka,
	   shiire_tanka, hanbai_tanka - shiire_tanka
FROM Shopin;

SELECT * FROM ShohinSaeki;

-- 4.4 
START TRANSACTION;
	UPDATE ShohinSaeki
    SET hanbai_tanka = 3000
    WHERE shohin_id = '0004';
    
    UPDATE ShohinSaeki
    SET saeki = hanbai_tanka - shiire_tank
    WHERE shohin_id = '0004';
COMMIT;