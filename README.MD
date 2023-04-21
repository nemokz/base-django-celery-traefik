# Basic Django starter kit

This project is a basic setup of: 
  * `Django, DRF` - Web framework
  * `Celery, Celery beat, Redis, Flower` - Queues and async
  * `PostgreSQL` - Relational database
  * `Traefik` - Reverse proxy
  * `Docker, Docker Compose` - Application containerization

## Requirements

* Docker
* Docker Compose

## Installation

1. Clone this repository
2. Run `docker-compose -f docker-compose-local.yml --env-file .env up -d` to build and start the containers
3. Access the Django app at `http://localhost`
4. Access Flower monitoring tool at `http://localhost:5555`
5. Access Traefik dashboard at `http://localhost:8080`

## For prodaction:

1. Update Hosts in web service in docker-compose file.
2. Сonfigure env
3. Run docker-compose -f docker-compose.prod --env-file .env up -d

## Usage

1. Start the containers: `docker-compose up -d`
2. Stop the containers: `docker-compose stop`
3. Remove the containers: `docker-compose down`
4. View logs: `docker logs base-django-celery-traefik-web-1  -f --tail 500 --follow