ARG FROM_IMAGE
FROM ${FROM_IMAGE}

# FROM: https://github.com/kkarczmarczyk/docker-node-yarn/blob/master/8.0/Dockerfile

# Global install yarn package manager

RUN     DEBIAN_FRONTEND=noninteractive apt-get update \
    &&  DEBIAN_FRONTEND=noninteractive apt-get install -y \
            curl \
            apt-transport-https \
            gnupg \
    &&  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    &&  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    &&  DEBIAN_FRONTEND=noninteractive apt-get update \
    &&  DEBIAN_FRONTEND=noninteractive apt-get install -y \
            yarn

WORKDIR /workspace
