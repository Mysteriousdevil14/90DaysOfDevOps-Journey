#!/bin/bash
echo -n "Enter a filename:"
read file
if [ -f "$file" ]; then
	echo "File $file exists."
else
	echo "File $file does not exist."
fi
