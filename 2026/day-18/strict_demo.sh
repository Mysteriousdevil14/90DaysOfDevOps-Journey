#!/bin/bash
set -euo pipefail
echo "Testing strict mode..."
echo "Undefined variable: $UNDEFINED"
false # This will stop the script (set -e)
echo "This won't run"
cat /nonexistent | grep something
echo "This won't run either"
