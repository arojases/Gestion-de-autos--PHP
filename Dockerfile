FROM php:8.2-apache

RUN docker-php-ext-install pdo_mysql

COPY . /var/www/html/phpmotors

CMD ["sh", "-c", "if [ \"$DEMO_MODE\" = \"true\" ]; then php /var/www/html/phpmotors/scripts/seed-demo.php; fi; apache2-foreground"]
