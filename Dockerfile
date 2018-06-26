FROM debian:9.4

RUN apt update -y && apt install -y \
    apache2 \
    bash \
    php \
    php-curl \
    php-mbstring \
    php-sqlite3 \
    unzip \
    wget

COPY deploy-code.sh .
RUN bash deploy-code.sh && rm deploy-code.sh

COPY hm3.ini /usr/local/share/cypht/hm3.ini
RUN chmod 644 /usr/local/share/cypht/hm3.ini
COPY run-cypht.sh /usr/local/bin
RUN chmod 755 /usr/local/bin/run-cypht.sh

EXPOSE 80

CMD [ "/bin/bash", "/usr/local/bin/run-cypht.sh" ]
