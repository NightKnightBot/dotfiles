{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dmenu-wayland
    imv
    waybar
    foot
    wl-clipboard
    grim
    slurp
  ];
}
