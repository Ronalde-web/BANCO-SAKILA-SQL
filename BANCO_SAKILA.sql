# listar todos os dados da lista filme
select * from film;
select * from actor;

# seleciona as colunas que eu quero
select first_name, last_update from actor;

# 3 lista do titulo de todos os filmes
select title from film;

# 4 lista dos filmes menor que 60 minutos
select title from film
where length < 60;

# lista geral os clientes
select * from customer;

# 5 listas dos clientes inativos
select * from customer
where active = 0;

# 6 .	Lista dos clientes ativos e respectivos endereços
SELECT first_name, last_name, address
FROM customer c, address a
WHERE active = 1 AND c.address_id = a.address_id;

# 7 Lista dos nomes dos clientes residentes no Brasil.
SELECT first_name, last_name, a.address, co.country
FROM customer c, address a, city ct, country co
WHERE c.address_id = a.address_id and co.country = 'Brazil';

# 8. Relação de filmes e atores que atuaram no mesmo
SELECT f.title, a.first_name, a.last_name
FROM film f, film_actor fa, actor a
WHERE f.film_id = fa.film_id AND a.actor_id = fa.actor_id

# 9 Relação de filmes e atores que atuaram no mesmo ordenada por filme( de A á Z)
SELECT f.title, a.first_name, a.last_name
FROM film f, film_actor fa, actor a
WHERE f.film_id = fa.film_id AND a.actor_id = fa.actor_id
ORDER BY f.title ASC
# Mesma coisa so muda á ondem alfabetica de (A á Z)
SELECT f.title, a.first_name, a.last_name
FROM film f, film_actor fa, actor a
WHERE f.film_id = fa.film_id AND a.actor_id = fa.actor_id
ORDER BY f.title DESC

# 9.	Relação de filmes e atores que atuaram no mesmo ordenada por ator
SELECT f.title, a.first_name, a.last_name
FROM film f, film_actor fa, actor a
WHERE f.film_id = fa.film_id AND a.actor_id = fa.actor_id
ORDER BY a.first_name

# 10.	Relação de filmes com participação de um ator específico.
SET @ator := "JENNIFER";

SELECT f.title, a.first_name, a.last_name
FROM film f, film_actor fa, actor a
WHERE f.film_id = fa.film_id AND a.actor_id = fa.actor_id
AND a.first_name = @ator;

#11.	Quantidade total de filmes
SELECT COUNT(*) qtd_filmes
FROM film;

# 12.	Duração média dos filmes em minutos
SELECT AVG(length) as media_Duracao
FROM film;

#13.	Lista de filmes por categoria
SELECT f.title, c.name 
FROM film f,category c, film_category fc
WHERE f.film_id = fc.film_id
  AND fc.category_id = c.category_id;
  
  #14	Quantidade de filmes por categoria
  SELECT c.name, COUNT(*)
FROM film f, category c, film_category fc
WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id
GROUP BY c.name;

#15	Duração média dos filmes por categoria
SELECT c.name, AVG(f.length)
FROM film f,category c, film_category fc
WHERE f.film_id = fc.film_id 
  AND fc.category_id = c.category_id
GROUP BY c.name;

# 16	Quantidade de filmes por categoria das categorias com menos de 57 filmes
SELECT c.name, COUNT(*) qtd
FROM film f,category c, film_category fc
WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id
GROUP BY c.name
HAVING qtd < 57;

# 17.	Duração média dos filmes por categoria das categorias com menos de 57 filmes
SELECT c.name, COUNT(*) qtd, AVG(f.length)
FROM film f,category c, film_category fc
WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id
GROUP BY c.name
HAVING qtd < 57;

#18.	Quantidade de filmes alugados por cliente
SELECT c.first_name, c.last_name, COUNT(*)
FROM customer c, rental r
WHERE c.customer_id = r.customer_id
GROUP BY (c.customer_id);

# 19.	Quantidade de filmes alugados por cliente em ordem decrescente de quantidade de filmes alugados
SELECT c.first_name, c.last_name, COUNT(*) qtd
FROM customer c, rental r
WHERE c.customer_id = r.customer_id
GROUP BY (c.customer_id)
ORDER BY qtd desc;

# 20.	Relação de nomes dos clientes que possuem um filme alugado no momento
SELECT c.first_name as cliente, c.last_name as nome_filme
FROM customer c
WHERE EXISTS (SELECT 1 
	FROM rental r
    WHERE c.customer_id = r.customer_id AND r.return_date IS NOT NULL);

# 21.	Relação de nomes dos clientes que não possuem um filme alugado no momento
SELECT c.first_name, c.last_name
FROM customer c
WHERE NOT EXISTS (SELECT 1 
	FROM rental r
    WHERE c.customer_id = r.customer_id AND r.return_date IS NOT NULL);














