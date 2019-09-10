build:
	docker-compose -f builds-compose.yml build

push: build
	docker-compose -f builds-compose.yml push

galaxy:
	(cd ansible;ansible-galaxy install -f -r galaxy_requirements.yml)

