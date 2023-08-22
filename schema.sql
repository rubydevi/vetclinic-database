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
