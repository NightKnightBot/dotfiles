{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Language Server lsp
    jdt-language-server
    nil
    basedpyright
    lua-language-server
    tinymist
    gopls
    basedpyright

    # Compilers
    jdk
    jre
    python3
    rustup
    clang
    go
    protobuf
    # Editors
    # godot
    # neovim - THIS IS PRESENT AS A FLAKE. Building from source

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
