from flask import Flask
from flask import render_template
from flask import request
from flask import abort, redirect, url_for

app = Flask(__name__)

# http://127.0.0.1:5000/static/example.txt

@app.route('/')
def hello_world():
    app.logger.debug('A value for debugging')
    app.logger.warning('A warning occurred (%d apples)', 42)
    app.logger.error('An error occurred')
    return 'Hello, World!'

# default is GET only
# http://127.0.0.1:5000/param?key=aaa
@app.route('/param', methods=['GET', 'POST'])
def query_param():
    #request.method
    return 'METHOD %s' % request.args.get('key', '')

# http://127.0.0.1:5000/emr/TODO/clusters
@app.route('/emr/<env>/clusters')
@app.route('/emr/<env>/clusters/')
def get_clusters(env):
    return 'env %s' % env

# http://127.0.0.1:5000/hello/name
@app.route('/hello/')
@app.route('/hello/<name>')
def hello(name=None):
    return render_template('hello.html', name=name)

@app.route('/redirect')
def my_redirect():
    return redirect(url_for('error'))

@app.route('/error')
def error():
    abort(401)

# http://127.0.0.1:5000/xxx
@app.errorhandler(404)
def page_not_found(error):
    return render_template('page_not_found.html'), 404

@app.teardown_appcontext
def teardown(error):
    app.logger.debug('before teardown')
