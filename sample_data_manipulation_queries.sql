-- Colon : is the special character used to denote variables that will have data given by the user.

-- Get all people and their data for the home People page
SELECT People.id, name, age, Movies.title AS favMovie, Shows.title AS favShow, Books.title AS favBook, VideoGames.title AS favGame FROM People
JOIN Movies ON People.id=seenMovies.people_id
JOIN Shows ON People.id=seenShows.people_id
JOIN Books ON People.id=readBooks.people_id
JOIN VideoGames ON People.id=playedGames.people_id;

-- Get all Movies and their data for the display Movies page and for dropdowns
SELECT Movies.id, title, genre, director, runTimMins, metacritic FROM Movies
JOIN People ON Movies.id=seenMovies.movies_id;

-- Get all Shows and their data for the display Shows page and for dropdowns
SELECT Shows.id, title, genre, network, episodes, seasons, metacritic FROM Shows
JOIN People ON Shows.id=seenShows.shows_id;

-- Get all Books and their data for the display Movies page and for dropdowns
SELECT Books.id, title, genre, author, pages, metacritic FROM Books
JOIN People ON Books.id=readBooks.books_id;

-- Get all Video Games and their data for the display Movies page and for dropdowns
SELECT VideoGames.id, title, genre, studio, playTimeHrs, metacritic FROM VideoGames
JOIN People ON VideoGames.id=playedGames.video_games_id;

-- Add a new Person
INSERT INTO People (name, age, favMovie, favShow, favBook, favGame) VALUES (:nameInput, :ageInput, :movie_idInput, :show_idInput, :book_idInput, :game_idInput)

-- Add a new Movie
INSERT INTO Movies (title, genre, director, runTimeMins, metacritic) VALUES (:titleInput, :genreInput, :directorInput, :runTimeMinsInput, :metacriticInput)

-- Add a new Show
INSERT INTO Shows (title, genre, network, episodes, seasons, metacritic) VALUES (:titleInput, :genreInput, :networkInput, :episodesInput, :seasonsInput, :metacriticInput)

-- Add a new Book
INSERT INTO Books (title, genre, author, pages, metacritic) VALUES (:titleInput, :genreInput, :authorInput, :pagesInput, :metacriticInput)

-- Add a new Video Game
INSERT INTO VideoGames (title, genre, studio, playTimeHrs, metacritic) VALUES (:titleInput, :genreInput, :studioInput, :playTimeHrsInput, :metacriticInput)

-- Associate a Person with a seen Movie (M:M)
INSERT INTO seenMovies (people_id, movies_id) VALUES (:people_idInput, :movies_idInput)

-- Associate a Person with a seen Show (M:M)
INSERT INTO seenMovies (people_id, shows_id) VALUES (:people_idInput, :shows_idInput)

-- Associate a Person with a read Book (M:M)
INSERT INTO seenMovies (people_id, books_id) VALUES (:people_idInput, :books_idInput)

-- Associate a Person with a played Video Game (M:M)
INSERT INTO seenMovies (people_id, video_games_id) VALUES (:people_idInput, :video_games_idInput)




-- These are some Database Manipulation queries for a partially implemented Project Website
-- using the bsg database.
-- Your submission should contain ALL the queries required to implement ALL the
-- functionalities listed in the Project Specs.

-- get all Planet IDs and Names to populate the Homeworld dropdown
SELECT planet_id, name FROM bsg_planets

-- get all characters and their homeworld name for the List People page
SELECT bsg_people.character_id, fname, lname, bsg_planets.name AS homeworld, age FROM bsg_people INNER JOIN bsg_planets ON homeworld = bsg_planets.planet_id

-- get a single character's data for the Update People form
SELECT character_id, fname, lname, homeworld, age FROM bsg_people WHERE character_id = :character_ID_selected_from_browse_character_page

-- get all character's data to populate a dropdown for associating with a certificate
SELECT character_id AS pid, fname, lname FROm bsg_people
-- get all certificates to populate a dropdown for associating with people
SELECT certification_id AS cid, title FROM bsg_cert

-- get all peoople with their current associated certificates to list
SELECT pid, cid, CONCAT(fname,' ',lname) AS name, title AS certificate
FROM bsg_people
INNER JOIN bsg_cert_people ON bsg_people.character_id = bsg_cert_people.pid
INNER JOIN bsg_cert on bsg_cert.certification_id = bsg_cert_people.cid
ORDER BY name, certificate

-- add a new character
INSERT INTO bsg_people (fname, lname, homeworld, age) VALUES (:fnameInput, :lnameInput, :homeworld_id_from_dropdown_Input, :ageInput)

-- associate a character with a certificate (M-to-M relationship addition)
INSERT INTO bsg_cert_people (pid, cid) VALUES (:character_id_from_dropdown_Input, :certification_id_from_dropdown_Input)

-- update a character's data based on submission of the Update Character form
UPDATE bsg_people SET fname = :fnameInput, lname= :lnameInput, homeworld = :homeworld_id_from_dropdown_Input, age= :ageInput WHERE id= :character_ID_from_the_update_form

-- delete a character
DELETE FROM bsg_people WHERE id = :character_ID_selected_from_browse_character_page

-- dis-associate a certificate from a person (M-to-M relationship deletion)
DELETE FROM bsg_cert_people WHERE pid = :character_ID_selected_from_certificate_and_character_list AND cid = :certification_ID_selected_from-certificate_and_character_list
