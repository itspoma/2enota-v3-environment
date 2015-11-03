NAME = 2enota
VERSION = v3.01

IMAGE_NAME = ${NAME}/${VERSION}
CONTAINER_NAME = ${NAME}

rebuild:
	docker build -t ${IMAGE_NAME} .

build:
	docker rmi -f ${CONTAINER_NAME}
	docker build --rm -t ${IMAGE_NAME} .

run:
	docker rm -f ${CONTAINER_NAME} >/dev/null
	docker run --name=${CONTAINER_NAME} -p 3000:3000 -v $$PWD:/shared -ti -d ${IMAGE_NAME}

test:
	env NAME=$(NAME) VERSION=$(VERSION) ./test/runner.sh

tag_latest:
	docker tag -f ${IMAGE_NAME} ${IMAGE_NAME}:latest

release: test tag_latest
	@echo not implemented

ssh:
	docker exec -ti ${CONTAINER_NAME} bash

.PHONY: clear build run