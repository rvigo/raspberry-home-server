.PHONY: help media_server samba host_monitor

help: 
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
.DEFAULT_GOAL := up

host_monitor: ## Docker host/containers health monitor
	$(MAKE) -C host_monitor up

host_monitor_down:
	$(MAKE) -C host_monitor down

samba: ## Share files 
	$(MAKE) -C samba up

samba_down:
	$(MAKE) -C samba down

ms: ## Download and watch media
	$(MAKE) -C media_server up

ms_down:
	$(MAKE) -C media_server down

up: host_monitor ms samba
down: host_monitor_down ms_down samba_down
