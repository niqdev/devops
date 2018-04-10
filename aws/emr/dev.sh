#!/bin/bash

rm -fr .eggs/ *.egg-info */__pycache__/ */*/__pycache__/

source venv/bin/activate

pip install -e .

export FLASK_APP=application
export FLASK_DEBUG=1
flask run
