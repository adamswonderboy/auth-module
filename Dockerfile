FROM python:3.10.0-slim-buster

ENV APP_HOME=/app
RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/staticfiles
WORKDIR $APP_HOME

LABEL maintainer="Adams"
LABEL decription="Development image for AUTH"

ENV PYTHONDONTWRITEBYTECODE 1

ENV PYTHONUNBUFFERED 1



RUN apt-get update \
  && apt-get install -y build-essential \
  && apt-get install -y libpq-dev \
  && apt-get install -y gettext \
  && apt-get -y install netcat gcc postgresql \
  && apt-get -y install ca-certificates wget \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip

RUN pip3 install --upgrade pip wheel


COPY ./requirements.txt /app/requirements.txt

RUN pip3 install -r requirements.txt


ENTRYPOINT [ "python3" "manage.py" "runserver"]
