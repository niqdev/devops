FROM python:3.6

WORKDIR /usr/src

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY ./application ./application

COPY setup.py setup.cfg MANIFEST.in ./
RUN pip install --editable .

CMD [ "python", "./application/main.py" ]
