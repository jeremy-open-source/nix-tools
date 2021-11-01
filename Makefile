#!make
include settings.env

build-chefdk-and-docker:
	(cd build/chefdk-and-docker && DOCKER_BUILDKIT=1 docker build . -t $(JS_NIX_TOOLS_DOCKER_IMAGE_PREFIX)-chefdk-and-docker:latest)

build-mermaid-js:
	(cd build/mermaid-js && DOCKER_BUILDKIT=1 docker build . -t $(JS_NIX_TOOLS_DOCKER_IMAGE_PREFIX)-mermaid-js:latest)

build-php-tools:
	(cd build/php-tools && DOCKER_BUILDKIT=1 docker build . -t $(JS_NIX_TOOLS_DOCKER_IMAGE_PREFIX)-php-tools:latest)

build-py-diagrams:
	(cd build/py-diagrams && DOCKER_BUILDKIT=1 docker build . -t $(JS_NIX_TOOLS_DOCKER_IMAGE_PREFIX)-py-diagrams:latest)

build-wscat:
	(cd build/wscat && DOCKER_BUILDKIT=1 docker build . -t $(JS_NIX_TOOLS_DOCKER_IMAGE_PREFIX)-wscat:latest)

build-all:
	make build-chefdk-and-docker
	make build-mermaid-js
	make build-php-tools
	make build-py-diagrams
	make build-wscat
