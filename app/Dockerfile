FROM python:3.11-alpine as builder

# set work directory
WORKDIR /app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install system dependencies
RUN apk add --no-cache bash \
    && apk add gcc libc-dev linux-headers python3-dev libffi-dev zlib-dev libjpeg musl-dev libevent-dev build-base \
    && apk add postgresql-dev \
    && apk add make

# lint
RUN pip install --upgrade pip

COPY . .

# install python dependencies
COPY requirements.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /usr/src/app/wheels -r requirements.txt


#########
# FINAL #
#########

# pull official base image
FROM python:3.11-alpine

# create directory for the app user
RUN mkdir -p /home/app

# create the app user
RUN adduser -D app \
    && addgroup app app

# create the appropriate directories
ENV HOME=/home/app
ENV APP_HOME=/home/app/web
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# install dependencies
COPY --from=builder /usr/src/app/wheels /wheels
COPY --from=builder /app/requirements.txt .
RUN pip install --no-cache-dir /wheels/*

# copy project
COPY . $APP_HOME

# chown all the files to the app user
RUN chown -R app:app $APP_HOME

# change to the app user
USER app

# ENTRYPOINT ["sh", "/home/app/web/entrypoint.sh"]
