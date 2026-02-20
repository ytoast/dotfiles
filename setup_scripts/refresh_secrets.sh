#!/bin/bash
# Pulls secrets from 1Password and writes them as plaintext to ~/.ignores/exports
# Run once per laptop setup, or whenever secrets change.
# Requires: op CLI signed into my.1password.com

set -euo pipefail

mkdir -p ~/.ignores

echo "Fetching secrets from 1Password..."

cat <<EOF > ~/.ignores/exports
export TAVILY_API_KEY="$(op read "op://ENV VARIABLES/Tavily/api_key" --account=my.1password.com)"
export SLACK_BOT_TOKEN="$(op read "op://ENV VARIABLES/Slack Bot/token" --account=my.1password.com)"
export SLACK_TEAM_ID="$(op read "op://ENV VARIABLES/Slack Bot/team_id" --account=my.1password.com)"
EOF

echo "Done! Secrets written to ~/.ignores/exports"
echo "Run 'source ~/.ignores/exports' or open a new shell to load them."
