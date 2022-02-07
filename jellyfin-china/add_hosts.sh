#!/bin/bash

# Path to the backup file
BACKUP_FILE="/etc/hosts.bak"

# Check if the backup file exists
if [ -f "$BACKUP_FILE" ]; then
    echo "Backup file already exists. No action taken."
else
    # Create a backup of /etc/hosts
    cp /etc/hosts "$BACKUP_FILE"
    
    # Append the contents of /hosts to /etc/hosts
    cat /hosts >> /etc/hosts
    echo "Backup created and /hosts content appended to /etc/hosts."
fi
