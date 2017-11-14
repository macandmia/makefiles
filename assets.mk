.PHONY: install-convert install-jpegtran install-optipng install-png2ico install-sassc

PKG_INSTALLER := brew install
PKG_UPGRADER := brew upgrade

SASSC := $(shell command -v sassc 2> /dev/null)
OPTIPNG := $(shell command -v optipng 2> /dev/null)
PNG2ICO := $(shell command -v png2ico 2> /dev/null)
JPEGTRAN := $(shell command -v jpegtran 2> /dev/null)
CONVERT := $(shell command -v convert 2> /dev/null)

define install_pkg
	$(if $(1), $(PKG_UPGRADER) $(2), $(PKG_INSTALLER) $(2))
endef

install-sassc:
	$(call install_pkg, $(SASSC), sassc)

install-optipng:
	$(call install_pkg, $(OPTIPNG), optipng)

install-png2ico:
	$(call install_pkg, $(PNG2ICO), png2ico)

install-jpegtran:
	$(call install_pkg, $(JPEGTRAN), libjpeg)

install-convert:
	$(call install_pkg, $(CONVERT), imagemagick)
