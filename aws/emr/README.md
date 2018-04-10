# flask-boilerplate

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

### Development

```
# install package
pip install Flask
pip install pylint

# update requirements
pip freeze > requirements.txt

# run tests
python tests/application_test.py
python setup.py test

# linting
pylint application/main.py
find ./application -iname "*.py" | xargs pylint

# install the application
pip install --editable .

# clean cached files
rm -fr .eggs/ *.egg-info */__pycache__/ */*/__pycache__/

# run in debug
export FLASK_APP=application
export FLASK_DEBUG=1
flask run

# logs
tail -F logs/application.log
```

### Run

```
# activate virtualenv
source venv/bin/activate

# helper script
./dev.sh

# main
python application/main.py
```

### Docker

```
# build image
docker build -t brightwindanalysis/flask-boilerplate:latest .

# start temporary container [port=HOST:CONTAINER]
docker run \
  --rm \
  -e HTTP_PORT=8080 \
  -p 5000:8080 \
  --name flask-boilerplate \
  brightwindanalysis/flask-boilerplate:latest

# test
http -v :5000

# access container
docker exec -it flask-boilerplate bash
```
