php bin/console make:migration
php bin/console doctrine:migration:migrate
mkdir www/upload/image 
mkdir www/html/var
chmod -R 777 www/upload/image
chmod -R 777 www/html/var
apachectl -D FOREGROUND
