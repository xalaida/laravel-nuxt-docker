# Image
FROM php:7.3-fpm

# Starting from scratch
RUN apt-get clean
RUN apt-get -y autoremove
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Update dependencies
RUN apt-get update

# Zip
RUN apt-get install -y libzip-dev zip && docker-php-ext-configure zip --with-libzip && docker-php-ext-install zip

# Curl
RUN apt-get install -y libcurl3-dev curl && docker-php-ext-install curl

# BC Math
RUN docker-php-ext-install bcmath

# MySQL
RUN docker-php-ext-install pdo pdo_mysql

# Human Language and Character Encoding Support
RUN apt-get install -y zlib1g-dev libicu-dev g++
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

## Xdebug
#RUN pecl install xdebug && docker-php-ext-enable xdebug
#COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Custom php.ini config
ADD ./custom.ini /usr/local/etc/php/conf.d/custom.ini

# Clean up
RUN apt-get clean
RUN apt-get -y autoremove
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up default directory
WORKDIR /var/www
