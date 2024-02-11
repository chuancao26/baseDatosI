from .entities.maquina import Maquina

class Model_maquina():
    
    @classmethod
    def insertar(cls, bd, maquina):
        
        print(f"ssadasd{maquina.marca}")   
        cursor = bd.connection.cursor()
        cursor.callproc('InsertarMaquina', (maquina.nombre, maquina.marca, maquina.funcion, maquina.precio, maquina.esta_operativa, maquina.codProveedor, maquina.codLugar))

        bd.connection.commit()
        
        
    @classmethod
    def mostrar(cls, db):
        try:
            cursor = db.connection.cursor()
            sql = """ call MostrarMaquina();"""
            cursor.execute(sql)
            rows = cursor.fetchall()
            maquinas = []
            
            for row in rows:
                nombre, marca, funcion, precio, estaOperativa, codProveedor, codLugar, codMaquina = row
                maquina = Maquina(nombre, marca, funcion, precio, estaOperativa, codProveedor, codLugar, codMaquina=codMaquina)
                maquinas.append(maquina)
            

            return tuple(maquinas)
            
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def borrar(cls,bd,dato):
    
        
        cursor = bd.connection.cursor()
        cursor.callproc('BorrarMaquina', (dato,))

        bd.connection.commit()
    @classmethod
    def mostrarU(cls,bd,dato):
    
        
        cursor = bd.connection.cursor()
        cursor.callproc('MostrarMaquinaU', (dato,))
        maquinad = []
        row= cursor.fetchone()
            
        nombre, marca, funcion, precio, estaOperativa, codProveedor, codLugar, codMaquina = row
        maquina = Maquina(nombre, marca, funcion, precio, estaOperativa, codProveedor, codLugar, codMaquina=codMaquina)
        maquinad.append(maquina)
            

        return maquina

        
    @classmethod
    def modificar(cls,bd,maquina):
    
        
        cursor = bd.connection.cursor()
        cursor.callproc('ActualizarMaquina', (maquina.codMaquina,maquina.nombre, maquina.marca, maquina.funcion, maquina.precio, maquina.esta_operativa, maquina.codProveedor, maquina.codLugar))

        bd.connection.commit()