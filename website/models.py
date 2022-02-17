from . import db
from flask_login import UserMixin
from sqlalchemy.sql import func


class Paciente(db.Model, UserMixin):
    __tablename__ = "Paciente"
    nif = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(45))
    apellidos = db.Column(db.String(45))
    email = db.Column(db.String(45), unique=True)
    telefono = db.Column(db.String(45), unique=True)
    fecha_nacimiento = db.Column(db.Date)
    password = db.Column(db.String(500))

    # readings = db.relationship("Lectura")


class Lectura(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    date_time = db.Column(db.DateTime(timezone=True), default=func.now())
    sys = db.Column(db.Integer)
    dia = db.Column(db.Integer)
    ppm = db.Column(db.Integer)
    notes = db.Column(db.Text)
    doctor_notes = db.Column(db.Text)
    medicine_taken = db.Column(db.Boolean)

    patient_id = db.Column(db.Integer, db.ForeignKey("paciente.id"))
