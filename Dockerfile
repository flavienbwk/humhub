FROM debian:buster

RUN apt update
RUN apt install php php-cli \
    php-imagick php-curl php-bz2 php-gd php-intl \
    php-mysql php-zip php-apcu-bc php-apcu php-xml php-ldap -y
RUN apt install nginx php-fpm -y

RUN sed -i 's/max_execution_time = 30/max_execution_time = 600/g' /etc/php/7.3/fpm/php.ini
RUN sed -i 's/post_max_size = 8M/post_max_size = 128M/g' /etc/php/7.3/fpm/php.ini
RUN sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 128M/g' /etc/php/7.3/fpm/php.ini

## Copying HumHub files
RUN mkdir -p /var/www/humhub
COPY ./assets /var/www/humhub/assets
COPY ./protected/yii /var/www/humhub/protected/yii
COPY ./protected/humhub /var/www/humhub/protected/humhub
COPY ./static /var/www/humhub/static
COPY ./themes /var/www/humhub/themes
COPY ./composer.json /var/www/humhub/composer.json
COPY ./composer.lock /var/www/humhub/composer.lock
COPY ./Gruntfile.js /var/www/humhub/Gruntfile.js
COPY ./index-test.php /var/www/humhub/index-test.php
COPY ./index.php /var/www/humhub/index.php
COPY ./package.json /var/www/humhub/package.json
COPY ./package-lock.json /var/www/humhub/package-lock.json
COPY ./robots.txt /var/www/humhub/robots.txt

## Installing HumHub dependencies
WORKDIR /var/www/humhub
RUN apt install composer -y
RUN composer install
RUN chown -R www-data:www-data /var/www/humhub
RUN usermod -u 1000 www-data
RUN usermod -G staff www-data

RUN echo "* * * * * /usr/bin/php /var/www/humhub/protected/yii queue/run >/dev/null 2>&1" > /etc/cron.d/humhub
RUN echo "* * * * * /usr/bin/php /var/www/humhub/protected/yii cron/run >/dev/null 2>&1" >> /etc/cron.d/humhub

## Setting up nginx
COPY ./nginx.conf /etc/nginx/sites-enabled/default

## Setting up entrypoint
COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/bin/sh", "/entrypoint.sh" ]
