{ config, pkgs, ... }: {
  home.file = {
    ".config/zsh/.zsh_abbr".source = ./.zsh_abbr;
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = true;

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      path = "/Users/ant/.config/zsh/zsh_history";
      save = 100000;
      size = 100000;
      share = true;
    };

    historySubstringSearch = {
      enable = true;
    };

    sessionVariables = {
      ABBR_USER_ABBREVIATIONS_FILE = "/Users/ant/.config/zsh/.zsh_abbr";
    };

    # shellAliases = {
    #   "..." = "../..";
    # };

    ## TODO move to external file? initExtra = builtins.readFile ./zshrc-extra;
    initExtra = ''
      ## history
      setopt hist_reduce_blanks # remove superfluous blanks from history items
      setopt inc_append_history # save history entries as soon as they are entered

      ## completions https://thevaluable.dev/zsh-completion-guide-examples/
      setopt auto_cd # cd by typing directory name if it's not a command
      setopt auto_list # automatically list choices on ambiguous completion
      setopt auto_menu # automatically use menu completion
      setopt always_to_end # move cursor to end if word had one match

      # https://zsh.sourceforge.io/Doc/Release/Completion-System.html
      zstyle ':completion:*' menu select # use tab/arrows to select completion in menu
      zstyle ':completion:*' completer _expand _extensions _complete _ignored _approximate # enable approximate matches for completion


      # TODODODODO
      alias -g ...='../..'
      alias -g ....='../../..'
      alias -g .....='../../../..'
      alias -g ......='../../../../..'
                              '';

    # oh-my-zsh = {
    #   enable = true;
    #   theme = "crunch";
    # };

    plugins = [
      {
        name = "fast-syntax-highlighting";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
      {
        name = "zsh-abbr";
        src = pkgs.fetchFromGitHub {
          owner = "olets";
          repo = "zsh-abbr";
          rev = "v4.8.0";
          sha256 = "diitszKbu530zXbJx4xmfOjLsITE9ucmWdsz9VTXsKg=";
        };
        file = "zsh-abbr.plugin.zsh";
      }
      {
        name = "sudo";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "7dcabbe6826073ef6069c8a4b6f9a943f00d2df0";
          sha256 = "Mk2GQh7Yh0cyklSEIutIIUEQNMAcPC1i3QT5K6lCEt8=";
        };
        file = "plugins/sudo/sudo.plugin.zsh";
      }
      {
        name = "git";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "7dcabbe6826073ef6069c8a4b6f9a943f00d2df0";
          sha256 = "Mk2GQh7Yh0cyklSEIutIIUEQNMAcPC1i3QT5K6lCEt8=";
        };
        file = "lib/git.zsh";
      }
      {
        name = "prompt_info_functions";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "7dcabbe6826073ef6069c8a4b6f9a943f00d2df0";
          sha256 = "Mk2GQh7Yh0cyklSEIutIIUEQNMAcPC1i3QT5K6lCEt8=";
        };
        file = "lib/prompt_info_functions.zsh";
      }
      {
        name = "theme-and-appearance";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "7dcabbe6826073ef6069c8a4b6f9a943f00d2df0";
          sha256 = "Mk2GQh7Yh0cyklSEIutIIUEQNMAcPC1i3QT5K6lCEt8=";
        };
        file = "lib/theme-and-appearance.zsh";
      }
      ## TODO fix dir on right side
      {
        name = "crunch";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "7dcabbe6826073ef6069c8a4b6f9a943f00d2df0";
          sha256 = "Mk2GQh7Yh0cyklSEIutIIUEQNMAcPC1i3QT5K6lCEt8=";
        };
        file = "themes/crunch.zsh-theme";
      }
      # {
      #   name = "kube-ps1 ";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "jonmosco";
      #     repo = "kube-ps1 ";
      #     rev = "c432ec18b81a03cff835678298650dca74731945";
      #     sha256 = "1iz4l8777i52gfynzpf6yybrmics8g4i3f1xs3rqsr40bb89igrs";
      #   };
      #   file = "kube-ps1.sh";
      # }
      # {
      #   name = "agkozak-zsh-prompt";
      #   src = fetchFromGitHub {
      #     owner = "agkozak";
      #     repo = "agkozak-zsh-prompt";
      #     rev = "v3.7.0";
      #     sha256 = "1iz4l8777i52gfynzpf6yybrmics8g4i3f1xs3rqsr40bb89igrs";
      #   };
      #   file = "agkozak-zsh-prompt.plugin.zsh";
      # }
    ];
  };
}
