#!/bin/bash

for file in *.jpg; do convert $file -resize 480 -gravity center -crop 480x240+0+0 +repage 480-$file; done

exit 0