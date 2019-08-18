install: install-galaxy install-python

install-galaxy:
	ansible-galaxy install --force -r galaxy_requirements.yml

install-python:
	virtualenv -p python3.6 .virtualenv
	pip install -r requirements.txt

activate:

