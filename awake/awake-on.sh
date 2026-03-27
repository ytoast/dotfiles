#!/bin/bash
# Start caffeinate and send a Telegram notification.
# Called by com.user.awake-on launchd agent at 10 AM daily.

set -euo pipefail

ENV_FILE="$HOME/.awake-env"
if [[ -f "$ENV_FILE" ]]; then
    source "$ENV_FILE"
fi

# Start caffeinate (-s: prevent system sleep on AC; -i: prevent idle sleep on battery)
/usr/bin/caffeinate -si &

# Send Telegram notification if credentials are configured
if [[ -n "${TELEGRAM_BOT_TOKEN:-}" && -n "${TELEGRAM_CHAT_ID:-}" ]]; then
    /usr/bin/curl -s "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
        -d chat_id="${TELEGRAM_CHAT_ID}" \
        -d text="[$(scutil --get ComputerName)] awake activated ($(date '+%H:%M'))" > /dev/null 2>&1 || true
fi
