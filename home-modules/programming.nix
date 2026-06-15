{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Language Server
    nil
    lua-language-server
    tinymist
    # Compilers
    python3
    rustup
    clang
    # Editors
    godot
    neovide
    neovim
    # Terminal Application
    mdterm
    tmux
    jujutsu
    cloc
    lazysql
    lazygit
    clang-tools
    devenv
    gnumake
    cmake
    lldb
  ];
}
