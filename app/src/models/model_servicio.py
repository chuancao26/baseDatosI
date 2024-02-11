from .entities.servicio import Servicio

class Model_servicio():
    
    @classmethod
    def insertar(cls, db, servicio):
        try:
            cursor = db.connection.cursor()
            cursor.callproc('InsertarServicio', (servicio.nombre, servicio.precio,servicio.duracion,servicio.descripcion, servicio.url_imagen))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def mostrar(cls, db):
        try:
            cursor = db.connection.cursor()
            cursor.execute("call MostrarServicio()")
            rows = cursor.fetchall()
            servicios = []
            for row in rows:
                nombre, precio, duracion, descripcion, url_imagen, codServicio = row
                servicio = Servicio(nombre, precio, duracion, descripcion, url_imagen, codServicio=codServicio)
                servicios.append(servicio)
            return servicios
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def borrar(cls, db, codServicio):
        try:
            cursor = db.connection.cursor()
            cursor.callproc('BorrarServicio', (codServicio,))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def mostrarU(cls, db, codServicio):
        try:
            cursor = db.connection.cursor()
            cursor.callproc('MostrarServicioU', (codServicio,))
            row = cursor.fetchone()
            if row:
                nombre, precio, duracion, descripcion, url_imagen, codServicio = row
                return Servicio(nombre, precio, duracion, descripcion, url_imagen,  codServicio=codServicio)
            else:
                return None
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def modificar(cls, db, servicio):
        try:
            cursor = db.connection.cursor()
            cursor.callproc('ActualizarServicio', (servicio.codServicio, servicio.nombre, servicio.precio, servicio.duracion, servicio.descripcion, servicio.url_imagen))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
