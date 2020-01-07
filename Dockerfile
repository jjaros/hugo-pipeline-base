FROM alpine:latest

LABEL maintainer="Jan Jaros, jan.jaros@jjaros.cz"

WORKDIR /work

RUN apk update; \
    apk add jq wget py-yuicompressor lftp tree git; \
    # Hugo v0.37.1
    wget https://api.github.com/repos/gohugoio/hugo/releases/9984421 -O - | jq -r '.assets[] | select(.name | index("Linux-64bit.tar.gz")) | .browser_download_url' | wget -i -; \
    tar --exclude='README.md' -xzf hugo*.tar.gz; \
    chmod a+x hugo; \

EXPOSE 1313
