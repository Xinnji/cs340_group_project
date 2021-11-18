from flask import Flask, render_template, request, redirect
import configparser
import MySQLdb
import os


def sql_query(query):
    con = MySQLdb.connect(host=config['sql']['host'],
                          user=config['sql']['user'],
                          passwd=config['sql']['passwd'],
                          db=config['sql']['db'])
    cursor = con.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query)
    con.commit();
    return cursor.fetchall()


app = Flask(__name__)

config = configparser.ConfigParser()
config.read('config.ini')

# con = MySQLdb.connect(host=config['sql']['host'],
#                       user=config['sql']['user'],
#                       passwd=config['sql']['passwd'],
#                       db=config['sql']['db'])
# cursor = con.cursor(MySQLdb.cursors.DictCursor)
# For each query
# cursor.execute('query')
# con.commit();

People = ["id", "name", "age", "favMovie", "favShow", "favBook", "favGame", "seenMovies", "seenShows", "readBooks", "playedGames"]
Movies = ["id", "title", "genre", "director", "runTimeMins", "metacritic", "Seen-it"]
Shows = ["id", "title", "genre", "network", "episodes", "seasons", "metacritic", "Seen-it"]
Books = ["id", "title", "genre", "author", "pages", "metacritic", "Read-it"]
VideoGames = ["id", "title", "genre", "studio", "playTimeHrs", "metacritic", "Played-it"]


@app.route('/', methods=["GET", "POST"])
def index():
    result = []
    queries = [
        '''SELECT People.id, name, age, Movies.title, Shows.title, Books.title, VideoGames.title FROM People
            JOIN Movies ON Movies.id = favMovie
            JOIN Shows ON Shows.id = favShow
            JOIN Books ON Books.id = favBook
            JOIN VideoGames ON VideoGames.id = favGame;''',
        '''SELECT People.id, title FROM Movies
            JOIN seenMovies ON Movies.id = seenMovies.movies_id
            JOIN People on seenMovies.people_id = People.id''',
        '''SELECT People.id, title FROM Books
            JOIN readBooks ON Books.id = readBooks.books_id
            JOIN People on readBooks.people_id = People.id''',
        '''SELECT People.id, title FROM Shows
            JOIN seenShows ON Shows.id = seenShows.shows_id
            JOIN People on seenShows.people_id = People.id''',
        '''SELECT People.id, title FROM VideoGames
            JOIN playedGames ON VideoGames.id = playedGames.video_games_id
            JOIN People on playedGames.people_id = People.id'''
    ]
    for query in queries:
        result.append(sql_query(query))

    if request.method == "POST":
        sql_query(f'''INSERT INTO People (name, age, favMovie, favShow, favBook, favGame)
                        VALUES ("{request.form['name']}", {request.form['age']}, {request.form['favMovie']}, {request.form['favShow']}, {request.form['favBook']}, {request.form['favGame']});''')
        return redirect('/')

    return render_template('index.html', entity=People, result=result)


@app.route('/movies', methods=["GET", "POST", "PATCH"])
def movies():
    result = []
    queries = [
        '''SELECT * FROM Movies''',
        '''SELECT Movies.id, name FROM Movies
            JOIN seenMovies ON Movies.id = seenMovies.movies_id
            JOIN People on seenMovies.people_id = People.id'''
    ]
    for query in queries:
        result.append(sql_query(query))

    if request.method == "POST":
        if all(attr in request.form for attr in Movies[1:-1]):
            sql_query(f'''INSERT INTO Movies (title, genre, director, runTimeMins, metacritic)
                        VALUES ("{request.form['title']}", "{request.form['genre']}", "{request.form['director']}", {request.form['runTimeMins']}, {request.form['metacritic']});''')
        elif ('people_id' in request.form) and ('movies_id' in request.form):
            sql_query(f'''INSERT INTO seenMovies (people_id, movies_id)
                        VALUES ({request.form['people_id']}, {request.form['movies_id']});''')
        print(2)
        return redirect('/movies')

    return render_template('movies.html', entity=Movies, result=result)


@app.route('/shows', methods=["GET", "POST"])
def shows():
    result = []
    queries = [
        '''SELECT * FROM Shows''',
        '''SELECT Shows.id, name FROM Shows
            JOIN seenShows ON Shows.id = seenShows.shows_id
            JOIN People on seenShows.people_id = People.id'''
    ]
    for query in queries:
        result.append(sql_query(query))

    if request.method == "POST":
        if all(attr in request.form for attr in Shows[1:-1]):
            sql_query(f'''INSERT INTO Shows (title, genre, network, episodes, seasons, metacritic)
                        VALUES ("{request.form['title']}", "{request.form['genre']}", "{request.form['network']}", {request.form['episodes']}, {request.form['seasons']}, {request.form['metacritic']});''')
        elif ('people_id' in request.form) and ('shows_id' in request.form):
            sql_query(f'''INSERT INTO seenShows (people_id, shows_id)
                        VALUES ({request.form['people_id']}, {request.form['shows_id']});''')
        return redirect('/shows')

    return render_template('shows.html', entity=Shows, result=result)


@app.route('/books', methods=["GET", "POST"])
def books():
    result = []
    queries = [
        '''SELECT * FROM Books''',
        '''SELECT Books.id, name FROM Books
            JOIN readBooks ON Books.id = readBooks.books_id
            JOIN People on readBooks.people_id = People.id'''
    ]
    for query in queries:
        result.append(sql_query(query))

    if request.method == "POST":
        if all(attr in request.form for attr in Books[1:-1]):
            sql_query(f'''INSERT INTO Books (title, genre, author, pages, metacritic)
                        VALUES ("{request.form['title']}", "{request.form['genre']}", "{request.form['author']}", {request.form['pages']}, {request.form['metacritic']});''')
        elif ('people_id' in request.form) and ('books_id' in request.form):
            sql_query(f'''INSERT INTO readBooks (people_id, books_id)
                        VALUES ({request.form['people_id']}, {request.form['books_id']});''')
        return redirect('/books')

    return render_template('books.html', entity=Books, result=result)


@app.route('/videogames', methods=["GET", "POST"])
def videogames():
    result = []
    queries = [
        '''SELECT * FROM VideoGames''',
        '''SELECT VideoGames.id, name FROM VideoGames
            JOIN playedGames ON VideoGames.id = playedGames.video_games_id
            JOIN People on playedGames.people_id = People.id'''
    ]
    for query in queries:
        result.append(sql_query(query))

    if request.method == "POST":
        if all(attr in request.form for attr in VideoGames[1:-1]):
            sql_query(f'''INSERT INTO VideoGames (title, genre, studio, playTimeHrs, metacritic)
                        VALUES ("{request.form['title']}", "{request.form['genre']}", "{request.form['studio']}", {request.form['playTimeHrs']}, {request.form['metacritic']});''')
        elif ('people_id' in request.form) and ('video_games_id' in request.form):
            sql_query(f'''INSERT INTO playedGames (people_id, video_games_id)
                        VALUES ({request.form['people_id']}, {request.form['video_games_id']});''')
        return redirect('/videogames')

    return render_template('videogames.html', entity=VideoGames, result=result)


if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8585))
    app.run(host='flip3.engr.oregonstate.edu', port=port, debug=True)
    # app.run(debug=True)
