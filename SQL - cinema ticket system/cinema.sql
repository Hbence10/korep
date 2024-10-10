DROP TABLE IF EXISTS order_summary;
DROP TABLE IF EXISTS bought_ticket; 
DROP TABLE IF EXISTS chairs;
DROP TABLE IF EXISTS rows; 
DROP TABLE IF EXISTS projection;
DROP TABLE IF EXISTS ticket_type;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS room;
DROP TABLE IF EXISTS movie;
DROP FUNCTION IF EXISTS ticket_checker();
-- DROP FUNCTION IF EXISTS date_checker();
-- DROP FUNCTION IF EXISTS update_total_price();

-- Filmek tartalmazo table:
CREATE TABLE IF NOT EXISTS movie (
    id SERIAL PRIMARY KEY NOT NULL,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(100) NOT NULL,
    director VARCHAR(50) NOT NULL, 
    producer VARCHAR(50) NOT NULL,
    minute_length INT NOT NULL,
    age_limit INT NOT NULL,
    release_date DATE NOT NULL 
);

-- Filmek feltoltese:
INSERT INTO movie (title, description, director, producer, minute_length, age_limit, release_date) VALUES ('The Lord of the Ring: The Two Tower', 'This is a good movie', 'Peter Jackson', 'Peter Jackson', 181, 13, '2003-12-01');
INSERT INTO movie (title, description, director, producer, minute_length, age_limit, release_date) VALUES ('Matrix', 'This is a good movie', 'Watchowski sisters', 'Watchowski sisters', 136, 16, '1999-03-24');
INSERT INTO movie (title, description, director, producer, minute_length, age_limit, release_date) VALUES ('Spirited Away', 'This is a good movie', 'Hayao Miyazaki', 'Hayao Miyazaki', 124, 0, '2001-07-20');
INSERT INTO movie (title, description, director, producer, minute_length, age_limit, release_date) VALUES ('Back to the Future', 'This is a good movie', 'Robert Zemeckis', 'Bob Gale', 116, 12, '1985-08-03');
INSERT INTO movie (title, description, director, producer, minute_length, age_limit, release_date) VALUES ('Star Wars A New Hope', 'This is a good movie', 'George Lucas', 'George Lucas', 121, 12, '1977-05-25');

-- A termeket tartalmazo table:
CREATE TABLE IF NOT EXISTS room (
    id SERIAL PRIMARY KEY NOT NULL,
    room_number INT UNIQUE NOT NULL,
    chair_capacity INT NOT NULL
);

-- Termek feltoltese:
INSERT INTO room (room_number, chair_capacity) VALUES (21, 13);
INSERT INTO room (room_number, chair_capacity) VALUES (56, 25);
INSERT INTO room (room_number, chair_capacity) VALUES (8, 68);

-- Adott terem adott sorait tartalmazo table
CREATE TABLE IF NOT EXISTS rows(
    id SERIAL PRIMARY KEY NOT NULL,
    room_id INT REFERENCES room(room_number) NOT NULL,
    chair_capacity INT
);

-- 21es terem sorai:
INSERT INTO rows (room_id, chair_capacity) VALUES (21, 8);
INSERT INTO rows (room_id, chair_capacity) VALUES (21, 6);

-- 56os terem sorai: 
INSERT INTO rows (room_id, chair_capacity) VALUES (56, 8);
INSERT INTO rows (room_id, chair_capacity) VALUES (56, 10);

-- Adott sor szekeit tartalmazo table
CREATE TABLE IF NOT EXISTS chairs(
    id SERIAL PRIMARY KEY NOT NULL,
    row_id INT REFERENCES rows(id) NOT NULL,
    chair_number INT NOT NULL,
    site VARCHAR NOT NULL
);

-- 21-es teremnek a szekei:
-- 8-as kapacitasu sor:
INSERT INTO chairs (row_id, chair_number, site) VALUES (1, 1, 'Left');
INSERT INTO chairs (row_id, chair_number, site) VALUES (1, 2, 'Left');
INSERT INTO chairs (row_id, chair_number, site) VALUES (1, 3, 'Left');
INSERT INTO chairs (row_id, chair_number, site) VALUES (1, 4, 'Left');
INSERT INTO chairs (row_id, chair_number, site) VALUES (1, 4, 'Right');
INSERT INTO chairs (row_id, chair_number, site) VALUES (1, 3, 'Right');
INSERT INTO chairs (row_id, chair_number, site) VALUES (1, 2, 'Right');
INSERT INTO chairs (row_id, chair_number, site) VALUES (1, 1, 'Right');

-- 6-os kapacitasu sor:
INSERT INTO chairs (row_id, chair_number, site) VALUES (1, 1, 'Left');
INSERT INTO chairs (row_id, chair_number, site) VALUES (1, 2, 'Left');
INSERT INTO chairs (row_id, chair_number, site) VALUES (1, 3, 'Left');
INSERT INTO chairs (row_id, chair_number, site) VALUES (1, 3, 'Right');
INSERT INTO chairs (row_id, chair_number, site) VALUES (1, 2, 'Right');
INSERT INTO chairs (row_id, chair_number, site) VALUES (1, 1, 'Right');


--  56-os teremnek a szekei
-- 8-as kapacitasu
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 1, 'Left');
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 2, 'Left');
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 3, 'Left');
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 4, 'Left');
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 4, 'Right');
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 3, 'Right');
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 2, 'Right');
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 1, 'Right');

-- 10-es kapacitasu
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 1, 'Left');
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 2, 'Left');
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 3, 'Left');
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 4, 'Left');
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 5, 'Left');
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 5, 'Right');
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 4, 'Right');
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 3, 'Right');
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 2, 'Right');
INSERT INTO chairs (row_id, chair_number, site) VALUES (2, 1, 'Right');

-- Vetiteseket tartalmazo table:
CREATE TABLE IF NOT EXISTS projection(
    id SERIAL PRIMARY KEY NOT NULL, 
    movie_id INT REFERENCES movie(id) NOT NULL,
    room_id INT REFERENCES room(room_number) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    projection_date DATE NOT NULL,
    available_tickets INT
);

-- Jegy tipusokat tartalmazo table:
CREATE TABLE ticket_type(
    id SERIAL PRIMARY KEY NOT NULL, 
    category VARCHAR(20) NOT NULL,
    price INT NOT NULL
);

-- Jegytipusok feltoltese:
INSERT INTO ticket_type (category, price) VALUES ('Student', 2100);
INSERT INTO ticket_type (category, price) VALUES ('Normal', 2500);
INSERT INTO ticket_type (category, price) VALUES ('Elderly', 2000);
INSERT INTO ticket_type (category, price) VALUES ('3D', 3500);
INSERT INTO ticket_type (category, price) VALUES ('Premium', 8000);

-- Jegyeket tartalmazo table:
CREATE TABLE bought_ticket (
    id SERIAL PRIMARY KEY NOT NULL,
    ticket_type INT NOT NULL,
    projection_id INT NOT NULL,
    order_id INT NOT NULL,
    chair_id INT REFERENCES chairs(id) NOT NULL
);


-- Vasarlolakat tartalmazo table:
CREATE TABLE customers (
    id SERIAL PRIMARY KEY NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL, 
    email VARCHAR(30) NOT NULL,
    phone_number VARCHAR(30) NOT NULL
);

-- Rendeles osszesito table:
CREATE TABLE order_summary(
    id SERIAL PRIMARY KEY NOT NULL,
    order_id INT NOT NULL,
    customer_id INT REFERENCES customers(id) NOT NULL,
    total_price INT DEFAULT 0 NOT NULL
);

-- Customers feltoltese:
INSERT INTO customers (first_name, last_name, email, phone_number) VALUES ('Kurosaki', 'Ichigo', 'bleach@gmail.com', '+362012345678');
INSERT INTO customers (first_name, last_name, email, phone_number) VALUES ('Uchiha', 'Madara', 'naruto@gmail.com', '+362012345678');
INSERT INTO customers (first_name, last_name, email, phone_number) VALUES ('Gojo', 'Satoru', 'jjk@gmail.com', '+362012345678');

-- 1. feladat
CREATE OR REPLACE FUNCTION date_checker()
    RETURNS TRIGGER AS $$
    BEGIN
        IF (SELECT COUNT(*) FROM projection WHERE NEW.room_id = room_id AND NEW.projection_date = projection_date AND NEW.start_time BETWEEN start_time AND end_time) = 2
        THEN  RAISE EXCEPTION 'Ijj cigany';
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER date_check
AFTER INSERT ON projection
FOR EACH ROW 
EXECUTE FUNCTION date_checker();

INSERT INTO projection (movie_id, room_id, start_time, end_time, projection_date) VALUES (1, 21, '04:25', '06:25', '2006-08-02');
INSERT INTO projection (movie_id, room_id, start_time, end_time, projection_date) VALUES (1, 21, '04:30', '06:25', '2006-08-02');
INSERT INTO projection (movie_id, room_id, start_time, end_time, projection_date) VALUES (1, 21, '06:30', '08:30', '2006-08-02');

-- 2. feladat
CREATE OR REPLACE FUNCTION ticket_checker()
    RETURNS TRIGGER AS $$
    BEGIN
        IF (SELECT COUNT(*) FROM bought_ticket WHERE NEW.chair_id = chair_id AND NEW.projection_id = projection_id) = 2
        THEN RAISE EXCEPTION 'Ijj cigany #2';

        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER check_ticket
AFTER INSERT ON bought_ticket
FOR EACH ROW 
EXECUTE FUNCTION ticket_checker();

INSERT INTO bought_ticket (ticket_type, projection_id, order_id, chair_id) VALUES (2, 1, 123456, 3);
INSERT INTO bought_ticket (ticket_type, projection_id, order_id, chair_id) VALUES (2, 1, 123456, 4);
INSERT INTO bought_ticket (ticket_type, projection_id, order_id, chair_id) VALUES (2, 2, 123456, 4);

-- 3. feladat
CREATE OR REPLACE FUNCTION set_total_price()
    RETURNS TRIGGER AS $$
    BEGIN
        UPDATE order_summary SET total_price = 
        (SELECT SUM(price) FROM bought_ticket INNER JOIN ticket_type ON ticket_type.id = bought_ticket.ticket_type) -- subquery --> query a queryben
        WHERE NEW.id = id;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER total_price_sum 
AFTER INSERT ON order_summary
FOR EACH ROW
EXECUTE FUNCTION set_total_price();

INSERT INTO order_summary (order_id, customer_id) VALUES (123456, 1); 