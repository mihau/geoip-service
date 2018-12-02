FROM golang:alpine AS builder
RUN apk add --no-cache git
RUN mkdir /go/src/app
COPY . /go/src/app/
WORKDIR /go/src/app

RUN go get -d -v ./...
RUN go build -o /go/bin/app

FROM alpine:latest
COPY --from=builder /go/bin/app /app
COPY GeoLite2-City.mmdb /data/geodb.mmdb
CMD ["./app", "-db=/data/geodb.mmdb"]
# VOLUME /data/geodb.mmdb
