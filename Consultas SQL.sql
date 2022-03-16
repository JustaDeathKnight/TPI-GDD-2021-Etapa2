-- INSERCIÓN, MODIFICACIÓN, BORRADO DE DATOS --
-- cinco consultas distintas para inserción de datos.
	-- insercion de un tripulante
    INSERT INTO Tripulantes VALUE ('Gowther Shaw','A0368K101');
    
	-- insercion de una empresa
    INSERT INTO Empresa VALUE ('ABA0010','Requiem',968.565);
    
    -- insercion de empresa que financia a una agencia espacial privada
    INSERT INTO Financia VALUE ('Infinity','ABA0010',33);
    
    -- insercion de una Clase de Nave
    INSERT INTO Clase_nave VALUE ('INF-101','Supercarguero Clase-Infinity');
    
    -- insercion de un Componente de nave
    INSERT INTO Componente VALUE (2892483,'Placa de titanio', 378.4, 2,'INF-101');
    
-- cinco consultas distintas para modificación de datos.
	-- Actualizar el diametro de un componente
	UPDATE Componente SET Diametro=33 WHERE Código=2892483;
    
    -- Modificar la el tipo de mision de una nave espacial 
	UPDATE Nave SET Misión='militar' WHERE Matricula='A1468S010';
    
    -- Actualizar la cantidad de personas que trabajan en una agencia espacial 
    UPDATE Agencia_espacial SET Cant_per=1369 WHERE Nombre='Shadowmourne';
    
    -- Actualizar el capital de una empresa
     UPDATE Empresa SET Capital=986.636 WHERE CIF='ABA0010';
    
    -- Actualizar el porcentaje de participacion de una empresa que financia una agencia espacial privada
    UPDATE Financia SET Participacion=77 WHERE E_CIF='ABA0010';
    
-- cinco consultas sql distintas para borrado de filas.
	-- Eliminar una empresa que ya no financia a una agencia espacial privada
   DELETE FROM Financia WHERE E_CIF='ABA0010';

-- CONSULTAS SELECT --
-- 1.Nombres de las naves que produjeron al menos 10 basuras distintas.
SELECT N.matricula
FROM Nave N, Basura_espacial B
WHERE N.matricula = B.nave
GROUP BY N.matricula
HAVING COUNT(*) > 9;

-- 2. Listar los pares (basura 1, basura 2) tales que basura 1 fue producida por una nave que también produjo basura 2.
SELECT B.id_Basura AS Basura1, B2.id_Basura AS Basura2
FROM Basura_espacial B, Basura_espacial B2
WHERE  B.nave = B2.nave AND B.id_Basura <> B2.id_Basura;

-- 3. Listar los nombres de las agencias que no lanzaron ninguna nave que haya estado en órbita.
SELECT DISTINCT N.agencia
FROM Nave N
WHERE N.matricula NOT IN (SELECT S.nave
              FROM Se_ubica S);
-- "Interpretamos que una nave no esta en orbita cuando todavia
-- no se lanzo, por lo tanto, si la matricula de la nave no esta
-- en la tabla Se_ubica significa que la nave no registro una 
-- ubicacion (o orbita)"

-- 4. Listar las órbitas en las cuales estuvieron todas las naves.
SELECT DISTINCT S.o_radio, S.o_delta, S.o_altura, S.o_excentricidad 
FROM Se_ubica S
GROUP BY S.o_radio, S.o_delta, S.o_altura, S.o_excentricidad 
HAVING COUNT(*) = (SELECT COUNT(DISTINCT S1.nave) AS Cant_Naves FROM Se_Ubica S1);

-- 5. "Liste el nombre de todos los estados y sus agencias públicas que supervisan al menos dos agencias privadas distintas."
SELECT PU.Estado, A.nombre AS Agencia, COUNT(*) AS Cantidad
FROM Publica PU, Privada PR, Agencia_espacial A
WHERE PR.publica_n = A.nombre AND PR.publica_n = PU.nombre
GROUP BY PR.publica_n
HAVING COUNT(*) > 1;
