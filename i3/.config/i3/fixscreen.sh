#!/bin/sh -e
if xrandr | grep -q 'DisplayPort-1 connected' ; then
    xrandr --output DisplayPort-1 --primary
    xrandr --output eDP --off
    ~/.fehbg
fi
