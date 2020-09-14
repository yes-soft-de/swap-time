php bin/console make:migration
php bin/console doctrine:migration:migrate
service apache2 start
