.PHONY: help

CURRENT_UID := $(shell id -u)
CURRENT_USER := $(shell whoami)

help: 
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
.DEFAULT_GOAL := up
host_monitor: ## Docker host/containers health monitor
	docker-compose -f host_monitor/docker-compose.yaml up -d

host_monitor_down:
	docker-compose -f host_monitor/docker-compose.yaml down; \
	docker image rm cadvisor


samba: ## Share files 
	docker-compose -f samba/docker-compose.yaml up -d; \
	docker exec -it samba ./utils/add_user.sh ${CURRENT_USER} ${CURRENT_UID}

samba_down:
	docker-compose -f samba/docker-compose.yaml down; \
	docker image rm samba

media_server: ## Download and watch media
	docker-compose -f media_server/docker-compose.yaml up -d

media_server_down:
	docker-compose -f media_server/docker-compose.yaml down

up: host_monitor_up media_server_up samba_up
down: host_monitor_down media_server_down samba_down
