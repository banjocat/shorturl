FROM python:3.7

COPY ./requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
RUN mkdir -p /opt/walter
WORKDIR /opt/walter
COPY . .

#CMD gunicorn --workers=2 walter.wsgi
