#!/bin/bash

CONFIGURED=""

function debug() {
  >&2 echo $@
}

function process_device() {
  local device="$1"
  local xrandr="$(xrandr | grep ^"$device")"
  debug "xrandr $device: $xrandr"

  if [[ -z $xrandr ]]; then
    debug "Unknown device $device. Skipping..."
    return
  fi

  if [[ $xrandr == *disconnected* ]]; then
    # If the device is disconnected, tell xrandr to turn it off.
    $(xrandr --output $device --off)
    debug "Turned $device off"
  else
    # if it's connected, make sure we set it up.
    $(xrandr \
      --output eDP-1 \
      --primary \
      --mode 1920x1080 \
      --right-of $device \
      --rotate normal \
      --output $device \
      --auto \
      --pos 0x0 \
      --rotate normal
    )
    debug "Configured $device"

    if [[ -z $CONFIGURED ]]; then
      CONFIGURED="$device"
    else
      CONFIGURED="$CONFIGURED, $device"
    fi
  fi
}

while (("$#")); do
  process_device "$1"
  shift
done

if [[ -n $CONFIGURED ]]; then
  echo "$CONFIGURED"
else
  echo "OFF"
fi
