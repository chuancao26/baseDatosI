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
        return cursor.fetchall()
    @classmethod
    def findDNI(self, db, dni):
        cursor = db.connection.cursor()
        sql = "call buscarClientePorDNI(%s);"
        cursor.execute(sql,(dni,))
        if cursor.fetchall():
            return True
        else:
            return False
    @classmethod
    def findUser(self, db, usuario):
        cursor = db.connection.cursor()
        sql = "call buscarUsuario(%s);"
        cursor.execute(sql,(usuario,))
        if cursor.fetchall():
            return True
        else:
            return False
    