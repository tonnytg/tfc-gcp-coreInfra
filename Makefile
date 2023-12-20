DOCKER_IMAGE = "hashicorp/terraform:latest"

all: check

	docker run --rm -it -v $(PWD):/app -w /app/terraform \
		$(DOCKER_IMAGE) fmt

	docker run --rm -it -v $(PWD):/app -w /app/terraform \
		-e TF_CLI_CONFIG_FILE=/app/credentials.tfrc.json \
		$(DOCKER_IMAGE) init

	docker run --rm -it -v $(PWD):/app -w /app/terraform \
		-e TF_CLI_CONFIG_FILE=/app/credentials.tfrc.json \
		$(DOCKER_IMAGE) plan

check:
	bash init.sh

.PHONY: all check
