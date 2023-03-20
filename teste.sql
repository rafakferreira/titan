CREATE DATABASE Teste;
USING Teste;

CREATE TABLE Produtos(
    cod_prod int NOT NULL,
    loj_prod int NOT NULL,
    desc_prod char(40),
    dt_inclu_prod date,
    preco_prod decimal(8,3),
    
	CONSTRAINT pk_prod PRIMARY KEY(cod_prod, loj_prod)
);

CREATE TABLE Estoque(
    cod_prod int NOT NULL,
    loj_prod int NOT NULL,
    qtd_prod decimal(15,3),
    
	CONSTRAINT pk_estoque PRIMARY KEY(cod_prod, loj_prod)
);

CREATE TABLE Lojas(
    loj_prod int NOT NULL,
    desc_loj char(40),
    
	CONSTRAINT pk_lojas PRIMARY KEY(loj_prod)
);

/* EX 1 */
INSERT INTO Produtos(cod_prod, loj_prod, desc_prod, dt_inclu_prod, preco_prod)
VALUES(170, 2, 'LEITE CONDESADO MOCOCA', '2010-12-30', 45.40);

/* EX 2 */
UPDATE Produtos
SET preco_prod = 95.40
WHERE cod_prod = 170 AND loj_prod = 2;

/* EX 3 */
SELECT * FROM Produtos WHERE loj_prod IN(1, 2);

/* EX 4 */
SELECT * FROM Produtos
WHERE dt_inclu_prod = 
(SELECT MAX(dt_inclu_prod) FROM Produtos) OR
dt_inclu_prod = 
(SELECT MIN(dt_inclu_prod) FROM Produtos)
ORDER BY dt_inclu_prod DESC;

/* EX 5 */
SELECT COUNT(*) as qtd_linhas FROM Produtos;

/* EX 6 */
SELECT * FROM Produtos WHERE desc_prod LIKE 'L%';

/* EX 7 */
SELECT loj_prod, SUM(preco_prod) as soma_loj FROM Produtos
GROUP BY loj_prod
ORDER BY loj_prod ASC;

/* EX 8 */
SELECT * FROM
(SELECT loj_prod, SUM(preco_prod) as soma_loj FROM Produtos
GROUP BY loj_prod
ORDER BY loj_prod ASC)
WHERE soma_loj > 100000;


/* EX 9 */
SELECT Lojas.loj_prod, Lojas.desc_loj,
Produtos.cod_prod, Produtos.desc_prod, Produtos.preco_prod,
Estoque.qtd_prod
FROM
((Lojas INNER JOIN Produtos ON Lojas.loj_prod = Produtos.loj_prod)
INNER JOIN Estoque ON Produtos.cod_prod = Estoque.cod_prod)
WHERE Lojas.loj_prod = 1;

/* EX 10 */
SELECT P.cod_prod, P.desc_prod, P.preco_prod SELECT Produtos P
LEFT JOIN Estoque E
ON P.cod_prod = E.cod_prod
WHERE E.cod_prod IS NULL;


/* EX 11 */
Select E.cod_prod, P.desc_prod, E.qtd_prod, from Estoque E
LEFT JOIN Produtos P
On E.cod_prod = P.cod_prod
WHERE P.cod_prod IS NULL;

