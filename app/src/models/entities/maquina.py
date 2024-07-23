class Maquina():
    def __init__(self,nombre, marca, funcion, precio, esta_operativa, codProveedor, codLugar,codMaquina=0) -> None:
        self.nombre = nombre
        self.marca = marca
        self.funcion = funcion
        self.precio = precio
        self.esta_operativa = esta_operativa
        self.codProveedor = codProveedor
        self.codLugar = codLugar
        self.codMaquina = codMaquina
        