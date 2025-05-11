{ pkgs, ... }:
let
  shellAliases = {
    l = "ls -l";
    ll = "ls -lAh";
  };
  home = "/home/sam";
in {
    home.file.".p10k.zsh".source = "${dotfiles}/zsh/.p10k.zsh";

    home.sessionPath = [
      "$HOME/.local/bin"
    ];
  
    programs.bash = {
      enable = true;
      shellAliases = shellAliases;
    };

    programs.zsh = {
      enable = true;
      shellAliases = shellAliases;
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
	}
      ];
    };

    programs.zsh.initContent = ''
      test -f ${home}/.p10k.zsh && source ${home}/.p10k.zsh
    '';
  }
