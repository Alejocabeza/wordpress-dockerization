#!/bin/bash
APP = wordpress
OS := $(shell uname)

ifeq ($(OS),Darwin)
        UID = $(shell id -u)
else ifeq ($(OS),Linux)
        UID = $(shell id -u)
else
        UID = 1000
endif

help: ## Show this help message
	@echo 'usage: make [target]'
	@echo
	@echo 'targets:'
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

start: ## Start the containers
	U_ID=${UID} docker-compose up -d

stop: ## Stop the containers
	U_ID=${UID} docker-compose stop

restart: ## Restart the containers
	$(MAKE) stop && $(MAKE) start

build: ## Rebuilds all the containers
	U_ID=${UID} docker-compose build
	
ssh: ## ssh's into the be container with docker
	U_ID=${UID} docker exec -it --user ${UID} ${APP} bash
