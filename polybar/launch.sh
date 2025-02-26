#!/bin/sh

polybar-msg cmd quit
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --config=~/.config/polybar/config.ini example 2>&1 &
done
