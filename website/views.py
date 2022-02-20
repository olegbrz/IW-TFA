from datetime import datetime

from flask import Blueprint, flash, redirect, render_template, request, url_for
from flask_login import current_user, login_required
from itsdangerous import json
from werkzeug.security import generate_password_hash

from website.models import Lectura, Medico, Paciente, Receta

from . import db

views = Blueprint("views", __name__)


@views.route("/")
def landing():
    return render_template("landing_page.html", user=current_user)


@views.route("/patient-home")
@login_required
def patient_home():
    return render_template("patient_home.html", user=current_user)


@views.route("/readings")
@login_required
def patient_readings():
    last_records = current_user.readings[:10]
    danger_number = 0
    for record in last_records:
        if not (
            120 <= record.ta_sistolica <= 139
            and 80 <= record.ta_diastolica <= 89
            and 50 <= record.ppm <= 100
        ):
            danger_number += 1
    return render_template(
        "patient_readings.html", user=current_user, danger_number=danger_number
    )


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
        return redirect(url_for("views.patient_readings"))
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
        return redirect(url_for("views.patient_readings"))

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


""" Doctor views """


@views.route("/doctor-home")
@login_required
def doctor_home():
    return render_template("doctor_home.html", user=current_user)


@views.route("/doctor-patients", methods=["GET", "POST"])
@login_required
def doctor_patients():
    if request.method == "POST":
        nif = request.form.get("nif")
        paciente = Paciente.query.filter_by(nif=nif).first()
        if paciente and current_user.__tablename__ == "Medico":
            paciente.medico_nif = current_user.nif
            db.session.commit()
            flash("Paciente añadido correctamente", category="success")
        else:
            flash("El usuario con el NIF dado no existe", category="error")
        return redirect(url_for("views.doctor_patients"))
    return render_template("doctor_patients.html", user=current_user)


@views.route("/delete-patient", methods=["POST"])
def delete_patient():
    nif = json.loads(request.data)["nif"]
    paciente = Paciente.query.get(nif)
    if paciente and paciente.medico_nif == current_user.nif:
        paciente.medico_nif = None
        db.session.commit()
        flash("El usuario fue eliminado satisfactoriamente", category="success")
        return redirect(url_for("views.doctor_patients"))


@views.route("/doctor-prescriptions", methods=["GET", "POST"])
@login_required
def doctor_prescriptions():
    if request.method == "POST":
        nif = request.form.get("nif")
        paciente = Paciente.query.filter_by(nif=nif).first()
        if paciente and current_user.__tablename__ == "Medico":
            paciente.medico_nif = current_user.nif
            db.session.commit()
            flash("Paciente añadido correctamente", category="success")
        else:
            flash("El usuario con el NIF dado no existe", category="error")
        return redirect(url_for("views.doctor_patients"))
    return render_template("doctor_prescriptions.html", user=current_user)


@views.route("/update-prescription/<idReceta>", methods=["GET", "POST"])
@login_required
def doctor_update_prescription(idReceta):
    prescription = Receta.query.filter_by(idReceta=idReceta).first()
    if request.method == "POST":
        prescription.fecha_inicio = request.form.get("fecha_inicio")
        prescription.fecha_inicio = request.form.get("fecha_fin")
        prescription.medicamento = request.form.get("medicamento")
        prescription.principio_activo = request.form.get("principio_activo")
        prescription.posologia = request.form.get("posologia")
        db.session.commit()
        flash("La lectura fue actualizada correctamente", category="success")
        return redirect(url_for("views.doctor_prescriptions"))

    if prescription:
        fi = datetime.strftime(prescription.fecha_inicio, "%Y-%m-%d")
        ff = datetime.strftime(prescription.fecha_fin, "%Y-%m-%d")
        return render_template(
            "doctor_update_prescription.html",
            user=current_user,
            prescription=prescription,
            fi=fi,
            ff=ff,
        )


@views.route("/add-prescription/", defaults={"nif": None}, methods=["GET", "POST"])
@views.route("/add-prescription/<nif>", methods=["GET", "POST"])
@login_required
def doctor_add_prescription(nif):
    if request.method == "POST":
        paciente_nif = request.form.get("paciente_nif")
        fecha_inicio = request.form.get("fecha_inicio")
        fecha_fin = request.form.get("fecha_fin")
        medicamento = request.form.get("medicamento")
        principio_activo = request.form.get("principio_activo")
        posologia = request.form.get("posologia")

        prescription = Receta(
            fecha_inicio=fecha_inicio,
            fecha_fin=fecha_fin,
            medicamento=medicamento,
            principio_activo=principio_activo,
            posologia=posologia,
            medico_nif=current_user.nif,
            paciente_nif=paciente_nif,
        )
        db.session.add(prescription)
        db.session.commit()
        flash("Receta registrada correctamente", category="success")
        return redirect(url_for("views.doctor_prescriptions"))
    return render_template(
        "doctor_add_prescription.html", user=current_user, target_patient_nif=nif
    )


@views.route("/delete-prescription", methods=["POST"])
@login_required
def delete_prescription():
    idReceta = json.loads(request.data)["idReceta"]
    receta = Receta.query.get(idReceta)
    if receta and current_user.__tablename__ == "Medico":
        db.session.delete(receta)
        db.session.commit()
        flash("La receta fue eliminada satisfactoriamente", category="success")
        return redirect(url_for("views.doctor_prescriptions"))


@views.route("/doctor-view-patient/<patient_nif>")
@login_required
def doctor_view_patient(patient_nif):
    patient = Paciente.query.filter_by(nif=patient_nif).first()
    if patient and patient.medico_nif == current_user.nif:
        return render_template(
            "doctor_view_patient.html", user=current_user, patient=patient
        )


@views.route("/add-note/<idLectura>", methods=["POST"])
@login_required
def doctor_add_note(idLectura):
    lectura = Lectura.query.filter_by(idLectura=idLectura).first()
    if lectura and current_user.__tablename__ == "Medico":
        lectura.notas_medico = request.form.get("notas_medico")
        db.session.commit()
        flash("La nota fue actualizada satisfactoriamente", category="success")
        return lectura.idLectura


@views.route("/doctor/<nif>")
def doctor_data(nif):
    doctor = Medico.query.filter_by(nif=nif).first()
    if doctor:
        return render_template("doctor-data.html", user=current_user, doctor=doctor)


@views.route("/doctor-edit-personal-data", methods=["GET", "POST"])
def doctor_edit_data():
    if request.method == "POST":
        current_user.nif = request.form.get("nif")
        current_user.nombre = request.form.get("nombre")
        current_user.apellidos = request.form.get("apellidos")
        current_user.email = request.form.get("email")
        current_user.telefono = request.form.get("telefono")
        current_user.hospital = request.form.get("hospital")
        current_user.consulta = request.form.get("consulta")
        current_user.horario_atencion = request.form.get("horario_atencion")

        contrasena1 = request.form.get("contrasena1")
        contrasena2 = request.form.get("contrasena2")
        if contrasena1 and contrasena1 == contrasena2:
            current_user.password = generate_password_hash(contrasena1, method="sha256")

        db.session.commit()
        flash("Información personal actualizada correctamente", category="success")
        return redirect(url_for("views.doctor_data", nif=current_user.nif))
    if current_user.__tablename__ == "Medico":
        return render_template("doctor_edit_personal_data.html", user=current_user)
