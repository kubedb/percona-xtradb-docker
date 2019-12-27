SHELL=/bin/bash -o pipefail

REGISTRY ?= kubedb
BIN      := percona-xtradb-cluster
IMAGE    := $(REGISTRY)/$(BIN)
TAG      := 5.7-percona-test7
#TAG      := $(shell git describe --exact-match --abbrev=0 2>/dev/null || echo "")

.PHONY: push
push: container
	docker push $(IMAGE):$(TAG)

.PHONY: container
container:
	mkdir -p dockerdir/usr/bin
	wget -qO dockerdir/usr/bin/peer-finder https://github.com/kmodules/peer-finder/releases/download/v1.0.1-ac/peer-finder
	chmod +x dockerdir/usr/bin/peer-finder
	chmod +x dockerdir/on-start.sh
	chmod +x dockerdir/cluster-check.sh
	docker build --pull -t $(IMAGE):$(TAG) .
	rm -rf dockerdir/usr

.PHONY: version
version:
	@echo ::set-output name=version::$(TAG)
