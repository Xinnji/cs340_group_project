from flask import Flask, render_template
# import MySQLdb
import os

app = Flask(__name__)


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/<page>')
def page(page):
    return render_template(f'{page}.html')


if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8585))
    app.run(host='flip3.engr.oregonstate.edu', port=port, debug=True)
    # app.run(debug=True)
