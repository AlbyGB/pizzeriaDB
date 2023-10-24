INSERT INTO clienti (cod_fiscale, nome, cognome, indirizzo) VALUES ('qwwwwwwwwwwwwwww', 'tore', 'tore', 'torecity');
INSERT INTO clienti (cod_fiscale, nome, cognome, indirizzo) VALUES ('qwwwwwwsddwww', 'fedesanga', 'tore', 'torecity');
INSERT INTO clienti (cod_fiscale, nome, cognome, indirizzo) VALUES ('qwwwwwwwwwww', 'gennaro', 'dalterio', 'torecity');

INSERT INTO ingredienti (nome) VALUES ('salame tore');
INSERT INTO ingredienti (nome) VALUES ('tore');
INSERT INTO ingredienti (nome) VALUES ('pomodoro tore');
INSERT INTO ingredienti (nome) VALUES ('prosciutto tore');

INSERT INTO pizze (nome) VALUES ('margherita');
INSERT INTO pizze (nome) VALUES ('tore');
INSERT INTO pizze (nome) VALUES ('tonno');
INSERT INTO pizze (nome) VALUES ('napoli tore');

INSERT INTO ordini (numero, tipo, cod_fiscale_cliente) VALUES (1,'consegna', 'qwwwwwwwwwwwwwww');

INSERT INTO ingredienti (nome) VALUES ('prosciutto tore');
INSERT INTO ingredienti (nome) VALUES ('prosciutto tore');
INSERT INTO ingredienti (nome) VALUES ('prosciutto tore');

INSERT INTO ordini_pizze (nome_pizza, numero_ordine) VALUES ('margherita', 0);
INSERT INTO ordini_pizze (nome_pizza, numero_ordine) VALUES ('tore', 0);
INSERT INTO ordini_pizze (nome_pizza, numero_ordine) VALUES ('tonno', 0);
INSERT INTO ordini_pizze (nome_pizza, numero_ordine) VALUES ('tonno', 1);
INSERT INTO ordini_pizze (nome_pizza, numero_ordine) VALUES ('napoli tore', 1);

INSERT INTO pizze_ingredienti (nome_pizza, nome_ingrediente) VALUES ('napoli tore', 'salame tore');
INSERT INTO pizze_ingredienti (nome_pizza, nome_ingrediente) VALUES ('tore', 'pomodoro tore');
INSERT INTO pizze_ingredienti (nome_pizza, nome_ingrediente) VALUES ('tonno', 'prosciutto tore');
INSERT INTO pizze_ingredienti (nome_pizza, nome_ingrediente) VALUES ('margherita', 'pomodoro tore');

ALTER TABLE ordini ADD COLUMN data TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE pizze ADD COLUMN costo NUMERIC NOT NULL DEFAULT 0;

SELECT cod_fiscale_cliente FROM ordini;
SELECT cod_fiscale_cliente FROM clienti JOIN ordini ON clienti.cod_fiscale = ordini.cod_fiscale_cliente WHERE DATE(ordini.data) = '2023-10-24';
SELECT cod_fiscale_cliente FROM clienti JOIN ordini ON clienti.cod_fiscale = ordini.cod_fiscale_cliente
                           JOIN ordini_pizze on ordini.numero = ordini_pizze.numero_ordine
                           WHERE DATE(ordini.data) = '2023-10-24' AND ordini_pizze.nome_pizza = 'margherita';

SELECT cod_fiscale_cliente FROM clienti JOIN ordini ON clienti.cod_fiscale = ordini.cod_fiscale_cliente
                           JOIN ordini_pizze on ordini.numero = ordini_pizze.numero_ordine
                           WHERE DATE(ordini.data) = '2023-10-24' AND ordini_pizze.nome_pizza = 'margherita' AND ordini.tipo = 'carta';

SELECT cod_fiscale_cliente FROM clienti JOIN ordini ON clienti.cod_fiscale = ordini.cod_fiscale_cliente
                           JOIN ordini_pizze on ordini.numero = ordini_pizze.numero_ordine
                           JOIN public.pizze_ingredienti on ordini_pizze.nome_pizza = pizze_ingredienti.nome_pizza
                           WHERE DATE(ordini.data) = '2023-10-24' AND ordini_pizze.nome_pizza = 'margherita' AND ordini.tipo = 'carta' AND pizze_ingredienti.nome_ingrediente = 'pomodoro tore';

SELECT
    clienti.cod_fiscale, clienti.nome, clienti.cognome, COUNT(ordini.numero) AS numero_di_ordini
FROM
    clienti
JOIN
    ordini ON clienti.cod_fiscale = ordini.cod_fiscale_cliente
GROUP BY
    clienti.cod_fiscale, clienti.nome, clienti.cognome
ORDER BY
    numero_di_ordini DESC
LIMIT 1;


SELECT
    clienti.cod_fiscale, clienti.nome, clienti.cognome, COUNT(ordini.numero) AS numero_di_ordini
FROM
    clienti
JOIN
    ordini ON clienti.cod_fiscale = ordini.cod_fiscale_cliente
JOIN
    ordini_pizze ON ordini.numero = ordini_pizze.numero_ordine
WHERE
    DATE(ordini.data) = '2023-10-24' AND ordini_pizze.nome_pizza = 'tonno'
GROUP BY
    clienti.cod_fiscale, clienti.nome, clienti.cognome
ORDER BY
    numero_di_ordini DESC
LIMIT 1;


SELECT
    ordini_pizze.nome_pizza, COUNT(*) AS numero_di_ordini
FROM
    ordini_pizze
WHERE
    ordini_pizze
GROUP BY
    ordini_pizze.nome_pizza
ORDER BY
    numero_di_ordini DESC;


SELECT
    ordini_pizze.nome_pizza,
    COUNT(*) AS numero_di_ordini
FROM
    ordini
JOIN
    ordini_pizze ON ordini.numero = ordini_pizze.numero_ordine
WHERE
    DATE(ordini.data) = '2023-10-24'
GROUP BY
    ordini_pizze.nome_pizza
ORDER BY
    numero_di_ordini DESC;


SELECT
    clienti.cod_fiscale,
    clienti.nome,
    clienti.cognome,
    SUM(pizze.costo) AS spesa_totale
FROM
    clienti
JOIN
    ordini ON clienti.cod_fiscale = ordini.cod_fiscale_cliente
JOIN
    ordini_pizze ON ordini.numero = ordini_pizze.numero_ordine
JOIN
    pizze ON ordini_pizze.nome_pizza = pizze.nome
GROUP BY
    clienti.cod_fiscale, clienti.nome, clienti.cognome;


SELECT DISTINCT ON (clienti.cod_fiscale)
    clienti.cod_fiscale,
    clienti.nome,
    clienti.cognome,
    pizze.nome AS pizza_piu_costosa,
    pizze.costo AS prezzo
FROM
    clienti
JOIN
    ordini ON clienti.cod_fiscale = ordini.cod_fiscale_cliente
JOIN
    ordini_pizze ON ordini.numero = ordini_pizze.numero_ordine
JOIN
    pizze ON ordini_pizze.nome_pizza = pizze.nome
ORDER BY
    clienti.cod_fiscale,
    pizze.costo DESC;


SELECT
    clienti.cod_fiscale,
    clienti.nome,
    clienti.cognome,
    pizze.nome,
    COUNT(*) AS conteggio
FROM
    clienti
INNER JOIN
    ordini ON clienti.cod_fiscale = ordini.cod_fiscale_cliente
INNER JOIN
    ordini_pizze ON ordini.numero = ordini_pizze.numero_ordine
INNER JOIN
    pizze ON ordini_pizze.nome_pizza = pizze.nome
GROUP BY
    clienti.cod_fiscale, clienti.nome, clienti.cognome, pizze.nome
ORDER BY
    clienti.cod_fiscale, conteggio DESC;