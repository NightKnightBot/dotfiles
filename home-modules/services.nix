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
        "super + shift + {e, d}" = "{pcmanfm, bookmarkr}";
        "super + Return" = "alacritty";
        "super + v" = "copyq toggle";
        "super + {b, p}" = "{helium, passmenu}";
        "super + space" = "rofi -modi drun,run -show drun";
        "super + shift + s" = "screenshot";
        "super + m" = "rofimoji";
        "super + shift + {c, r, q}" = "i3-msg {reload, restart, exit}";

        # Volume
        "{XF86AudioRaiseVolume, XF86AudioLowerVolume}" =
          "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%{+,-}";
        "XF86AudioMute" = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

        # Brightness
        "XF86MonBrightnessUp" = "brightnessctl set +5%";
        "XF86MonBrightnessDown" = "brightnessctl set 5%-";

        "super + q" = "i3-msg kill";
        "super + {h, j, k, l, Left, Up, Down, Right}" =
          "i3-msg focus {left,up,down,right,left,up,down,right}";
        "super + {Left, Up, Down, Right}" = "i3-msg focus {left,up,down,right}";
        "super + f" = "i3-msg fullscreen toggle";
        "super + shift + {h,j,k,l,Left,Down,Up,Right}" =
          "i3-msg move {left,down,up,right,left,down,up,right}";
        "super + {s, w, e}" = "i3-msg layout {stacking, tabbed, toggle split}";
        "super + {1, 2, 3, 4, 5, 6, 7, 8, 9, 0}" = "i3-msg workspace number {1,2,3,4,5,6,7,8,9.0}";
        "super + shift + {1, 2, 3, 4, 5, 6, 7, 8, 9, 0}" =
          "i3-msg move container to workspace number {1,2,3,4,5,6,7,8,9.0}";
        "super + shift + BackSpace" = "i3-msg floating toggle";
        "super + BackSpace" = "i3-msg focus mode_toggle";
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
