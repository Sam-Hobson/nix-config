{ config, pkgs, dotfiles, ... }: {
  home.file.".config/nvim/init.lua".source = "${dotfiles}/nvim/init.lua";
  home.file.".config/nvim/lua".source = "${dotfiles}/nvim/lua";
  home.file.".config/nvim/snippets".source = "${dotfiles}/nvim/snippets";
  home.file.".config/nvim/spell".source = "${dotfiles}/nvim/spell";
  home.file.".config/nvim/after".source = "${dotfiles}/nvim/after";
}
