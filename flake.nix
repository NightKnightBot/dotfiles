{
  description = "Anand Nix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    devenv.url = "github:cachix/devenv/latest";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mangowc = {
      url = "github:DreamMaoMao/mangowc";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs =
    {
      nixpkgs,
      home-manager,
      auto-cpufreq,
      mangowc,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
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
          inherit home-manager mangowc inputs;
        };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.anand = import ./home.nix;
              backupFileExtension = "hmbackup";
            };
          }
          mangowc.nixosModules.mango
          auto-cpufreq.nixosModules.default
        ];
      };
    };
}
