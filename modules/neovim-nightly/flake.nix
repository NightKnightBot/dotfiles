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
          rev = "d3b4f562a636a7f9df69a18c27d1e0d7bbad22a5";
          hash = "sha256-kENcHoVIaCbdAljehRoNxBJeaUjVe5031AcXOxmN3I8=";
        };
        doInstallCheck = false;
      });
    };
}
