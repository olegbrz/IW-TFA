from flask import Blueprint, render_template
from flask_login import login_required, current_user

views = Blueprint("views", __name__)


@views.route("/")
def home():
    return render_template("home.html", user=current_user)


@views.route("/readings")
@login_required
def patient_home():
    return render_template("patient_home.html", user=current_user)


@views.route("/add-reading")
@login_required
def patient_add_reading():
    return render_template("patient_add_reading.html", user=current_user)
