class Servicio():
    def __init__(self, nombre, precio, duracion,descripcion, url_imagen, codServicio=0) -> None:
        self.nombre = nombre
        self.precio = precio
        self.duracion = duracion
        self.descripcion = descripcion
        self.url_imagen = url_imagen
        
        self.codServicio = codServicio
