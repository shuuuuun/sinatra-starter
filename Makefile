PROJECT_NAME := sinatra-starter

APP_STAGE := dev

IMAGE_PREFIX := ${PROJECT_NAME}-${APP_STAGE}

AWS_REGION := ap-northeast-1
# AWS_PROFILE :=

ECR_REGISTRY_ID := $(shell aws ecr describe-registry | jq -rc '.registryId')
ECR_REGISTRY_URL := ${ECR_REGISTRY_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

.PHONY: docker ecr

show-env:
	@echo "IMAGE_PREFIX: ${IMAGE_PREFIX}"
	@echo "ECR_REGISTRY_ID: ${ECR_REGISTRY_ID}"
	@echo "ECR_REGISTRY_URL: ${ECR_REGISTRY_URL}"

docker/build:
	docker image build --tag ${IMAGE_PREFIX}_app .

docker/run:
	docker container run --rm ${IMAGE_PREFIX}_app

ecr/init:
	aws ecr create-repository --repository-name ${IMAGE_PREFIX}_app

ecr/login:
	aws ecr get-login-password | docker login --username AWS --password-stdin ${ECR_REGISTRY_URL}

ecr/tag:
	docker tag ${IMAGE_PREFIX}_app:latest ${ECR_REGISTRY_URL}/${IMAGE_PREFIX}_app:latest

ecr/push:
	docker push ${ECR_REGISTRY_URL}/${IMAGE_PREFIX}_app:latest
