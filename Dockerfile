FROM php:7.3-fpm
COPY php.ini /usr/local/etc/php/

RUN apt-get update \
  && apt-get install -y zlib1g-dev libzip-dev mariadb-client vim \
  && docker-php-ext-install zip pdo_mysql

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php'):
RUN php -r "if(hash_file('sha384', 'coposer-setup.php')=='e0012edf3e80b69788495eff0d4b4e4c79ff1609ddie613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; }else{ echo 'Installer corrupt'; unlink('composer-setup.php');} echo PHP_EQL;"
RUN php composer-setup.php
RUN php -r "unlink('cmposer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER 1

ENV COMPOSER_HOME /composer

ENV PATH $PATH:/composer/vendor/bin

RUN composer global require "laravel/installer"

RUN curl -SL https://deb.nodesource.com/setup_13.x | bash
RUN apt-get install -y nodejs && \
  npm install -g npm@latest && \
  npm install -g @vue/cli

WORDIR /var/www

