# Include this in the Makefile of projects that use heroku-pipelines for deployment.
#
#    include github.com/macandmia/makefiles/pipelines
#
# PLEASE NOTE: you must set PROJECT_DIR and STAGING_APP vars in your project's Makefile.
#
# `make staging` assumes you have a git remote named staging.

# deploy app to staging
staging: preflight
	git push staging

# deploy app to production
production:
ifdef ${STAGING_APP}
    	@echo "STAGING_APP must be set. Aborting deploy."
else
	heroku pipelines:promote -a ${STAGING_APP}
endif

preflight:
ifndef ${PROJECT_DIR}
	@echo "Ensuring your working copy is up to date with master before pushing..."
	git -C ${PROJECT_DIR} fetch origin
	git -C ${PROJECT_DIR} status | grep 'On branch master'
	git -C ${PROJECT_DIR} status | grep "Your branch is up-to-date with 'origin/master'."
	git -C ${PROJECT_DIR} status | grep 'nothing to commit, working tree clean'
else
	@echo "PROJECT_DIR must be set. Aborting deploy."
endif
