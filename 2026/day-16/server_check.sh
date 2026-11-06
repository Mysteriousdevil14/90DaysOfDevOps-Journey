#!/bin/bash
SERVICE="nginx"

echo "Do you want to check the status? (y/n)"
read -p "Enter choice: " choice
if [ "$choice" = "y" ]; then
        systemctl status $SERVICE | grep "Active:"
        
        if systemctl is-active --quiet $SERVICE; then
                echo "$SERVICE is active."
        else
                echo "$SERVICE is not active."
        fi
else
        echo "Skipped."
fi

