php bin/console make:migration
php bin/console doctrine:migration:migrate
apachectl -D FOREGROUND
chmod -r 777 var/www/upload/image
