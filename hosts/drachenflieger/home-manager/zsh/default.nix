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
      save = 100000;
      size = 100000;
    };

    historySubstringSearch = {
      enable = true;
      # not working
      searchUpKey = "$terminfo[kcuu1]";
      searchDownKey = "$terminfo[kcud1]";
    };

    sessionVariables = {
      TEST = 30;
    };

    # initExtra = ''
    #   #
    #                           '';

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
