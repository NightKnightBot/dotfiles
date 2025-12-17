{ config, pkgs, ... }:

{
  home-manager.users.anand = { pkgs, ... }:
  
  {
    home.packages = [
      pkgs.nil
      pkgs.tinymist
      pkgs.lua-language-server
      pkgs.clang-tools
      pkgs.jdt-language-server
      pkgs.rust-analyzer
      pkgs.emmet-ls
      pkgs.cmake-language-server
      pkgs.phpactor
    ];
  };
}
