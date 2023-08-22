SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;
SELECT * FROM animals WHERE neutered = 'true' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.50;
SELECT * FROM animals WHERE neutered = 'true';
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.39 AND 17.31;

-- Begin a transaction
BEGIN;

-- Update the animals table, setting species to 'unspecified'
UPDATE animals SET species = 'unspecified';

-- Verify the change
SELECT * FROM animals;

-- Roll back the transaction
ROLLBACK;

-- Verify that the species column is back to its original state
SELECT * FROM animals;

-- Inside a transaction:
BEGIN;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

-- Verify the change
SELECT * FROM animals;

-- Commit the transaction.
COMMIT;

-- Verify that changes persist after commit.
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Begin a transaction
BEGIN;

-- Delete animals born after Jan 1st, 2022
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create a savepoint
SAVEPOINT my_savepoint;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO my_savepoint;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;

-- How many animals are there?
SELECT COUNT(*) AS total_animals
FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS animals_never_escaped
FROM animals
WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) AS average_weight
FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) AS total_escape_attempts
FROM animals
GROUP BY neutered
ORDER BY total_escape_attempts DESC;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000
GROUP BY species;

-- What animals belong to Melody Pond?

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).

SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
ORDER BY o.full_name, a.name;

-- How many animals are there per species?

SELECT s.name, COUNT(a.id) AS animal_count
FROM species s
LEFT JOIN animals a ON s.id = a.species_id
GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Who owns the most animals?

SELECT o.full_name, COUNT(a.id) AS animal_count
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;
