{ config, pkgs, lib, ... }:
let
  dotfiles = "${config.home.homeDirectory}/dots/";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  programs.home-manager.enable = true;
  configs = {
    nvim = "nvim";
    niri = "niri";
    foot = "foot";
    spectrwm = "spectrwm";
    qutebrowser = "qutebrowser";
    dunst = "dunst";
    waybar = "waybar";
    hypr = "hypr";
    rmpc = "rmpc";
    fastfetch = "fastfetch";
    mutt = "mutt";
    wezterm = "wezterm";
    mango = "mango";
    tmux = "tmux";
    polybar = "polybar";
    flameshot = "flameshot";
  };
in
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [ "ignoreboth" ];
    historyFile = "${config.home.homeDirectory}/.bash_history";
    historyIgnore = [
      "ls"
      "eza"
      "z"
      "cd"
    ];
    initExtra = ''
      bind -m vi-insert '"\C-l": clear-screen'
      bind -m vi-command '"\C-l": clear-screen'
      set -o vi
      eval "$(fzf --bash)"
      eval "$(zoxide init bash)"
      if [ "$TERM" != "dumb" ] || [ -n "$INSIDE_EMACS" ]; then
        PROMPT_COLOR="1;31m"
        ((UID)) && PROMPT_COLOR="1;34m"
        if [ -n "$INSIDE_EMACS" ]; then
          # Emacs term mode doesn't support xterm title escape sequence (\e]0;)
          PS1="\n\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] "
        else
          PS1="\n\[\033[$PROMPT_COLOR\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] "
        fi
        if test "$TERM" = "xterm"; then
          PS1="\[\033]2;\h:\u:\w\007\]$PS1"
        fi
      fi
    '';
    shellAliases = {
      ls = "eza --icons";
      grep = "grep --color=auto";
      cd = "z";
      cat = "bat";
      ll = "eza --icons -la";
      la = "eza --icons -a";
    };
  };
  home.username = "anand";
  home.homeDirectory = "/home/anand";
  home.stateVersion = "25.11"; # NEVER CHANGE THIS
  home.packages = [
      pkgs.mpv
      pkgs.dunst
      pkgs.fzf
      pkgs.nb
      pkgs.eza
      pkgs.yt-dlp
      pkgs.mpv
      pkgs.cmake
      pkgs.copyq
      pkgs.fastfetch
      pkgs.scrcpy
      pkgs.watch
      pkgs.progress
      pkgs.uv
      pkgs.dysk
      pkgs.glow
      pkgs.termdown
      pkgs.hugo
      pkgs.pfetch
      pkgs.laravel
      pkgs.php
      pkgs.flameshot
      pkgs.grim
      pkgs.slurp
      pkgs.dmenu-wayland
  ];

  home.activation.dotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sf ${config.home.homeDirectory}/dots/shell/zshrc ${config.home.homeDirectory}/.zshrc
    ln -sf ${config.home.homeDirectory}/dots/shell/bashrc ${config.home.homeDirectory}/.bashrc
    ln -sf ${config.home.homeDirectory}/dots/shell/profile ${config.home.homeDirectory}/.profile
    ln -sf ${config.home.homeDirectory}/dots/shell/bash_profile ${config.home.homeDirectory}/.bash_profile
    ln -sf ${config.home.homeDirectory}/dots/shell/starship.toml ${config.home.homeDirectory}/.config/starship.toml
    ln -sf ${config.home.homeDirectory}/dots/shell/Xresources ${config.home.homeDirectory}/.Xresources
  '';

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
