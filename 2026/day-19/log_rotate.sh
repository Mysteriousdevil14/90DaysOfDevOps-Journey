#!/bin/bash
set -euo pipefail

#check_argument
if [ $# -ne 1 ]; then
	echo "Usage: $0 <log_directory>"
	exit 1
fi
LOG_DIR="$1"
if [ ! -d "$LOG_DIR" ]; then
	echo "Error: Directory $LOG_DIR does not exist"
	exit 1
fi

# Compress .log files older than 7 days
compressed=$(find "$LOG_DIR" -name "*.log" -mtime +7 -exec gzip {} \; | wc -l)
echo "Compressed $compressed .log files"

#Delete .gz files oleder than 30 days
deleted=$(find "$LOG_DIR" -name "*.gz" -mtime +30 -print rm {} \; | wc -l)
echo "Deleted $deleted older .gz files"
echo "log rotation completed at $(date)"
