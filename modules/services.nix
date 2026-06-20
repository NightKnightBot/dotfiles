{ pkgs, ... }:
{
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
      xkb = {
        layout = "us";
        options = "caps:escape";
      };

      autoRepeatDelay = 200;
      autoRepeatInterval = 35;

      windowManager = {
        dwm = {
          enable = true;
          package = pkgs.dwm.overrideAttrs {
            src = ../configs/dwm;
          };
        };
        oxwm.enable = true;
        i3 = {
          enable = true;
          extraPackages = with pkgs; [
            dmenu
            dex
            xss-lock
            xdotool
            xprop
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
}
