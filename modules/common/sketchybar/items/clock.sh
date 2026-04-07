#!/usr/bin/env bash

# Clock
clock=(
  update_freq=10
  script="$PLUGIN_DIR/clock.sh"
  icon.drawing=off
  label.font="SF Pro:Semibold:13.0"
  label.padding_left=8
  label.padding_right=8
  background.corner_radius=8
  background.height=26

  popup.align=right
  popup.horizontal=off
  popup.drawing=off
  popup.blur_radius=20
  popup.background.corner_radius=10
  popup.background.border_width=1
)

popup_item=(
  label.font="SF Pro:Medium:12.0"
  icon.font="SF Pro:Semibold:12.0"
  icon.width=90
  label.width=110
  label.align=right
  background.padding_left=8
  background.padding_right=8
)

sketchybar \
  --add item clock right \
  --set clock "${clock[@]}" \
  --subscribe clock mouse.entered mouse.exited mouse.exited.global

sketchybar \
  --add item clock.tz_ny popup.clock \
  --set clock.tz_ny "${popup_item[@]}" icon="New York" label="--:--"

sketchybar \
  --add item clock.tz_ldn popup.clock \
  --set clock.tz_ldn "${popup_item[@]}" icon="London" label="--:--"

sketchybar \
  --add item clock.tz_tyo popup.clock \
  --set clock.tz_tyo "${popup_item[@]}" icon="Tokyo" label="--:--"

sketchybar \
  --add item clock.tz_syd popup.clock \
  --set clock.tz_syd "${popup_item[@]}" icon="Sydney" label="--:--"