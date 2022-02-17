from flask import Blueprint, render_template, request, flash, redirect, url_for
from .models import Paciente
from werkzeug.security import generate_password_hash, check_password_hash
from . import db

auth = Blueprint("auth", __name__)


@auth.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form.get("email")
        password = request.form.get("contrasena")

        patient = Paciente.query.filter_by(email=email).first()
        if patient and check_password_hash(patient.password, password):
            flash("Sesión iniciada exitosamente", category="success")
        else:
            flash("Usuario y/o contraseña incorrectos", category="error")
    return render_template("login.html")


@auth.route("/logout")
def logout():
    return "<p>Logout</p>"


@auth.route("/sign-up", methods=["GET", "POST"])
def sign_up():
    if request.method == "POST":
        nif = request.form.get("nif")
        name = request.form.get("nombre")
        surnames = request.form.get("apellidos")
        email = request.form.get("email")
        telephone = request.form.get("telefono")
        dob = request.form.get("fecha_nacimiento")
        password1 = request.form.get("contrasena1")
        password2 = request.form.get("contrasena2")

        patient = Paciente.query.filter_by(email=email).first()
        if patient:
            flash("Ya existe un usuario registrado con este email", category="error")
        elif len(email) < 4:
            flash(
                "El email no es válido (debe contener más de 4 caracteres",
                category="error",
            )
        elif len(name) < 2:
            flash("El nombre debe tener más de 2 caracteres", category="error")
        elif password1 != password2:
            flash("Las contraseñas no coinciden", category="error")
            print(password1, password2)
        elif len(password1) < 8:
            flash("La contraseña debe contener al menos 8 caracteres", category="error")
        else:
            new_user = Paciente(
                nif=nif,
                nombre=name,
                apellidos=surnames,
                email=email,
                telefono=telephone,
                fecha_nacimiento=dob,
                password=generate_password_hash(password1, method="sha256"),
            )
            db.session.add(new_user)
            db.session.commit()
            flash("La cuenta fue registrada exitosamente!", category="success")
            return redirect(url_for("views.home"))

    return render_template("sign_up.html")
