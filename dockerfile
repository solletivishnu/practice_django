# Dockerfile
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

COPY requirements.txt .
COPY wait-for-it.sh .

RUN pip install --upgrade pip && pip install -r requirements.txt


COPY . .

RUN python manage.py collectstatic --noinput

CMD ["gunicorn", "todo_project.wsgi:application", "--bind", "0.0.0.0:8000"]
