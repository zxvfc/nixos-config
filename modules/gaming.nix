{ lib, pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
      package = pkgs.steam.override {
        extraEnv = {
          PROTON_ENABLE_WAYLAND = "1";
        };
      };
    };
    gamemode.enable = true;
  };

  hardware.graphics = {
    enable = true;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
  ];
}
