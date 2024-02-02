#!/bin/sh

# Code is from following repo:
# https://github.com/markasoftware/bing-wallpaper-linux 

imgurl="https://www.bing.com$( \
curl "https://www.bing.com/HPImageArchive.aspx?format=rss&idx=0&n=1&mkt=en-US" \
| xmllint --xpath "/rss/channel/item/link/text()" - \
)"

bname="$(date '+%Y-%m-%d-%-H:%-M:%-S')"-bing-background.jpg
curl -sS "$imgurl" -o ./"$bname"
# feh --bg-scale ./"$bname"
