FROM docker.io/alpine:latest AS downloader

ENV RSSBOT_VERSION aaaa

RUN apk add --no-cache curl && \
    mkdir /rssbot && \
    curl -LJo /rssbot/rssbot https://github.com/iovxw/rssbot/releases/download/$RSSBOT_VERSION/rssbot-en-amd64-linux && \
    chmod 555 /rssbot/rssbot


FROM scratch

COPY --from=downloader /rssbot /opt/rssbot/

WORKDIR /opt/rssbot

ENTRYPOINT [ "/opt/rssbot/rssbot" ]
