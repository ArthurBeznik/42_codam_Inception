FROM alpine:3.17.0

RUN apk add --no-cache mariadb mariadb-client mariadb-server-utils && \
    rm -f /var/cache/apk/*

ADD tools/run.sh /scripts/run.sh

RUN mkdir /docker-entrypoint-initdb.d && \
    mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/scripts/run.sh"]