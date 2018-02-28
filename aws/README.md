# AWS

Documentation

* [Flask](http://flask.pocoo.org)


### Setup

```
# create
virtualenv -p $(which python3) venv

# activate virtualenv
source venv/bin/activate

# deactivate virtualenv
deactivate

# install requirements
pip install -r requirements.txt
```

### Run

```
export FLASK_DEBUG=1
export FLASK_APP=app/main.py

flask run

TODO api
http://127.0.0.1:5000/emr/TODO/clusters
http://127.0.0.1:5000/static/example.txt
```

### Development

```
# install package
pip install Flask
pip install pylint

# update requirements
pip freeze > requirements.txt

# verify code
pylint app/main.py
find ./app -iname "*.py" | xargs pylint
```
