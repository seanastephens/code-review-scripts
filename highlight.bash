#!/bin/bash

# For each file listed on the command line, use tohtml.com to highlight
# syntax. The resulting text is opened in a the browser.

BROWSER=google-chrome

for file in $@ ; do

	# Right click on a request in chrome dev tools to find "copy as cURL."
	curl 'https://tohtml.com/python/' \
		--data "code_src=$(cat $file)&Submit=Highlight&style=default&type=python" \
	> ${file}.html

	HTML_FILES="${HTML_FILES} ${file}.html"

done

$BROWSER $HTML_FILES

# Clean up, but make sure the browser found them all first.
sleep 3
rm $HTML_FILES
