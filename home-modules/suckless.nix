{ pkgs, ... }:

{
  home.packages = [
    (pkgs.st.overrideAttrs (_: {
      src = ../configs/st;
      patches = [
        ../config/st/patches/st-scrollback-0.9.2.diff
      ];
    }))
  ];
}
