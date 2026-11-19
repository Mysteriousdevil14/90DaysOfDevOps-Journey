
#!/bin/bash
set -euo pipefail

# 1. Input validation
if [ $# -ne 1 ]; then
    echo "Error: Please provide a log file path."
    echo "Usage: ./log_analyzer.sh <log_file>"
    exit 1
fi

LOG_FILE="$1"
DATE=$(date +%Y-%m-%d)

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' does not exist."
    exit 1
fi

REPORT_FILE="log_report_${DATE}.txt"
ARCHIVE_DIR="archive"

# Create archive directory
mkdir -p "$ARCHIVE_DIR"

# Temporary file for top 5 errors
TEMP_ERRORS=$(mktemp)
trap 'rm -f "$TEMP_ERRORS"' EXIT

# 2. Count errors (ERROR or FAILED)
ERROR_COUNT=$(awk 'toupper($0) ~ /(ERROR|FAILED)/ {count++} END {print count+0}' "$LOG_FILE")

echo "Total error count: $ERROR_COUNT"

# 3. Critical events
echo -e "\n--- Critical Events ---"
grep -in "CRITICAL" "$LOG_FILE" || echo "No critical events found."

# 4. Top 5 error messages
awk 'toupper($0) ~ /ERROR/ {
    $1=$2=$3=""
    sub(/^[[:space:]]+/, "")
    print
}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5 > "$TEMP_ERRORS"

# 5. Generate report
{
    echo "Log Analysis Report - $DATE"
    echo "Log file: $LOG_FILE"
    echo "Total lines: $(wc -l < "$LOG_FILE")"
    echo "Total error count: $ERROR_COUNT"

    echo -e "\n--- Top 5 Error Messages ---"
    if [ -s "$TEMP_ERRORS" ]; then
        cat "$TEMP_ERRORS"
    else
        echo "No error messages found."
    fi

    echo -e "\n--- Critical Events ---"
    grep -in "CRITICAL" "$LOG_FILE" || echo "No critical events found."

} > "$REPORT_FILE"

# 6. Archive original log file
mv -- "$LOG_FILE" "$ARCHIVE_DIR/"

echo "Log file moved to $ARCHIVE_DIR/"
echo "Log analysis completed."
echo "Report saved as $REPORT_FILE"

