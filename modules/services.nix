{ pkgs, ... }:
{
  services = {
    blueman.enable = true;

    logind.settings.Login = {
      HandlePowerKey = "ignore";
      LidSwitchIgnoreInhibited = "no";
    };

    mysql = {
      enable = true;
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
      dpi = 96;
      xkb = {
        layout = "us";
        options = "caps:escape";
      };

      autoRepeatDelay = 200;
      autoRepeatInterval = 35;

      windowManager = {
        i3 = {
          enable = true;
          extraPackages = with pkgs; [
            picom
            pcmanfm
            dunst
            feh
            qutebrowser
            libinput-gestures
            xwallpaper
            ueberzugpp
          ];
        };
        # xmonad = {
        #   enable = true;
        #   enableContribAndExtras = true;
        # };
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
