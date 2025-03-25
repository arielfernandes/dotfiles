#!/usr/bin/env bash

picom &
nm-applet &
sleep 1
conky &
emacs &
nitrogen --restore &
