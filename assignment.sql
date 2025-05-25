-- Active: 1747640292108@@localhost@5432@conservation_db
CREATE Table kaiser(
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50),
    age int 

);

INSERT INTO kaiser (name,age)
VALUES ('kaiser',21)

SELECT * FROM kaiser;
