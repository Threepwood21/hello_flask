#!/usr/bin/env python
from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!"

@app.route("/goodbye")
def goodbye():
    return "Goodbye"

@app.route('/user/<username>')
def show_user_profile(username):
    # show the user profile for that user
    return 'hello %s' % username


if __name__ == "__main__":
    app.run(port=80, host="0.0.0.0", threaded=True)
