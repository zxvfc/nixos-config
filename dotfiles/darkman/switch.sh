#!/bin/sh
case "$1" in
dark)
  theme="Bibata-Modern-Ice"
  ln -sf ~/.config/alacritty-themes/github_dark_high_contrast.toml ~/.config/alacritty-theme.toml
  cp --no-preserve=mode,timestamps ~/.config/waybar/dark.css ~/.config/waybar/colors.css
  ln -sf ~/.config/tofi/github_dark_high_contrast.conf ~/.config/tofi/config
  ln -sf ~/.config/mako/github_dark_high_contrast.conf ~/.config/mako/colors
  ;;
light)
  theme="Bibata-Modern-Classic"
  ln -sf ~/.config/alacritty-themes/github_light_high_contrast.toml ~/.config/alacritty-theme.toml
  cp --no-preserve=mode,timestamps ~/.config/waybar/light.css ~/.config/waybar/colors.css
  ln -sf ~/.config/tofi/github_light_high_contrast.conf ~/.config/tofi/config
  ln -sf ~/.config/mako/github_light_high_contrast.conf ~/.config/mako/colors
  ;;
esac

gsettings set org.gnome.desktop.interface cursor-theme "$theme"
swaymsg seat '*' xcursor_theme "$theme" 24
makoctl reload
