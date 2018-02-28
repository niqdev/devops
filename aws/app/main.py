from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/emr/<env>/clusters')
def get_clusters(env):
    return 'env %s' % env
