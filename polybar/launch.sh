#!/bin/sh

polybar-msg cmd quit
polybar --config=~/.config/polybar/config.ini primary 2>&1 &
polybar --config=~/.config/polybar/config.ini secondary 2>&1 &
