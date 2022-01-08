DC = $(shell which docker-compose)

all: help

help:
	@echo "Available make commands:"
	@echo "  build           - build docker images for development"
	@echo "  dev             - up docker compose with logs"
	@echo "  down            - remove containers for services defined in the Compose file"
	@echo "  db-create       - create database based in config/database.yml file"
	@echo "  db-migrate      - migrations to database"
	@echo "  create-api      - create api project with postgresql database"
	@echo "  create-full     - create fullstack project with postgresql database"

bash:
	${DC} exec rails-app bash

build:
	${DC} build --no-cache

bundle:
	${DC} exec rails-app bin/rails bundle

dev:
	${DC} up -d

down:
	${DC} down --remove-orphans 

db-create:
	${DC} exec rails-app bin/rails db:create db:migrate

db-migrate:
	${DC} exec rails-app bin/rails db:migrate

db-drop:
	${DC} exec rails-app bin/rails db:drop

create-api:
	${DC} run --no-deps rails-app rails new . --api --force --database=postgresql

create-full:
	${DC} run --no-deps rails-app rails new . --api --force --database=postgresql