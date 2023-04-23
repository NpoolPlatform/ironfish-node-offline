REPO_ROOT	:= $(shell git rev-parse --show-toplevel)

.PHONY: build release deploy

build: 
	bash ${REPO_ROOT}/docker/build.sh

release: 
	bash ${REPO_ROOT}/docker/release.sh

deploy: 
	bash ${REPO_ROOT}/docker/deploy.sh
