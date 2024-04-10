#!/bin/sh

# O shell irá encerrar a execução do script quando um comando falhar
set -e

while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
  echo "🟡 Waiting for Postgres Database Startup ($POSTGRES_HOST $POSTGRES_PORT) ..."
  sleep 2
done

echo "✅ Postgres Database Started Successfully ($POSTGRES_HOST:$POSTGRES_PORT)"

python manage.py collectstatic --noinput
python manage.py makemigrations --noinput
python manage.py migrate --noinput


# Criar superusuário admin
echo "Creating superuser admin..."
python manage.py shell -c "from django.contrib.auth.models import User; User.objects.create_superuser($DJANGO_ADMIN, $DJANGO_ADMIN_EMAIL, $DJANGO_ADMIN_PASSWORD)" || true

# Iniciar o servidor
python manage.py runserver 0.0.0.0:8000
