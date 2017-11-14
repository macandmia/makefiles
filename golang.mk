# Include this in the Makefile of projects written in
# golang that use glide for dependency management.
#
#    include github.com/xentek/makefiles/golang
#
# PLEASE NOTE: you must set PKG_NAME var in your project's Makefile.

GLIDE := $(shell command -v glide 2> /dev/null)
GOVERALLS := $(shell command -v goveralls 2> /dev/null)
GOLINT := $(shell command -v golint 2> /dev/null)
GOMETALINT := $(shell command -v gometalinter 2> /dev/null)

.PHONY: install deps test docs golang_tools golang_check

# install dependencies
install:
	glide install

# update dependencies
deps:
	glide up

# run tests
test:
	go test $(glide nv)

# read the docs
docs: golang_check
	@echo "RTFM: http://localhost:6060/pkg/${PKG_NAME}/"
	godoc -http=:6060

golang_tools:
ifndef GLIDE
	go get -u github.com/Masterminds/glide
else
	@echo "Already Installed: glide. Skipping."
endif
ifndef GOLINT
	go get -u github.com/golang/lint/golint
else
	@echo "Already Installed: golint. Skipping."
endif
ifndef GOMETALINT
	go get -u github.com/alecthomas/gometalinter
	gometalinter --install
else
	@echo "Already Installed: gometalinter. Skipping."
endif
ifndef GOVERALLS
	go get -u github.com/mattn/goveralls
else
	@echo "Already Installed: goveralls. Skipping."
endif

golang_check:
ifndef PKG_NAME
    	@echo "PKG_NAME must be set. Aborting."
    	@exit 1
endif
