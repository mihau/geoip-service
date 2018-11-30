FROM golang:alpine AS builder
RUN apk add --no-cache git
RUN mkdir /go/src/app
COPY . /go/src/app/
WORKDIR /go/src/app

RUN go get -d -v ./...
RUN go get -d -v ./...

FROM alpine:latest
COPY --from=builder /go/bin/app /app
CMD ["./app", "-db=/data/geodb.mmdb"]
VOLUME /data/geodb.mmdb
