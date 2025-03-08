#!/bin/bash

LOGFILE="/var/log/syslog"  # Adjust if using another log file
ERROR_MSG="stream copy error: reading from a closed fifo"

tail -Fn0 "$LOGFILE" | while read line; do
    if echo "$line" | grep -q "$ERROR_MSG"; then
        echo "Error detected: $ERROR_MSG"
        echo "Rebooting system..."
        sudo reboot
    fi
done
