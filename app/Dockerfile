# Build dependencies
FROM python:3.11.3-alpine as builder

RUN apk add --no-cache bash \
    && apk add gcc libc-dev linux-headers python3-dev libffi-dev zlib-dev libjpeg musl-dev libevent-dev build-base \
    && apk add postgresql-dev \
    && apk add make

WORKDIR /app

COPY . .

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip setuptools wheel \
    && pip wheel --no-cache-dir --wheel-dir=/usr/src/app/wheels -r requirements.txt

# Final image
FROM python:3.11.3-alpine

RUN adduser -D app
RUN addgroup app app

ENV APP_HOME=/home/app/web
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY --from=builder /usr/src/app/wheels /wheels
COPY --from=builder /app/requirements.txt .

RUN apk add --no-cache libjpeg \
    && pip install --no-cache-dir --no-index --find-links=/wheels -r requirements.txt \
    && rm -rf /root/.cache/pip/*

COPY . $APP_HOME

RUN chown -R app:app $APP_HOME 
RUN mkdir -p /certificates
RUN chown -R app:app /certificates

USER app
