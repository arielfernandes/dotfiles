#!/usr/bin/env bash

# temporary location for the screenshot
tmpbg='/tmp/screen.png'

# take a screenshot
scrot "$tmpbg"

# blur the screenshot (pixelate: shrink 20% then scale back 500%)
magick "$tmpbg" -filter Gaussian -thumbnail 20% -sample 500% "$tmpbg"

# lock the screen with the blurred screenshot
i3lock -i "$tmpbg"

# remove the temporary screenshot file
rm "$tmpbg"