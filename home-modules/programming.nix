{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Language Server
    nil
    basedpyright
    lua-language-server
    tinymist
    gopls
    # Compilers
    python3
    rustup
    clang
    go
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
