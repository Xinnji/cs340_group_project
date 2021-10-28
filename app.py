from flask import Flask, render_template
# import MySQLdb
import os


app = Flask(__name__)

# people = ["id", "name", "age", "favMovie", "favShow", "favBook", "favGame", "seenMovies", "seenShows", "readBooks"]
# movies = ["id", "title", "genre", "director", "runTimeMins", "metacritic"]
# shows = ["id", "title", "genre", "network", "episodes", "seasons", "metacritic"]
# books = ["id", "title", "genre", "author", "pages", "metacritic"]
# videogames = ["id", "title", "genre", "studio", "playTimHrs", "metacritic"]


@app.route('/', methods=["GET", "POST"])
def index():
    return render_template('index.html')


@app.route('/<page>', methods=["GET", "POST"])
def page(page):
    return render_template(f'{page}.html')


if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8585))
    app.run(host='flip3.engr.oregonstate.edu', port=port, debug=True)
    # app.run(debug=True)
