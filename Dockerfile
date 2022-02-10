FROM alpine:latest
WORKDIR /opt/bigreplapse
COPY bigreplapse.sh ./
COPY start.sh ./
COPY telegram-bot-bash/STANDALONE ./telegram-bot-bash/
COPY send_broadcast_file.sh ./telegram-bot-bash/bin/

RUN apk add --no-cache bash ffmpeg bc curl jq procps flock
ENTRYPOINT ["/opt/bigreplapse/start.sh"]

