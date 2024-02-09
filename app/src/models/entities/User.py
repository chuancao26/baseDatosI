from werkzeug.security import check_password_hash, generate_password_hash
from flask_login import UserMixin
class User(UserMixin):
    def __init__(self, id, fullname, username , dni, password = '') -> None:
        self.id = id
        self.username = username
        self.password = password
        self.fullname = fullname
        self.dni = dni
