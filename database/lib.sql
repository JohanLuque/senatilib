CREATE DATABASE senatilib;
USE senatilib;

CREATE TABLE categorias
(
	idcategoria	INT AUTO_INCREMENT PRIMARY KEY,
	categoria	VARCHAR(50) 	NOT NULL,
	imgdefault 	VARCHAR(100) 	NOT NULL,
	estado		CHAR(1)		NOT NULL DEFAULT '1',
	create_at	DATETIME	NOT NULL DEFAULT NOW(),
	update_at	DATETIME	NULL,
	CONSTRAINT uk_categorias_cat UNIQUE (categoria)
)ENGINE = INNODB;

INSERT INTO categorias (categoria, imgdefault) VALUES
	('Informática', 'informatica.jpg'),
	('Matemáticas','matematica.jpg'),
	('Comunicación','comunicacion.jpg');
	
CREATE TABLE subcategorias
(
	idsubcategoria INT AUTO_INCREMENT PRIMARY KEY,
	idcategoria		INT 				NOT NULL,
	subcategoria	VARCHAR(70)		NOT NULL,
	estado			CHAR(1)			NOT NULL DEFAULT '1',
	create_at		DATETIME			NOT NULL DEFAULT NOW(),
	update_at		DATETIME			NULL,
	CONSTRAINT fk_idecategoria_sun FOREIGN KEY (idcategoria) REFERENCES categorias (idcategoria),
	CONSTRAINT uk_subcategorias_sub UNIQUE (subcategoria)
)ENGINE = INNODB;

INSERT INTO subcategorias (idcategoria, subcategoria) VALUES
(1, 'Microsoft Office'),
(1, 'Base de datos'),
(1, 'Seguridad Informática'),
(1, 'Programación'),
(1, 'Diseño gráfico');

CREATE TABLE editoriales
(
	ideditorial 		INT AUTO_INCREMENT PRIMARY KEY,
	editorial 		VARCHAR(150)	NOT NULL,
	pais			CHAR(2)		NOT NULL,
	email			VARCHAR(150)	NULL,
	telefono		VARCHAR(15)	NULL,
	estado			CHAR(1)		NOT NULL DEFAULT '1',
	create_at		DATETIME	NOT NULL DEFAULT NOW(),
	update_at		DATETIME	NULL,
	CONSTRAINT uk_editorial_ed UNIQUE (editorial, pais)
)ENGINE = INNODB;

INSERT INTO editoriales(editorial, pais)VALUES
('Apress', 'US'),
('Pragmtic', 'ES'),
('Macro', 'PE');

CREATE TABLE materiales
(
	idmaterial 			INT AUTO_INCREMENT PRIMARY KEY,
	idsubcategoria 			INT 		NOT NULL,
	ideditorial			INT 		NULL,
	titulo				VARCHAR(200)	NOT NULL,
	sinopsis			VARCHAR(300)	NOT NULL,
	versionmat			TINYINT 	NOT NULL DEFAULT 1,
	autor				VARCHAR(100)	NOT NULL,
	cantpaginas			SMALLINT	NOT NULL,
	apublicacion			CHAR(4)		NOT NULL,
	caratula			VARCHAR(100)	NULL,
	materialpdf			VARCHAR(100)	NOT NULL,
	estado				CHAR(1)		NOT NULL DEFAULT '1',
	create_at			DATETIME	NOT NULL DEFAULT NOW(),
	update_at			DATETIME	NULL,
	CONSTRAINT fk_idsubcategoria_mat FOREIGN KEY (idsubcategoria) REFERENCES subcategorias (idsubcategoria),
	CONSTRAINT fk_ideditorial_mat FOREIGN KEY (ideditorial) REFERENCES editoriales (ideditorial)
)ENGINE = INNODB;

INSERT INTO  materiales 
(idsubcategoria, ideditorial, titulo, sinopsis, autor, cantpaginas, apublicacion, materialpdf) VALUES
(1, 3, 'Aprende Excel Fácil', 'Ms Excel 365 integracion con PowerBi', 'Carlos Prada Perez', 300, '2022', 'ruta'),
(4,1 , 'JS como debe ser' , 'aprende JS desde cero con este libro fácil de leer', 'Miguel Munayco Gonzales', 290, '2023', 'ruta');

SELECT * FROM categorias;
SELECT * FROM subcategorias;
SELECT * FROM editoriales;
	

-- Procesos
DELIMITER $$ 
CREATE PROCEDURE spu_listar_categoria()
BEGIN 
	SELECT idcategoria, categoria FROM categorias;
END $$

DELIMITER $$ 
CREATE PROCEDURE spu_listar_subcategoria()
BEGIN 
	SELECT idsubcategoria, subcategoria FROM subcategorias;
END $$

DELIMITER $$ 
CREATE PROCEDURE spu_listar_editorial()
BEGIN 
	SELECT ideditorial, editorial FROM editoriales;
END $$

DELIMITER $$
CREATE PROCEDURE spu_materiales_listar()
BEGIN
	SELECT	materiales.idmaterial, subcategorias.subcategoria, editoriales.editorial,
		materiales.titulo, materiales.sinopsis, materiales.versionmat,
		materiales.autor, materiales.cantpaginas, materiales.apublicacion, 
		materiales.caratula, materiales.materialpdf
	FROM materiales
	INNER JOIN subcategorias ON materiales.idsubcategoria = subcategorias.idsubcategoria
	LEFT JOIN editoriales ON materiales.ideditorial = editoriales.ideditorial
	ORDER BY 1 DESC;
END $$


DELIMITER $$
CREATE PROCEDURE spu_registrar_material
(
IN _idsubcategoria 	INT,
IN _ideditorial		INT,
IN _titulo		VARCHAR(200),
IN _sinopsis		VARCHAR(300),
IN _versionmat		TINYINT, 
IN _autor		VARCHAR(100),
IN _cantpaginas		SMALLINT,
IN _apublicacion	CHAR(4),
IN _caratula		VARCHAR(100),
IN _materialpdf		VARCHAR(100)
)
BEGIN 
IF _ideditorial = '' THEN SET _ideditorial = NULL; END IF;
IF _caratula = '' THEN SET _caratula = NULL; END IF;
	INSERT INTO materiales 
	(idsubcategoria, ideditorial, titulo, sinopsis, versionmat,autor , cantpaginas, apublicacion, caratula, materialpdf) VALUES
	(_idsubcategoria, _ideditorial, _titulo, _sinopsis, _versionmat,_autor , _cantpaginas, _apublicacion, _caratula, _materialpdf);
END $$

CALL spu_registrar_material(4, 1, 'jose', 'Dias', 1, 'Autor', 12, '2023', NULL, 'ruta.pdf');