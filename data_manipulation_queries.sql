-- Colon : is the special character used to denote variables that will have data given by the user.

-- Get all people and their data for the home People page
SELECT name, age, Movies.title, Shows.title, Books.title, VideoGames.title FROM People
JOIN Movies ON Movies.id = favMovie
JOIN Shows ON Shows.id = favShow
JOIN Books ON Books.id = favBook
JOIN VideoGames ON VideoGames.id = favGame;
-- Get all the info about what people have watched/read/played
SELECT People.id, title FROM Movies
JOIN seenMovies ON Movies.id = seenMovies.movies_id
JOIN People on seenMovies.people_id = People.id
SELECT People.id, title FROM Books
JOIN readBooks ON Books.id = readBooks.books_id
JOIN People on readBooks.people_id = People.id
SELECT People.id, title FROM Shows
JOIN seenShows ON Shows.id = seenShows.shows_id
JOIN People on seenShows.people_id = People.id
SELECT People.id, title FROM VideoGames
JOIN playedGames ON VideoGames.id = playedGames.video_games_id
JOIN People on playedGames.people_id = People.id
-- Get all Movies and their data for the display Movies page and for dropdowns
SELECT * FROM Movies
SELECT Movies.id, name FROM Movies
JOIN seenMovies ON Movies.id = seenMovies.movies_id
JOIN People on seenMovies.people_id = People.id
-- Get all Shows and their data for the display Shows page and for dropdowns
SELECT * FROM Shows
SELECT Shows.id, name FROM Shows
JOIN seenShows ON Shows.id = seenShows.shows_id
JOIN People on seenShows.people_id = People.id
-- Get all Books and their data for the display Movies page and for dropdowns
SELECT * FROM Books
SELECT Books.id, name FROM Books
JOIN readBooks ON Books.id = readBooks.books_id
JOIN People on readBooks.people_id = People.id
-- Get all Video Games and their data for the display Movies page and for dropdowns
SELECT * FROM VideoGames
SELECT VideoGames.id, name FROM VideoGames
JOIN playedGames ON VideoGames.id = playedGames.video_games_id
JOIN People on playedGames.people_id = People.id


-- Add a new Person
INSERT INTO People (name, age, favMovie, favShow, favBook, favGame)
VALUES ("{request.form['name']}", {request.form['age']}, {request.form['favMovie']}, {request.form['favShow']}, {request.form['favBook']}, {request.form['favGame']});
-- Add a new Movie
INSERT INTO Movies (title, genre, director, runTimeMins, metacritic)
VALUES ("{request.form['title']}", "{request.form['genre']}", "{request.form['director']}", {request.form['runTimeMins']}, {request.form['metacritic']});
-- Add a new Show
INSERT INTO Shows (title, genre, network, episodes, seasons, metacritic)
VALUES ("{request.form['title']}", "{request.form['genre']}", "{request.form['network']}", {request.form['episodes']}, {request.form['seasons']}, {request.form['metacritic']});
-- Add a new Book
INSERT INTO Books (title, genre, author, pages, metacritic)
VALUES ("{request.form['title']}", "{request.form['genre']}", "{request.form['author']}", {request.form['pages']}, {request.form['metacritic']});
-- Add a new Video Game
INSERT INTO VideoGames (title, genre, studio, playTimeHrs, metacritic)
VALUES ("{request.form['title']}", "{request.form['genre']}", "{request.form['studio']}", {request.form['playTimeHrs']}, {request.form['metacritic']});
 

-- Associate a Person with a seen Movie (M:M)
INSERT INTO seenMovies (people_id, movies_id)
VALUES ({request.form['people_id']}, {request.form['movies_id']});
-- Associate a Person with a seen Show (M:M)
INSERT INTO seenShows (people_id, shows_id)
VALUES ({request.form['people_id']}, {request.form['shows_id']});
-- Associate a Person with a read Book (M:M)
INSERT INTO readBooks (people_id, books_id)
VALUES ({request.form['people_id']}, {request.form['books_id']});
-- Associate a Person with a played Video Game (M:M)
INSERT INTO playedGames (people_id, video_games_id)
VALUES ({request.form['people_id']}, {request.form['video_games_id']});


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
