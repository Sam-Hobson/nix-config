{ config, pkgs, dotfiles, ... }:

let
  shellAliases = {
    l = "ls -l";
    ll = "ls -lAh";
  };
in {
    home.packages = [
      pkgs.zsh-powerlevel10k
    ];


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
      autosuggestion.enable = true;

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
	}
      ];

      history = {
        size = 100000;
        save = 100000;
        ignoreSpace = true;
        ignoreDups = true;
        ignoreAllDups = true;
        expireDuplicatesFirst = true;
        extended = true;
        share = true;
        path = "${config.home.homeDirectory}/.zsh_history";
      };

      profileExtra = ''
        setopt extendedglob
	zstyle ':completion:*' menu select
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' list-colors "$${(s.:.)LS_COLORS}"
	WORDCHARS=""

	function tmuxSessionizer {
	  exec </dev/tty  # This is to fix an issue with zle binds nulling stdin/out.
	  exec <&1
	  tmux-sessionizer
	}

        function gotoDir {
	  . gotodir
	}

	zle -N tmuxSessionizer
	zle -N gotoDir

	bindkey '^f' tmuxSessionizer
	bindkey '^a' gotoDir
	bindkey '^p' history-search-backward
	bindkey '^n' history-search-forward
	bindkey '^[[Z' reverse-menu-complete
	bindkey '^[^?' backward-kill-word
	bindkey "^[[1;5C" forward-word
	bindkey "^[[1;5D" backward-word
      '';

    };

    programs.zsh.initContent = ''
      test -f ${config.home.homeDirectory}/.p10k.zsh && source ${config.home.homeDirectory}/.p10k.zsh
    '';


    home.file.".local/bin/gotodir" = {
      source = "${dotfiles}/bin/gotodir";
      executable = true;
    };
  }
