-- 3-1 对表进行聚合查询

/*
聚合函数:
COUNT: 计算表中的记录数(行数)
SUM: 计算表中数值列的数据合计值
AVG: 计算表中数值列的数据平均值
MAX: 求出表中任意列中数据的最大值
MIN: 求出表中任意列中数据的最小值
*/


/*
计算表中数据的行数:
COUNT(*)表示计算表的行数
COUNT(<列名>)表示据算除NULL以外数据的行数
*/
SELECT COUNT(*), COUNT(shiire_tanka)
FROM Shopin;

/*
计算合计值(不能用*作为参数)
SUM(<列名>)
*/
SELECT SUM(hanbai_tanka)
FROM Shopin;

/*
计算平均值
*/
SELECT AVG(hanbai_tanka)
FROM Shopin;

/*
计算最大值和最小值
可以适用于任意类型的列
*/
SELECT MAX(hanbai_tanka), MIN(shiire_tanka),
       MAX(torokubi), MIN(torokubi)
FROM Shopin;

/*
使用聚合函数删除重复值(关键字DISTINCT)
可以使用聚合函数计算去除重复数据后的数据
*/
SELECT COUNT(DISTINCT shohin_bunrui),
	   SUM(hanbai_tanka), SUM(DISTINCT hanbai_tanka)
FROM Shopin;

-- 3-2 对表进行分组
/*
GROUP BY子句
可以对数据进行分组后再使用聚合函数
SELECT <列名1>, <列名2>, <列名3>, ...
FROM <表名>
GROUP BY <列名1>, <列名2>, <列名3>, ...
常与聚合函数一起使用
*/
-- 统计每个商品具体的物品数量
SELECT shohin_bunrui, COUNT(*)
FROM Shopin
GROUP BY shohin_bunrui;

-- 如果聚合键中包含NULL时,也会将NULL作为一组特定的数据
SELECT shiire_tanka, COUNT(*)
FROM Shopin
GROUP BY shiire_tanka;

-- 3.3 为聚集结果指定条件
/*
HAVING子句
通过指定条件选取特定组
SELECT <列名1>, <列名2>, <列名3>, ...
FROM <表名>
GROUP BY <列名1>, <列名2>, <列名3>, ...
HAVING <分组结果对应的条件>

WHERE子句 = 指定行所对应的条件
HAVING子句 = 指定组所对应的条件
条件写在WHERE子句要比写在HAVING子句中的处理速度要快
*/
SELECT shohin_bunrui, COUNT(*)
FROM Shopin
GROUP BY shohin_bunrui
HAVING COUNT(*) = 2;

SELECT shohin_bunrui, AVG(hanbai_tanka)
FROM Shopin
GROUP BY shohin_bunrui
HAVING AVG(hanbai_tanka) >= 2500;

-- 3.4 对查询结果进行排序
/*
ORDER BY子句
用于指定排列顺序
SELECT <列名1>, <列名2>, <列名3>, ...
FROM <表名>
ORDER BY <排序基准列1>, <排序基准列2>, ...;
默认升序(ASC)
降序排序(DESC)

对NULL排序时,NULL的排序结果会在开头或者末尾
*/
SELECT shohin_id, shohin_mei, hanbai_tanka, shiire_tanka
FROM Shopin
ORDER BY hanbai_tanka;

SELECT shohin_id, shohin_mei, hanbai_tanka, shiire_tanka
FROM Shopin
ORDER BY hanbai_tanka DESC;

SELECT shohin_id, shohin_mei, hanbai_tanka, shiire_tanka
FROM Shopin
ORDER BY hanbai_tanka, shohin_id;

-- 可以使用聚合函数
SELECT shohin_bunrui, COUNT(*)
FROM Shopin
GROUP BY shohin_bunrui
ORDER BY COUNT(*);

/*
子句书写顺序
1. SELECT子句
2. FROM子句
3. WHERE子句
4. GROUP BY子句
5. HAVING子句
6. ORDER BY子句

子句执行顺序
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
*/


-- 练习题

-- 3.2
SELECT shohin_bunrui,
	   SUM(hanbai_tanka) AS sum1,
       SUM(shiire_tanka) AS sum2
FROM Shopin
GROUP BY shohin_bunrui
HAVING sum1 >= sum2 * 1.5;

-- 3.3
SELECT *
FROM Shopin
ORDER BY torokubi DESC, shiire_tanka;