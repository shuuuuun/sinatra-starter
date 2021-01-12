PROJECT_NAME := sinatra-starter
IMAGE_NAME := sinatra-starter

APP_STAGE := dev

.PHONY: docker

docker/build-as-prod:
	docker image build --tag ${IMAGE_NAME}_prod .

docker/run-as-prod:
	docker container run --rm ${IMAGE_NAME}_prod
