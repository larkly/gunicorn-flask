# gunicorn-flask

FROM docker.io/python:buster
#docker-registry.default.svc:5000/base-images/ubi

RUN yum install -y python3 python3-pip
RUN pip3 install gunicorn

# Setup flask application
RUN mkdir -p /deploy/app
COPY gunicorn_config.py /deploy/gunicorn_config.py
COPY app /deploy/app
RUN pip3 install -r /deploy/app/requirements.txt
WORKDIR /deploy/app

EXPOSE 5000

# Start gunicorn
CMD ["/usr/bin/gunicorn", "--config", "/deploy/gunicorn_config.py", "hello:app"]
