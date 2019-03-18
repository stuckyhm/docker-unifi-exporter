FROM golang:alpine AS build
RUN apk add git --no-cache && \
    go get -u github.com/mdlayher/unifi_exporter && \
    go get -t -v ./...

FROM alpine:latest
COPY --from=build /go/bin/unifi_exporter /bin/unifi_exporter
RUN apk add --update --virtual ca-certificates && \
    rm -rf /var/cache/apk/*

EXPOSE 9130
VOLUME /unifi
CMD /bin/unifi_exporter -config.file /unifi/config.yml
