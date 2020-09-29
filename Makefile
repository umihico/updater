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

push:
	# RUN THIS AT FIRST: `aws ecs create-cluster --cluster-name stg`
	# RUN THIS AT FIRST: `aws ecr create-repository --repository-name sakekaitori`
	@make build
	$(shell aws ecr get-login --no-include-email)
	docker tag updater:latest $(shell aws sts get-caller-identity --query Account --output text).dkr.ecr.ap-northeast-1.amazonaws.com/updater:latest
	docker push $(shell aws sts get-caller-identity --query Account --output text).dkr.ecr.ap-northeast-1.amazonaws.com/updater:latest
