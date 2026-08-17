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
      extraConfig = {
        kb-row-up = "Up,Control+Shift+K";
        kb-row-down = "Down,Control+Shift+J";
      };
    };

    nix-index.enable = true;
    home-manager.enable = true;
    fzf = {
      enable = true;
      enableBashIntegration = true;
    };

    git = {
      enable = true;
      settings = {
        include.path = "${config.home.homeDirectory}/dots/git_identity";
        init.defaultBranch = "main";
      };
    };
  };
}
