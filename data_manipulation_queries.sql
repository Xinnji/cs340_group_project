-- Colon : is the special character used to denote variables that will have data given by the user.

-- Get all people and their data for the home People page
SELECT name, age, Movies.title, Shows.title, Books.title, VideoGames.title FROM People
JOIN Movies ON Movies.id = favMovie
JOIN Shows ON Shows.id = favShow
JOIN Books ON Books.id = favBook
JOIN VideoGames ON VideoGames.id = favGame;
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
INSERT INTO People (name, age, favMovie, favShow, favBook, favGame) VALUES (:nameInput, :ageInput, :movie_idInput, :show_idInput, :book_idInput, :game_idInput);
-- Add a new Movie
INSERT INTO Movies (title, genre, director, runTimeMins, metacritic) VALUES (:titleInput, :genreInput, :directorInput, :runTimeMinsInput, :metacriticInput);
-- Add a new Show
INSERT INTO Shows (title, genre, network, episodes, seasons, metacritic) VALUES (:titleInput, :genreInput, :networkInput, :episodesInput, :seasonsInput, :metacriticInput);
-- Add a new Book
INSERT INTO Books (title, genre, author, pages, metacritic) VALUES (:titleInput, :genreInput, :authorInput, :pagesInput, :metacriticInput);
-- Add a new Video Game
INSERT INTO VideoGames (title, genre, studio, playTimeHrs, metacritic) VALUES (:titleInput, :genreInput, :studioInput, :playTimeHrsInput, :metacriticInput);


-- Associate a Person with a seen Movie (M:M)
INSERT INTO seenMovies (people_id, movies_id) VALUES (:people_idInput, :movies_idInput);
-- Associate a Person with a seen Show (M:M)
INSERT INTO seenShows (people_id, shows_id) VALUES (:people_idInput, :shows_idInput);
-- Associate a Person with a read Book (M:M)
INSERT INTO readBooks (people_id, books_id) VALUES (:people_idInput, :books_idInput);
-- Associate a Person with a played Video Game (M:M)
INSERT INTO playedGames (people_id, video_games_id) VALUES (:people_idInput, :video_games_idInput);


-- update a Person's data based on submission of the Update Person form
UPDATE People SET name=:nameInput, age=:ageInput, favMovie=:movie_idInput, favShow=:show_idInput, favBook=:book_idInput, favGame=:game_idInput WHERE id=:people_idInput;
-- update a Movie's data based on submission of the Update Movie form
UPDATE Movies SET title=:titleInput, genre=:genreInput, director=:directorInput, runTimeMins=:runTimeMinsInput, metacritic=:metacriticInput WHERE id=:movies_idInput;
-- update a Shows's data based on submission of the Update Movie form
UPDATE Shows SET title=:titleInput, genre=:genreInput, network=:networkInput, episodes=:episodesInput, seasons=:seasonsInput, metacritic=:metacriticInput WHERE id=:shows_idInput;
-- update a Books's data based on submission of the Update Movie form
UPDATE Books SET title=:titleInput, genre=:genreInput, author=:authorInput, pages=:pagesInput, metacritic=:metacriticInput WHERE id=:books_idInput;
-- update a Video Games's data based on submission of the Update Movie form
UPDATE VideoGames SET title=:titleInput, genre=:genreInput, studio=:studioInput, playTimeHrs=:playTimeHrsInput, metacritic=:metacriticInput WHERE id=:video_games_idInput;


-- Delete a Person
DELETE FROM People WHERE id=:people_idInput;
-- Delete a Movie
DELETE FROM Movies WHERE id=:movies_idInput;
-- Delete a Show
DELETE FROM Shows WHERE id=:shows_idInput;
-- Delete a Book
DELETE FROM Books WHERE id=:books_idInput;
-- Delete a Video Game
DELETE FROM VideoGames WHERE id=:video_games_idInput;


-- dis-associate a movie from a person (M-to-M deletion)
DELETE FROM seenMovies WHERE people_id=:people_idInput AND movies_id=:movies_idInput;
-- dis-associate a show from a person (M-to-M deletion)
DELETE FROM seenShows WHERE people_id=:people_idInput AND shows_id=:shows_idInput;
-- dis-associate a book from a person (M-to-M deletion)
DELETE FROM readBooks WHERE people_id=:people_idInput AND books_id=:books_idInput;
-- dis-associate a video game from a person (M-to-M deletion)
DELETE FROM playedGames WHERE people_id=:people_idInput AND video_games_id=:video_games_idInput;
