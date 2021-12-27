FROM alpine:latest
WORKDIR /opt/bigreplapse
COPY bigreplapse.sh ./
COPY telegram-bot-bash/ ./telegram-bot-bash/

RUN apk add --no-cache bash ffmpeg bc curl jq procps
ENTRYPOINT ["/opt/bigreplapse/bigreplapse.sh"]

