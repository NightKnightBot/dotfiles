{ pkgs, ... }:
{
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
    ydotool.enable = true;
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
}
