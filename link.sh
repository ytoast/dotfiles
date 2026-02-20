#!/usr/bin/env zsh
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/tmate.conf ~/.tmate.conf
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/zprofile ~/.zprofile
ln -sf ~/dotfiles/aliases ~/.aliases
ln -sf ~/dotfiles/functions ~/.functions
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/gitignore_global ~/.gitignore_global
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/alacritty.yml ~/.alacritty.yml
ln -sf ~/dotfiles/config ~/.config
mkdir -p ~/.ignores
ln -sf ~/dotfiles/ignores/op_exports ~/.ignores/exports
ln -sf ~/dotfiles/config/hammerspoon ~/.hammerspoon
ln -sf ~/dotfiles/config/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/dotfiles/config/claude/settings.json ~/.claude/settings.json
ln -sf ~/dotfiles/config/claude/settings.local.json ~/.claude/settings.local.json
mkdir -p ~/.claude/agents
ln -sf ~/dotfiles/config/claude/agents/messari-dbt-modeler.md ~/.claude/agents/messari-dbt-modeler.md
