FROM docker.io/alpine:latest AS downloader

ENV RSSBOT_VERSION v2.0.0-alpha.9

RUN apk add --no-cache curl ca-certificates && \
    mkdir /rssbot && \
    curl -LJo /rssbot/rssbot https://github.com/iovxw/rssbot/releases/download/$RSSBOT_VERSION/rssbot-en-amd64-linux && \
    chmod 555 /rssbot/rssbot


FROM scratch

COPY --from=downloader /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=downloader /rssbot /opt/rssbot/

WORKDIR /opt/rssbot

ENTRYPOINT [ "/opt/rssbot/rssbot" ]
