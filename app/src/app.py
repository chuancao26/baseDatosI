from flask import Flask, render_template, request, url_for, redirect, jsonify, flash
from flask_mysqldb import MySQL
from flask_login import LoginManager, login_user, logout_user, login_required, current_user

from models.Model import Model
from config import config

app = Flask(__name__)
conexion = MySQL(app)

@app.route('/')
def login():
    return render_template('login.html')
@app.route('/ClienteFormulario')
def ClienteFormulario():
    return render_template("formCliente.html")

@app.route('/insertCliente', methods=['GET', 'POST'])
def insertCliente():
    dni = request.form['DNI']
    if Model.findDNI(conexion, dni):
        flash("Dni ya registrado!")
        return render_template("formCliente.html")
    nombres = request.form['nombres']
    primerApellido = request.form['primerApellido'] 
    segundoApellido = request.form['segundoApellido'] 
    fecNacimiento = request.form['fecNacimiento'] 
    sexo = request.form['sexo'] 
    telefono = request.form['telefono'] 
    correo = request.form['correo'] 
    direccion = request.form['direccion']
    usuario = request.form["usuario"]
    if Model.findUser(conexion, usuario):
        flash("usuario ya registrado!")
        return render_template("formCliente.html")
    password = request.form['password']
    Model.insertCliente(conexion, dni, nombres, primerApellido, segundoApellido, fecNacimiento, sexo, telefono, correo, direccion, usuario, password)
    return redirect(url_for('login'))



@app.route('/EmpleadoFormulario')
def EmpleadoFormulario():
    return render_template("formEmpleado.html")
@app.route('/representanteFormulario')
def representanteFormulario():
    return render_template("formRepresentante.html")



if __name__ == '__main__':
    app.config.from_object(config['development'])
    app.run()


