#!/bin/bash

# Backup and create symlink for Alacritty
mkdir -p ~/.config/alacritty
[ -f ~/.config/alacritty/alacritty.toml ] && mv ~/.config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml.bak
ln -sf "$(pwd)/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml

# Backup and create symlink for i3wm
#mkdir -p ~/.config/i3
#[ -f ~/.config/i3/config ] && mv ~/.config/i3/config ~/.config/i3/config.bak
#ln -sf "$(pwd)/i3wm/config" ~/.config/i3/config

# Backup and create symlink for Vim
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.bak
ln -sf "$(pwd)/vim/vimrc" ~/.vimrc

# Backup and create symlink for Bashrc
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak
ln -sf "$(pwd)/bashrc/bashrc" ~/.bashrc



# Make runtime scripts executable and move to a hidden folder
mkdir -p ~/.runtimescripts
cp -r runtimescripts/* ~/.runtimescripts/
chmod +x ~/.runtimescripts/*

# Add to PATH in bashrc if not already added
if ! grep -q "runtimescripts" ~/.bashrc; then
  echo 'export PATH=$PATH:~/.runtimescripts' >> ~/.bashrc
fi

# Adding Keybinds to the system and invoking them.
# Make Keybinds directory and backup existing custom_keymap.xkb
mkdir -p ~/keybinds
[ -f ~/keybinds/custom_keymap.xkb ] && mv ~/keybinds/custom_keymap.xkb ~/keybinds/custom_keymap.xkb.bak

# Symlink for custom_keymap.xkb
ln -sf "$(pwd)/keybinds/custom_keymap.xkb" ~/keybinds/custom_keymap.xkb

# Apply the keymap
xkbcomp ~/keybinds/custom_keymap.xkb $DISPLAY

# Add command to i3 config to make the keymap persistent across reboots
#if ! grep -q "xkbcomp ~/keybinds/custom_keymap.xkb \$DISPLAY" ~/.config/i3/config; then
#  echo 'exec --no-startup-id "xkbcomp ~/keybinds/custom_keymap.xkb $DISPLAY"' >> ~/.config/i3/config
#fi

# Print message
echo "CapsLock has been successfully binded to Backspace."
