/* ---------------------------------------------------------------------------------
 * --------------------------- DQL - Data Query Languaje ---------------------------
 * by Ivan Alducin
 */
 USE dvdrental; 
 GO

--1. Vamos a seleccionar el nombre y apellido de los actores
SELECT first_name, last_name 
FROM dbo.actor;
	
--2. Vamos a seleccionar el nombre completo del actor en una sola columna
SELECT CONCAT(first_name, ' ', last_name) 
AS nombre_completo 
FROM dbo.actor;
	

--3. Selecciona los actores que su nombre empieza con "D"
SELECT actor_id, first_name, last_name 
FROM dbo.actor 
WHERE first_name LIKE 'D%';

--4. ¿Tenemos algún actor con el mismo nombre?
SELECT first_name, COUNT(*) 
AS cantidad 
FROM dbo.actor 
GROUP BY first_name 
HAVING COUNT(*) > 1 
ORDER BY cantidad DESC, first_name;

--5. ¿Cuál es el costo máximo de renta de una película?
SELECT MAX(rental_rate) 
AS costo_maximo_renta 
FROM dbo.film;
	
--6. ¿Cuáles son las peliculas que fueron rentadas con ese costo?	
SELECT title, rental_rate 
FROM dbo.film 
WHERE rental_rate = ( SELECT MAX(rental_rate) FROM dbo.film );
	
--7. ¿Cuantás películas hay por el tipo de audencia (rating)?
SELECT rating, COUNT(*)
AS cantidad_peliculas 
FROM dbo.film 
GROUP BY rating ORDER BY cantidad_peliculas DESC;

--8. Selecciona las películas que no tienen un rating R o NC-17
SELECT film_id, title, rating 
FROM dbo.film 
WHERE rating NOT IN ('R', 'NC-17');
	
--9. ¿Cuantos clientes hay en cada tienda?
SELECT s.store_id, COUNT(c.customer_id) 
AS cantidad_clientes 
FROM dbo.store AS s LEFT JOIN dbo.customer AS c ON s.store_id = c.store_id GROUP BY s.store_id ORDER BY s.store_id;
	
--10. ¿Cuál es la pelicula que mas veces se rento?
SELECT TOP 1 f.film_id, f.title, 
COUNT(r.rental_id) AS veces_rentada FROM dbo.film AS f INNER JOIN dbo.inventory 
AS i ON f.film_id = i.film_id INNER JOIN dbo.rental 
AS r ON i.inventory_id = r.inventory_id 
GROUP BY f.film_id, f.title ORDER BY COUNT(r.rental_id) DESC;

--11. ¿Qué peliculas no se han rentado?
SELECT f.film_id, f.title 
FROM dbo.film AS f 
WHERE NOT EXISTS ( SELECT 1 FROM dbo.inventory AS i INNER JOIN dbo.rental AS r ON i.inventory_id = r.inventory_id WHERE i.film_id = f.film_id ) 
ORDER BY f.title;
	
--12. ¿Qué clientes no han rentado ninguna película?
SELECT c.customer_id, c.first_name, c.last_name 
FROM dbo.customer AS c 
WHERE NOT EXISTS ( SELECT 1 FROM dbo.rental AS r WHERE r.customer_id = c.customer_id ) 
ORDER BY c.last_name, c.first_name;

---------------- Clientes sin rentas ----------
SELECT
    COUNT(*) AS clientes_sin_rentas
FROM dbo.customer AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.rental AS r
    WHERE r.customer_id = c.customer_id
);
	
--13. ¿Qué actores han actuado en más de 30 películas?
SELECT a.actor_id, a.first_name, a.last_name, 
COUNT(fa.film_id) AS cantidad_peliculas 
FROM dbo.actor AS a INNER JOIN dbo.film_actor AS fa ON a.actor_id = fa.actor_id GROUP BY a.actor_id, a.first_name, a.last_name HAVING COUNT(fa.film_id) > 30 
ORDER BY cantidad_peliculas DESC;
	

--14. Muestra las ventas totales por tienda
SELECT s.store_id, SUM(TRY_CONVERT(DECIMAL(12, 2), p.amount)) AS ventas_totales
FROM dbo.store AS s
INNER JOIN dbo.staff AS st
ON s.store_id = st.store_id
INNER JOIN dbo.payment AS p
ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY s.store_id;

--15. Muestra los clientes que rentaron una pelicula más de una vez
WITH a AS 
( SELECT r.customer_id, i.film_id, COUNT(*) AS veces_rentada 
FROM dbo.rental AS r INNER JOIN dbo.inventory AS i 
ON r.inventory_id = i.inventory_id 
GROUP BY r.customer_id, i.film_id 
HAVING COUNT(*) > 1 ) 
SELECT c.customer_id, c.first_name, c.last_name, f.title AS pelicula, a.veces_rentada 
FROM a INNER JOIN dbo.customer AS c 
ON a.customer_id = c.customer_id INNER JOIN dbo.film AS f ON a.film_id = f.film_id 
ORDER BY c.customer_id, f.title;

	
	