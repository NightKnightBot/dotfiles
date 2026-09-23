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
          rev = "0f7538c4abb2cebdb34ab9736deea63006858542";
          hash = "sha256-C8o5iryN7CjKA4qp4+DPnd4KuHUf8T69lK2kpKElDmY=";
        };
        doInstallCheck = false;
      });
    };
}
