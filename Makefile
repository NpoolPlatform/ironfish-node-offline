REPO_ROOT	:= $(shell git rev-parse --show-toplevel)

.PHONY: build release deploy

build: 
	version=${VERSION} registry=${REGISTRY} bash ${REPO_ROOT}/docker/build.sh

release: 
	version=${VERSION} registry=${REGISTRY} bash ${REPO_ROOT}/docker/release.sh

deploy: 
	version=${VERSION} registry=${REGISTRY} bash ${REPO_ROOT}/docker/deploy.sh
