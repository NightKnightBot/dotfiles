{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/services.nix
    ./modules/programs.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  documentation.dev.enable = true;

  hardware.bluetooth = {
    enable = false;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  networking = {
    hostName = "anand-mini";
    extraHosts = ''
      100.88.139.92 homelab
      192.168.1.26  homelab
    '';

    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        8080
        9090
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
  };

  time.timeZone = "Asia/Kolkata";

  nixpkgs.config.allowUnfree = true;

  nix.settings.trusted-users = [
    "root"
    "anand"
  ];

  users.users.anand = {
    isNormalUser = true;
    extraGroups = [
      "ydotool"
      "wheel"
      "network"
      "input"
      "uinput"
      "video"
      "adbusers"
      "libvirtd"
      "kvm"
      "docker"
      "ydotool"
    ];
  };

  environment = {
    sessionVariables = {
      NH_FLAKE = "/home/anand/dots/";
    };

    localBinInPath = true;

    systemPackages = with pkgs; [
      xrandr
      brightnessctl
      nix-output-monitor
      nvd
      vim
      ly
      pavucontrol
      networkmanagerapplet
      pass
      libnotify
      wlr-randr
      trash-cli
      nh
      sshfs
      xclip
      man-pages
      man-pages-posix
      upower-notify
      inputs.helium.packages.x86_64-linux.default
    ];
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      corefonts
      vista-fonts
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
      };
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  virtualisation = {
    # libvirtd.enable = true;
    docker = {
      enable = false;
      enableOnBoot = true;
    };
  };

  security.pam.services.swaylock = { };

  system.stateVersion = "25.11"; # DO NOT CHANGE THIS
}
