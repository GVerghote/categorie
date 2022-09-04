-- Définir le moteur par défaut sur le moteur transactionnel InnoDb
SET default_storage_engine=InnoDb;

-- Suppression de la base de données
drop database if exists club;

create database club
    character set = 'utf8'
    default collate 'utf8_unicode_ci';

use club;

CREATE TABLE categorie (
  id varchar(3)  primary key,
  nom varchar(20)  NOT NULL,
  agemin tinyint NOT NULL,
  agemax tinyint NOT NULL
) ;

INSERT INTO categorie (id, nom, agemin, agemax) VALUES
('CA', 'Cadet', 16, 17 ),
('ES', 'Espoir', 20, 22),
('JU', 'Junior', 18, 19),
('M0', 'Master 0', 35, 39),
('M1', 'Master 1', 40, 44),
('M10', 'Master 10', 85, 89),
('M11', 'Master 11', 90, 99),
('M2', 'Master 2', 45, 49),
('M3', 'Master 3', 50, 54),
('M4', 'Master 4', 55, 59),
('M5', 'Master 5', 60, 64),
('M6', 'Master 6', 65, 69),
('M7', 'Master 7', 70, 74),
('M8', 'Master 8', 75, 79),
('M9', 'Master 9', 80, 84),
('MI', 'Minime', 14, 15 ),
('SE', 'Senior', 23, 34);


-- Mise en place d'une procédure stockée

drop procedure if exists getLesCategories;
CREATE  PROCEDURE getLesCategories (annee int)
    begin
        Select nom, id, ageMin, ageMax, annee - ageMax as anneeMin, annee - ageMin as anneeMax
        from categorie
        order by agemin;
end;

-- test de la procédure
call getLesCategories(2023);