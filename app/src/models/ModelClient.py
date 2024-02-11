class ModelClient():
    @classmethod
    def data(cls,db,dni):
        try:
            cursor = db.connection.cursor()
            sql = "call BuscarClienteDNI(%s)"
            cursor.execute(sql,(dni,))
            data = cursor.fetchall()
            return data
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def autos(cls,db,dni):
        try:
            cursor = db.connection.cursor()
            sql = "call BuscarAutosPorDNI(%s)"
            cursor.execute(sql,(dni,))
            data = cursor.fetchall()
            return data
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def insertar_auto(cls, db, placa, tipo, volumen, color, marca, modelo, dni):
        try:
            cursor = db.connection.cursor()
            sql = "call InsertarAuto(%s, %s, %s, %s, %s, %s, %s)"
            cursor.execute(sql, (placa, tipo, volumen, color, marca, modelo, dni))
            db.connection.commit()
        except Exception as ex:
            db.connection.rollback()
            raise Exception(ex)
        
    @classmethod
    def facturas(cls, db, dni):
        try:
            cursor = db.connection.cursor()
            sql = "call ObtenerFacturaPorDNI(%s)"
            cursor.execute(sql, (dni,))
            data = cursor.fetchall()
            return data
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def eliminar(cls, db, codAuto):
        try:
            with db.connection.cursor() as cursor:
                sql = "CALL EliminarAuto(%s)"
                cursor.execute(sql, (codAuto,))
            db.connection.commit()
        except Exception as ex:
            db.connection.rollback()
            raise Exception(ex)

