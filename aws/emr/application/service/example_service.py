from application import app

from datetime import datetime
from flask import jsonify

class ExampleService(object):

    def get_tasks(self, request):
        tasks = [
            {
                'id': 1,
                'title': u'Buy groceries',
                'description': u'Milk, Cheese, Pizza, Fruit, Tylenol', 
                'done': False
            },
            {
                'id': 2,
                'title': u'Learn Python',
                'description': u'Need to find a good Python tutorial on the web', 
                'done': False
            }
        ]
        app.logger.debug(request.method)
        app.logger.debug(request.url)
        #app.logger.debug('\n'.join('{}: {}'.format(k, v) for k, v in request.headers.items()))
        #app.logger.debug(request.body)
        return jsonify({
            'href': request.url,
            'createdAt': datetime.utcnow().isoformat(),
            'modifiedAt': datetime.utcnow().isoformat(),
            'tasks': tasks
        })
