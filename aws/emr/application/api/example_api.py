from application import app
from application.service.example_service import ExampleService

from flask import render_template, request, abort, redirect, url_for

example_service = ExampleService()

# http://127.0.0.1:5000/static/example.txt

# http://127.0.0.1:5000
@app.route('/')
def index():
    app.logger.debug('A value for debugging')
    app.logger.warning('A warning occurred (%d apples)', 42)
    app.logger.error('An error occurred')
    return 'Hello, World!'

# default is GET only
# http://127.0.0.1:5000/query?key=aaa
@app.route('/query', methods=['GET', 'POST'])
def query_param():
    return 'METHOD %s' % request.args.get('key', '')

# http://127.0.0.1:5000/path/TODO/hello
@app.route('/path/<param>/hello')
@app.route('/path/<param>/hello/')
def path_param(param):
    return 'param %s' % param

# http://127.0.0.1:5000/hello/name
@app.route('/hello/')
@app.route('/hello/<name>')
def hello(name=None):
    return render_template('hello.html', name=name)

# http://127.0.0.1:5000/redirect
@app.route('/redirect')
def my_redirect():
    return redirect(url_for('error'))

# http://127.0.0.1:5000/error
@app.route('/error')
def error():
    abort(401)

# http://127.0.0.1:5000/xxx
@app.errorhandler(404)
def page_not_found(error):
    return render_template('page_not_found.html'), 404

@app.teardown_appcontext
def teardown(error):
    app.logger.debug('after each request')

# http://127.0.0.1:5000/v1/tasks
@app.route('/v1/tasks', methods=['GET'])
def get_tasks():
    return example_service.get_tasks(request)
