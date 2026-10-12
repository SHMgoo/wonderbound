
# ============================================================
# WONDERBOUND - APPLICATION CONTAINER
# ============================================================

# PHP 8.3 with Apache
FROM php:8.3-apache

# ------------------------------------------------------------
# INSTALL PHP EXTENSIONS AND ENABLE APACHE MODULES
# ------------------------------------------------------------

RUN apt-get update \
    && apt-get install -y --no-install-recommends libpq-dev \
    && docker-php-ext-install pdo_pgsql \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# CONFIGURE APACHE DOCUMENT ROOT
# ------------------------------------------------------------

# Only public/ should be accessible through the browser
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public

RUN sed -ri \
    -e 's!/var/www/html!/var/www/html/public!g' \
    /etc/apache2/sites-available/000-default.conf \
    /etc/apache2/apache2.conf \
    /etc/apache2/conf-available/*.conf

# ------------------------------------------------------------
# APPLICATION DIRECTORY
# ------------------------------------------------------------

WORKDIR /var/www/html

# ------------------------------------------------------------
# COPY ADAPT APPLICATION FILES
# ------------------------------------------------------------

COPY public/ public/
COPY src/ src/
COPY config/ config/
COPY data/ data/
COPY vendor/ vendor/
COPY bootstrap.php bootstrap.php

# ------------------------------------------------------------
# EXPOSE APACHE PORT
# ------------------------------------------------------------

EXPOSE 80
