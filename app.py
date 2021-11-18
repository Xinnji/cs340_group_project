from flask import Flask, render_template, request, redirect
import configparser
import MySQLdb
import os


app = Flask(__name__)

config = configparser.ConfigParser()
config.read('config.ini')

con = MySQLdb.connect(host=config['sql']['host'],
                      user=config['sql']['user'],
                      passwd=config['sql']['passwd'],
                      db=config['sql']['db'])
cursor = con.cursor(MySQLdb.cursors.DictCursor)
# For each query
# cursor.execute('query')
# con.commit();

people = ["id", "name", "age", "favMovie", "favShow", "favBook", "favGame", "seenMovies", "seenShows", "readBooks", "playedGames"]
movies = ["id", "title", "genre", "director", "runTimeMins", "metacritic"]
shows = ["id", "title", "genre", "network", "episodes", "seasons", "metacritic"]
books = ["id", "title", "genre", "author", "pages", "metacritic"]
videogames = ["id", "title", "genre", "studio", "playTimHrs", "metacritic"]


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
        cursor.execute(query)
        result.append(cursor.fetchall())
    # print(result)

    if request.method == "POST":
        cursor.execute(f'''INSERT INTO People (name, age, favMovie, favShow, favBook, favGame)
            VALUES ("{request.form['name']}", {request.form['age']}, {request.form['favMovie']}, {request.form['favShow']}, {request.form['favBook']}, {request.form['favGame']});''')
        con.commit();
        return redirect('/')

    return render_template('index.html', entity=people, result=result)


@app.route('/movies', methods=["GET", "POST"])
def movies():
    result = []
    queries = []
    for query in queries:
        cursor.execute(query)
        result.append(cursor.fetchall())
    # print(result)

    if request.method == "POST":
        cursor.execute()
        con.commit();
        return redirect('/movies')

    return render_template('movies.html', entity=movies, result=result)


@app.route('/shows', methods=["GET", "POST"])
def shows():
    result = []
    queries = []
    for query in queries:
        cursor.execute(query)
        result.append(cursor.fetchall())
    # print(result)

    if request.method == "POST":
        cursor.execute()
        con.commit();
        return redirect('/shows')

    return render_template('shows.html', entity=shows, result=result)


@app.route('/books', methods=["GET", "POST"])
def books():
    result = []
    queries = []
    for query in queries:
        cursor.execute(query)
        result.append(cursor.fetchall())
    # print(result)

    if request.method == "POST":
        cursor.execute()
        con.commit();
        return redirect('/books')

    return render_template('books.html', entity=books, result=result)


@app.route('/videogames', methods=["GET", "POST"])
def videogames():
    result = []
    queries = []
    for query in queries:
        cursor.execute(query)
        result.append(cursor.fetchall())
    # print(result)

    if request.method == "POST":
        cursor.execute()
        con.commit();
        return redirect('/videogames')

    return render_template('videogames.html', entity=videogames, result=result)


if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8585))
    app.run(host='flip3.engr.oregonstate.edu', port=port, debug=True)
    # app.run(debug=True)
