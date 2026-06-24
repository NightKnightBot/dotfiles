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

    swayidle =
      let
        lock = "${pkgs.swaylock}/bin/swaylock --daemonize --image ${config.home.homeDirectory}/dots/walls/lock.jpeg --clock";
        systemctl = "${pkgs.systemd}/bin/systemctl";
      in
      {
        enable = true;
        timeouts = [
          {
            timeout = 600;
            command = lock;
          }
          {
            timeout = 1000;
            command = "${systemctl} suspend";
          }
        ];
        events.before-sleep = lock;
      };
  };
}
