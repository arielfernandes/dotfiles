#!/usr/bin/env bash

# set the icon and a temporary location for the screenshot to be stored
icon="$HOME/images/lock-icon-light.png"
tmpbg='/tmp/screen.png'

# take a screenshot
scrot "$tmpbg"

magick "$tmpbg" -filter Gaussian -thumbnail 20% -sample 500% "$tmpbg"
magick "$tmpbg" "$icon" -gravity center -composite "$tmpbg"

# lock the screen with the blurred screenshot
i3lock -i "$tmpbg"

# remove the temporary screenshot file
rm "$tmpbg"

