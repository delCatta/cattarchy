#!/bin/sh

action=$1
terminal_class=$2

active_class=$(hyprctl activewindow -j | jq -r '.class')

case "$action" in
    copy)
        shortcut="CTRL,C,"
        terminal_shortcut="CTRL_SHIFT,C,"
        ;;
    paste)
        shortcut="CTRL,V,"
        terminal_shortcut="CTRL_SHIFT,V,"
        ;;
    cut)
        shortcut="CTRL,X,"
        terminal_shortcut="CTRL_SHIFT,X,"
        ;;
    undo)
        shortcut="CTRL,Z,"
        terminal_shortcut="CTRL_SHIFT,Z,"
        ;;
    redo)
        shortcut="CTRL,Y,"
        terminal_shortcut="CTRL_SHIFT,Z,"
        ;;
    selectall)
        shortcut="CTRL,A,"
        terminal_shortcut="CTRL_SHIFT,A,"
        ;;
    save)
        shortcut="CTRL,S,"
        terminal_shortcut="CTRL_SHIFT,S,"
        ;;
    find)
        shortcut="CTRL,F,"
        terminal_shortcut="CTRL_SHIFT,F,"
        ;;
    
esac

if [ "$(echo "$active_class" | tr '[:upper:]' '[:lower:]')" = "$(echo "$terminal_class" | tr '[:upper:]' '[:lower:]')" ]; then
    shortcut=$terminal_shortcut
else
    shortcut=$shortcut
fi

echo "$(date): Active Class='${active_class}', Shortcut='${shortcut}'" >> /tmp/clip.log

hyprctl dispatch sendshortcut "$shortcut"
