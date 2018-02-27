```
virtualenv -p $(which python3) venv
source venv/bin/activate
deactivate

pip install Flask
pip freeze > requirements.txt

pip install -r requirements.txt

export FLASK_APP=app/main.py
flask run
```

https://hackernoon.com/restful-api-designing-guidelines-the-best-practices-60e1d954e7c9
https://github.com/WhiteHouse/api-standards
https://geemus.gitbooks.io/http-api-design/content/en/
