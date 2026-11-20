{ pkgs, config, ... }:
{
  services = {
    spotifyd = {
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

    mako = {
      enable = true;
      settings = {
        default-timeout = 5000;
      };
    };

    sxhkd = {
      enable = true;
      keybindings = {
        "super + shift + {e, d}" = "{thunar, bookmarkr}";
        "super + Return" = "alacritty";
        "super + v" = "copyq toggle";
        "super + {b, p}" = "{helium, passmenu}";
        "super + space" = "rofi -modi drun,run -show drun";
        "super + shift + s" = "screenshot";
        "super + m" = "rofimoji";

        # Volume
        "{XF86AudioRaiseVolume, XF86AudioLowerVolume}" =
          "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%{+,-}";
        "XF86AudioMute" = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

        # Brightness
        "XF86MonBrightnessUp" = "brightnessctl set +5%";
        "XF86MonBrightnessDown" = "brightnessctl set 5%-";
      };
    };

    # Disable this flag to disable chromium from being visible in playerctl chromium://flags/#hardware-media-key-handling
    # Use media.hardwaremediakeys.enabled in about:config for firefox
    playerctld.enable = true;

    mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music";
      extraConfig = ''
        audio_output {
          type "pulse"
          name "PipeWire Output"
          always_on "yes"
        }
      '';
    };
    mpd-mpris.enable = true;
  };
}
