# Include this in the Makefile of projects that need daemons,
# such as data stores and other servers
#
#    include github.com/xentek/makefiles/daemons

.PHONY: install-convert install-jpegtran install-optipng install-png2ico install-sassc

UNAME = $(shell uname)
ifeq ($(UNAME), Linux)
	PKG_INSTALLER := sudo apt-get install -y
	POSTGRES_PKG  := postgresql postgresql-client libpq5 libpq-dev
	MYSQL_PKG     := mysql-client mysql-server libmysqlclient-dev
	REDIS_PKG     := redis-server redis-tools
	MEMCACHED_PKG := memcached libmemcached-dev libmemcached11
endif
ifeq ($(UNAME), Darwin)
	# assumes osx
	PKG_INSTALLER := brew install
	POSTGRES_PKG  := postgres libpq
	MYSQL_PKG     := mariadb
	REDIS_PKG     := redis
	MEMCACHED_PKG := memcached
endif
PKG_INSTALLER := brew install

POSTGRES  := $(shell command -v postgres 2> /dev/null)
MYSQL     := $(shell command -v mysql 2> /dev/null)
REDIS     := $(shell command -v redis-server 2> /dev/null)
MEMCACHED := $(shell command -v memcached 2> /dev/null)

SASSC := $(shell command -v sassc 2> /dev/null)
OPTIPNG := $(shell command -v optipng 2> /dev/null)
PNG2ICO := $(shell command -v png2ico 2> /dev/null)
JPEGTRAN := $(shell command -v jpegtran 2> /dev/null)
CONVERT := $(shell command -v convert 2> /dev/null)

define install_pkg
	$(if $(1), @ echo "Already Installed: ${2}", $(PKG_INSTALLER) $(2))
endef


install-postgres:
	$(call install_pkg, $(POSTGRES), ${POSTGRES_PKG})

install-mysql:
	$(call install_pkg, $(MYSQL), ${MYSQL_PKG})

install-redis:
	$(call install_pkg, $(REDIS), ${REDIS_PKG})

install-memcached:
	$(call install_pkg, $(MEMCACHED), ${MEMCACHED_PKG})
