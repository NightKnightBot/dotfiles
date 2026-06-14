{ pkgs, config, ... }:
{
  programs = {
    swaylock = {
      package = pkgs.swaylock-effects;
      enable = true;
      settings = {
        font-size = 24;
        indicator-idle-visible = false;
        show-failed-attempts = true;
      };
    };
    rofi = {
      enable = true;
      theme = "Paper";
    };

    nix-index.enable = true;
    home-manager.enable = true;

    git = {
      enable = true;
      settings = {
        include.path = "${config.home.homeDirectory}/dots/git_identity";
        init.defaultBranch = "main";
      };
    };
  };
}
