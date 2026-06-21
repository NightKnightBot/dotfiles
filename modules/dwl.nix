# from https://codeberg.org/anriha/nixos-config/src/commit/f15d97a097eca43d620be9d68974f2710a6fe807/dwl.nix#
{
  config,
  pkgs,
  dwl-source,
  yambar-source,
  ...
}:
{
  nixpkgs.overlays = [
    (self: super: {
      yambar = super.yambar.overrideAttrs (oldAttrs: rec {
        src = yambar-source;
      });
      dwl = super.dwl.overrideAttrs (oldAttrs: rec {
        src = dwl-source;
        patches = [ ];
      });
    })
  ];
}
