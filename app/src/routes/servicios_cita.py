from flask import render_template, request, redirect, url_for, flash
from flask_login import login_required, current_user
from models.ModelCita import ModelCita

def servicio_route(app, db):
    
    @app.route("/logear/client/gaa", methods=['GET'])
    @login_required
    def start_cita():
        servicios = ModelCita.data_service(db)
        return render_template("cita/servicios.html", servicios=servicios)

    @app.route("/logear/client/faa/<int:codServicio>", methods=['GET'])
    @login_required
    def start_factura(codServicio):
        codCliente = current_user.dni
        return render_template("cita/cita_form.html", codCliente=codCliente, codServicio=codServicio)

    @app.route("/logear/client/crear_cita", methods=['POST'])
    @login_required
    def crear_cita():
        codCliente = current_user.dni
        codServicio = request.form['codServicio']
        fecha = request.form['fecha']
        hora = request.form['hora']
        progreso = request.form['progreso'] if 'progreso' in request.form else None
        
        # Aquí debes manejar la generación del codCita
        codCita = 2  # Por ejemplo, supongamos que tienes una función para generar un código de cita único
        
        try:
            ModelCita.guardar_cita(db, codCita, codCliente, codServicio, fecha, hora, progreso)
            flash('Cita creada exitosamente', 'success')
            return redirect(url_for('start_factura_view'))  # Redirige a la página de registro exitoso
        except Exception as ex:
            flash('Error al crear la cita', 'error')
            return redirect(url_for('crear_cita'))  # Otra opción de manejo de error
        
    @app.route("/logear/client/registro_exitoso", methods=['GET'])
    def registro_exitoso():
        return render_template('cita/factura.html,0')

    @app.route("/logear/client/factura-view", methods=['GET'])
    @login_required
    def start_factura_view():
        info = ModelCita.Factura(db)
        return render_template("cita/boleta.html", dato = info)
    