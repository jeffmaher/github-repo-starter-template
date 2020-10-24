FROM alpine:3

# Upgrades packages
RUN apk --update-cache update
WORKDIR /app

################################
# CONFIGURE AT BUILD TIME:
#   Example: `docker build --build-arg APP_VERSION=(version) (...)`
################################
# Version or branch name that that the container will be labeled with
ARG ENV_APP_VERSION="not set"
ENV APP_VERSION=${ENV_APP_VERSION}

# GitHub SHA that this was built from
ARG ENV_APP_COMMIT="SHA not set"
ENV APP_COMMIT=${ENV_APP_COMMIT}



# Command run when container launches
CMD echo "Running from your built container at version/branch: ${APP_VERSION}"