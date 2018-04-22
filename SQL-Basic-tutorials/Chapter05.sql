-- 5.1 视图

/*
数据库中的数据实际上会被保存到计算机的存储设备中
当进行SELECT语句查询时，实际上是从存储设备中读取数据

视图不会将数据保存到存储设备中，也不会保存到其他任何地方
视图保存的是SELECT语句，从视图中读取数据时，视图会在内部
执行该SELECT语句并创建出一张临时表。

视图的优点：
视图无需保存数据，因此可以节省存储设备的容量
可以将频繁使用的SELECT语句保存成视图，这样就不用每次都重新书写了

创建视图方法(CREATE VIEW子句)：
CREATE VIEW 视图名称(<视图列名1>， <视图列名2>, ...)
AS
<SELECT语句>；
SELECT语句中的第一列就是视图中的第一列，以此类推
*/
USE shop;

CREATE VIEW ShohinSum(shohin_bunrui, cnt_shohin)
AS
SELECT shohin_bunrui, COUNT(*)
FROM Shopin
GROUP BY shohin_bunrui;

SELECT * FROM ShohinSum;

/*
使用视图的查询时的步骤
首先执行定义视图的SELECT语句
然后根据得到的结果，再执行再FROM子句中使用视图的SELECT语句

尽量避免在视图的基础上创建视图，会降低SQL的性能
*/

CREATE VIEW ShohinSumJim (shohin_bunrui, cnt_shohin)
AS
SELECT shohin_bunrui, cnt_shohin
FROM ShohinSum
WHERE shohin_bunrui = '办公用品';

SELECT * FROM ShohinSumJim;

/*
视图的限制：
定义视图时不能使用ORDER BY子句（因为和表一样，数据行时没有顺序的）
对于视图的更新，由于视图和表需要同时更新，所以通过聚合得到的视图无法进行更新
*/

CREATE VIEW ShohinJim (shohin_id, shohin_mei, shohin_bunrui,
						hanbai_tanka, shiire_tanka, torokubi)
AS
SELECT * 
FROM Shopin
WHERE shohin_bunrui = '办公用品';

SELECT * FROM ShohinJim;

INSERT INTO ShohinJim 
VALUES('0009', '印章', '办公用品', 95, 10, '2009-11-30');

SELECT * FROM Shopin;

DELETE FROM Shopin
WHERE shohin_id = '0009';

/*
删除视图
DROP VIEW 视图名称；
*/
DROP VIEW ShohinSum;

-- 5.2 子查询

/*
子查询就是将用来定义视图的SELECT语句直接用于FROM子句当中

下面两种查询方式一致
*/
-- 利用视图进行查询
CREATE VIEW ShohinSum(shohin_bunrui, cnt_shohin)
AS
SELECT shohin_bunrui, COUNT(*)
FROM Shopin
GROUP BY shohin_bunrui;

SELECT shohin_bunrui, cnt_shohin
FROM ShohinSum;

-- 子查询
SELECT shohin_bunrui, cnt_shohin
FROM (SELECT shohin_bunrui, COUNT(*) AS cnt_shohin
	  FROM Shopin
      GROUP BY shohin_bunrui) AS ShohinSum;
      
-- 子查询嵌套
SELECT shohin_bunrui, cnt_shohin
FROM (SELECT * 
	  FROM (SELECT shohin_bunrui, COUNT(*) AS cnt_shohin
			FROM Shopin
            GROUP BY shohin_bunrui) AS ShohinSum
	  WHERE cnt_shohin = 4) AS ShohinSum2;
      
/*
标量子查询(返回单一值的子查询)
*/
SELECT shohin_id, shohin_mei, hanbai_tanka
FROM Shopin
WHERE hanbai_tanka > (SELECT AVG(hanbai_tanka)
					  FROM Shopin);
                      
-- 5.3 关联子查询

/*
在细分的组内进行比较时，需要使用关联子查询
大概就是在子查询中添加WHERE子句条件
*/
SELECT shohin_id, shohin_mei, hanbai_tanka
FROM Shopin AS S1
WHERE hanbai_tanka > (SELECT AVG(hanbai_tanka)
					  FROM Shopin AS S2
                      WHERE S1.shohin_bunrui = S2.shohin_bunrui
                      GROUP BY shohin_bunrui);
                      
-- 练习题
-- 5.1
CREATE VIEW ViewRenshu5_1(shohin_mei, hanbai_tanka, torokubi)
AS
SELECT shohin_mei, hanbai_tanka, torokubi
FROM Shopin
WHERE hanbai_tanka >= 1000 AND
	  torokubi = '2009-9-20';
      
SELECT * FROM ViewRenshu5_1;

-- 5.3
SELECT shohin_id, shohin_mei,
	   shohin_bunrui, hanbai_tanka,
       (SELECT AVG(hanbai_tanka) FROM Shopin) AS hanbai_tanka_all
FROM Shopin;

-- 5.4
CREATE VIEW AvgTankByBunrui(shohin_id, shohin_mei,
						    shohin_bunrui, hanbai_tanka,
							avg_hanbai_tanka)
AS
SELECT shohin_id, shohin_mei,
	   shohin_bunrui, hanbai_tanka,
	   (SELECT AVG(hanbai_tanka)
        FROM Shopin AS S2
        WHERE S1.shohin_bunrui = S2.shohin_bunrui
        GROUP BY S1.shohin_bunrui) AS avg_hanbai_tanka
FROM Shopin AS S1;

SELECT * FROM AvgTankByBunrui;
