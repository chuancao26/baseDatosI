class Config:
    SECRET_KEY = '2638'
class DevelpmentConfig(Config):
    DEBUG = True
    MYSQL_HOST = 'localhost'
    MYSQL_USER = "root"
    MYSQL_PASSWORD = "2638"
    MYSQL_DB= 'carwash'
config = {
    'development': DevelpmentConfig
}
