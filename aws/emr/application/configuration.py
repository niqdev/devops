import os

class DefaultConfig(object):
    APP_NAME = 'flask-boilerplate'
    LOG_PATH = 'logs/application.log'
    ENVIRONMENT = 'DEFAULT'
    DEBUG = False
    HTTP_HOST = '127.0.0.1'
    HTTP_PORT = 5000

class Config(DefaultConfig):
    # docker doesn't forward 127.0.0.1
    HTTP_HOST = os.getenv('HTTP_HOST', '0.0.0.0')
    HTTP_PORT = int(os.getenv('HTTP_PORT', 5000))
