# dotfiles

Personal dotfiles managed with symlinks.

## Install

```bash
cd ~/dotfiles
./link.sh
```

Modules with their own setup have a separate `install.sh`:

| Module | Description | Install |
|--------|-------------|---------|
| [awake](awake/) | Scheduled caffeinate (10 AM-2 AM) with Telegram notifications | `awake/install.sh` |
