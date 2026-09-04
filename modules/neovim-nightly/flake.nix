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
          rev = "b51a0b2dccb78151ae02b12ef32e0a6b623006d3";
          hash = "sha256-kEerY0TTlE0dlS4UinY5XSEydCaeFbHsIsqZmg8a5k8=";
        };
        doInstallCheck = false;
      });
    };
}
