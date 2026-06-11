{
  config,
  pkgs,
  lib,
  ...
}:
let
  dotfiles = "${config.home.homeDirectory}/dots/configs/";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
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
    spotify-player = "spotify-player";
    zathura = "zathura";
    i3 = "i3";
    sway = "i3";
    alacritty = "alacritty";
    kitty = "kitty";
    picom = "picom";
    oxwm = "oxwm";
  };
in
{
  imports = [
    ./home-modules/suckless.nix
  ];
  programs.swaylock = {
    package = pkgs.swaylock-effects;
    enable = true;
    settings = {
      font-size = 24;
      indicator-idle-visible = false;
      show-failed-attempts = true;
    };
  };
  programs.rofi = {
    enable = true;
    theme = "Paper";
  };

  programs.nix-index.enable = true;
  programs.home-manager.enable = true;

  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        zeroconf_port = 1234;
        device_name = "NixOS Spotifyd";
        backend = "alsa";
        bitrate = 320;
      };
    };
  };

  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
    };
  };

  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
  };

  services.swayidle =
    let
      lock = "${pkgs.swaylock}/bin/swaylock --daemonize --image ${config.home.homeDirectory}/dots/walls/lock.jpeg --clock";
    in
    {
      enable = true;

      timeouts = [
        {
          timeout = 290;
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

      events = {
        before-sleep = lock;
      };
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
      export MANPAGER="nvim +Man!"

      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        command yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d "" cwd < "$tmp"
        [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
        command rm -f -- "$tmp"
      }

      if [ "$TERM" != "dumb" ] || [ -n "$INSIDE_EMACS" ]; then
        PROMPT_COLOR="1;31m"
        ((UID)) && PROMPT_COLOR="1;34m"
        if [ -n "$INSIDE_EMACS" ]; then
          # Emacs term mode doesn't support xterm title escape sequence (\e]0;)
          PS1="\n\[\033[$PROMPT_COLOR\][\w]\\$\[\033[0m\] "
        else
          PS1="\n\[\033[$PROMPT_COLOR\][\[\e]0;\w\a\]\w]\\$\[\033[0m\] "
        fi
        if test "$TERM" = "xterm"; then
          PS1="\[\033]2;:\w\007\]$PS1"
        fi
      fi
      clear
    '';
    shellAliases = {
      ls = "eza --icons";
      grep = "grep --color=auto";
      cd = "z";
      cat = "bat";
      ll = "eza --icons -lha";
      la = "eza --icons -a";
      sp = "spotify_player";
      t = "tmux";
    };
  };
  home.username = "anand";
  home.homeDirectory = "/home/anand";
  home.stateVersion = "25.11"; # NEVER CHANGE THIS
  home.packages = with pkgs; [
    rmpc
    mpv
    fzf
    nb
    eza
    yt-dlp
    mpv
    copyq
    fastfetch
    dysk
    termdown
    pfetch
    flameshot
    grim
    slurp
    dmenu-wayland
    ripgrep
    fd
    imv
    libreoffice
    mgba
    unrar
    imagemagick
    yazi
    cloc
    jujutsu
    qbittorrent
    playerctl
    ffmpeg
    exiftool
    picard

    # Programming
    nil
    lua-language-server
    godot
    neovide
    neovim
    python3
    rustup
    clang
    lazysql
    lazygit

  ];

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "kitty.desktop"
        "foot.desktop"
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
    gtk4.theme = null;
  };
}
