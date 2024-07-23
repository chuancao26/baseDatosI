from .entities.utensilio import Utensilio

class Model_utensilio():
    
    @classmethod
    def insertar(cls, db, utensilio):
        try:
            cursor = db.connection.cursor()
            cursor.callproc('InsertarUtensilio', (utensilio.nombre, utensilio.descripcion, utensilio.precio, utensilio.cantidad, utensilio.unidad))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def mostrar(cls, db):
        try:
            cursor = db.connection.cursor()
            cursor.execute("call MostrarUtensilio()")
            rows = cursor.fetchall()
            utensilios = []
            for row in rows:
                nombre, descripcion,  precio, cantidad, unidad, codUtensilio = row
                utensilio = Utensilio(nombre, descripcion, precio, cantidad, unidad, codUtensilio=codUtensilio)
                utensilios.append(utensilio)
            return utensilios
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def borrar(cls, db, codUtensilio):
        try:
            cursor = db.connection.cursor()
            cursor.callproc('BorrarUtensilio', (codUtensilio,))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def mostrarU(cls, db, codUtensilio):
        try:
            cursor = db.connection.cursor()
            cursor.callproc('MostrarUtensilioU', (codUtensilio,))
            row = cursor.fetchone()
            if row:
                nombre, descripcion, precio, cantidad, unidad, codUtensilio = row
                return Utensilio(nombre, descripcion, precio, cantidad, unidad, codUtensilio=codUtensilio)
            else:
                return None
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def modificar(cls, db, utensilio):
        try:
            cursor = db.connection.cursor()
            cursor.callproc('ActualizarUtensilio', (utensilio.codUtensilio, utensilio.nombre, utensilio.descripcion, utensilio.precio, utensilio.cantidad, utensilio.unidad))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
