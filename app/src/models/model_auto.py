from .entities.auto import Auto

class Model_auto():
    
    @classmethod
    def insertar(cls, db, auto):
        try:
            cursor = db.connection.cursor()
            cursor.callproc('InsertarAuto', (auto.placa, auto.tipo, auto.volumen, auto.color, auto.marca, auto.modelo, auto.codCliente))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def mostrar(cls, db):
        try:
            cursor = db.connection.cursor()
            cursor.execute("SELECT * FROM Auto")
            rows = cursor.fetchall()
            autos = []
            for row in rows:
                placa, tipo, volumen, color, marca, modelo, codCliente, codAuto = row
                auto = Auto(placa, tipo, volumen, color, marca, modelo, codCliente, codAuto=codAuto)
                autos.append(auto)
            return autos
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def borrar(cls, db, codAuto):
        try:
            cursor = db.connection.cursor()
            cursor.callproc('BorrarAuto', (codAuto,))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def mostrarU(cls, db, codAuto):
        try:
            cursor = db.connection.cursor()
            cursor.callproc('MostrarAutoU', (codAuto,))
            row = cursor.fetchone()
            if row:
                placa, tipo, volumen, color, marca, modelo, codCliente, codAuto = row
                return Auto(placa, tipo, volumen, color, marca, modelo, codCliente, codAuto=codAuto)
            else:
                return None
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def modificar(cls, db, auto):
        try:
            cursor = db.connection.cursor()
            cursor.callproc('ActualizarAuto', (auto.codAuto, auto.placa, auto.tipo, auto.volumen, auto.color, auto.marca, auto.modelo, auto.codCliente))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
