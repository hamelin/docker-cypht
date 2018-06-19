FROM debian:9.4

RUN apt update -y && apt install -y php php-curl apache2
RUN apt install -y wget bash unzip

COPY deploy-code.sh .
RUN bash deploy-code.sh && rm deploy-code.sh

RUN for DIR in attachments app_data; do mkdir -p $DIR && chown www_data:www_data $DIR; done
