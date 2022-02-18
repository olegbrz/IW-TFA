from datetime import datetime

from flask import Blueprint, flash, redirect, render_template, request, url_for
from flask_login import current_user, login_required
from itsdangerous import json
from werkzeug.security import generate_password_hash

from website.models import Lectura, Medico

from . import db

views = Blueprint("views", __name__)


@views.route("/")
def landing():
    return render_template("landing_page.html", user=current_user)


@views.route("/home")
@login_required
def home():
    return render_template("home.html", user=current_user)


@views.route("/readings")
@login_required
def patient_home():
    return render_template("patient_home.html", user=current_user)


@views.route("/prescriptions")
@login_required
def patient_prescriptions():
    return render_template("patient_prescriptions.html", user=current_user)


@views.route("/personal-data")
@login_required
def patient_personal_data():
    doctor = Medico.query.filter_by(nif=current_user.medico_nif).first()
    return render_template(
        "patient_personal_data.html", user=current_user, doctor=doctor
    )


@views.route("/edit-personal-data", methods=["GET", "POST"])
@login_required
def patient_edit_personal_data():
    fn = datetime.strftime(current_user.fecha_nacimiento, "%Y-%m-%d")
    if request.method == "POST":
        current_user.nif = request.form.get("nif")
        current_user.nombre = request.form.get("nombre")
        current_user.apellidos = request.form.get("apellidos")
        current_user.email = request.form.get("email")
        current_user.telefono = request.form.get("telefono")
        current_user.fecha_nacimiento = request.form.get("fecha_nacimiento")

        contrasena1 = request.form.get("contrasena1")
        contrasena2 = request.form.get("contrasena2")
        if contrasena1 and contrasena1 == contrasena2:
            current_user.password = generate_password_hash(contrasena1, method="sha256")

        db.session.commit()
        flash("Información personal actualizada correctamente", category="success")
        return redirect(url_for("views.patient_personal_data"))
    return render_template("patient_edit_personal_data.html", user=current_user, fn=fn)


@views.route("/add-reading", methods=["GET", "POST"])
@login_required
def patient_add_reading():
    if request.method == "POST":
        fecha_hora = request.form.get("fecha_hora")
        ta_sistolica = int(request.form.get("ta_sistolica"))
        ta_diastolica = int(request.form.get("ta_diastolica"))
        ppm = int(request.form.get("ppm"))
        notas = request.form.get("nota")
        medicacion_tomada = bool(request.form.get("medicacion_tomada"))

        new_reading = Lectura(
            fecha_hora=fecha_hora,
            ta_sistolica=ta_sistolica,
            ta_diastolica=ta_diastolica,
            ppm=ppm,
            notas=notas,
            medicacion_tomada=medicacion_tomada,
            paciente_nif=current_user.nif,
        )
        db.session.add(new_reading)
        db.session.commit()
        flash("Lectura registrada correctamente", category="success")
        return redirect(url_for("views.patient_home"))
    return render_template("patient_add_reading.html", user=current_user)


@views.route("/update-reading/<idLectura>", methods=["GET", "POST"])
@login_required
def update_reading(idLectura):
    reading = Lectura.query.filter_by(idLectura=idLectura).first()
    if request.method == "POST":
        reading.fecha_hora = request.form.get("fecha_hora")
        reading.ta_sistolica = int(request.form.get("ta_sistolica"))
        reading.ta_diastolica = int(request.form.get("ta_diastolica"))
        reading.ppm = int(request.form.get("ppm"))
        reading.notas = request.form.get("notas")
        reading.medicacion_tomada = bool(request.form.get("medicacion_tomada"))
        db.session.commit()
        flash("La lectura fue actualizada correctamente", category="success")
        return redirect(url_for("views.patient_home"))

    if reading and current_user.nif == reading.paciente_nif:
        fh = datetime.strftime(reading.fecha_hora, "%Y-%m-%dT%H:%M")
        return render_template(
            "patient_update_reading.html", user=current_user, reading=reading, fh=fh
        )


@views.route("/delete-reading", methods=["POST"])
def delete_reading():
    idLectura = json.loads(request.data)["idLectura"]
    lectura = Lectura.query.get(idLectura)
    if lectura and lectura.paciente_nif == current_user.nif:
        db.session.delete(lectura)
        db.session.commit()
        flash("La lectura fue eliminada satisfactoriamente", category="success")
        return redirect(url_for("views.patient_home"))
