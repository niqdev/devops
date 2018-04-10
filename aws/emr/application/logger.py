from application import app

import os
import logging
from logging.handlers import TimedRotatingFileHandler

class Logger(object):
    
    def __init__(self):
        self.log_path = app.config['LOG_PATH']
    
    def init(self):
        # create directory if doesn't exist
        os.makedirs(os.path.dirname(self.log_path), exist_ok=True)

        formatter = logging.Formatter("[%(asctime)s][%(levelname)s][%(pathname)s:%(lineno)d] %(message)s")
        handler = TimedRotatingFileHandler(self.log_path, when='midnight', interval=1, backupCount=5)
        handler.setLevel(logging.DEBUG)
        handler.setFormatter(formatter)

        app.logger.addHandler(handler)
        app.logger.setLevel(logging.DEBUG)
        app.logger.debug('init logger')
