FROM php:7.4.15-apache

RUN apt-get update && apt-get upgrade -y && apt-get install -y vim unzip libpq-dev 

# Activate Apache modules
RUN a2enmod rewrite

# Install Lumen PHP requirements - openssl, pdo_psql and mbstring extensions
RUN docker-php-ext-install pdo_pgsql 

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \ 
  php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
  php composer-setup.php --filename=composer --install-dir=/bin && \
  php -r "unlink('composer-setup.php');"


# Change document root path
ENV APACHE_DOCUMENT_ROOT /app/api/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

WORKDIR /app

VOLUME [ "/app" ]