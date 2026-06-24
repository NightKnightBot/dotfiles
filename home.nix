{
  pkgs,
  lib,
  config,
  dotfiles,
  create_symlink,
  configs,
  ...
}:
{
  imports = [
    ./home-modules/suckless.nix
    ./home-modules/waylandonly.nix
    ./home-modules/programming.nix
    ./home-modules/symlinks.nix
    ./home-modules/bash.nix
    ./home-modules/packages.nix
    ./home-modules/programs.nix
    ./home-modules/services.nix
  ];

  home.username = "anand";
  home.homeDirectory = "/home/anand";
  home.stateVersion = "25.11"; # NEVER CHANGE THIS
  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    CC = "clang";
    GOPATH = "${config.home.homeDirectory}/.local/share/go";
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "alacritty.desktop"
        "st.desktop"
        "kitty.desktop"
        "foot.desktop"
      ];
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = lib.mkForce {
      name = "Nightfox-Dark";
      package = pkgs.nightfox-gtk-theme;
    };
    gtk4.theme = null;
  };
}
