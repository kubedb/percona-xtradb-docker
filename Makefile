SHELL=/bin/bash -o pipefail

REGISTRY ?= kubedb
BIN      := percona
IMAGE    := $(REGISTRY)/$(BIN)
BASE_TAG := 5.7
TAG      := $(shell git describe --exact-match --abbrev=0 2>/dev/null || echo "")

.PHONY: push
push: container
	docker push $(IMAGE):$(TAG)

.PHONY: container
container:
	docker pull $(BIN):$(BASE_TAG)
	docker tag $(BIN):$(BASE_TAG) $(IMAGE):$(TAG)

.PHONY: version
version:
	@echo ::set-output name=version::$(TAG)
