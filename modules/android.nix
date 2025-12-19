{ config, pkgs, ... }:
let
  androidSdk = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [ "35" ];
    buildToolsVersions = [ "35.0.0" ];
    platformToolsVersion = "35.0.1";

    includeEmulator = true;
    includeSources = true;

    includeNDK = true;
    ndkVersions = [ "28.2.13676358" ];

    cmdLineToolsVersion = "12.0";
  };
in
{
  #### SYSTEM (NixOS) ####

  programs.adb.enable = true;

  nixpkgs.config.android_sdk.accept_license = true;

  environment.systemPackages = [
    androidSdk.androidsdk
  ];

  users.users.anand.extraGroups = [ "adbusers" ];

  environment.variables = {
    ANDROID_SDK_ROOT = "${androidSdk.androidsdk}/libexec/android-sdk";
    ANDROID_HOME = "${androidSdk.androidsdk}/libexec/android-sdk";
  };
  #### USER (Home Manager) ####

  home-manager.users.anand =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.flutter
        pkgs.android-tools
        androidSdk.emulator
      ];
    };
}
