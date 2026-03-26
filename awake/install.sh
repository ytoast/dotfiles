#!/bin/bash
# Install the awake module: symlinks, launchd agents, pmset wake schedule.
set -euo pipefail

AWAKE_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== awake module ==="

# Ensure directories exist
mkdir -p "$HOME/bin"
mkdir -p "$HOME/Library/LaunchAgents"

# Make script executable
chmod +x "$AWAKE_DIR/awake-on.sh"
chmod +x "$AWAKE_DIR/awake-off.sh"

# Create symlinks
ln -sf "$AWAKE_DIR/awake-on.sh" "$HOME/bin/awake-on.sh"
ln -sf "$AWAKE_DIR/awake-off.sh" "$HOME/bin/awake-off.sh"
ln -sf "$AWAKE_DIR/com.user.awake-on.plist" "$HOME/Library/LaunchAgents/com.user.awake-on.plist"
ln -sf "$AWAKE_DIR/com.user.awake-off.plist" "$HOME/Library/LaunchAgents/com.user.awake-off.plist"
echo "  Symlinks created."

# Create ~/.awake-env template if it doesn't exist
if [[ ! -f "$HOME/.awake-env" ]]; then
    cat > "$HOME/.awake-env" <<'ENVEOF'
# Telegram credentials for awake notifications.
# Get your bot token from @BotFather on Telegram.
# Get your chat ID by messaging your bot, then visiting:
#   https://api.telegram.org/bot<YOUR_TOKEN>/getUpdates
TELEGRAM_BOT_TOKEN=""
TELEGRAM_CHAT_ID=""
ENVEOF
    echo "  Created ~/.awake-env — edit it with your Telegram credentials."
else
    echo "  ~/.awake-env already exists, skipping."
fi

# Unload existing agents (ignore errors if not loaded)
launchctl unload "$HOME/Library/LaunchAgents/com.user.awake-on.plist" 2>/dev/null || true
launchctl unload "$HOME/Library/LaunchAgents/com.user.awake-off.plist" 2>/dev/null || true

# Load agents
launchctl load "$HOME/Library/LaunchAgents/com.user.awake-on.plist"
launchctl load "$HOME/Library/LaunchAgents/com.user.awake-off.plist"
echo "  LaunchAgents loaded."

# pmset wake schedule
echo ""
echo "Setting pmset wake schedule (requires sudo):"
echo "  sudo pmset repeat wakeorpoweron MTWRFSU 09:59:00"
read -p "Run this now? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo pmset repeat wakeorpoweron MTWRFSU 09:59:00
    echo "  pmset schedule set."
else
    echo "  Skipped. Run manually later if needed."
fi

echo ""
echo "Done! Verify with:"
echo "  launchctl list | grep com.user.awake"
echo "  pmset -g sched"
