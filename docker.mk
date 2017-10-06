# Include this in the Makefile of projects that use docker, but aren't
# publishing a docker base image for other projects to use.
#
#    include github.com/macandmia/makefiles/docker
#
# PLEASE NOTE: you must set NAME and IMG vars in your project's Makefile

TAG=latest
.PHONY: container boot create destroy tag release

# build container
container:
	docker build -t ${IMG} .

# run the Docker container
#
# arguments:
#
#   - NAME: name of container. default: mm-go
boot: create
	docker start -ai ${NAME} --env-file .env

# create the Docker container
#
# arguments:
#
#   - NAME: name of container. default: mm-go
create: destroy container
	docker create --env-file .env -it --init --name "${NAME}" ${IMG}

# destroy the Docker container
#
# arguments:
#
#   - NAME: name of container. default: mm-subscribers
destroy:
	docker rm -v $(shell docker ps -aqf "name=${NAME}") || (exit 0)

# tag container
#
# arguments:
#
#   - TAG: tag the container. default: latest
tag: container
	docker tag ${IMG} ${IMG}:${TAG}

# release the Docker container
#
# arguments:
#
#   - TAG: tag the container. default: latest
release: tag
	docker push ${IMG}:${TAG}

# vim: set ft=make
