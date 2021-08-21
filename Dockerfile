FROM alpine:latest
WORKDIR /opt/bigreplapse
COPY bigreplapse.sh ./
COPY telegram-bot-bash/ ./telegram-bot-bash/

RUN apk add --no-cache ffmpeg bc curl jq
RUN apk add --no-cache bash bc
ENTRYPOINT ["/opt/bigreplapse/bigreplapse.sh"]

