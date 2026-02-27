{ mango, ... }:
{
  imports = [
    mangowc.nixosModules.default
  ];

  programs.mango.enable = true;
}
