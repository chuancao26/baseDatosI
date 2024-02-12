class Model_reporte():
    @classmethod
    
    def obtener_datos_clientes(cls, db):
        cursor = db.connection.cursor()
        cursor.execute("call ObtenerInformacionClientes()")
        data1 = cursor.fetchall()
        
        
        return data1
    
    @classmethod
    def obtener_datos_proveedores(cls, db):
        cursor = db.connection.cursor()
        cursor.execute("call ObtenerProveedoresYUtensilios()")
        data2 = cursor.fetchall()

        return data2
    @classmethod
    def obtener_datos_empleados(cls, db):
        cursor = db.connection.cursor()
        cursor.execute("call ObtenerEmpleados()")
        data3 = cursor.fetchall()

        return data3