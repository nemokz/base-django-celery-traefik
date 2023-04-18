#!/usr/bin/env sh

python manage.py makemigrations
python manage.py migrate
python manage.py collectstatic --no-input

if [ "$DJANGO_SUPERUSER_USERNAME" ]
then
    python manage.py createsuperuser \
        --noinput \
        --username $DJANGO_SUPERUSER_USERNAME \
        --email $DJANGO_SUPERUSER_EMAIL
fi

$@

celery -A config worker --loglevel=INFO --concurrency=10 -n worker1@%h &
celery -A config worker -B &
celery -A config beat -l INFO --scheduler django_celery_beat.schedulers:DatabaseScheduler &
gunicorn --bind 0.0.0.0:8000 config.wsgi --timeout 300 --workers=3 --worker-class=gevent --reload 
