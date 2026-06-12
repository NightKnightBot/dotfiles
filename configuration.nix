{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
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

  networking.hostName = "anand-mini";
  networking.extraHosts = ''
    100.88.139.92 homelab
    192.168.1.26  homelab
  '';

  networking = {
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

  environment.localBinInPath = true;

  environment.systemPackages = with pkgs; [
    xrandr
    vulkan-tools
    brightnessctl
    nix-output-monitor
    nvd
    vim
    git
    ly
    pavucontrol
    networkmanagerapplet
    pass
    libnotify
    wlr-randr
    docker
    trash-cli
    nh
    sshfs
    file
    xauth
    xdotool
    xdo
    xprop
    xclip
    man-pages
    man-pages-posix
    upower-notify

    inputs.helium.packages.x86_64-linux.default
    # inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default
    # inputs.devenv.packages.${stdenv.hostPlatform.system}.devenv
  ];

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

  virtualisation.libvirtd.enable = true;
  programs = {
    virt-manager.enable = true;
    nix-ld.enable = true;
    mango.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
    firefox = {
      enable = false;
      policies = {
        IPProtectionAvailable = true;
      };
    };
    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-volman
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    };
    xfconf.enable = true;
    dconf.enable = true;
    auto-cpufreq = {
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
  };

  security.pam.services.swaylock = { };

  services = {
    tailscale.enable = true;

    blueman.enable = true;

    logind.settings.Login = {
      HandlePowerKey = "ignore";
      LidSwitchIgnoreInhibited = "no";
    };

    mysql = {
      enable = false;
      package = pkgs.percona-server;
    };

    displayManager.ly = {
      enable = true;
      settings = {
        clock = "%c";
        bigclock = true;
      };
    };

    printing.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    power-profiles-daemon.enable = false;

    upower.enable = true;

    gvfs.enable = true;

    tumbler.enable = true;

    openssh.enable = true;

    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.options = "caps:escape";

      autoRepeatDelay = 200;
      autoRepeatInterval = 35;

      windowManager = {
        oxwm.enable = true;
        i3 = {
          enable = true;
          extraPackages = with pkgs; [
            dmenu
            i3status
            dex
            xss-lock
            i3lock
            xdotool
            xorg.xprop
            xdo
            picom
            alacritty
            nsxiv
            pcmanfm
            dunst
            waypaper
            feh
            qutebrowser
            libinput-gestures
            xwallpaper
            rxvt-unicode-emoji
            ueberzugpp
          ];
        };
      };
      videoDrivers = [ "modesetting" ];
    };

    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        horizontalScrolling = true;
        scrollMethod = "twofinger";
        disableWhileTyping = true;
      };
    };
  };

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
