{ config, pkgs, dotfiles, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    escapeTime = 0;
    baseIndex = 1;
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = ''
      set -ga terminal-overrides ",screen-256color*:Tc"
      set -g mouse on
      setw -g pane-base-index 1

      set-window-option -g mode-keys vi
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
    '';
  };

  home.file.".local/bin/tmux-sessionizer" = {
    source = "${dotfiles}/bin/tmux-sessionizer";
    executable = true;
  };
}
