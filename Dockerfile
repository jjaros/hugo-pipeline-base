FROM alpine:latest

LABEL maintainer="Jan Jaros, jan.jaros@jjaros.cz"

RUN apk update; \
    apk add jq wget py-yuicompressor lftp tree git; \
    mkdir /opt/hugo; \
    cd /opt/hugo; \
    # Hugo v0.54.0/extended
    wget https://api.github.com/repos/gohugoio/hugo/releases/15311618 -O - | jq -r '.assets[] | select(.name | index("Linux-64bit.tar.gz")) | .browser_download_url' | wget -i -; \
    tar -xzf hugo_extended_0.54.0*.tar.gz; \
    rm hugo*.tar.gz; \
    chmod a+x hugo; \
    ln -s /opt/hugo/hugo /usr/local/bin;

WORKDIR /work

EXPOSE 1313
