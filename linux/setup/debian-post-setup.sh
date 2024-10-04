#!/bin/bash

# Copy custom keybindings
# dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > ../dump/dump_1
# dconf dump /org/gnome/desktop/wm/keybindings/ > ../dump/dump_2
# dconf dump /org/gnome/shell/keybindings/ > ../dump/dump_3
# dconf dump /org/gnome/mutter/keybindings/ > ../dump/dump_4
# dconf dump /org/gnome/mutter/wayland/keybindings/ > ../dump/dump_5

# Apply custom keybindings
cat ../dump/dump_1 | dconf load /org/gnome/settings-daemon/plugins/media-keys/
cat ../dump/dump_2 | dconf load /org/gnome/desktop/wm/keybindings/
cat ../dump/dump_3 | dconf load /org/gnome/shell/keybindings/
cat ../dump/dump_4 | dconf load /org/gnome/mutter/keybindings/
cat ../dump/dump_5 | dconf load /org/gnome/mutter/wayland/keybindings/

# Copy ZShell config
cp ../config/.zshrc ~/.zshrc
source ~/.zshrc

# Copy Kitty config
cp ../config/kitty.conf ~/.config/kitty/kitty.conf

# Copy SSH
sudo cp -r ./.ssh /