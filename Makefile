.PHONY: build push test

IMAGE_NAME := quay.io/app-sre/qontract-schemas
IMAGE_TAG := $(shell git rev-parse --short=7 HEAD)
QONTRACT_VALIDATOR := quay.io/app-sre/qontract-validator:latest

ifneq (,$(wildcard $(CURDIR)/.docker))
	DOCKER_CONF := $(CURDIR)/.docker
else
	DOCKER_CONF := $(HOME)/.docker
endif

build:
	@docker build -t $(IMAGE_NAME):latest -f Dockerfile .
	@docker tag $(IMAGE_NAME):latest $(IMAGE_NAME):$(IMAGE_TAG)

push:
	@docker --config=$(DOCKER_CONF) push $(IMAGE_NAME):latest
	@docker --config=$(DOCKER_CONF) push $(IMAGE_NAME):$(IMAGE_TAG)

test:
	tox
