FROM alpine:latest AS builder

RUN apk update && apk add alpine-sdk git && rm -rf /var/cache/apk/*

RUN mkdir -p /app
WORKDIR /app

COPY . .

FROM alpine:latest

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

RUN mkdir -p /app
WORKDIR /app
COPY --from=builder /app .

EXPOSE 8080

ENTRYPOINT ["./app -addr=:8080 -sdbDir=/mnt/images/onlinedb"]
