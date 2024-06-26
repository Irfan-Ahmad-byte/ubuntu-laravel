FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV COMPOSER_ALLOW_SUPERUSER=1

RUN apt-get update && apt-get install -y \
    mariadb-client \
    zip \
    software-properties-common \
    git \
    curl \
    wget \
    unzip \
    gnupg \
    lsb-release 

RUN add-apt-repository ppa:ondrej/php && apt-get update && apt-get -y install php8.1 \
    php8.1-cli php8.1-common php8.1-mysql php8.1-zip php8.1-gd php8.1-mbstring php8.1-curl php8.1-xml php8.1-bcmath

# Copy the script to setup github
COPY --chown=1000:1000 /setup/gh.sh /setup/gh.sh

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

    
# Append ~/.composer/vendor/bin to path using bashrc
RUN echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"

RUN composer global require "laravel/installer=~1.1"

RUN apt-get update

# Set Git config based on passed arguments
ENTRYPOINT ["/setup/gh.sh"]