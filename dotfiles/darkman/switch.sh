#!/bin/sh
case "$1" in
dark)
  ln -sf ~/.config/alacritty/themes/themes/github_dark_high_contrast.toml ~/.config/alacritty-theme.toml
  cp --no-preserve=mode,timestamps ~/.config/waybar/dark.css ~/.config/waybar/colors.css
  cp --no-preserve=mode,timestamps ~/.config/kde-colors/dark.colors ~/.config/kdeglobals
  theme="Bibata-Modern-Ice"
  ;;
light)
  ln -sf ~/.config/alacritty/themes/themes/github_light_high_contrast.toml ~/.config/alacritty-theme.toml
  cp --no-preserve=mode,timestamps ~/.config/waybar/light.css ~/.config/waybar/colors.css
  cp --no-preserve=mode,timestamps ~/.config/kde-colors/light.colors ~/.config/kdeglobals
  theme="Bibata-Modern-Classic"
  ;;
esac

gsettings set org.gnome.desktop.interface cursor-theme "$theme"
swaymsg seat '*' xcursor_theme "$theme" 24
