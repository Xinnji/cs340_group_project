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
UUPDATE People
SET name = '{request.form['name']}',
    age = {request.form['age']},
    favMovie = {request.form['favMovie']},
    favShow = {request.form['favShow']},
    favBook = {request.form['favBook']},
    favGame = {request.form['favGame']}
WHERE id = {id};
-- update a Movie's data based on submission of the Update Movie form
UPDATE Movies
SET title = '{request.form['title']}',
    genre = '{request.form['genre']}',
    director = '{request.form['director']}',
    runTimeMins = {request.form['runTimeMins']},
    metacritic = {request.form['metacritic']}
WHERE id = {id};
-- update a Shows's data based on submission of the Update Movie form
UPDATE Shows
SET title = '{request.form['title']}',
    genre = '{request.form['genre']}',
    network = '{request.form['network']}',
    episodes = {request.form['episodes']},
    seasons = {request.form['seasons']},
    metacritic = {request.form['metacritic']}
WHERE id = {id};
-- update a Books's data based on submission of the Update Movie form
UPDATE Books
SET title = '{request.form['title']}',
    genre = '{request.form['genre']}',
    author = '{request.form['author']}',
    pages = {request.form['pages']},
    metacritic = {request.form['metacritic']}
WHERE id = {id};
-- update a Video Games's data based on submission of the Update Movie form
UPDATE VideoGames
SET title = '{request.form['title']}',
    genre = '{request.form['genre']}',
    studio = '{request.form['studio']}',
    playTimeHrs = {request.form['playTimeHrs']},
    metacritic = {request.form['metacritic']}
WHERE id = {id};


-- Delete a Person and their M-to-M info
DELETE FROM `playedGames` WHERE people_id = {id};
DELETE FROM `readBooks` WHERE people_id = {id};
DELETE FROM `seenShows` WHERE people_id = {id};
DELETE FROM `seenMovies` WHERE people_id = {id};
DELETE FROM `People` WHERE People.id = {id};
-- Delete a Movie and their M-to-M info
UPDATE People SET People.favMovie = NULL WHERE favMovie = {id};
DELETE FROM `seenMovies` WHERE movies_id = {id};
DELETE FROM `Movies` WHERE id = {id}
-- Delete a Show and their M-to-M info
UPDATE People SET People.favShow = NULL WHERE favShow = {id};
DELETE FROM `seenShows` WHERE shows_id = {id};
DELETE FROM `Shows` WHERE id = {id}
-- Delete a Book and their M-to-M info
UPDATE People SET People.favBook = NULL WHERE favBook = {id};
DELETE FROM `readBooks` WHERE books_id = {id};
DELETE FROM `Books` WHERE id = {id}
-- Delete a Video Game and their M-to-M info
UPDATE People SET People.favGame = NULL WHERE favGame = {id};
DELETE FROM `playedGames` WHERE video_games_id = {id};
DELETE FROM `VideoGames` WHERE id = {id}
