# AWS

Documentation

* [Flask](http://flask.pocoo.org)
* [Click](http://click.pocoo.org)


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
export FLASK_APP=app
export FLASK_DEBUG=1

flask run
```

### Development

```
# install package
pip install Flask
pip install pylint
# TODO remove
pip install pytest

# update requirements
pip freeze > requirements.txt

# verify code
pylint app/main.py
find ./app -iname "*.py" | xargs pylint

# install the application
pip install --editable .
pip install -e .

# run tests
python tests/app_test.py
py.test
```
