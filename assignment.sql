-- Active: 1747640292108@@localhost@5432@conservation_db

----------------------------------------------------------- tables-------------------------------------------------------

CREATE Table rangers(
    ranger_id SERIAL NOT NULL PRIMARY Key,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(250) NOT NULL
);

CREATE Table species(
    species_id SERIAL NOT NULL PRIMARY Key,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR NOT NULL
);


CREATE Table sightings(
    sighting_id SERIAL NOT NULL PRIMARY Key,
    ranger_id INTEGER REFERENCES rangers(ranger_id ),
    species_id INTEGER REFERENCES species(species_id),
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(100) NOT NULL,
    notes VARCHAR(250)
);

INSERT INTO rangers (name,region) 
values( 'Alice Green', 'Northern Hills'),
( 'Bob White', 'River Delta'),
('Carol King', 'Mountain Range')

SELECT * FROM rangers;

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status)
 values ('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

SELECT * FROM species;

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);

SELECT * FROM sightings;


---------------------------------------------------- problem :1--------------------------------------------------------
 INSERT INTO rangers(name,region)
 values('Derek Fox', 'Coastal Plains')

 SELECT * FROM rangers;

-- ---------------------------------------------problem 02---------------------------------------------------------------
SELECT COUNT(  DISTINCT species_id) as  unique_species_count
 FROM sightings;
 
--  ------------------------------------------------------------Probelm no-03--------------------------------------------

SELECT * FROM sightings
WHERE location ILIKE '%pass%';

---------------------------------------------------------Problem no-04---------------------------------------------------


SELECT r.name AS ranger_name, COUNT(s.sighting_id) AS total_sightings
 FROM rangers as r
LEFT JOIN sightings as s ON r.ranger_id = s.ranger_id
GROUP BY r.ranger_id, r.name
ORDER BY total_sightings DESC;


-----------------------------------------------------Problem no-05-------------------------------------------------------
SELECT sp.common_name
FROM species as sp
LEFT JOIN sightings as s ON sp.species_id = s.species_id
WHERE s.species_id IS NULL;

-- --------------------------------------------------Problem no 6-------------------------------------------------------


SELECT sp.common_name, s.sighting_time, r.name
FROM sightings as s
JOIN species as sp ON s.species_id = sp.species_id
JOIN rangers as r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;
-- ----------------------------------------------------Problem no 07-----------------------------------------------------
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

-- ------------------------------------------------------Probelm 08------------------------------------------------------
select * from sightings

DROP TABLE sightings

SELECT 
  sighting_id,
  CASE
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings;

-- ------------------------------------------------------Probelm 09------------------------------------------------------
DELETE FROM rangers
WHERE ranger_id NOT IN (
    SELECT DISTINCT ranger_id FROM sightings
);
