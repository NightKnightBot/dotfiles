{
  config,
  pkgs,
  lib,
  ...
}:
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
  programs.swaylock = {
    package = pkgs.swaylock-effects;
    enable = true;
    settings = {
      font-size = 24;
      indicator-idle-visible = false;
      show-failed-attempts = true;
    };
  };
  services.swayidle =
    let
      # Lock command
      lock = "${pkgs.swaylock}/bin/swaylock --daemonize --image /home/anand/dots/walls/lock.jpeg --clock";
      suspend = "systemctl suspend";
    in
    {
      enable = true;
      timeouts = [
        {
          timeout = 290; # in seconds
          command = "${pkgs.libnotify}/bin/notify-send 'Locking in 10 seconds' -t 10000";
        }
        {
          timeout = 300;
          command = lock;
        }
        {
          timeout = 800;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
      events = [
        {
          event = "before-sleep";
          command = lock;
        }
      ];
    };
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
      ll = "eza --icons -lha";
      la = "eza --icons -a";
    };
  };
  home.username = "anand";
  home.homeDirectory = "/home/anand";
  home.stateVersion = "25.11"; # NEVER CHANGE THIS
  home.packages = with pkgs; [
    mpv
    dunst
    fzf
    nb
    eza
    yt-dlp
    mpv
    copyq
    fastfetch
    watch
    progress
    dysk
    glow
    termdown
    pfetch
    flameshot
    grim
    slurp
    dmenu-wayland
    lazysql
    lazygit
    ripgrep
    fd
    imv
    libreoffice
    godot
    mgba
    unrar
    chromium
    nil
    lua-language-server
  ];

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "org.wezfurlong.wezterm.desktop"
      ];
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
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
  };

}
