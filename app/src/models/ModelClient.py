class ModelClient():
    @classmethod
    def data(cls,db,dni):
        try:
            cursor = db.connection.cursor()
            sql = "SELECT codCliente, DNI, nombres, primerApellido, segundoApellido, fecNacimiento, sexo, telefono, correo, direccion FROM cliente where DNI = (%s)"
            cursor.execute(sql,(dni,))
            data = cursor.fetchall()
            return data
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def autos(cls,db,dni):
        try:
            cursor = db.connection.cursor()
            sql = "SELECT * FROM auto join cliente on auto.codCliente = cliente.codCliente WHERE cliente.DNI = (%s)"
            cursor.execute(sql,(dni,))
            data = cursor.fetchall()
            return data
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def insertar_auto(cls, db, codAuto, placa, tipo, volumen, color, marca, modelo, dni):
        try:
            cursor = db.connection.cursor()
            sql_cod_cliente = "SELECT codCliente FROM cliente WHERE DNI = %s"
            cursor.execute(sql_cod_cliente, (dni,))
            codCliente = cursor.fetchone()[0] 
            sql_insert_auto = "INSERT INTO auto (codAuto, placa, tipo, volumen, color, marca, modelo, codCliente) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
            cursor.execute(sql_insert_auto, (codAuto, placa, tipo, volumen, color, marca, modelo, codCliente))
            db.connection.commit()
        except Exception as ex:
            db.connection.rollback()
            raise Exception(ex)
