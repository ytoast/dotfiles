# awake

Automatically keeps your Mac awake from 10 AM to 2 AM daily using `caffeinate`, then lets it sleep overnight. Sends a Telegram notification when activated.

## How it works

| Time | Action | Method |
|------|--------|--------|
| 9:59 AM | Mac wakes from sleep (best-effort) | `pmset repeat wakeorpoweron` |
| 10:00 AM | `caffeinate -s` starts + Telegram notification | `com.user.awake-on` launchd agent |
| 2:00 AM | `killall caffeinate` | `com.user.awake-off` launchd agent |

## Setup

1. Run `~/dotfiles/awake/install.sh` (creates symlinks, loads launchd agents, optionally sets pmset wake)
2. Edit `~/.awake-env` with your Telegram credentials

### Getting your Telegram chat ID

1. Create a bot via [@BotFather](https://t.me/BotFather) on Telegram (if you haven't already)
2. Send any message to your bot
3. Open in your browser: `https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates`
4. Find `"chat":{"id":123456789}` in the JSON — that number is your chat ID
5. Add both values to `~/.awake-env`

## Manual overrides

These shell aliases still work for ad-hoc use:

```bash
awake        # caffeinate -s &
awake-off    # killall caffeinate
```

## Limitations

- **Unplugged + lid closed at 10 AM**: the `pmset` wake won't fire. You'll need to run `awake` manually when you open the lid.
- **After reboot**: launchd agents auto-reload, but caffeinate won't be running until 10 AM (or you start it manually).
- **Telegram notification is best-effort**: if `curl` fails or credentials are missing, caffeinate still starts.

## Logs

```
/tmp/awake-on.log   # stdout from awake-on.sh
/tmp/awake-on.err   # stderr from awake-on.sh
/tmp/awake-off.log  # stdout from killall
/tmp/awake-off.err  # stderr from killall
```
