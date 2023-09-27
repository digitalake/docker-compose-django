#!/bin/sh
set -e

python manage.py makemigrations
python manage.py migrate
python manage.py collectstatic

exec gunicorn mysite.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 3