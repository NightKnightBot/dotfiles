{ home-manager, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.anand = import ../home.nix;
    backupFileExtension = "hmbackup";
  };
}
