FROM python:alpine3.16

RUN apk add --no-cache --virtual .build-deps \
    gcc \
    linux-headers \
    libc-dev \
    libffi-dev

RUN pip install --no-cache-dir \
    libtorrent==2.0.6 \
    deluge==2.0.5

RUN apk del .build-deps && rm -rf /tmp

ENV UMASK=022 \
    LOG_LEVEL=warning

COPY GeoIP.dat /usr/share/GeoIP/GeoIP.dat
COPY run.sh /run.sh

EXPOSE 8080 20000/udp

ENTRYPOINT ["sh", "/run.sh"]