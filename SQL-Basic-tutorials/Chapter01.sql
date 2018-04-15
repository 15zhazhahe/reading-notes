-- 1.4 表的创建
/* 
数据库创建：
CREATE DATABASE <数据库名称>
*/
CREATE DATABASE shop;

/*
表的创建：
CREATE TABLE <表名>
(
<列名1> <数据类型> <该列所需约束>，
<列名2> <数据类型> <该列所需约束>，
<列名3> <数据类型> <该列所需约束>，
<列名4> <数据类型> <该列所需约束>，
			.
			.
			.
<该表的约束1>,<该表的约束2>,...);
*/
USE shop;
CREATE TABLE Shopin
(
-- 长度为4的char字段，若单元格的内容长度不够，一般用空格补齐
shohin_id	CHAR(4)		NOT NULL,		-- 商品编号，非空约束
-- 长度最长为100的可变长字段
shohin_mei	VARCHAR(100) NOT NULL,		-- 商品名称
shohin_bunrui	VARCHAR(32)	NOT NULL,	-- 商品分类
hanbai_tanka	INTEGER	, 				-- 销售单价，整型字段
shiire_tanka	INTEGER	,				-- 进货单价
torokubi		date	,				-- 登记日期
PRIMARY KEY (shohin_id));				-- 主键约束


-- 1.5 表的删除和更新

/*
表的删除：
DROP TABLE <表名> ;
*/

DROP TABLE shop.Shopin;

/*
添加列的ALTER TABLE语句：
ALTER TABLE <表名> ADD COLUMN <列的定义> ;
*/

ALTER TABLE shop.Shopin ADD COLUMN shohin_mei_kana VARCHAR(100);
SELECT * from shop.Shopin;

/*
删除列的ALTER TABLE语句：
ALTER TABLE <> DROP COLUMN <列名> ;
*/

ALTER TABLE shop.Shopin DROP COLUMN shohin_mei_kana;
SELECT * from shop.Shopin;


-- 习题
-- 1.1
CREATE TABLE shop.Jyushoroku(			-- 地址簿
toroku_bango 	INTEGER NOT NULL,		-- 注册编号
name 			VARCHAR(128) NOT NULL,	-- 姓名
jyusho			VARCHAR(256) NOT NULL, 	-- 住址
tel_no			CHAR(10),				-- 电话号码
mail_address	CHAR(20),				-- 邮件地址
PRIMARY KEY(toroku_bango));

-- 1.2
ALTER TABLE shop.Jyushoroku ADD COLUMN yubin_bango CHAR(8) NOT NULL;
SELECT * FROM shop.Jyushoroku;

-- 1.3
DROP TABLE shop.Jyushoroku;

-- DML 插入数据
START TRANSACTION;

INSERT INTO shop.Shopin VALUES ('0001', 'T恤衫', '衣服', 1000, 500, '2009-09-20');
INSERT INTO shop.Shopin VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
INSERT INTO shop.Shopin VALUES ('0003', '运动T恤', '衣服', 4000, 2800, NULL);
INSERT INTO shop.Shopin VALUES ('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');
INSERT INTO shop.Shopin VALUES ('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');
INSERT INTO shop.Shopin VALUES ('0006', '叉子', '厨房用具', 500, NULL, '2009-09-20');
INSERT INTO shop.Shopin VALUES ('0007', '擦菜板', '厨房用具', 880, 790, '2008-04-28');
INSERT INTO shop.Shopin VALUES ('0008', '圆珠笔', '办公用品', 100, NULL, '2009-11-11');

COMMIT;

SELECT * 
FROM shop.Shopin;