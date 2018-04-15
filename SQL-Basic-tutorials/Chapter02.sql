-- 2.1 SELECT 语句基础
/*
列的查询
SELECT <列名>, ...
  FROM <表明>;
*/
SELECT shohin_id, shohin_mei, shiire_tanka
FROM shop.Shopin;

/*
查询出表中的所有的列
SELECT *
FROM <表名>;
*/
SELECT *
FROM shop.Shopin;

/*
为列设置别名
SELECT <列名> AS <别名>, ...
FROM <表名>;
SELECT shohin_id	AS id,
	   shohin_mei	AS name,
       shiire_tanka AS tanka
  FROM shop.Shopin;
*/
SELECT shohin_id	AS 商品编号,
	   shohin_mei	AS 商品名称,
       shiire_tanka AS 进货单价
  FROM shop.Shopin;
  
/*
从结果中删除重复的行(DISTINCT)
NULL也被认为是一类数据，多条NULL会结合成一条
SELECT DISTINCT shohin_bunrui
FROM shop.Shopin;

DINSTINCT关键字只能用在第一个列名之前
*/
SELECT DISTINCT shiire_tanka
FROM shop.Shopin;

/*
根据WHERE语句来选择记录
SELECT <列名>, ...
FROM <表名>
WHERE <条件表达式>;
*/
SELECT shohin_mei, shohin_bunrui
FROM shop.Shopin
WHERE shohin_bunrui = '衣服';

-- 2.2 算术运算符和比较运算符
/*
对查询的列进行算术运算符运算
运算符是以行为单位进行计算的
对NULL进行计算时，结果还是NULL
*/
SELECT shohin_mei, hanbai_tanka,
	   hanbai_tanka * 2 AS hanbai_tanka_x2
FROM shop.Shopin;

/*
比较运算符, =, <>, >=, >, <=, <
不能对NULL用比较运算符
*/
SELECT shohin_mei, shiire_tanka
FROM shop.Shopin
WHERE shiire_tanka = NULL;

-- 可以用 IS NULL / IS NOT NULL
SELECT shohin_mei, shiire_tanka
FROM shop.Shopin
WHERE shiire_tanka IS NULL;

-- 2.3 逻辑运算符
/*
NOT 运算符(取反)
SELECT shohin_mei, shohin_bunrui
FROM shop.Shopin
WHERE hanbai_tanka < 1000;
*/
SELECT shohin_mei, shohin_bunrui
FROM shop.Shopin
WHERE NOT hanbai_tanka >= 1000;

/*
AND运算符和OR运算符
AND：当两侧条件都成立时整个查询条件才成立
OR：两侧条件有一个成立，则成立
*/
SELECT shohin_mei, shiire_tanka
FROM shop.Shopin
WHERE shohin_bunrui = '厨房用具'
  AND hanbai_tanka >= 3000;
  
SELECT shohin_mei, shiire_tanka
FROM shop.Shopin
WHERE shohin_bunrui = '厨房用具'
  OR hanbai_tanka >= 3000;
  
  
-- 习题
-- 2.1
SELECT shohin_mei, torokubi
FROM shop.Shopin
WHERE torokubi >= '2009-04-28';

-- 2.3
SELECT shohin_mei, hanbai_tanka, shiire_tanka
FROM shop.Shopin
WHERE hanbai_tanka - shiire_tanka >= 500;

SELECT shohin_mei, hanbai_tanka, shiire_tanka
FROM shop.Shopin
WHERE NOT hanbai_tanka - shiire_tanka < 500;

-- 2.4
SELECT shohin_mei, shohin_bunrui,
	   hanbai_tanka * 0.9 - shiire_tanka AS rieki
FROM shop.Shopin
WHERE hanbai_tanka * 0.9 - shiire_tanka > 100
  AND (shohin_bunrui = '办公用品'
       OR shohin_bunrui = '厨房用具');