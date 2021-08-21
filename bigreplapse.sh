#!/bin/sh

purl="bigrep.dii.unitn.it:5000" # Printer URL
key="B04E7D95CA844EC987FAA7D54EC812A0" # Printer API Key
curl="rtsp://bigrepcam.dii.unitn.it/ipcam_h264.sdp" # Cam URL
targetduration=60 # timelapse duration in sec
targetfps=15 # timelapse FPS
framenum=$(echo "$targetduration*$targetfps" | bc) # number of estimated frames to capture
bot_path="$(pwd)/telegram-bot-bash/bin"

tmpdir="./.tmp"
exportdir="./export"
mkdir -p "$tmpdir" "$exportdir"

while true; do
  job=$(curl -s -X GET -H "X-Api-Key: $key" http://$purl/api/job)

  state=$(jq -n "$job" | jq -r .state) # printer state
  printtime=$(jq -n "$job" | jq .job.estimatedPrintTime) # estimated print time
  timeleft=$(jq -n "$job" | jq .progress.printTimeLeft) # estimated print time left
  interval=$(echo "$printtime/$framenum" | bc) # interval between frames

  if [ "$state" = "Printing" ] || [ "$state" = "Pausing" ] || [ "$state" = "Paused" ]; then
    if [ -z "$ffpid" ]; then
      name=$(jq -n "$job" | jq -r .job.file.name) # filename

      echo "Starting image capture for $name every $interval seconds"
      endtime=$(echo "$(date +%s)+$timeleft" | bc)
      
      $bot_path/send_broadcast.sh --doit --both "Print $name started. It should end at $(date -d @$endtime)"
      # if ffmpeg is not running yet
      rm -rf $tmpdir/*
      
      # Capture snapshot every $interval
      ffmpeg -hide_banner -loglevel error -i "$curl" -f image2 -vf fps=fps="1/$interval" "$tmpdir/$name-%04d.jpg" & ffpid=$!
    fi
  elif [ ! -z "$ffpid" ]; then
    echo "Generating timelapse"
    $bot_path/send_broadcast.sh --doit --both "Print $name ended! now generating timelapse..."
    kill "$ffpid"
    unset ffpid
    ffmpeg -hide_banner -loglevel error -framerate $targetfps -i "$tmpdir/$name-%04d.jpg" -c:v libx264 -pix_fmt yuv420p "$exportdir/timelapse-$name-$(date +%s).mp4"

    $bot_path/send_file.sh --doit --both "Print $name ended! now generating timelapse..."
  fi

  sleep 60 # don't overload octoprint with requests
done

