#!/bin/bash
DEST=/usr/local/share/cypht
mkdir -p $DEST && \
    chmod 755 $DEST && \
    DIR_TEMP=$(mktemp -d) && \
    pushd $DIR_TEMP && \
    wget https://github.com/jasonmunro/cypht/archive/master.zip && \
    unzip master.zip && \
    find . -type d -exec chmod 755 {} \; && \
    find . -type f -exec chmod 644 {} \; && \
    mv -v cypht-master/* $DEST && \
    popd && \
    rm -rf $DIR_TEMP
