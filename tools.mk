# Include this in the Makefile of projects that need to ensure
# these tools are installed
#
#    include github.com/xentek/makefiles/tools

.PHONY: install-jq

UNAME = $(shell uname)
ifeq ($(UNAME), Linux)
	PKG_INSTALLER := sudo apt-get install -y
endif
ifeq ($(UNAME), Darwin)
	# assumes osx
	PKG_INSTALLER := brew install

endif
PKG_INSTALLER := brew install

JQ  := $(shell command -v jq 2> /dev/null)

define install_pkg
	$(if $(1), @ echo "Already Installed: ${2}", $(PKG_INSTALLER) $(2))
endef


install-jq:
	$(call install_pkg, $(JQ), jq)

install-pipenv:
	$(if $(filter ${UNAME}, Linux), echo "Running Linux", echo "Running Mac"))
	$(call install_pkg, $(PIPENV), pipenv)
