{ config, pkgs, ... }:

{
  #### SYSTEM (NixOS) ####

  programs.adb.enable = true;

  nixpkgs.config.android_sdk.accept_license = true;

  users.users.anand.extraGroups = [ "adbusers" ];


  #### USER (Home Manager) ####

  home-manager.users.anand = { pkgs, ... }:
  let
    androidSdk = pkgs.androidenv.composeAndroidPackages {
      platformVersions = [ "35" ];
      buildToolsVersions = [ "35.0.0" ];
      platformToolsVersion = "35.0.1";
      includeEmulator = true;
      includeSources = true;
      cmdLineToolsVersion = "12.0";
    };
  in
  {
    home.packages = [
      pkgs.flutter
      androidSdk.androidsdk
      androidSdk.emulator
    ];

    home.sessionPath = [
      "${androidSdk.androidsdk}/libexec/android-sdk/platform-tools"
      "${androidSdk.androidsdk}/libexec/android-sdk/cmdline-tools/latest/bin"
    ];
    
    home.sessionVariables = {
      ANDROID_SDK_ROOT =
        "${androidSdk.androidsdk}/libexec/android-sdk";

      ANDROID_HOME =
        "${androidSdk.androidsdk}/libexec/android-sdk";

      # This makes Flutter happy even if layout differs
      ANDROID_SDK_MANAGER =
        "${androidSdk.androidsdk}/libexec/android-sdk/cmdline-tools/*/bin/sdkmanager";
    };
  };
}

