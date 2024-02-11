from flask import render_template, request, redirect, url_for, flash
from flask_login import login_required, current_user, logout_user

from models.ModelClient import ModelClient

def configure_route_client(app,db):

    @app.route("/logout")
    @login_required
    def logout():
        logout_user()
        return redirect(url_for("login"))
    
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
            placa = request.form['placa']
            tipo = request.form['tipo']
            volumen = request.form['volumen']
            color = request.form['color']
            marca = request.form['marca']
            modelo = request.form['modelo']
            if not (placa and tipo and volumen and color and marca and modelo):
                flash('Error en el Registro. Completar Campos')
                return redirect(url_for('start_client_auto_register'))
            try:
                ModelClient.insertar_auto(db, placa, tipo, volumen, color, marca, modelo, current_user.dni)
                flash('Registro Hecho')
                return redirect(url_for('start_client_auto_register'))
            except Exception as ex:
                flash(f'Error: {str(ex)}')
            
            return redirect(url_for('start_client_auto_register'))
        
        return redirect(url_for('start_client_auto_register'))   
    
    @app.route("/logear/client/facture", methods=['GET'])
    @login_required
    def start_client_facture():
        info = ModelClient.facturas(db, current_user.dni)
        return render_template("client/facture.html", dato = info)
    
    @app.route("/eliminar_auto", methods=['DELETE'])
    @login_required
    def eliminar_auto():
        if request.method == 'DELETE':
            cod_auto = request.json['codAuto']
            ModelClient.eliminar(db, cod_auto)
            return redirect(url_for('start_client_auto_view'))
        return redirect(url_for('start_client_auto_view'))

    