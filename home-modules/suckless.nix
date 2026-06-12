{ pkgs, ... }:

{
  home.packages = [
    (pkgs.st.overrideAttrs (_: {
      src = ../configs/st;
      patches = [ ];
    }))
  ];

  xdg.desktopEntries.st = {
    name = "st";
    genericName = "Terminal";
    exec = "st";
    terminal = false;
    categories = [
      "System"
      "TerminalEmulator"
    ];
  };
}
