{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nil
    lua-language-server
    godot
    mdterm
    tmux
    jujutsu
    cloc
    neovide
    neovim
    python3
    rustup
    clang
    lazysql
    lazygit
    tinymist
    clang-tools
    devenv
  ];
}
