from flask import Blueprint, render_template, request, flash, redirect, url_for
from .models import Medico, Paciente
from werkzeug.security import generate_password_hash, check_password_hash
from . import db
from flask_login import login_user, login_required, logout_user, current_user

auth = Blueprint("auth", __name__)


@auth.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form.get("email")
        password = request.form.get("contrasena")

        patient = Paciente.query.filter_by(email=email).first()
        doctor = Medico.query.filter_by(email=email).first()
        if patient:
            user = patient
            redir = "views.patient_home"
        elif doctor:
            user = doctor
            redir = "views.doctor_home"
        else:
            flash("Usuario y/o contraseña incorrectos", category="error")
            return render_template("login.html", user=current_user)

        if user and check_password_hash(user.password, password):
            flash("Sesión iniciada exitosamente", category="success")
            login_user(user, remember=True)
            return redirect(url_for(redir))
        else:
            flash("Usuario y/o contraseña incorrectos", category="error")
    return render_template("login.html", user=current_user)


@auth.route("/logout")
@login_required
def logout():
    logout_user()
    return redirect(url_for("auth.login"))


@auth.route("/patient-sign-up", methods=["GET", "POST"])
def patient_sign_up():
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
            login_user(patient, remember=True)
            flash("La cuenta fue registrada exitosamente!", category="success")
            return redirect(url_for("views.home"))

    return render_template("patient_sign_up.html", user=current_user)


@auth.route("/doctor-sign-up", methods=["GET", "POST"])
def doctor_sign_up():
    if request.method == "POST":
        nif = request.form.get("nif")
        name = request.form.get("nombre")
        surnames = request.form.get("apellidos")
        hospital = request.form.get("hospital")
        consulta = request.form.get("consulta")
        horario_atencion = request.form.get("horario_atencion")
        email = request.form.get("email")
        telefono = request.form.get("telefono")
        password1 = request.form.get("contrasena1")
        password2 = request.form.get("contrasena2")

        doctor = Paciente.query.filter_by(email=email).first()
        if doctor:
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
            new_doctor = Medico(
                nif=nif,
                nombre=name,
                apellidos=surnames,
                email=email,
                telefono=telefono,
                hospital=hospital,
                consulta=consulta,
                horario_atencion=horario_atencion,
                password=generate_password_hash(password1, method="sha256"),
            )
            db.session.add(new_doctor)
            db.session.commit()
            login_user(doctor, remember=True)
            flash("La cuenta fue registrada exitosamente!", category="success")
            return redirect(url_for("views.home"))

    return render_template("doctor_sign_up.html", user=current_user)
