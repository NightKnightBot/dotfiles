{
  description = "Anand Nix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs =
    {
      nixpkgs,
      home-manager,
      auto-cpufreq,
      mango,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations.anand-mini = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit home-manager mango;
        };
        modules = [
          ./configuration.nix
          ./modules/home-manager.nix
          # ./modules/mango.nix
          ./modules/lsp.nix
          auto-cpufreq.nixosModules.default
        ];
      };
    };
}
