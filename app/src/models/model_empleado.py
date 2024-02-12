from .entities.empleado import Empleado

class Model_empleado:
    
    @classmethod
    def insertar(cls, db, empleado):
        try:
            cursor = db.connection.cursor()
            cursor.callproc('InsertarEmpleado', (empleado.DNI, empleado.nombres, empleado.primerApellido, empleado.segundoApellido, empleado.fecNacimiento, empleado.sexo, empleado.telefono, empleado.correo, empleado.direccion, empleado.salario, empleado.puesto, empleado.aniosExperiencia, empleado.codHorario))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def mostrar(cls, db):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL MostrarEmpleado()")
            rows = cursor.fetchall()
            empleados = []
            for row in rows:
                codEmpleado, DNI, nombres, primerApellido, segundoApellido, fecNacimiento, sexo, telefono, correo, direccion, salario, puesto, aniosExperiencia, codHorario = row
                empleado = Empleado(DNI, nombres, primerApellido, segundoApellido, fecNacimiento, sexo, telefono, correo, direccion, salario, puesto, aniosExperiencia, codHorario, codEmpleado=codEmpleado)
                empleados.append(empleado)
            return empleados
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def borrar(cls, db, codEmpleado):
        try:
            cursor = db.connection.cursor()
            cursor.callproc('BorrarEmpleado', (codEmpleado,))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def mostrarU(cls, db, codEmpleado):
        try:
            cursor = db.connection.cursor()
            cursor.callproc('MostrarEmpleadoU', (codEmpleado,))
            row = cursor.fetchone()
            if row:
                codEmpleado, DNI, nombres, primerApellido, segundoApellido, fecNacimiento, sexo, telefono, correo, direccion, salario, puesto, aniosExperiencia, codHorario = row
                return Empleado(DNI, nombres, primerApellido, segundoApellido, fecNacimiento, sexo, telefono, correo, direccion, salario, puesto, aniosExperiencia, codHorario, codEmpleado=codEmpleado)
            else:
                return None
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def modificar(cls, db, empleado):
        try:
            cursor = db.connection.cursor()
            cursor.callproc('ActualizarEmpleado', (empleado.codEmpleado, empleado.DNI, empleado.nombres, empleado.primerApellido, empleado.segundoApellido, empleado.fecNacimiento, empleado.sexo, empleado.telefono, empleado.correo, empleado.direccion, empleado.salario, empleado.puesto, empleado.aniosExperiencia, empleado.codHorario))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
