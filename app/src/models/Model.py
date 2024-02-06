class Model():
    @classmethod
    def insertCliente(self, db, dni, nombres, primer_apellido, 
                      segundo_apellido, fec_nacimiento, sexo, 
                      telefono, correo, direccion, usuario, password):
        cursor = db.connection.cursor()
        sql = "call Insertar_Cliente(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);"
        # sql = "INSERT INTO `cliente` (`codCliente`,`DNI`,`nombres`,`primerApellido`,`segundoApellido`,`fecNacimiento`,`sexo`,`telefono`,`correo`,`direccion`) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        cursor.execute(sql,(dni, nombres, primer_apellido, 
                            segundo_apellido, fec_nacimiento, sexo, 
                            telefono, correo, direccion, usuario, password))
        db.connection.commit()
        return True