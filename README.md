# BigRep tools

Ugly hacks to have timelapse and Telegram Bot on the crippled version of OctoPrint featured in BigRep Printers 

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
1. Clone the telegram-bot-bash submodule
2. Setup the bot and save `count.jssh` and `botconfig.sh` in the project root.
3. Build Docker image with `docker-compose build`
4. Run the container with `docker-compose up`

## FAQ
Q: Why a Telegram Bot in Bash?

A: So that I'm not incentivized to add features and waste time on it

