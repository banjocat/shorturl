build:
	docker-compose -f builds-compose.yml build

push: build
	docker-compose -f builds-compose.yml push

