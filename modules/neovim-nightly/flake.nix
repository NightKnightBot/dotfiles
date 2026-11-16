{
  description = "Neovim nightly";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system}.default = pkgs.neovim-unwrapped.overrideAttrs (oldAttrs: {
        pname = "neovim-nightly";
        version = "v0.13.0-dev-1275+ga08607b8d6";

        src = pkgs.fetchFromGitHub {
          owner = "neovim";
          repo = "neovim";
          rev = "7e394dbb896eaf86cb1046666dd423d512cda55f";
          hash = "sha256-MnOZRn4LvHmyLeSaVSeBZ9+DT3NCrlzF9lVQZCt0STM=";
        };
        doCheck = false;
        doInstallCheck = false;
      });
    };
}
