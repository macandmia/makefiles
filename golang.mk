GLIDE := $(shell command -v glide 2> /dev/null)
GOVERALLS := $(shell command -v goveralls 2> /dev/null)
GOLINT := $(shell command -v golint 2> /dev/null)
GOMETALINT := $(shell command -v gometalinter 2> /dev/null)

.PHONY: gotools install deps test godocs

# install go tools
gotools:
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

# install dependencies
install:
	glide install

# update dependencies
deps:
	glide up

# run tests
test:
	go test $(glide nv)

# start documentation server
godocs:
	godoc -http=:6060
