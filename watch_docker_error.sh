#!/bin/bash

ERROR_MSG="stream copy error: reading from a closed fifo"

journalctl -f | while read line; do
    if echo "$line" | grep -q "$ERROR_MSG"; then
        echo "Error detected: $ERROR_MSG"
        echo "Rebooting system..."
        sudo reboot
    fi
done
