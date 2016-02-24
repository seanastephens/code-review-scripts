#!/bin/bash

# For each file listed on the command line, use tohtml.com to highlight
# syntax. The resulting text is opened in a the browser.

BROWSER=google-chrome

for file in $@ ; do

	# Right click on a request in chrome dev tools to find "copy as cURL."
	curl 'https://tohtml.com/python/' \
		-H 'origin: https://tohtml.com' \
		-H 'accept-encoding: gzip, deflate' \
		-H 'accept-language: en-US,en;q=0.8' \
		-H 'upgrade-insecure-requests: 1' \
		-H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36' \
		-H 'content-type: application/x-www-form-urlencoded' \
		-H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' \
		-H 'cache-control: max-age=0' \
		-H 'authority: tohtml.com' \
		-H 'cookie: __cfduid=db6b30abe984458c8284b503446c0153f1454084289; cr_style=default; cr_type=python; cr_recent_types=python; __utmt=1; __utma=194695208.127157489.1454084290.1456122154.1456354200.9; __utmb=194695208.3.10.1456354200; __utmc=194695208; __utmz=194695208.1456354200.9.7.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not%20provided)' \
		-H 'referer: https://tohtml.com/python/' \
		--data "code_src=$(cat $file)&Submit=Highlight&style=default&type=python" \
		--compressed \
	> ${file}.html

	HTML_FILES="${HTML_FILES} ${file}.html"

done

$BROWSER $HTML_FILES

# Clean up, but make sure the browser found them all first.
sleep 3
rm $HTML_FILES
