--livro mais antigo de cada autor.
with table1 as (select 
  author,
  title,
  publication,
  row_number () over (partition by author order by publication) as row_n
from silver.books
where publication > 0
)

select 
  author,
  title,
  publication 
from table1
where row_n = 1;

--cidade com mais usuários
select 
  cidade, 
  count(distinct user_id) as quant_usuarios
from silver.users
where cidade != ''
group by 1
order by 2 desc
limit 1;

--cidade com mais usuários (outra forma de fazer - subquery e row_number)
with table1 as 
(select
  count (distinct user_id) as quant_users,
  cidade
from silver.users
where cidade != ''
group by 2
order by 1 desc),

table2 as (select
  quant_users,
  cidade,
  row_number () over (order by quant_users desc) as row_n
from table1)

select 
  quant_users,
  cidade
from table2
where row_n = 1;

--categorizando os livros de acordo com a avaliação deles: ruins, médios e bons
select 
  b.title, 
  r.book_rating,
  case 
	when book_rating >= 0 and book_rating <= 3 then 'ruim'
	when book_rating >= 4 and book_rating <= 6 then 'médio'
	when book_rating >= 7 then 'bom' end categorias
from dataset.books b
  left join silver.ratings r
    on b.isbn = r.isbn 
group by 1, 2;

--diferença de tempo entre o livro mais antigo e o mais novo de cada autor
select 
  distinct author, 
  max(publication)-min(publication) as diferenca_publi
from silver.books b 
group by 1;

--quantidade de livros publicados por autor
with table1 as(
  select 
    distinct title,
    author 
  from silver.books)

select 
  distinct author, 
  count(title) as quant_books
from table1 
group by 1
order by 2 desc;

--diferença de idade de cada usuário para o usuário mais novo e o usuário mais antigo
select
   max (idade),
   min (idade)
 from silver.users

select 
  user_id, 
  idade, 
  idade-6 as dif_mais_novo, 
  100-idade as dif_mais_velho
from silver.users u
where idade >= 6 and idade <= 100
group by 1, 2
order by 2;

--dividir a coluna "local" da tabela "users" em 3 partes: cidade, estado e país
select *,
  split_part(local, ',', 1) cidade,
  split_part(local, ',', 2) estado,
  split_part(local, ',', 3) pais
from silver.users;

--top 10 usuários que leram mais livros
select user_id,
  count(user_id) as total_books
from silver.ratings r 
group by user_id
order by total_books desc 
limit 10;

--quais livros já receberam avaliação 10?
select r.isbn,
  b.title,
  r.book_rating
from silver.ratings r
left join silver.books b 
  on r.isbn = b.isbn
where book_rating = 10;

--quais livros já receberam avaliação 0?
select r.isbn,
  b.title,
  r.book_rating
from dataset.ratings r
left join dataset.books b 
  on r.isbn = b.isbn
where book_rating = 0;

--qual é a média de avaliação por ISBN?
select avg(book_rating),
  isbn
from silver.ratings r
group by isbn;

