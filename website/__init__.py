from lib2to3.pgen2.token import SLASHEQUAL
from flask import Flask
from json import load
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager

db = SQLAlchemy()
DB_NAME = "iw_tfa"
DB_USER = "root"
DB_HOST = "localhost"


def create_app():
    app = Flask(__name__)
    app.config["SQLALCHEMY_ECHO"] = True

    with open("secret.json") as s:
        keys = load(s)
        SECRET_KEY = keys["key"]
        DB_PASS = keys["mysql_key"]
    app.config["SECRET_KEY"] = SECRET_KEY

    app.config[
        "SQLALCHEMY_DATABASE_URI"
    ] = f"mysql://{DB_USER}:{DB_PASS}@{DB_HOST}/{DB_NAME}"
    app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = True

    db.init_app(app)

    login_manager = LoginManager()
    login_manager.login_view = "auth.login"
    login_manager.init_app(app)

    @login_manager.user_loader
    def load_user(nif):
        return Paciente.query.get(int(nif))

    from .views import views
    from .auth import auth

    app.register_blueprint(views, url_prefix="/")
    app.register_blueprint(auth, url_prefix="/")

    from .models import Paciente, Lectura

    return app
