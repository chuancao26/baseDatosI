class Config:
    SECRET_KEY = '2638'
class DevelpmentConfig(Config):
    DEBUG = True
    MYSQL_HOST = 'localhost'
    MYSQL_USER = "root"
<<<<<<< HEAD
    MYSQL_PASSWORD = 'mamani20'
=======
    MYSQL_PASSWORD = '12345'
>>>>>>> a66ac4c156809d090c4bb4482d0e8b94224dc1c9
    MYSQL_DB = 'carwash'
config = {
    'development': DevelpmentConfig
}
