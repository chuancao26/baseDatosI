class ModelCita():
    @classmethod
    def data_service(cls,db):
        try:
            cursor = db.connection.cursor()
            sql = "SELECT * FROM servicio"
            cursor.execute(sql)
            data = cursor.fetchall()
            return data
        except Exception as ex:
            raise Exception(ex)

    @classmethod
    def boleta(cls,db,codServicio):
        try:
            cursor = db.connection.cursor()
            sql = "SELECT * FROM servicio WHERE codServicio = (%s)"
            cursor.execute(sql,(codServicio,))
            data = cursor.fetchall()
            return data
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def guardar_cita(cls, db, codCita, codCliente, codServicio, fecha, hora, progreso):
        try:
            cursor = db.connection.cursor()

            sql_cod_cliente = "call GetCodClienteByDNI(%s)"
            cursor.execute(sql_cod_cliente, (codCliente,))
            codCliente = cursor.fetchone()[0] 
             
            sql = "call Insertar_Cita(%s, %s, %s, %s)"
            cursor.execute(sql, (fecha, hora, codCliente, codServicio)) 

            sql_factura = "call generarFactura(%s,%s)"
            cursor.execute(sql_factura, ( codServicio, progreso))                     
            db.connection.commit()
        except Exception as ex:
            db.connection.rollback()
            raise Exception(ex)

    @classmethod
    def Factura(cls,db):
        try:
            cursor = db.connection.cursor()

            sql = "call obtenerFacturaMaxima()"
            cursor.execute(sql,())
            data = cursor.fetchall()
            return data
        except Exception as ex:
            raise Exception(ex)
        