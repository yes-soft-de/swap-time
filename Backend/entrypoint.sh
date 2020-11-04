php bin/console make:migration
php bin/console doctrine:migration:migrate
apachectl -D FOREGROUND
chmod -R 777 var/www/upload/image
chown -R www-data:www-data /var && chmod -R g+rw /var
ls -al 
