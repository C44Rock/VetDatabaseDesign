DROP DATABASE pets;
CREATE DATABASE pets;

\c pets;

CREATE TABLE procedures (
        procedure_id numeric(2,0) NOT NULL,
        name varchar NOT NULL UNIQUE,
        cost numeric(6, 2),
        CONSTRAINT pk_procedures_proedure_id PRIMARY KEY (procedure_id)
);

CREATE TABLE owners (
        owner_id serial NOT NULL,
        first_name varchar NOT NULL,
        last_name varchar NOT NULL,
        address varchar,
        city varchar,
        state varchar,
        zip varchar,
        gender char(1),
        CONSTRAINT pk_owners_owner_id PRIMARY KEY (owner_id)
);

CREATE TABLE pet_type (
        type_id integer NOT NULL,
        name varchar NOT NULL,
        cost_multiplier numeric(3, 2) NOT NULL,
        CONSTRAINT pk_pet_type_type_id PRIMARY KEY (type_id)
);

CREATE TABLE pets (
        pet_id integer NOT NULL,
        name varchar NOT NULL,
        type_id integer NOT NULL,
        age integer NOT NULL,
        owner_id integer NOT NULL,
        CONSTRAINT pk_pets_pet_id PRIMARY KEY (pet_id),
        CONSTRAINT fk_pets_owner_id_owners_owner_id FOREIGN KEY (owner_id) REFERENCES owners(owner_id),
        CONSTRAINT fk_pets_type_id_pet_type_type_id FOREIGN KEY (type_id) REFERENCES pet_type(type_id)
);

CREATE TABLE visits (
        visit_id serial NOT NULL,
        visit_date date NOT NULL,
        pet_id integer NOT NULL,
        CONSTRAINT pk_visits_visit_id PRIMARY KEY (visit_id),
        CONSTRAINT fk_visits_pet_id_pets_pet_id FOREIGN KEY (pet_id) REFERENCES pets(pet_id)
);

CREATE TABLE visit_procedure (
        visit_id integer NOT NULL,
        procedure_id numeric(2, 0) NOT NULL,
        CONSTRAINT pk_visit_procedure_visit_id_procedure_id PRIMARY KEY (visit_id, procedure_id),
        CONSTRAINT fk_visit_procedure_procedure_procedure_id FOREIGN KEY (procedure_id) REFERENCES procedures(procedure_id),
        CONSTRAINT fk_visit_procedure_visits_visit_id FOREIGN KEY (visit_id) REFERENCES visits(visit_id)
);

INSERT INTO procedures (procedure_id, name) VALUES (1, 'Rabies Vaccination');
--INSERT INTO procedures (procedure_id, name) VALUES (5, 'Heart Worm Test');
--INSERT INTO procedures (procedure_id, name) VALUES (8, 'Tetanus Vaccination');
--INSERT INTO procedures (procedure_id, name) VALUES (10, 'Examine and Treat Wound');
--INSERT INTO procedures (procedure_id, name) VALUES (12, 'Eye Wash');
--INSERT INTO procedures (procedure_id, name) VALUES (20, 'Annual Check Up');

INSERT INTO owners (first_name, last_name, address, city, state, zip, gender) VALUES ('Richard', 'Cook', '123 This Street', 'My City', 'Ontario', 'Z5Z6G6', 'M');
--INSERT INTO owners (first_name, last_name) VALUES ('Terry', 'Kim');

INSERT INTO pet_type (type_id, name, cost_multiplier) VALUES (1, 'Dog', 1);
INSERT INTO pet_type (type_id, name, cost_multiplier) VALUES (2, 'Cat', .8);
--INSERT INTO pet_type (type_id, name, cost_multiplier) VALUES (3, 'Bird', .5);

INSERT INTO pets (pet_id, name, type_id, age, owner_id) VALUES (246, 'Rover', 1, 12, 1);
--INSERT INTO pets (pet_id, name, type_id, age, owner_id) VALUES (298, 'Spot', 1, 2, 2);
INSERT INTO pets (pet_id, name, type_id, age, owner_id) VALUES (341, 'Morris', 2, 4, 1);
--INSERT INTO pets (pet_id, name, type_id, age, owner_id) VALUES (519, 'Tweety', 3, 2, 2);

INSERT INTO visits (visit_date, pet_id) VALUES ('01-13-2002', 246);
--INSERT INTO visits (visit_date, pet_id) VALUES ('03-27-2002', 246);
--INSERT INTO visits (visit_date, pet_id) VALUES ('04-02-2002', 246);
--INSERT INTO visits (visit_date, pet_id) VALUES ('01-21-2002', 298);
--INSERT INTO visits (visit_date, pet_id) VALUES ('03-10-2002', 298);
--INSERT INTO visits (visit_date, pet_id) VALUES ('01-23-2001', 341);
INSERT INTO visits (visit_date, pet_id) VALUES ('01-13-2002', 341);
--INSERT INTO visits (visit_date, pet_id) VALUES ('04-30-2002', 519);

INSERT INTO visit_procedure (visit_id, procedure_id) VALUES (1, 1);
--INSERT INTO visit_procedure (visit_id, procedure_id) VALUES (2, 10);
--INSERT INTO visit_procedure (visit_id, procedure_id) VALUES (3, 5);
--INSERT INTO visit_procedure (visit_id, procedure_id) VALUES (4, 8);
--INSERT INTO visit_procedure (visit_id, procedure_id) VALUES (5, 5);
--INSERT INTO visit_procedure (visit_id, procedure_id) VALUES (6, 1);
INSERT INTO visit_procedure (visit_id, procedure_id) VALUES (2, 1);
--INSERT INTO visit_procedure (visit_id, procedure_id) VALUES (8, 20);
--INSERT INTO visit_procedure (visit_id, procedure_id) VALUES (8, 12);



SELECT *
FROM site
WHERE campground_id = 2
AND site_id NOT IN (
        SELECT site_id
        FROM reservation
        WHERE ('2017-10-07' BETWEEN from_date AND to_date)
        OR ('2017-10-09' BETWEEN from_date AND to_date)
);

