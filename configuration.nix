{ config, lib, pkgs, ... }:

{
  imports =
    [
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

  time.timeZone = "Asia/Kolkata";

  nixpkgs.config.allowUnfree = true;

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
    extraGroups = [ "wheel" "network" "input" "uinput" "video" "adbusers" "libvirtd" "kvm" "docker" ];
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
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
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    python315
    rustc
    cargo
    clippy
    rustfmt
    brillo
    gnome.gvfs
    wlr-randr
    bat
    batsignal
    vlc
    zathura
    localsend
    docker
    podman
    kdePackages.kleopatra
    gimp3
    kdePackages.ark
    spotifyd
    ferdium
    spotify-player
    wl-clipboard
    hypridle
    hyprlock
    hyprshot
    trashy
    php
    phpPackages.composer
    nodejs_25
    go
    lazygit
    libgcc
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["JetBrainsMono Nerd Font"];
    };
  };

	nix.settings.experimental-features = ["nix-command" "flakes"];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

  programs.firefox.enable = true;

  programs.auto-cpufreq.enable = true;
  programs.auto-cpufreq.settings = {
    charger = {
      governer = "performance";
      turbo = "auto";
    };
    battery = {
      governer = "powersave";
      turbo = "auto";
    };
  };

  services.openssh.enable = true;

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

