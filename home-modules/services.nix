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

    mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music";
    };

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
