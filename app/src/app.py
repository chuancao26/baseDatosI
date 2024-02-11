from flask import Flask, render_template, request, url_for, redirect, jsonify, flash
from flask_mysqldb import MySQL
from flask_login import LoginManager, login_user, logout_user, login_required, current_user

from models.entities.User import User

from models.Model import Model
from config import config

from routes.client_route import configure_route_client
from routes.servicios_cita import servicio_route

app = Flask(__name__)
conexion = MySQL(app)
login_manager_app = LoginManager(app)

configure_route_client(app,conexion)
servicio_route(app,conexion)

@login_manager_app.user_loader
def load_user(id):
    return Model.getById(conexion, id)

@app.route('/')
def login():
    return render_template('login.html')

@app.route('/logear', methods=['GET', 'POST'])
def logear():
    username = request.form['username']
    password = request.form['password']
    user = Model.login(conexion, username)
    if user:
        if User.check_password(user.password, password):
            login_user(user)
            return redirect(url_for("start_client"))
        else:
            flash("password erroneo")
            return render_template("login.html")
    else:
        flash("usuario no encontrado")
        return render_template("login.html")



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
    if Model.insertCliente(conexion, dni, nombres, primerApellido, segundoApellido, fecNacimiento, sexo, telefono, correo, direccion, usuario, User.generate_password(password),password):
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


