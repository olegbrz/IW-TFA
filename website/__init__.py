from flask import Flask
from json import load


def create_app():
    app = Flask(__name__)
    with open("secret.json") as s:
        sk = load(s)["key"]
    app.config["SECRET_KEY"] = sk
    return app
