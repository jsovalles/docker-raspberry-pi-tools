docker-compose:
	docker compose up -d

.PHONY: backup_config
backup_config:
	@echo "Enter the password for the zip file:"
	@bash -c 'read -s PASSWORD && echo "Compressing directory with password..."; sudo zip -r -P $$PASSWORD config.zip config'

.PHONY: uncompress_config
uncompress_config:
	@echo "Enter the password to unzip the file:"
	@bash -c 'read -s PASSWORD && echo "Uncompressing file..."; unzip -P $$PASSWORD config.zip'
