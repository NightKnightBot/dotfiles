{ config, pkgs, ... }:
{
  #### SYSTEM (NixOS) ####

  programs.adb.enable = true;

  nixpkgs.config.android_sdk.accept_license = true;

  users.users.anand.extraGroups = [ "adbusers" ];

  environment.variables = {
    ANDROID_SDK_ROOT = "/home/anand/.android-sdk/libexec/android-sdk";
    ANDROID_HOME = "/home/anand/.android-sdk/libexec/android-sdk";
  };

  home-manager.users.anand =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.flutter
        pkgs.android-tools
      ];
    };
}
