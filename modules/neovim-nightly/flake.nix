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
          rev = "24183950e183a6908f21142905ecbcf424b7f0f5";
          hash = "sha256-Cr0jB5xXnowoEmxvc5hQYrFxII86MYpb6WHtJTrg2Ko=";
        };
        doInstallCheck = false;
      });
    };
}
