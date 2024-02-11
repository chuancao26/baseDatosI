from flask import render_template, request, redirect, url_for, flash
from flask_login import login_required, current_user

from models.ModelClient import ModelClient

def configure_route_client(app,db):
    
    @app.route("/logear/client", methods=['GET'])
    @login_required
    def start_client():
        info = ModelClient.data(db, current_user.dni)
        return render_template("client/client.html", dato = info)
    
    @app.route("/logear/client/auto-view", methods=['GET'])
    @login_required
    def start_client_auto_view():
        info = ModelClient.autos(db, current_user.dni)
        return render_template("client/view_auto.html", dato = info)
    
    @app.route("/logear/client/auto-register", methods=['GET'])
    @login_required
    def start_client_auto_register():
        return render_template("client/form_auto.html")
                               
    @app.route("/logear/client/auto-register-auto", methods=['POST'])
    def start_cliente_auto_register_auto():
        if request.method == 'POST':
            codAuto = request.form['codAuto']
            placa = request.form['placa']
            tipo = request.form['tipo']
            volumen = request.form['volumen']
            color = request.form['color']
            marca = request.form['marca']
            modelo = request.form['modelo']
            if not (codAuto and placa and tipo and volumen and color and marca and modelo):
                flash('Error en el Registro. Completar Campos')
                return redirect(url_for('start_client_auto_register'))
            try:
                ModelClient.insertar_auto(db, codAuto, placa, tipo, volumen, color, marca, modelo, current_user.dni)
                flash('Registro Hecho')
                return redirect(url_for('start_client_auto_register'))
            except Exception as ex:
                flash(f'Error: {str(ex)}')
            
            return redirect(url_for('start_client_auto_register'))
        
        return redirect(url_for('start_client_auto_register'))   