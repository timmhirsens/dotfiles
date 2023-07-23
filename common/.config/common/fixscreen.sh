#!/bin/sh -e
if xrandr | grep -q 'DisplayPort-1 connected' ; then
    xrandr --output DisplayPort-1 --primary
    ~/.fehbg
fi
if xrandr | grep -q 'DisplayPort-0 connected' ; then
    xrandr --output DisplayPort-0 --primary
    ~/.fehbg
fi
