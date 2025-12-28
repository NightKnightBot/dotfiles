{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "anand-mini";
  networking.extraHosts = ''
    192.168.1.26  homelab
  '';

  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80
      443
      22
      53317
    ];
    allowedUDPPorts = [
      53317
      5353
    ];
    allowedUDPPortRanges = [
      {
        from = 4000;
        to = 4007;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
  };

  time.timeZone = "Asia/Kolkata";

  nixpkgs.config.allowUnfree = true;

  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    LidSwitchIgnoreInhibited = "no";
  };
  services.mysql = {
    enable = true;
    package = pkgs.percona-server;
  };

  services.displayManager.ly = {
    enable = true;
    settings = {
      clock = "%c";
      bigclock = true;
    };
  };

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  users.users.anand = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "network"
      "input"
      "uinput"
      "video"
      "adbusers"
      "libvirtd"
      "kvm"
      "docker"
    ];
  };

  environment.sessionVariables = {
    NH_FLAKE = "/home/anand/dots/";
  };

  environment.systemPackages = with pkgs; [
    btop
    nix-output-monitor
    nvd
    unzip
    zip
    vim
    neovim
    tree-sitter
    wget
    git
    kitty
    tmux
    ly
    pavucontrol
    waybar
    polybar
    pass
    rofi
    rofimoji
    wezterm
    swww
    networkmanagerapplet
    zoxide
    brillo
    wlr-randr
    bat
    vlc
    zathura
    localsend
    docker
    kdePackages.kleopatra
    gimp3
    kdePackages.ark
    ferdium
    spotify-player
    wl-clipboard
    hypridle
    hyprlock
    hyprshot
    trashy
    nh
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  programs.nix-ld.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.firefox.enable = true;
  programs.xfconf.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
      thunar-archive-plugin
      thunar-media-tags-plugin
    ];
  };
  programs.auto-cpufreq = {
    enable = true;
    settings = {
      charger = {
        governer = "performance";
        turbo = "auto";
      };
      battery = {
        governer = "powersave";
        turbo = "auto";
      };
    };
  };

  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.openssh.enable = true;
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        username = "";
        password = "";
      };
    };
  };

  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "caps:escape";

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}
