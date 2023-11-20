FROM debian:buster-20230109

RUN apt-get update
RUN apt-get -y install php7.3 php-mysqli php-fpm curl mariadb-client

EXPOSE 9000

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d
ADD files/run.sh /var/www/
# ADD files/wp-config.php /var/www/
RUN chmod +x /var/www/run.sh
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/bin/wp-cli && \
    chown -R www-data:www-data /usr/bin/wp-cli

ENTRYPOINT [ "/var/www/run.sh" ]

CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"]
