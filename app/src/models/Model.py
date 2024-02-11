from models.entities.User import User
class Model():
    @classmethod
    def login(self, db, username):
        cursor = db.connection.cursor()
        sql = "call buscarUsuario(%s);"
        cursor.execute(sql,(username,))
        datos = cursor.fetchone()
        if datos:
            return User(datos[0], datos[1], datos[2], datos[3], datos[4])
        else:
            return False
        
    @classmethod
    def insertCliente(self, db, dni, nombres, primer_apellido, 
                      segundo_apellido, fec_nacimiento, sexo, 
                      telefono, correo, direccion, usuario, password, passwordN):
        cursor = db.connection.cursor()
        sql = "call Insertar_Cliente(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);"
        cursor.execute(sql,(dni, nombres, primer_apellido, 
                            segundo_apellido, fec_nacimiento, sexo, 
                            telefono, correo, direccion, usuario, password, passwordN))
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
    @classmethod
    def getById(self, db, id):
        cursor = db.connection.cursor()
        sql = "call getByID(%s);"
        cursor.execute(sql,(id,))
        datos = cursor.fetchone()
        if datos:
            return User(datos[0], datos[1], datos[2], datos[3], datos[4])
        else:
            return False
        
    @classmethod
    def esAdmin(cls,db,username ):
        cursor = db.connector.cursor()
        cursor.callproc('esAdmin', (username, es_admin))

        es_admin = cursor.fetchone()[1]
        cursor.close()

        return es_admin

    
        