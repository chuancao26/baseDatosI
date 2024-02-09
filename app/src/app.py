from flask import Flask, render_template, request, url_for, redirect, jsonify, flash
from flask_mysqldb import MySQL
from flask_login import LoginManager, login_user, logout_user, login_required, current_user

from models.entities.User import User

from models.Model import Model
from config import config

app = Flask(__name__)
conexion = MySQL(app)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '2638'
app.config['MYSQL_DB'] = 'carwash'

login_manager_app = LoginManager(app)
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
    try:
        app.config['MYSQL_HOST'] = 'localhost'
        app.config['MYSQL_USER'] = username
        app.config['MYSQL_PASSWORD'] = password
        app.config['MYSQL_DB'] = 'carwash'
        user = Model.login(conexion, username)
        login_user(user)
        return user.fullname
    except:
        app.config['MYSQL_HOST'] = 'localhost'
        app.config['MYSQL_USER'] = "root"
        app.config['MYSQL_PASSWORD'] = "2638"
        app.config['MYSQL_DB'] = 'carwash'
        flash("usuario y/o password equivocados")
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
    if Model.insertCliente(conexion, dni, nombres, primerApellido, segundoApellido, fecNacimiento, sexo, telefono, correo, direccion, usuario, password):
        flash("registro Exitoso!")
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


