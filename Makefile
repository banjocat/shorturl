build:
	docker-compose -f services-compose.yml build

push: build
	docker-compose -f services-compose.yml push

