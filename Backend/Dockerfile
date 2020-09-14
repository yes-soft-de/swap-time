FROM php:7.4-fpm AS vendor

WORKDIR /tmp/

COPY composer.json composer.json
COPY composer.lock composer.lock
RUN apt install zip
RUN RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer install 
RUN composer update 
RUN composer require symfony/translation 
RUN composer require doctrine/annotations 



FROM php:7.4-apache

#ENV APACHE_DOCUMENT_ROOT=/var/www/html
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf


COPY . /var/www/html
RUN chown -R www-data:www-data /var
RUN chmod -R g+rw /var


#ENV APACHE_RUN_USER=root
#ENV APACHE_RUN_GROUP=root
#RUN usermod -aG sudo www-data
#RUN apt update
#RUN apt install acl

#RUN setfacl -R -m u:"www-data":rwX -m u:`whoami`:rwX /var/www/html
#RUN setfacl -dR -m u:"www-data":rwX -m u:`whoami`:rwX /var/www/html

COPY .htaccess /var/www/html/public/
#COPY .env /var/www/html
COPY --from=vendor /tmp/vendor/ /var/www/html/vendor/
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN php bin/console doctrine:database:create --if-not-exists
RUN php bin/console make:migration
RUN php bin/console doctrine:migration:migrate

#ENV APP_ENV=prod
#ENV APP_DEBUG=0 
#RUN php bin/console cache:clear
