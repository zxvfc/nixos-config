{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nixd
    nixfmt
    statix
    docker-language-server
    gdtoolkit_4

    gcc
    tree-sitter
    ripgrep
    fd
    lazygit
    nodejs
  ];

  home-manager.users.zxvfc = { config, ... }: {
    xdg.configFile."nvim".source =
      config.lib.file.mkOutOfStoreSymlink "/home/zxvfc/nixos-config/dotfiles/nvim";
  };
}
