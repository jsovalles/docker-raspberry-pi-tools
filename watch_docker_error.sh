#!/bin/bash

ERROR_MSG="stream copy error: reading from a closed fifo"
ERROR_COUNT=0
MAX_ERRORS=10
LAST_ERROR_TIME=0  # Store last error timestamp
IGNORE_DURATION=5  # Ignore duplicate errors within this time (seconds)

# Function to check if an upgrade is running
is_upgrade_running() {
    if pgrep -x "apt" > /dev/null || pgrep -x "dpkg" > /dev/null; then
        return 0  # Upgrade is running
    else
        return 1  # No upgrade running
    fi
}

# Read journal logs without a subshell
journalctl -f | while IFS= read -r line; do
    if [[ "$line" == *"$ERROR_MSG"* ]]; then
        if is_upgrade_running; then
            echo "Upgrade in progress, ignoring error."
            continue
        fi

        # Get current timestamp
        CURRENT_TIME=$(date +%s)

        # Ignore duplicate errors within IGNORE_DURATION seconds
        if (( CURRENT_TIME - LAST_ERROR_TIME < IGNORE_DURATION )); then
            echo "Duplicate error detected within $IGNORE_DURATION seconds, ignoring."
            continue
        fi

        LAST_ERROR_TIME=$CURRENT_TIME  # Update last error timestamp
        ((ERROR_COUNT++))

        echo "Error detected: $ERROR_MSG (Count: $ERROR_COUNT/$MAX_ERRORS)"

        if [[ $ERROR_COUNT -ge $MAX_ERRORS ]]; then
            ERROR_COUNT=0  # Reset counter after reaching max errors
            echo "Max errors reached. Rebooting system..."
            sudo reboot
        fi
    fi
done

