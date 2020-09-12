build:
	docker build -t updater .

bash:
	@make build
	docker run -it \
		-e GITHUB_REPOSITORY_TOKEN=$(shell aws ssm get-parameter --name GITHUB_REPOSITORY_TOKEN --query 'Parameter.Value' --output text) \
		-e GITHUB_PASSWORD=$(shell aws ssm get-parameter --name GITHUB_REPOSITORY_TOKEN --query 'Parameter.Value' --output text) \
		-e GITHUB_USER=umihico \
		updater bash

local:
	@make build
	docker run \
		-e GITHUB_REPOSITORY_TOKEN=$(shell aws ssm get-parameter --name GITHUB_REPOSITORY_TOKEN --query 'Parameter.Value' --output text) \
		-e GITHUB_PASSWORD=$(shell aws ssm get-parameter --name GITHUB_REPOSITORY_TOKEN --query 'Parameter.Value' --output text) \
		-e GITHUB_USER=umihico \
		updater
