#!/bin/bash

# Check for user-supplied command to run on remote servers
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <command_to_run_on_servers>"
    exit 1
fi

REMOTE_COMMAND="$*"
SESSION_NAME="cos568_run_$RUN_COMMAND"

# Step 1-3: Commit and push changes from main system
echo "Committing and pushing local changes..."
git add .
git commit -m "updates"
git push origin main

# Define your server hostnames or IPs
SERVERS=("atharvsp@ms1022.utah.cloudlab.us" 
        "atharvsp@ms1025.utah.cloudlab.us" 
        "atharvsp@ms1016.utah.cloudlab.us" 
        "atharvsp@ms1044.utah.cloudlab.us")

# Define the working directory on the remote servers
REMOTE_DIR="/proj/cos568proj2-PG0/groups/ap9721/COS568-DistLM-SP25"

# Step 4-7: SSH into each server and run commands inside tmux
for i in "${!SERVERS[@]}"; do
    SERVER="${SERVERS[$i]}"
    echo "Connecting to $SERVER..."
    ssh "$SERVER" << EOF
        cd "$REMOTE_DIR" || exit 1
        git pull
        tmux new-session -d -s "$SESSION_NAME" "$REMOTE_COMMAND $i"
EOF
done
