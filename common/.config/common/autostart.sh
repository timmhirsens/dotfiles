#!/bin/bash  

function run {
    if ! pgrep $1 ;
    then
        $@&
    fi
}

run ~/.fehbg 
# run xss-lock --transfer-sleep-lock -- '/home/timm/.config/i3/lock_screen.sh' --nofork
run nm-applet
run setxkbmap -layout eu,us,de -variant ,intl, -option "caps:escape"
run /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1
run xautolock -detectsleep -time 15 -locker '~/.config/i3/lock_screen.sh'
run tuxedo-control-center --tray
run picom -b
run flameshot
# run redshift-gtk
run 1password --silent
run xfce4-power-manager
run blueman-applet

xsetroot -cursor_name left_ptr &
