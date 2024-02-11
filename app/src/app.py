from flask import Flask, render_template, request, url_for, redirect, jsonify, flash
from flask_mysqldb import MySQL
from flask_login import LoginManager, login_user, logout_user, login_required, current_user

from models.Model import Model
from models.model_maquina import Model_maquina
from models.model_auto import Model_auto
from models.model_utensilio import Model_utensilio
from models.model_servicio import Model_servicio

from models.entities.maquina import Maquina
from models.entities.utensilio import Utensilio
from models.entities.auto import Auto
from models.entities.servicio import Servicio



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

#---------------------------------------------------------------

@app.route('/panelAdmin')
def panelAdmin():
    return render_template('panel_Admin_beta.html')


@app.route('/readMaquina')
def readMaquina():
    data = Model_maquina.mostrar(conexion)
    return render_template('cruds/maquina/readMaquina.html',data=data)

@app.route('/readMaquina/formMaquin', methods=['GET','POST'])
def formMaquina():
    if request.method =='POST':
        nombre = request.form['nombre']
        marca = request.form['marca'] 
        funcion = request.form['funcion'] 
        precio = request.form['precio'] 
        estaOperativa = request.form['estaOperativa'] 
        codProveedor = request.form['codProveedor'] 
        codLugar = request.form['codLugar'] 
        maquina = Maquina(nombre,marca,funcion,precio,estaOperativa, codProveedor, codLugar)
        Model_maquina.insertar(conexion, maquina)
        
        return redirect(url_for('readMaquina'))
    else:
        print('hjhjh')
        return render_template('cruds/maquina/formMaquin.html')

@app.route('/delMaquina/<int:codMaquina>', methods=['GET'])
def delMaquina(codMaquina):
    Model_maquina.borrar(conexion,codMaquina)

    return redirect(url_for('readMaquina'))


@app.route('/readMaquina/modMaquin/<int:codMaquina>', methods=['GET','POST'])
def modMaquina(codMaquina):
    if request.method =='POST':
        nombre = request.form['nombre']
        marca = request.form['marca'] 
        funcion = request.form['funcion'] 
        precio = request.form['precio'] 
        estaOperativa = request.form['estaOperativa'] 
        codProveedor = request.form['codProveedor'] 
        codLugar = request.form['codLugar'] 
        maquina = Maquina(nombre,marca,funcion,precio,estaOperativa, codProveedor, codLugar,codMaquina=codMaquina)
        Model_maquina.modificar(conexion, maquina)
        
        return redirect(url_for('readMaquina'))
    else:
        print('hjhjh')
        maquina = Model_maquina.mostrarU(conexion, codMaquina)
        return render_template('cruds/maquina/modMaquina.html',data=maquina)

    
#---------------------------------------------------------------
@app.route('/readServicio')
def readServicio():
    data = Model_servicio.mostrar(conexion)
    return render_template('cruds/servicio/readServicio.html', data=data)

@app.route('/readServicio/formServicio', methods=['GET','POST'])
def formServicio():
    if request.method =='POST':
        nombre = request.form['nombre']
        precio = request.form['precio'] 
        duracion = request.form['duracion'] 
        servicio = Servicio(nombre, precio, duracion)
        Model_servicio.insertar(conexion, servicio)
        return redirect(url_for('readServicio'))
    else:
        return render_template('cruds/servicio/formServicio.html')

@app.route('/delServicio/<int:codServicio>', methods=['GET'])
def delServicio(codServicio):
    Model_servicio.borrar(conexion, codServicio)
    return redirect(url_for('readServicio'))

@app.route('/readServicio/modServicio/<int:codServicio>', methods=['GET','POST'])
def modServicio(codServicio):
    if request.method =='POST':
        nombre = request.form['nombre']
        precio = request.form['precio'] 
        duracion = request.form['duracion'] 
        servicio = Servicio(nombre, precio, duracion, codServicio=codServicio)
        Model_servicio.modificar(conexion, servicio)
        return redirect(url_for('readServicio'))
    else:
        servicio = Model_servicio.mostrarU(conexion, codServicio)
        return render_template('cruds/servicio/modServicio.html', data=servicio)
#-------------------------------------------------
@app.route('/readAuto')
def readAuto():
    data = Model_auto.mostrar(conexion)
    return render_template('cruds/auto/readAuto.html', data=data)

@app.route('/readAuto/formAuto', methods=['GET','POST'])
def formAuto():
    if request.method =='POST':
        placa = request.form['placa']
        tipo = request.form['tipo'] 
        volumen = request.form['volumen'] 
        color = request.form['color'] 
        marca = request.form['marca'] 
        modelo = request.form['modelo'] 
        codCliente = request.form['codCliente'] 
        auto = Auto(placa, tipo, volumen, color, marca, modelo, codCliente)
        Model_auto.insertar(conexion, auto)
        return redirect(url_for('readAuto'))
    else:
        return render_template('cruds/auto/formAuto.html')

@app.route('/delAuto/<int:codAuto>', methods=['GET'])
def delAuto(codAuto):
    Model_auto.borrar(conexion, codAuto)
    return redirect(url_for('readAuto'))

@app.route('/readAuto/modAuto/<int:codAuto>', methods=['GET','POST'])
def modAuto(codAuto):
    if request.method =='POST':
        placa = request.form['placa']
        tipo = request.form['tipo'] 
        volumen = request.form['volumen'] 
        color = request.form['color'] 
        marca = request.form['marca'] 
        modelo = request.form['modelo'] 
        codCliente = request.form['codCliente'] 
        auto = Auto(placa, tipo, volumen, color, marca, modelo, codCliente, codAuto=codAuto)
        Model_auto.modificar(conexion, auto)
        return redirect(url_for('readAuto'))
    else:
        auto = Model_auto.mostrarU(conexion, codAuto)
        return render_template('cruds/auto/modAuto.html', data=auto)
#-------------------------------------------------

@app.route('/readUtensilio')
def readUtensilio():
    data = Model_utensilio.mostrar(conexion)
    return render_template('cruds/utensilio/readUtensilio.html', data=data)

@app.route('/readUtensilio/formUtensilio', methods=['GET','POST'])
def formUtensilio():
    if request.method =='POST':
        nombre = request.form['nombre']
        descripcion = request.form['descripcion'] 
        precio = request.form['precio'] 
        cantidad = request.form['cantidad'] 
        unidad = request.form['unidad'] 
        utensilio = Utensilio(nombre, descripcion, precio, cantidad, unidad)
        Model_utensilio.insertar(conexion, utensilio)
        return redirect(url_for('readUtensilio'))
    else:
        return render_template('cruds/utensilio/formUtensilio.html')

@app.route('/delUtensilio/<int:codUtensilio>', methods=['GET'])
def delUtensilio(codUtensilio):
    Model_utensilio.borrar(conexion, codUtensilio)
    return redirect(url_for('readUtensilio'))

@app.route('/readUtensilio/modUtensilio/<int:codUtensilio>', methods=['GET','POST'])
def modUtensilio(codUtensilio):
    if request.method =='POST':
        nombre = request.form['nombre']
        descripcion = request.form['descripcion'] 
        precio = request.form['precio'] 
        cantidad = request.form['cantidad'] 
        unidad = request.form['unidad'] 
        utensilio = Utensilio(nombre, descripcion, precio, cantidad, unidad, codUtensilio=codUtensilio)
        Model_utensilio.modificar(conexion, utensilio)
        return redirect(url_for('readUtensilio'))
    else:
        utensilio = Model_utensilio.mostrarU(conexion, codUtensilio)
        return render_template('cruds/utensilio/modUtensilio.html', data=utensilio)
#-------------------------------------------------

#-------------------------------------------------

#-------------------------------------------------

if __name__ == '__main__':
    app.config.from_object(config['development'])
    app.run()


