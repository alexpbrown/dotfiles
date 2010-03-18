#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#exec ratpoison

xrandr -q &
sh ~/bin/externalmon &
xrdb ~/.Xdefaults &
nitrogen --restore &
numlockx &
sleep 2

#dwm
conky | while read line; do
  xsetroot -name "$line";
done | while true; do exec ck-launch-session dwm > /dev/null; done;

#exec ck-launch-session openbox

#xmonad
#xsetroot -cursor_name left_ptr
#exec ck-launch-session xmonad
