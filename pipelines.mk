# Include this in the Makefile of projects that use heroku-pipelines for deployment.
#
#    include github.com/macandmia/makefiles/pipelines
#
# PLEASE NOTE: you must set PROJECT_DIR, STAGING_APP, PRODUCTION_APP vars in your project's Makefile.

.PHONY: staging production remotes preflight pipelines_check

# deploy app to staging
staging: preflight
	git push staging

# deploy app to production
production: pipelines_check
	heroku pipelines:promote -a ${STAGING_APP}

remotes: pipelines_check
	heroku git:remote -a ${STAGING_APP} -r staging
	heroku git:remote -a ${PRODUCTION_APP} -r production

preflight: pipelines_check
	git -C ${PROJECT_DIR} fetch origin
	git -C ${PROJECT_DIR} status | grep 'On branch master'
	git -C ${PROJECT_DIR} status | grep "Your branch is up-to-date with 'origin/master'."
	git -C ${PROJECT_DIR} status | grep 'nothing to commit, working tree clean'

pipelines_check:
ifndef PROJECT_DIR
	@echo "PROJECT_DIR must be set. Aborting."
	@exit 1
endif
ifndef STAGING_APP
    	@echo "STAGING_APP must be set. Aborting."
    	@exit 1
endif
ifndef PRODUCTION_APP
    	@echo "PRODUCTION_APP must be set. Aborting."
    	@exit 1
endif
