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

    def get_id(self):
        return self.nif

    # readings = db.relationship("Lectura")


class Lectura(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    fecha_hora = db.Column(db.DateTime(timezone=True), default=func.now())
    ta_sistolica = db.Column(db.Integer)
    ta_diastolica = db.Column(db.Integer)
    ppm = db.Column(db.Integer)
    notes = db.Column(db.Text)
    notas_medico = db.Column(db.Text)
    medicacion_tomada = db.Column(db.Boolean)

    paciente_nif = db.Column(db.Integer, db.ForeignKey("paciente.nif"))
