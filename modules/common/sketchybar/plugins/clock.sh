#!/usr/bin/env bash

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

case "$SENDER" in
  "mouse.entered")
    sketchybar --set "$NAME" popup.drawing=on
    ;;
  "mouse.exited"|"mouse.exited.global")
    sketchybar --set "$NAME" popup.drawing=off
    ;;
esac

# Main local clock
LOCAL_LABEL="$(date '+%a %d %b  %H:%M')"

# Popup timezone rows
NY_TIME="$(TZ='America/New_York' date '+%a %H:%M')"
LDN_TIME="$(TZ='Europe/London'    date '+%a %H:%M')"
TYO_TIME="$(TZ='Asia/Tokyo'       date '+%a %H:%M')"
SYD_TIME="$(TZ='Australia/Sydney' date '+%a %H:%M')"

sketchybar \
  --set "$NAME" label="$LOCAL_LABEL" \
  --set clock.tz_ny  label="$NY_TIME" \
  --set clock.tz_ldn label="$LDN_TIME" \
  --set clock.tz_tyo label="$TYO_TIME" \
  --set clock.tz_syd label="$SYD_TIME"
