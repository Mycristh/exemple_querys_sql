--criando schema
create schema silver

--criando tabelas
create table silver.books(
isbn varchar,
title varchar,
author varchar,
publication int,
publisher varchar,
imageurls varchar,
imageurlm varchar,
imageurll varchar
)

create table silver.ratings(
user_id bigint,
isbn varchar,
book_rating int
)

create table silver.users(
user_id bigint,
local varchar,
idade int
)

--importando dados
copy books(isbn, title, author, publication, publisher, imgurls, imgurlm, imgurll) from 'C:\Users\mycri\Desktop\docs\books.csv' delimiter ';' csv header NULL 'NULL' ENCODING 'LATIN1';
copy ratings(user_id, isbn, book_rating) from 'C:\Users\mycri\Desktop\docs\ratings.csv' delimiter ';' csv header NULL 'NULL' ENCODING 'LATIN1';
copy users(user_id, local, idade) from 'C:\Users\mycri\Desktop\docs\users.csv' delimiter ';' csv header NULL 'NULL' ENCODING 'LATIN1';