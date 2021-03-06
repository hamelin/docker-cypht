FROM debian:9.4

RUN apt update -y && apt install -y \
    apache2 \
    bash \
    php \
    php-curl \
    php-mbstring \
    php-sqlite3 \
    pwgen \
    sqlite3

RUN mkdir -p /usr/local/share && chmod 755 /usr/local/share
COPY --chown="root:www-data" cypht /usr/local/share/cypht

COPY hm3.ini /usr/local/share/cypht/hm3.ini
RUN chmod 644 /usr/local/share/cypht/hm3.ini
COPY run-cypht.sh /usr/local/bin
RUN chmod 700 /usr/local/bin/run-cypht.sh
COPY cypht-acc /usr/local/bin
RUN chmod 755 /usr/local/bin/cypht-acc

EXPOSE 80

CMD [ "/bin/bash", "/usr/local/bin/run-cypht.sh" ]
