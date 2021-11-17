from flask import Flask, render_template
import MySQLdb
import os
import configparser


app = Flask(__name__)

# people = ["id", "name", "age", "favMovie", "favShow", "favBook", "favGame"]
# movies = ["id", "title", "genre", "director", "runTimeMins", "metacritic"]
# shows = ["id", "title", "genre", "network", "episodes", "seasons", "metacritic"]
# books = ["id", "title", "genre", "author", "pages", "metacritic"]
# videogames = ["id", "title", "genre", "studio", "playTimHrs", "metacritic"]

config = configparser.ConfigParser()
config.read('config.ini')

con = MySQLdb.connect(host=config['SQL']['host'],
                      user=config['SQL']['user'],
                      passwd=config['SQL']['passwd'],
                      db=config['SQL']['db'])
cursor = con.cursor(MySQLdb.cursors.DictCursor)
# For each query
# cursor.execute('query')
# con.commit();


@app.route('/', methods=["GET", "POST"])
def index():
    return render_template('index.html')


@app.route('/<page>', methods=["GET", "POST"])
def page(page):
    return render_template(f'{page}.html')


if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8686))
    app.run(host='flip3.engr.oregonstate.edu', port=port, debug=False)
    # app.run(debug=True)
