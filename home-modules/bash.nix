{ config, ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [ "ignoreboth" ];
    historyFile = "${config.home.homeDirectory}/.bash_history";
    historyIgnore = [
      "ls"
      "eza"
      "z"
      "cd"
    ];
    initExtra = ''
      bind -m vi-insert '"\C-l": clear-screen'
      bind -m vi-command '"\C-l": clear-screen'
      set -o vi
      eval "$(fzf --bash)"
      eval "$(zoxide init bash)"
      export MANPAGER="nvim +Man!"

      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        command yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d "" cwd < "$tmp"
        [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
        command rm -f -- "$tmp"
      }

      if [ "$TERM" != "dumb" ] || [ -n "$INSIDE_EMACS" ]; then
        PROMPT_COLOR="1;31m"
        ((UID)) && PROMPT_COLOR="1;34m"
        if [ -n "$INSIDE_EMACS" ]; then
          # Emacs term mode doesn't support xterm title escape sequence (\e]0;)
          PS1="\n\[\033[$PROMPT_COLOR\][\w]\\$\[\033[0m\] "
        else
          PS1="\n\[\033[$PROMPT_COLOR\][\[\e]0;\w\a\]\w]\\$\[\033[0m\] "
        fi
        if test "$TERM" = "xterm"; then
          PS1="\[\033]2;:\w\007\]$PS1"
        fi
      fi
      clear
    '';
    shellAliases = {
      ls = "eza --icons";
      grep = "grep --color=auto";
      cd = "z";
      cat = "bat";
      ll = "eza --icons -lha";
      la = "eza --icons -a";
      sp = "spotify_player";
      t = "tmux";
      hm = "cd ~/dots && nvim home.nix";
    };
  };
}
