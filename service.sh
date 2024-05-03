#!/bin/bash
picom --config /home/spidey/.config/picom/picom.conf --experimental-backends
xinput set-prop $(xinput list | grep Touchpad | awk '{print $6}' | cut -d= -f2) "libinput Tapping Enabled" 1

