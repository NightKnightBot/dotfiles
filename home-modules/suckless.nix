{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (pkgs.st.overrideAttrs (_: {
      src = ../configs/st;
      patches = [ ];
    }))
    surf
  ];
}
