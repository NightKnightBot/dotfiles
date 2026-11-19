{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Language Server lsp
    jdt-language-server
    nil
    lua-language-server
    tinymist
    gopls
    harper
    vtsls

    # Compilers
    jdk25
    python3
    uv
    rustup
    clang
    go
    protobuf
    typst
    nodejs
    vite
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
