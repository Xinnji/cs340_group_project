from flask import Flask, render_template, request, redirect
import configparser
import MySQLdb
import os


# Execute a SQL query after connecting to the database
def sql_query(query):
    con = MySQLdb.connect(host=config['sql']['host'],
                          user=config['sql']['user'],
                          passwd=config['sql']['passwd'],
                          db=config['sql']['db'])
    cursor = con.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query)
    con.commit();
    return cursor.fetchall()


# Instantiate the Flask website object
app = Flask(__name__)
# Instantiate the config parser so we don't have to include sensitive info like passwords
config = configparser.ConfigParser()
config.read('config.ini')
# Define a bunch of entity attributes so we can dynamically check forms and whatnot
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
            LEFT OUTER JOIN Movies ON Movies.id = favMovie
            LEFT OUTER JOIN Shows ON Shows.id = favShow
            LEFT OUTER JOIN Books ON Books.id = favBook
            LEFT OUTER JOIN VideoGames ON VideoGames.id = favGame;''',
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

    # print(result)

    if request.method == "POST":
        sql_query(f'''INSERT INTO People (name, age, favMovie, favShow, favBook, favGame)
                        VALUES ("{request.form['name']}", {request.form['age']}, {request.form['favMovie']}, {request.form['favShow']}, {request.form['favBook']}, {request.form['favGame']});''')
        return redirect('/')

    return render_template('index.html', entity=People, result=result)


@app.route('/movies', methods=["GET", "POST"])
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


@app.route('/delete')
def delete():
    table = request.args.get('table')
    id = request.args.get('id')

    if not (table and id) or table not in ['People', 'Movies', 'Shows', 'Books', 'VideoGames']:
        return redirect('/')

    if table == 'People':
        queries = [
            f'''DELETE FROM `playedGames` WHERE people_id = {id};''',
            f'''DELETE FROM `readBooks` WHERE people_id = {id};''',
            f'''DELETE FROM `seenShows` WHERE people_id = {id};''',
            f'''DELETE FROM `seenMovies` WHERE people_id = {id};''',
            f'''DELETE FROM `People` WHERE People.id = {id};'''
        ]
        for query in queries:
            sql_query(query)
        return redirect('/')

    elif table == 'Movies':
        queries = [
            f'''UPDATE People SET People.favMovie = NULL WHERE favMovie = {id};''',
            f'''DELETE FROM `seenMovies` WHERE movies_id = {id};''',
            f'''DELETE FROM `Movies` WHERE id = {id}'''
        ]
        for query in queries:
            sql_query(query)
        return redirect('/movies')

    elif table == 'Shows':
        queries = [
            f'''UPDATE People SET People.favShow = NULL WHERE favShow = {id};''',
            f'''DELETE FROM `seenShows` WHERE shows_id = {id};''',
            f'''DELETE FROM `Shows` WHERE id = {id}'''
        ]
        for query in queries:
            sql_query(query)
        return redirect('/shows')

    elif table == 'Books':
        queries = [
            f'''UPDATE People SET People.favBook = NULL WHERE favBook = {id};''',
            f'''DELETE FROM `readBooks` WHERE books_id = {id};''',
            f'''DELETE FROM `Books` WHERE id = {id}'''
        ]
        for query in queries:
            sql_query(query)
        return redirect('/books')

    elif table == 'VideoGames':
        queries = [
            f'''UPDATE People SET People.favGame = NULL WHERE favGame = {id};''',
            f'''DELETE FROM `playedGames` WHERE video_games_id = {id};''',
            f'''DELETE FROM `VideoGames` WHERE id = {id}'''
        ]
        for query in queries:
            sql_query(query)
        return redirect('/videogames')

    else:
        return redirect('/')


@app.route('/update', methods=["GET", "POST"])
def update():
    table = request.args.get('table')
    id = request.args.get('id')

    if not (table and id) or table not in ['People', 'Movies', 'Shows', 'Books', 'VideoGames']:
        return redirect('/')

    if request.method == "GET":
        row = sql_query(f'''SELECT * FROM {table} WHERE id = {id};''')
        entity = globals()[table]
        if table == 'People':
            entity = entity[1:7]
        else:
            entity = entity[1:-1]

        print(row[0])
        print(entity)

        return render_template('update.html', row=row[0], entity=entity, table=table, id=id)

    if request.method == "POST":
        if table == 'People':
            sql_query(f'''UPDATE People
                        SET name = '{ request.form['name'] }',
                            age = { request.form['age'] },
                            favMovie = { request.form['favMovie'] },
                            favShow = { request.form['favShow'] },
                            favBook = { request.form['favBook'] },
                            favGame = { request.form['favGame'] }
                        WHERE id = {id};''')
            return redirect('/')

        elif table == 'Movies':
            sql_query(f'''UPDATE Movies
                        SET title = '{ request.form['title'] }',
                            genre = { request.form['genre'] },
                            director = { request.form['director'] },
                            runTimeMins = { request.form['runTimeMins'] },
                            metacritic = { request.form['metacritic'] }
                        WHERE id = {id};''')
            return redirect('/movies')

        elif table == 'Shows':
            sql_query(f'''UPDATE Shows
                        SET title = '{ request.form['title'] }',
                            genre = { request.form['genre'] },
                            network = { request.form['network'] },
                            episodes = { request.form['episodes'] },
                            seasons = { request.form['seasons'] },
                            metacritic = { request.form['metacritic'] }
                        WHERE id = {id};''')
            return redirect('/shows')

        elif table == 'Books':
            sql_query(f'''UPDATE Books
                        SET title = '{ request.form['title'] }',
                            genre = { request.form['genre'] },
                            author = { request.form['author'] },
                            pages = { request.form['pages'] },
                            metacritic = { request.form['metacritic'] }
                        WHERE id = {id};''')
            return redirect('/books')

        elif table == 'VideoGames':
            sql_query(f'''UPDATE VideoGames
                        SET title = '{ request.form['title'] }',
                            genre = { request.form['genre'] },
                            studio = { request.form['studio'] },
                            playTimeHrs = { request.form['playTimeHrs'] },
                            metacritic = { request.form['metacritic'] }
                        WHERE id = {id};''')
            return redirect('/videogames')

        else:
            return redirect('/')


if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8585))
    app.run(host='flip3.engr.oregonstate.edu', port=port, debug=True)
    # app.run(debug=True)
