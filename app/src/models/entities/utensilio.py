class Utensilio():
    def __init__(self, nombre, descripcion, precio, cantidad, unidad, codUtensilio=0) -> None:
        self.nombre = nombre
        self.descripcion = descripcion
        self.precio = precio
        self.cantidad = cantidad
        self.unidad = unidad
        self.codUtensilio = codUtensilio
