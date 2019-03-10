ARG CHEF_DK_VERSION
FROM chef/chefdk:${CHEF_DK_VERSION}

# Install extra gem modules
RUN     gem install --no-user-install docker \
    &&  gem install --no-user-install kitchen-docker

# Install extra packages
RUN     DEBIAN_FRONTEND=noninteractive apt-get update \
    &&  DEBIAN_FRONTEND=noninteractive apt-get install -y \
            # For sanity \
            nano \
            # For Docker \
            apt-transport-https \
            ca-certificates \
            curl \
            software-properties-common \
            # For scripts \
            jq

## DOCKER
RUN     curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    &&  apt-key fingerprint 0EBFCD88 \
    &&  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    &&  DEBIAN_FRONTEND=noninteractive apt-get update \
    &&  DEBIAN_FRONTEND=noninteractive apt-get install -y \
            docker-ce
