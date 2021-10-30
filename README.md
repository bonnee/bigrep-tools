# BigRep tools

Ugly hacks to have timelapse and Telegram Bot on the crippled version of OctoPrint shipped with BigRep Products 

## Dependencies
 - sh
 - curl
 - jq
 - ffmpeg
 - bc

## Requirements
 - Any printer with OctoPrint
 - Bravery

## Setup
1. Build Docker image with `docker-compose build`
2. Run the container with `docker-compose up`

## FAQ
Q: Why a Telegram Bot in Bash?

A: So that I'm not incentivized to add features and waste time on it
