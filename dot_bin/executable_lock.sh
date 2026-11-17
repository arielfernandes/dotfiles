#!/usr/bin/env bash

# temporary location for the screenshot
tmpbg='/tmp/screen.png'

# take a screenshot
scrot "$tmpbg"

# blur the screenshot (pixelate: shrink 20% then scale back 500%)
convert "$tmpbg" -filter Gaussian -thumbnail 20% -sample 500% "$tmpbg"

# lock the screen with the blurred screenshot
i3lock -n -i "$tmpbg"

# remove the temporary screenshot file
rm -f "$tmpbg"