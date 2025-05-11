{ config, pkgs, dotfiles, ... }:

let
  shellAliases = {
    l = "ls -l";
    ll = "ls -lAh";
  };
  username = "sam";
  home = "/home/sam";
in {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = username;
    home.homeDirectory = home;
  
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "24.11"; # Please read the comment before changing.
  
    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = [
      pkgs.zsh-powerlevel10k

      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello
  
      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  
      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];
  
    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;
  
      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };
  
    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/sam/etc/profile.d/hm-session-vars.sh
    #
    home.sessionVariables = {
    };

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
  
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  }
