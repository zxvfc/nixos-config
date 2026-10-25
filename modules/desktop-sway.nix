{ pkgs, ... }: {

  imports = [ ./ly ];

  systemd.services.NetworkManager-wait-online.enable = false;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-termfilechooser
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      darkman
    ];
    config.sway = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      "org.freedesktop.impl.portal.Settings" = [ "darkman" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      "org.freedesktop.impl.portal.Inhibit" = [ "none" ];
    };
  };

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      package = pkgs.sway.override {
        sway-unwrapped = pkgs.sway-unwrapped.override { swaybg = null; };
      };
    };
    firefox.enable = true;
  };

  # environment.etc."sway/config.d/90-local.conf".text = '';
  environment.sessionVariables = {
    WLR_RENDERER = "vulkan";
    QT_QPA_PLATFORMTHEME = "xdgdesktopportal";
  };
  environment.systemPackages = with pkgs; [
    tofi
    libnotify
    mako
    alacritty
    waybar
    bibata-cursors
    wiremix
    wl-clipboard
    yazi
    grim
    slurp

    nixd
    nixfmt
    statix

    gcc
    tree-sitter
    ripgrep
    fd
    lazygit
    nodejs
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    font-awesome
    inter
  ];

  home-manager.backupFileExtension = "backup";
  home-manager.users.zxvfc = { config, ... }: {
    home.stateVersion = "26.11";

    services.darkman.enable = true;

    programs = {
      ssh = {
        enable = true;
        includes = [ "/run/agenix/ssh_hosts" ];
      };
      git = {
        enable = true;
        settings = {
          user.name = "Valentin";
          user.email = "velya.96@gmail.com";
        };
      };
    };

    xdg.configFile = {
      "nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/zxvfc/nixos-config/dotfiles/nvim";
      "sway".source = ../dotfiles/sway;
      "gtk-3.0".source = ../dotfiles/gtk-3.0;
      "gtk-4.0".source = ../dotfiles/gtk-4.0;

      "alacritty".source = ../dotfiles/alacritty;
      "alacritty-themes".source = "${pkgs.alacritty-theme}/share/alacritty-theme";

      "waybar/config.jsonc".source = ../dotfiles/waybar/config.jsonc;
      "waybar/power_menu.xml".source = ../dotfiles/waybar/power_menu.xml;
      "waybar/style.css".source = ../dotfiles/waybar/style.css;
      "waybar/dark.css".source = ../dotfiles/waybar/dark.css;
      "waybar/light.css".source = ../dotfiles/waybar/light.css;

      "tofi/github_dark_high_contrast.conf".source = ../dotfiles/tofi/github_dark_high_contrast.conf;
      "tofi/github_light_high_contrast.conf".source = ../dotfiles/tofi/github_light_high_contrast.conf;

      "mako/config".source = ../dotfiles/mako/config;
      "mako/github_dark_high_contrast.conf".source = ../dotfiles/mako/github_dark_high_contrast.conf;
      "mako/github_light_high_contrast.conf".source = ../dotfiles/mako/github_light_high_contrast.conf;

      "xdg-desktop-portal-termfilechooser".source = ../dotfiles/xdg-desktop-portal-termfilechooser;
      "xdg-desktop-portal-wlr/config".text = ''
        				[screencast]
        				chooser_type=dmenu
        				chooser_cmd=${pkgs.tofi}/bin/tofi
        			'';
    };
    xdg.dataFile."darkman/switch.sh" = {
      source = ../dotfiles/darkman/switch.sh;
      executable = true;
    };
  };
}
