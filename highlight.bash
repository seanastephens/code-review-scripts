#!/bin/bash

# For each file listed on the command line, use tohtml.com to highlight
# syntax. The resulting text is opened in a the browser.

BROWSER=google-chrome

for file in $@ ; do

	# Where does this come from? Right click on a request in chrome dev tools
	# to find "copy as cURL."
	#
	# We need to --data-urlencode the source code itself, because things like
	# '+' get lost otherwise.
	curl 'https://tohtml.com/python/' \
		--data "Submit=Highlight&style=default&type=python" \
		--data-urlencode "code_src=$(cat $file)" \
		> ${file}.html

	html_files="${html_files} ${file}.html"

done

$BROWSER $html_files

# Clean up, but make sure the browser found them all first.
sleep 3
rm $html_files
