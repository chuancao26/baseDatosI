from flask import Flask, render_template, request, url_for, redirect, jsonify, flash
from flask_mysqldb import MySQL
from flask_login import LoginManager, login_user, logout_user, login_required, current_user
app = Flask(__name__)

@app.route('/')
def login():
    return render_template('login.html')
@app.route('/ClienteFormulario')
def ClienteFormulario():
    return render_template("formCliente.html")
@app.route('/EmpleadoFormulario')
def EmpleadoFormulario():
    return render_template("formEmpleado.html")
@app.route('/representanteFormulario')
def representanteFormulario():
    return render_template("formRepresentante.html")



if __name__ == '__main__':
    app.run(debug=True)


