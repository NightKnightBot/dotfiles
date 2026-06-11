{ pkgs, ... }:

{
      home.packages = [
        pkgs.nil
        pkgs.tinymist
        pkgs.lua-language-server
        pkgs.clang-tools
        pkgs.emmet-ls
        pkgs.cmake-language-server
      ];
}
