# home-modules/symlinks.nix
{ config, ... }:
let
  dotfiles = "${config.home.homeDirectory}/dots/configs/";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    niri = "niri";
    foot = "foot";
    spectrwm = "spectrwm";
    qutebrowser = "qutebrowser";
    dunst = "dunst";
    waybar = "waybar";
    rmpc = "rmpc";
    fastfetch = "fastfetch";
    mutt = "mutt";
    wezterm = "wezterm";
    mango = "mango";
    tmux = "tmux";
    polybar = "polybar";
    flameshot = "flameshot";
    spotify-player = "spotify-player";
    zathura = "zathura";
    i3 = "i3";
    alacritty = "alacritty";
    kitty = "kitty";
    picom = "picom";
    oxwm = "oxwm";
    quickshell = "quickshell";
  };
in
{
  _module.args = { inherit dotfiles create_symlink configs; };
}
