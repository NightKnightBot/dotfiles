{
  config,
  lib,
  pkgs,
  inputs,
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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };

  networking.hostName = "anand-mini";
  networking.extraHosts = ''
    100.88.139.92 homelab
    192.168.1.26  homelab
  '';

  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80
      8080
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

  security.pam.services.swaylock = { };
  services.tailscale.enable = true;
  services.blueman.enable = true;
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

  environment.systemPackages = [
    pkgs.vulkan-tools
    pkgs.libnotify
    pkgs.brightnessctl
    pkgs.btop
    pkgs.nix-output-monitor
    pkgs.nvd
    pkgs.unzip
    pkgs.zip
    pkgs.vim
    pkgs.tree-sitter
    pkgs.wget
    pkgs.git
    pkgs.tmux
    pkgs.ly
    pkgs.pavucontrol
    pkgs.waybar
    pkgs.pass
    pkgs.rofi
    pkgs.foot
    pkgs.awww
    pkgs.networkmanagerapplet
    pkgs.zoxide
    pkgs.wlr-randr
    pkgs.bat
    pkgs.vlc
    pkgs.zathura
    pkgs.localsend
    pkgs.docker
    pkgs.kdePackages.kleopatra
    pkgs.gimp3
    pkgs.kdePackages.ark
    pkgs.ferdium
    pkgs.spotify-player
    pkgs.wl-clipboard
    pkgs.grim
    pkgs.slurp
    pkgs.trash-cli
    pkgs.nh
    pkgs.mosh
    pkgs.calibre
    pkgs.easyeffects
    pkgs.prismlauncher
    pkgs.sshfs
    pkgs.obs-studio
    pkgs.mdterm
    pkgs.heroic

    inputs.helium.packages.x86_64-linux.default
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    corefonts
    vista-fonts
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
  programs.mango.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
  programs.firefox = {
    enable = false;
    policies = {
      IPProtectionAvailable = true;
    };
  };
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-volman
      thunar-archive-plugin
      thunar-media-tags-plugin
    ];
  };
  programs.xfconf.enable = true;
  programs.dconf.enable = true;
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

  services.power-profiles-daemon.enable = false;
  services.upower.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
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
