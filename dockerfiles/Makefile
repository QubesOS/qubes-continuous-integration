DOCKER_IMAGES_DIR=$(shell readlink -m $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

DOCKER_IMAGES ?= \
	host-fc37 \
	host-fc41 \
	vm-trixie \
	vm-bookworm \
	vm-bullseye \
	vm-archlinux \
	vm-centos-stream8 \
	vm-jammy \
	vm-fc39 \
	vm-fc41 \
	vm-fc42

.ONESHELL:
build: $(DOCKER_IMAGES:%=build-%)

push: $(DOCKER_IMAGES:%=push-%)

build-%: DOCKER_IMAGE=$(subst build-,,$@)
build-%:
	sudo docker build -t fepitre/$(DOCKER_IMAGE):latest -f $(DOCKER_IMAGE).Dockerfile .

push-%: DOCKER_IMAGE=$(subst push-,,$@)
push-%:
	sudo docker push fepitre/$(DOCKER_IMAGE):latest
