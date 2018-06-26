FROM debian:9.4

RUN apt update -y && apt install -y php php-curl apache2
RUN apt install -y wget bash unzip php-sqlite3

COPY deploy-code.sh .
RUN bash deploy-code.sh && rm deploy-code.sh

RUN apt install -y sqlite3
RUN apt install -y less man xxd vim
RUN apt install -y php-mbstring

COPY hm3.ini /usr/local/share/cypht/hm3.ini
RUN chmod 644 /usr/local/share/cypht/hm3.ini
COPY run-cypht.sh /usr/local/bin
RUN chmod 755 /usr/local/bin/run-cypht.sh

EXPOSE 80

CMD [ "/bin/bash", "/usr/local/bin/run-cypht.sh" ]
