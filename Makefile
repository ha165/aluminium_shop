# Makefile
.PHONY: help build dev prod clean logs shell migrate

help:
	@echo "Available commands:"
	@echo "  make dev      - Start development environment"
	@echo "  make prod     - Start production environment"
	@echo "  make build    - Build production image"
	@echo "  make clean    - Remove containers and volumes"
	@echo "  make logs     - View logs"
	@echo "  make shell    - Open shell in web container"
	@echo "  make migrate  - Run database migrations"

dev:
	docker-compose up

dev-build:
	docker-compose up --build

dev-detached:
	docker-compose up -d

prod:
	docker-compose -f docker-compose.prod.yml up -d

build:
	docker build -t aluminium_shop:latest .

clean:
	docker-compose down -v
	docker-compose -f docker-compose.prod.yml down -v

logs:
	docker-compose logs -f

shell:
	docker-compose exec web /bin/bash

migrate:
	docker-compose exec web mix ecto.migrate

prod-migrate:
	docker-compose -f docker-compose.prod.yml exec web bin/aluminium_shop eval "AluminiumShop.Release.migrate"

seed:
	docker-compose exec web mix run priv/repo/seeds.exs