.PHONY: help build up down restart shell logs migrate createsuperuser collectstatic npm-build npm-watch clean reset

help:  ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@egrep '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

build:  ## Build Docker images
	docker compose build

up:  ## Start all services
	docker compose up

up-build:  ## Build and start all services
	docker compose up --build

up-d:  ## Start all services in background
	docker compose up -d

down:  ## Stop all services
	docker compose down

restart:  ## Restart all services
	docker compose restart

shell:  ## Open shell in web container
	docker compose exec web bash

shell-db:  ## Open database shell
	docker compose exec db psql -U waf_pg_db -d waf_pg_db

logs:  ## Show logs for all services
	docker compose logs -f

logs-web:  ## Show logs for web service
	docker compose logs -f web

logs-db:  ## Show logs for database service
	docker compose logs -f db

migrate:  ## Run database migrations
	docker compose exec web python manage.py migrate

createsuperuser:  ## Create Django superuser
	docker compose exec web python manage.py createsuperuser

collectstatic:  ## Collect static files
	docker compose exec web python manage.py collectstatic --noinput

npm-build:  ## Build frontend assets
	docker compose exec web npm run build

npm-watch:  ## Watch and build frontend assets
	docker compose exec web npm run watch

clean:  ## Remove containers and images
	docker compose down --rmi local

reset:  ## Complete reset - remove containers, volumes, and images
	docker compose down --volumes --rmi local
	docker volume prune -f

install:  ## Install/update dependencies
	docker compose exec web pip install -r dev-requirements.txt
	docker compose exec web npm install

test:  ## Run tests (if available)
	docker compose exec web python manage.py test

backup-db:  ## Backup database
	docker compose exec db pg_dump -U waf_pg_db -d waf_pg_db > backup_$$(date +%Y%m%d_%H%M%S).sql
