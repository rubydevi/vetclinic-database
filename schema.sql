-- CREATE ANIMALS TABLE

CREATE TABLE animals (
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(100) NOT NULL,
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL(10, 2)
);

-- Add a column species of type string to your animals table.
ALTER TABLE animals ADD COLUMN species VARCHAR(100);

-- Create a table named owners

CREATE TABLE owners (
	id SERIAL PRIMARY KEY NOT NULL,
	full_name VARCHAR(250),
	age INT
);

-- Create a table named species

CREATE TABLE species (
	id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(100) NOT NULL
);

-- Remove column species

ALTER TABLE animals
DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table

ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table

ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners(id);