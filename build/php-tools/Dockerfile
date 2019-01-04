ARG FROM_IMAGE
FROM ${FROM_IMAGE}

#---INSTALL REQUIREMENTS---
RUN     DEBIAN_FRONTEND=noninteractive apt-get update \
    &&  DEBIAN_FRONTEND=noninteractive apt-get install -y \
            php-cli \
            php-common \
            php-readline \
            php-xdebug \
            wget \
            curl \
            openssl \
            dialog \
            composer \
            libxml2-utils \
            # Tool Requirements \
            php-mbstring \
            php-bcmath \
            php-gd \
            php-json \
            php-curl \
            php-soap \
            php-ast \
            php-dom \
            # Debugging \
            htop \
            nano \
            # Required for composer \
            git \
            ssh-client \
            unzip \
    &&  composer \
    &&  phpenmod xdebug \
    &&  mkdir /project

#---Install Tools---
WORKDIR /project
ENV COMPOSER_DISABLE_ROOT_WARN 1
ADD ../../composer.json /project
RUN composer update --no-plugins --no-scripts
