from application import app
from application.logger import Logger

Logger().init()

# api
import application.api.status_api
import application.api.example_api

# if run with cli this is NOT executed
if __name__ == '__main__':
    app.logger.info('start application: [{0}] @ {1}:{2} in DEBUG={3}'.format(
        app.config['APP_NAME'], app.config['HTTP_HOST'], app.config['HTTP_PORT'], app.config['DEBUG']))
    app.run(host=app.config['HTTP_HOST'], port=app.config['HTTP_PORT'], debug=app.config['DEBUG'])
