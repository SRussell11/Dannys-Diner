CREATE TABLE sales (
  "customer_id" VARCHAR(1),
  "order_date" DATE,
  "product_id" INTEGER
);

INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 
CREATE TABLE menu (
  "product_id" INTEGER,
  "product_name" VARCHAR(5),
  "price" INTEGER
);

INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  "customer_id" VARCHAR(1),
  "join_date" DATE
);

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');


SELECT s.customer_id,sum(price) as "Total Amount Spent"
FROM sales as s
INNER JOIN menu as m on s.product_id =m.product_id
GROUP BY customer_id;
 

SELECT customer_id, COUNT (DISTINCT order_date)as "Total Days Visted"
FROM sales
GROUP BY customer_id;

SELECT DISTINCT (s.customer_id),s.product_id, s.order_date, m.product_name
FROM sales as s
INNER JOIN menu as m on m.product_id = s.product_id
ORDER BY s.order_date
offset 0 rows
fetch next 4 rows only

SELECT product_id, count(product_id)as "total purchased", product_name
FROM sales 
GROUP BY product_name


SELECT (COUNT(s.product_id)) AS most_purchased, product_name
FROM sales AS s
JOIN menu AS m
 ON s.product_id = m.product_id
GROUP BY s.product_id, product_name
ORDER BY most_purchased DESC


SELECT DISTINCT(s.customer_ID),(COUNT(s.product_id)) AS total_purchased, product_name
FROM sales AS s
JOIN menu AS m
 ON s.product_id = m.product_id
GROUP BY s.customer_id, product_name
ORDER BY total_purchased DESC


SELECT s.customer_id,s.order_date, b.join_date, s.product_id
FROM sales AS s
JOIN members AS b
ON s.customer_id = b.customer_id
WHERE s.order_date >=b.join_date
ORDER BY s.order_date 


SELECT s.customer_id,s.order_date, b.join_date, s.product_id
FROM sales AS s
JOIN members AS b
ON s.customer_id = b.customer_id
WHERE s.order_date < b.join_date
ORDER BY s.order_date 


SELECT s.customer_id,count(distinct s.product_id) as menu_item, sum(m.price) as total_cost
FROM sales AS s
JOIN members AS b
ON s.customer_id = b.customer_id
JOIN menu AS m
ON s.product_id = m.product_id
WHERE s.order_date < b.join_date
GROUP BY s.customer_id


 SELECT *, 
 CASE
  WHEN product_id = 1 THEN price * 20
  ELSE price * 10
  END AS points
 FROM menu as price_points



SELECT s.customer_id,
SUM(
	CASE
  	WHEN m.product_name = 'sushi' THEN 20 * price
  	ELSE 10 * PRICE
	END
) AS Points
FROM sales as s
	JOIN menu as m
	ON s.product_id = m.product_id
GROUP BY
s.customer_id
ORDER BY
s.customer_id;

SELECT
s.customer_id,
SUM(
	CASE
	WHEN m.product_name = 'sushi' THEN 20 * price
	WHEN order_date BETWEEN '2021-01-07' AND '2021-01-14' THEN 20 * price
	ELSE 10 * PRICE
	END
) AS Points
FROM sales as s
	JOIN menu as m
	ON s.product_id = m.product_id
	JOIN members as b
	ON b.customer_id = s.customer_id
GROUP BY
s.customer_id
ORDER BY
s.customer_id;


