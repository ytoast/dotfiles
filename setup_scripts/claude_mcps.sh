#!/bin/bash
# Setup Claude Code MCP servers at user scope
# Secrets are expected from ~/.ignores/exports (not committed)

set -euo pipefail

echo "Setting up Claude Code MCP servers..."

# Obsidian (no secrets)
claude mcp add --scope user obsidian -- npx -y obsidian-mcp \
  "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/polychain/"

# Notion (no secrets, OAuth-based)
claude mcp add --scope user notionMCP -- npx -y mcp-remote https://mcp.notion.com/mcp

# Tavily (secret from env)
if [ -z "${TAVILY_API_KEY:-}" ]; then
  echo "WARNING: TAVILY_API_KEY not set, skipping tavilyMCP"
else
  claude mcp add --scope user tavilyMCP -- npx -y mcp-remote \
    "https://mcp.tavily.com/mcp/?tavilyApiKey=${TAVILY_API_KEY}"
fi

# Snowflake (no secrets)
claude mcp add --scope user snowflake -- "$HOME/.local/bin/uvx" \
  snowflake-labs-mcp --service-config-file

# Slack (secrets from env)
if [ -z "${SLACK_BOT_TOKEN:-}" ] || [ -z "${SLACK_TEAM_ID:-}" ]; then
  echo "WARNING: SLACK_BOT_TOKEN or SLACK_TEAM_ID not set, skipping slack"
else
  claude mcp add --scope user slack \
    -e "SLACK_BOT_TOKEN=${SLACK_BOT_TOKEN}" \
    -e "SLACK_TEAM_ID=${SLACK_TEAM_ID}" \
    -- npx -y @modelcontextprotocol/server-slack
fi

echo "Done! Restart Claude Code for changes to take effect."
