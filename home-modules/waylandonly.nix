{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dmenu-wayland
    waybar
    foot
    wl-clipboard
    grim
    slurp
  ];
}
