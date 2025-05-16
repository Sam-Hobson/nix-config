{ config, pkgs, dotfiles, ... }: {
  # Set dark mode
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
