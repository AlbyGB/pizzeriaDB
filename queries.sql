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

SELECT cod_fiscale_cliente FROM ordini