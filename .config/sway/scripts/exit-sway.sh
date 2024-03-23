#!/bin/bash

# Kill running swayrd window switcher
killall swayrd

# Finally exit SwayWM
swaymsg exit
