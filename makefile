.PHONY: start stop restart shell reactor build

start:
	docker-compose up -d node

stop:
	docker-compose down

restart: stop start

shell: start
	docker-compose exec node bash

reactor: start
	docker-compose exec node npm run reactor

build: start
	docker-compose exec node npm run build